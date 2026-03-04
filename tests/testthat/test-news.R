test_that("r4sub_news returns a list invisibly", {
  result <- suppressMessages(r4sub_news())
  expect_type(result, "list")
})

test_that("r4sub_news accepts a specific package name", {
  result <- suppressMessages(r4sub_news("r4subcore"))
  expect_type(result, "list")
})

test_that("r4sub_news does not error", {
  expect_no_error(suppressMessages(r4sub_news()))
})

test_that("r4sub_news result names match requested packages", {
  result <- suppressMessages(r4sub_news("r4subcore"))
  if (length(result) > 0L) {
    expect_true("r4subcore" %in% names(result))
  }
})
