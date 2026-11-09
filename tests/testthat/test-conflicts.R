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

test_that("r4sub_conflicts returns an r4sub_conflicts object that is still a tibble", {
  result <- suppressMessages(r4sub_conflicts())
  expect_s3_class(result, "r4sub_conflicts")
  expect_s3_class(result, "tbl_df")
})

test_that("format() renders the no-conflicts line when empty", {
  empty <- new_r4sub_conflicts(tibble::tibble(
    func = character(0),
    r4sub_package = character(0),
    other_package = character(0)
  ))
  out <- format(empty)
  expect_type(out, "character")
  expect_length(out, 1L)
  expect_match(out, "No conflicts")
})

test_that("format() renders an 'overrides' report for each conflict", {
  obj <- new_r4sub_conflicts(tibble::tibble(
    func = c("filter", "select"),
    r4sub_package = c("r4subcore", "r4subscore"),
    other_package = c("dplyr", "dplyr")
  ))
  out <- format(obj)
  # Header plus one line per conflict
  expect_length(out, 3L)
  expect_match(out[1], "R4SUB conflicts")
  expect_true(any(grepl("r4subcore::filter overrides dplyr::filter", out,
                        fixed = TRUE)))
  expect_true(any(grepl("r4subscore::select overrides dplyr::select", out,
                        fixed = TRUE)))
})

test_that("print() returns its argument invisibly", {
  obj <- new_r4sub_conflicts(tibble::tibble(
    func = "filter",
    r4sub_package = "r4subcore",
    other_package = "dplyr"
  ))
  expect_invisible(suppressMessages(print(obj)))
  out <- suppressMessages(print(obj))
  expect_identical(out, obj)
})

test_that("conflict startup line is OFF by default (attach behavior unchanged)", {
  old <- options(r4sub.conflicts = NULL)
  on.exit(options(old), add = TRUE)
  expect_false(isTRUE(getOption("r4sub.conflicts")))
  expect_null(r4sub_conflicts_startup_line())
})

test_that("conflict startup line appears only when the option is enabled", {
  old <- options(r4sub.conflicts = TRUE)
  on.exit(options(old), add = TRUE)
  line <- r4sub_conflicts_startup_line()
  expect_type(line, "character")
  expect_length(line, 1L)
  expect_match(line, "^r4sub:")
})
