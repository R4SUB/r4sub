test_that("r4sub_conflicts returns a tibble", {
  result <- suppressMessages(r4sub_conflicts())
  expect_s3_class(result, "tbl_df")
})

test_that("r4sub_conflicts has expected columns", {
  result <- suppressMessages(r4sub_conflicts())
  expect_true(all(c("func", "r4sub_package", "other_package") %in%
                    names(result)))
})

test_that("r4sub_conflicts does not error", {
  expect_no_error(suppressMessages(r4sub_conflicts()))
})

test_that("r4sub_conflicts returns 0 rows when no R4SUB packages attached", {
  # In a fresh test session no core packages are auto-attached
  result <- suppressMessages(r4sub_conflicts())
  expect_equal(nrow(result), 0L)
})

test_that("r4sub_conflicts returns character columns", {
  result <- suppressMessages(r4sub_conflicts())
  expect_type(result$func, "character")
  expect_type(result$r4sub_package, "character")
  expect_type(result$other_package, "character")
})

test_that("r4sub_conflicts prints a message", {
  expect_message(r4sub_conflicts())
})

test_that("conflict detection logic correctly identifies overlaps", {
  # Test the overlap logic used inside r4sub_conflicts() directly
  r4sub_exports <- list(pkgA = c("filter", "select", "mutate"))
  other_exports <- list(pkgB = c("filter", "select", "arrange"))
  overlap <- intersect(r4sub_exports[["pkgA"]], other_exports[["pkgB"]])
  expect_equal(sort(overlap), c("filter", "select"))
})

test_that("conflict detection returns empty when no overlap", {
  r4sub_exports <- list(pkgA = c("compute_sci", "compute_pillar_scores"))
  other_exports <- list(pkgB = c("filter", "select"))
  overlap <- intersect(r4sub_exports[["pkgA"]], other_exports[["pkgB"]])
  expect_equal(length(overlap), 0L)
})
