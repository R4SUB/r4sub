#' Run the R4SUB Readiness Pipeline End to End
#'
#' Drives the installed R4SUB ecosystem packages over a single body of
#' evidence and assembles their outputs into one consolidated readiness
#' object. It is the ecosystem's "front door": instead of calling
#' \pkg{r4subscore}, \pkg{r4subrisk}, \pkg{r4subtrace}, \pkg{r4subusability},
#' \pkg{r4subrepro}, and \pkg{r4subprofile} separately and stitching their
#' results together by hand, you pass the shared evidence table once and
#' receive every sibling's native result in a single structure.
#'
#' `r4sub_readiness()` is a pure orchestrator: it **computes no scores,
#' weights, thresholds, or domain metrics of its own**. Every number it
#' surfaces is produced by the sibling package that owns that concern (for
#' example the Submission Confidence Index and its band come from
#' [r4subscore::compute_sci()], the overall risk score from
#' [r4subrisk::compute_risk_scores()]). r4sub only validates the evidence,
#' invokes each sibling's existing entry points in dependency order, and
#' collects what they return.
#'
#' Each stage is run only when its package is installed (guarded with
#' [requireNamespace()]) and is wrapped so that a sibling raising an error
#' never aborts the whole run: that stage is recorded with status
#' `"error"` and the others still complete. A stage whose package is not
#' installed is recorded with status `"skipped"`. The profile stage runs
#' only when a `profile` is supplied.
#'
#' @param evidence Either a single validated evidence table (conforming to the
#'   \pkg{r4subcore} evidence schema) or a list of such tables. A list is
#'   combined into one table with [r4subcore::bind_evidence()] before the
#'   pipeline runs; the combined table is what every stage sees.
#' @param profile Optional. A `submission_profile` object from
#'   [r4subprofile::submission_profile()]. When supplied, the evidence is
#'   checked against it with [r4subprofile::validate_against_profile()]. When
#'   `NULL` (default), the profile stage is skipped.
#' @param sci_config Optional scoring configuration from
#'   [r4subscore::sci_config_default()], passed through to the scoring stage.
#'   When `NULL` (default), r4subscore's own default configuration is used;
#'   r4sub supplies no configuration values itself.
#' @param risk_config Optional risk configuration from
#'   [r4subrisk::risk_config_default()], passed through to the risk stage.
#'   When `NULL` (default), r4subrisk's own default configuration is used.
#' @param include_evidence Logical. If `TRUE`, the (possibly combined)
#'   evidence table is returned in the `evidence` component of the result.
#'   Default `FALSE`.
#' @param x An `r4sub_readiness` object, as returned by `r4sub_readiness()`.
#' @param ... Ignored, for compatibility with the [format()] and [print()]
#'   generics.
#'
#' @return An object of class `r4sub_readiness`: a list with components
#'   \describe{
#'     \item{`study_id`}{The study identifier read from the evidence.}
#'     \item{`n_evidence`}{The number of evidence rows the pipeline saw.}
#'     \item{`sci`}{The Submission Confidence Index from the scoring stage, or
#'       `NA` when that stage did not run.}
#'     \item{`band`}{The SCI decision band from the scoring stage, or `NA`.}
#'     \item{`generated_at`}{When the run was assembled.}
#'     \item{`stages`}{A named list, one entry per stage, each a list with
#'       `stage`, `package`, `status` (`"ok"`, `"skipped"`, or `"error"`),
#'       `detail` (a human-readable headline), `result` (the sibling's native
#'       return value, or `NULL`), and `message`.}
#'     \item{`summary`}{A tibble with one row per stage: `stage`, `package`,
#'       `status`, and `detail`.}
#'     \item{`evidence`}{The combined evidence table when `include_evidence`
#'       is `TRUE`, otherwise `NULL`.}
#'   }
#'   Printing the object renders a readable report; the same text is available
#'   from [format()].
#'
#' @examplesIf requireNamespace("r4subcore", quietly = TRUE)
#' ctx <- suppressMessages(
#'   r4subcore::r4sub_run_context(study_id = "STUDY01", environment = "DEV")
#' )
#' ev <- suppressMessages(r4subcore::as_evidence(
#'   data.frame(
#'     asset_type = "dataset",
#'     asset_id = c("ADSL", "ADAE"),
#'     source_name = "pinnacle21",
#'     indicator_id = c("Q-001", "R-001"),
#'     indicator_name = c("Quality check", "Risk check"),
#'     indicator_domain = c("quality", "risk"),
#'     severity = c("high", "critical"),
#'     result = c("fail", "fail"),
#'     stringsAsFactors = FALSE
#'   ),
#'   ctx = ctx
#' ))
#' readiness <- r4sub_readiness(ev)
#' readiness$summary
#'
#' @export
r4sub_readiness <- function(evidence,
                            profile = NULL,
                            sci_config = NULL,
                            risk_config = NULL,
                            include_evidence = FALSE) {
  if (!requireNamespace("r4subcore", quietly = TRUE)) {
    cli::cli_abort(
      "{.pkg r4subcore} must be installed to run the readiness pipeline."
    )
  }

  ev <- readiness_combine_evidence(evidence)
  r4subcore::validate_evidence(ev)

  study_id <- {
    s <- unique(ev$study_id[!is.na(ev$study_id)])
    if (length(s) == 0L) NA_character_ else as.character(s[1L])
  }

  if (!is.null(profile) && !inherits(profile, "submission_profile")) {
    cli::cli_abort(
      "{.arg profile} must be a {.cls submission_profile} object or {.code NULL}."
    )
  }

  stages <- list(
    score     = readiness_run_stage(
      "score", "r4subscore",
      function() readiness_stage_score(ev, sci_config)
    ),
    risk      = readiness_run_stage(
      "risk", "r4subrisk",
      function() readiness_stage_risk(ev, risk_config)
    ),
    trace     = readiness_run_stage(
      "trace", "r4subtrace",
      function() readiness_stage_trace(ev)
    ),
    usability = readiness_run_stage(
      "usability", "r4subusability",
      function() readiness_stage_usability(ev)
    ),
    repro     = readiness_run_stage(
      "repro", "r4subrepro",
      function() readiness_stage_repro(ev)
    )
  )

  if (!is.null(profile)) {
    stages$profile <- readiness_run_stage(
      "profile", "r4subprofile",
      function() readiness_stage_profile(ev, profile)
    )
  }

  summary_tbl <- tibble::tibble(
    stage   = vapply(stages, function(s) s$stage, character(1)),
    package = vapply(stages, function(s) s$package, character(1)),
    status  = vapply(stages, function(s) s$status, character(1)),
    detail  = vapply(stages, function(s) s$detail, character(1))
  )

  sci  <- NA_real_
  band <- NA_character_
  if (identical(stages$score$status, "ok") && !is.null(stages$score$result)) {
    sci  <- stages$score$result$SCI
    band <- stages$score$result$band
  }

  structure(
    list(
      study_id     = study_id,
      n_evidence   = nrow(ev),
      sci          = sci,
      band         = band,
      generated_at = Sys.time(),
      stages       = stages,
      summary      = summary_tbl,
      evidence     = if (isTRUE(include_evidence)) ev else NULL
    ),
    class = "r4sub_readiness"
  )
}

