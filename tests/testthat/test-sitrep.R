test_that("r4sub_sitrep returns a list invisibly", {
  result <- suppressMessages(r4sub_sitrep())
  expect_type(result, "list")
})

test_that("r4sub_sitrep has expected components", {
  result <- suppressMessages(r4sub_sitrep())
  expect_true(all(c("r_version", "platform", "packages", "conflicts") %in%
                    names(result)))
})

test_that("r4sub_sitrep packages component is the r4sub_packages tibble", {
  result <- suppressMessages(r4sub_sitrep())
  expect_s3_class(result$packages, "tbl_df")
  expect_true(all(c("package", "version", "attached") %in%
                    names(result$packages)))
  expect_true("r4sub" %in% result$packages$package)
})

test_that("r4sub_sitrep reports an integer conflict count", {
  result <- suppressMessages(r4sub_sitrep())
  expect_true(is.numeric(result$conflicts))
  expect_equal(result$conflicts, nrow(suppressMessages(r4sub_conflicts())))
})

test_that("r4sub_sitrep reports the running R version", {
  result <- suppressMessages(r4sub_sitrep())
  expect_identical(result$r_version, R.version.string)
})

test_that("r4sub_sitrep prints a report", {
  expect_message(r4sub_sitrep(), regexp = "situation report")
})
