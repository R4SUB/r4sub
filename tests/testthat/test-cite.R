test_that("r4sub_cite returns a list invisibly", {
  result <- suppressMessages(r4sub_cite())
  expect_type(result, "list")
})

test_that("r4sub_cite accepts a specific package name", {
  result <- suppressMessages(r4sub_cite("r4subcore"))
  expect_type(result, "list")
})

test_that("r4sub_cite does not error", {
  expect_no_error(suppressMessages(r4sub_cite()))
})

test_that("r4sub_cite result names match requested packages", {
  result <- suppressMessages(r4sub_cite("r4subcore"))
  expect_true("r4subcore" %in% names(result))
})

test_that("r4sub_cite returns citation objects", {
  result <- suppressMessages(r4sub_cite("r4subcore"))
  expect_s3_class(result[["r4subcore"]], "citation")
})
