# Build a small synthetic evidence table spanning several domains. Returns a
# validated r4subcore evidence frame, or skips the test if r4subcore is absent.
make_evidence <- function(study_id = "STUDY01") {
  skip_if_not_installed("r4subcore")
  ctx <- suppressMessages(
    r4subcore::r4sub_run_context(study_id = study_id, environment = "DEV")
  )
  df <- data.frame(
    asset_type = "dataset",
    asset_id = c("ADSL", "ADSL", "ADAE", "ADSL"),
    source_name = "pinnacle21",
    indicator_id = c("Q-001", "T-001", "R-001", "U-001"),
    indicator_name = c("Quality check", "Trace check", "Risk check", "Usability"),
    indicator_domain = c("quality", "trace", "risk", "usability"),
    severity = c("high", "medium", "critical", "low"),
    result = c("fail", "pass", "fail", "warn"),
    stringsAsFactors = FALSE
  )
  suppressMessages(r4subcore::as_evidence(df, ctx = ctx))
}

test_that("r4sub_readiness returns a classed object with expected components", {
  ev <- make_evidence()
  res <- r4sub_readiness(ev)

  expect_s3_class(res, "r4sub_readiness")
  expect_true(all(
    c("study_id", "n_evidence", "sci", "band", "generated_at",
      "stages", "summary", "evidence") %in% names(res)
  ))
  expect_identical(res$study_id, "STUDY01")
  expect_identical(res$n_evidence, nrow(ev))
  # Evidence is not carried unless asked for.
  expect_null(res$evidence)
})

test_that("the summary tibble has one row per run stage", {
  ev <- make_evidence()
  res <- r4sub_readiness(ev)

  expect_s3_class(res$summary, "tbl_df")
  expect_identical(names(res$summary), c("stage", "package", "status", "detail"))
  # No profile supplied -> the profile stage is absent.
  expect_false("profile" %in% res$summary$stage)
  expect_true(all(res$summary$status %in% c("ok", "skipped", "error")))
  expect_identical(nrow(res$summary), length(res$stages))
})

test_that("r4sub_readiness surfaces r4subscore's SCI without recomputing it", {
  skip_if_not_installed("r4subscore")
  ev <- make_evidence()
  res <- r4sub_readiness(ev)

  # The headline SCI must be byte-identical to the sibling's own output: r4sub
  # orchestrates, it does not compute its own score.
  ps  <- r4subscore::compute_pillar_scores(ev)
  sci <- r4subscore::compute_sci(ps)

  expect_identical(res$stages$score$status, "ok")
  expect_identical(res$sci, sci$SCI)
  expect_identical(res$band, sci$band)
  expect_identical(res$stages$score$result$SCI, sci$SCI)
})

test_that("the risk stage carries r4subrisk's native results", {
  skip_if_not_installed("r4subrisk")
  ev <- make_evidence()
  res <- r4sub_readiness(ev)

  expect_identical(res$stages$risk$status, "ok")
  risk_result <- res$stages$risk$result
  expect_s3_class(risk_result$scores, "risk_scores")
  expect_s3_class(risk_result$register, "risk_register")

  # Compare against calling the sibling directly.
  risks    <- r4subrisk::evidence_to_risks(ev)
  register <- r4subrisk::create_risk_register(risks)
  scores   <- r4subrisk::compute_risk_scores(register)
  expect_identical(risk_result$scores$overall_risk_score, scores$overall_risk_score)
  expect_identical(risk_result$scores$n_risks, scores$n_risks)
})

test_that("include_evidence returns the combined evidence frame", {
  ev <- make_evidence()
  res <- r4sub_readiness(ev, include_evidence = TRUE)
  expect_s3_class(res$evidence, "data.frame")
  expect_identical(nrow(res$evidence), nrow(ev))
})

test_that("a list of evidence frames is combined before the pipeline runs", {
  skip_if_not_installed("r4subcore")
  ev1 <- make_evidence()
  ev2 <- make_evidence()
  res_list   <- r4sub_readiness(list(ev1, ev2), include_evidence = TRUE)
  combined   <- suppressMessages(r4subcore::bind_evidence(ev1, ev2))
  expect_identical(res_list$n_evidence, nrow(combined))
})

test_that("supplying a profile adds a profile stage", {
  skip_if_not_installed("r4subprofile")
  ev   <- make_evidence()
  prof <- r4subprofile::submission_profile("FDA", "NDA")
  res  <- r4sub_readiness(ev, profile = prof)

  expect_true("profile" %in% res$summary$stage)
  expect_identical(res$stages$profile$status, "ok")
  direct <- r4subprofile::validate_against_profile(ev, prof)
  expect_identical(res$stages$profile$result$is_compliant, direct$is_compliant)
})

test_that("an invalid profile argument is rejected", {
  ev <- make_evidence()
  expect_error(r4sub_readiness(ev, profile = "FDA"), "submission_profile")
})

test_that("non-evidence input is rejected", {
  expect_error(r4sub_readiness(42), "evidence")
  expect_error(r4sub_readiness(list()), "empty")
})

test_that("readiness_run_stage reports skipped for an absent package", {
  stage <- readiness_run_stage(
    "fake", "this.package.does.not.exist.r4sub",
    function() list(result = NULL, detail = "never runs")
  )
  expect_identical(stage$status, "skipped")
  expect_identical(stage$detail, "package not installed")
  expect_null(stage$result)
})

test_that("readiness_run_stage traps sibling errors without aborting", {
  stage <- readiness_run_stage(
    "boom", "r4subcore",
    function() stop("kaboom")
  )
  expect_identical(stage$status, "error")
  expect_match(stage$message, "kaboom")
  expect_null(stage$result)
})

test_that("format and print render a readable report", {
  ev  <- make_evidence()
  res <- r4sub_readiness(ev)

  txt <- format(res)
  expect_type(txt, "character")
  expect_true(any(grepl("R4SUB readiness report", txt)))
  expect_true(any(grepl("Study", txt)))

  expect_message(print(res), "readiness report")
  expect_invisible(print(res))
})