# Accept a single evidence frame or a list of frames; combine the latter with
# r4subcore::bind_evidence(). Anything else is an error.
# @noRd
readiness_combine_evidence <- function(evidence) {
  if (is.data.frame(evidence)) {
    return(evidence)
  }
  if (is.list(evidence)) {
    if (length(evidence) == 0L) {
      cli::cli_abort("{.arg evidence} is an empty list; nothing to assess.")
    }
    return(suppressMessages(do.call(r4subcore::bind_evidence, evidence)))
  }
  cli::cli_abort(
    "{.arg evidence} must be an evidence data.frame or a list of them."
  )
}

# Run one pipeline stage. Returns a stage record regardless of outcome:
#   - package not installed        -> status "skipped"
#   - sibling raised a condition    -> status "error"
#   - otherwise                     -> whatever `fn` returned (status "ok")
# `fn` must return list(result, detail); this wrapper adds stage/package/status.
# @noRd
readiness_run_stage <- function(stage, package, fn) {
  if (!requireNamespace(package, quietly = TRUE)) {
    return(list(
      stage = stage, package = package, status = "skipped",
      detail = "package not installed", result = NULL, message = NA_character_
    ))
  }
  tryCatch({
    out <- suppressMessages(suppressWarnings(fn()))
    list(
      stage = stage, package = package, status = "ok",
      detail = out$detail, result = out$result, message = NA_character_
    )
  }, error = function(e) {
    list(
      stage = stage, package = package, status = "error",
      detail = "stage errored", result = NULL,
      message = conditionMessage(e)
    )
  })
}

# --- Individual stages. Each only calls the sibling's own functions. ---------

# Scoring: indicator -> pillar -> SCI (r4subscore). r4sub supplies the config
# only when the caller did; otherwise the sibling's default is used.
# @noRd
readiness_stage_score <- function(ev, sci_config) {
  if (is.null(sci_config)) {
    pillars <- r4subscore::compute_pillar_scores(ev)
    sci     <- r4subscore::compute_sci(pillars)
  } else {
    pillars <- r4subscore::compute_pillar_scores(ev, config = sci_config)
    sci     <- r4subscore::compute_sci(pillars, config = sci_config)
  }
  detail <- if (is.na(sci$SCI)) {
    "SCI: not available"
  } else {
    sprintf("SCI %s (%s)", format(sci$SCI), sci$band)
  }
  list(result = sci, detail = detail)
}

