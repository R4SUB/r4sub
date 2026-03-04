test_that("r4sub_status returns a tibble invisibly", {
  result <- suppressMessages(r4sub_status())
  expect_s3_class(result, "tbl_df")
})

test_that("r4sub_status has expected columns", {
  result <- suppressMessages(r4sub_status())
  expect_true(all(c("package", "installed") %in% names(result)))
})

test_that("r4sub_status lists all ecosystem packages", {
  result <- suppressMessages(r4sub_status())
  expected <- c("r4sub", "r4subcore", "r4subtrace", "r4subscore",
                "r4subrisk", "r4subdata", "r4subprofile", "r4subui")
  expect_true(all(expected %in% result$package))
})

test_that("r4sub_status reports core package versions", {
  result <- suppressMessages(r4sub_status())
  core <- result[result$package %in% core_packages(), ]
  expect_true(all(!is.na(core$installed)))
})

test_that("r4sub_status installed column is character", {
  result <- suppressMessages(r4sub_status())
  expect_type(result$installed, "character")
})

test_that("r4sub_status prints a success message", {
  expect_message(r4sub_status(), regexp = "installed")
})
