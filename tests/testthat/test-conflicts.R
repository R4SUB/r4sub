test_that("r4sub_conflicts returns a tibble", {
  result <- r4sub_conflicts()
  expect_s3_class(result, "tbl_df")
})

test_that("r4sub_conflicts has expected columns", {
  result <- r4sub_conflicts()
  expect_true(all(c("func", "r4sub_package", "other_package") %in%
                    names(result)))
})

test_that("r4sub_conflicts does not error", {
  expect_no_error(r4sub_conflicts())
})
