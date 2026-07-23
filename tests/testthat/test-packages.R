test_that("r4sub_packages returns a tibble", {
  result <- r4sub_packages()
  expect_s3_class(result, "tbl_df")
})

test_that("r4sub_packages has expected columns", {
  result <- r4sub_packages()
  expect_true(all(c("package", "version", "attached") %in% names(result)))
})

test_that("r4sub_packages lists all ecosystem packages", {
  result <- r4sub_packages()
  expected <- c("r4sub", "r4subcore", "r4subtrace", "r4subscore",
                "r4subrisk", "r4subdata", "r4subprofile", "r4subui")
  expect_true(all(expected %in% result$package))
})

test_that("r4sub_packages include_self works", {
  with_self <- r4sub_packages(include_self = TRUE)
  without_self <- r4sub_packages(include_self = FALSE)
  expect_true("r4sub" %in% with_self$package)
  expect_false("r4sub" %in% without_self$package)
})

test_that("core packages have non-NA versions", {
  result <- r4sub_packages()
  core <- result[result$package %in% core_packages(), ]
  expect_true(all(!is.na(core$version)))
})

test_that("attached column is logical", {
  result <- r4sub_packages()
  expect_true(is.logical(result$attached))
})
