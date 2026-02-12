test_that("r4sub_update returns a tibble invisibly", {
  result <- invisible(r4sub_update())
  expect_s3_class(result, "tbl_df")
})

test_that("r4sub_update has expected columns", {
  result <- suppressMessages(r4sub_update())
  expect_true(all(c("package", "installed") %in% names(result)))
})

test_that("r4sub_update lists all ecosystem packages", {
  result <- suppressMessages(r4sub_update())
  expected <- c("r4sub", "r4subcore", "r4subtrace", "r4subscore",
                "r4subrisk", "r4subdata", "r4subprofile", "r4subui")
  expect_true(all(expected %in% result$package))
})

test_that("r4sub_update reports core package versions", {
  result <- suppressMessages(r4sub_update())
  core <- result[result$package %in% core_packages(), ]
  expect_true(all(!is.na(core$installed)))
})