# Risk: evidence -> risk items -> register -> aggregate scores (r4subrisk).
# @noRd
readiness_stage_risk <- function(ev, risk_config) {
  if (is.null(risk_config)) {
    risks    <- r4subrisk::evidence_to_risks(ev)
    register <- r4subrisk::create_risk_register(risks)
    scores   <- r4subrisk::compute_risk_scores(register)
  } else {
    risks    <- r4subrisk::evidence_to_risks(ev, config = risk_config)
    register <- r4subrisk::create_risk_register(risks, config = risk_config)
    scores   <- r4subrisk::compute_risk_scores(register, config = risk_config)
  }
  indicators <- r4subrisk::risk_indicator_summary(register)
  detail <- sprintf(
    "overall risk %s across %d risk%s",
    format(round(scores$overall_risk_score, 2)),
    scores$n_risks, if (identical(scores$n_risks, 1L)) "" else "s"
  )
  list(
    result = list(scores = scores, register = register, indicators = indicators),
    detail = detail
  )
}

# Traceability indicators derived from the evidence (r4subtrace).
# @noRd
readiness_stage_trace <- function(ev) {
  trace <- r4subtrace::trace_indicator_scores(ev)
  cov <- trace$value[trace$indicator == "TRACE_VAR_COVERAGE_L2PLUS"]
  detail <- if (length(cov) == 0L || is.na(cov[1L])) {
    "no ADaM trace levels in evidence"
  } else {
    sprintf("L2+ trace coverage %s", format(round(cov[1L], 2)))
  }
  list(result = trace, detail = detail)
}

# Usability summary over the evidence (r4subusability).
# @noRd
readiness_stage_usability <- function(ev) {
  us <- r4subusability::usability_summary(ev)
  detail <- if (is.null(us$overall_score) || is.na(us$overall_score)) {
    "no usability indicators in evidence"
  } else {
    sprintf("usability %s%%", format(round(us$overall_score * 100, 1)))
  }
  list(result = us, detail = detail)
}

# Reproducibility summary over the evidence (r4subrepro).
# @noRd
readiness_stage_repro <- function(ev) {
  rp <- r4subrepro::reproducibility_summary(ev)
  detail <- if (is.null(rp$overall_score) || is.na(rp$overall_score)) {
    "no reproducibility indicators in evidence"
  } else {
    sprintf("reproducibility %s%%", format(round(rp$overall_score * 100, 1)))
  }
  list(result = rp, detail = detail)
}

# Profile conformance check (r4subprofile).
# @noRd
readiness_stage_profile <- function(ev, profile) {
  res <- r4subprofile::validate_against_profile(ev, profile)
  detail <- sprintf(
    "%s (coverage %s%%)",
    if (isTRUE(res$is_compliant)) "compliant" else "not compliant",
    format(round(res$coverage * 100, 1))
  )
  list(result = res, detail = detail)
}

# Attach the `r4sub_readiness` class to a plain list (used in tests).
# @noRd
new_r4sub_readiness <- function(x) {
  if (!inherits(x, "r4sub_readiness")) {
    class(x) <- c("r4sub_readiness", class(x))
  }
  x
}

#' @rdname r4sub_readiness
#' @export
format.r4sub_readiness <- function(x, ...) {
  header <- paste0(
    "-- R4SUB readiness report ", strrep("-", 30)
  )
  study <- paste0(
    "Study: ",
    if (is.na(x$study_id)) "<unknown>" else x$study_id,
    "  |  evidence rows: ", x$n_evidence
  )
  sci_line <- if (is.na(x$sci)) {
    "SCI: not available"
  } else {
    paste0("SCI: ", format(x$sci), " (", x$band, ")")
  }

  icon <- c(ok = "v", skipped = "-", error = "x")
  stage_lines <- vapply(x$stages, function(s) {
    paste0(
      "  ", icon[[s$status]], " ", s$stage, " [", s$package, "]: ", s$detail
    )
  }, character(1))

  c(header, study, sci_line, "Stages:", unname(stage_lines))
}

#' @rdname r4sub_readiness
#' @export
print.r4sub_readiness <- function(x, ...) {
  cli::cli_h2("R4SUB readiness report")
  cli::cli_alert_info(
    "Study {.val {if (is.na(x$study_id)) '<unknown>' else x$study_id}}: {x$n_evidence} evidence row{?s}."
  )
  if (is.na(x$sci)) {
    cli::cli_alert_info("Submission Confidence Index: not available.")
  } else {
    cli::cli_alert_info("Submission Confidence Index: {x$sci} ({x$band}).")
  }

  for (s in x$stages) {
    switch(
      s$status,
      ok      = cli::cli_alert_success("{s$stage} [{.pkg {s$package}}]: {s$detail}"),
      skipped = cli::cli_alert_info("{s$stage} [{.pkg {s$package}}]: {s$detail}"),
      error   = cli::cli_alert_danger(
        "{s$stage} [{.pkg {s$package}}]: {s$detail} ({s$message})"
      )
    )
  }
  invisible(x)
}
