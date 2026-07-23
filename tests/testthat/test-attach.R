test_that("core_packages returns 6 package names", {
  pkgs <- core_packages()
  expect_equal(length(pkgs), 6L)
  expect_true(is.character(pkgs))
})

test_that("core_packages contains expected packages", {
  pkgs <- core_packages()
  expect_true("r4subcore" %in% pkgs)
  expect_true("r4subtrace" %in% pkgs)
  expect_true("r4subscore" %in% pkgs)
  expect_true("r4subrisk" %in% pkgs)
  expect_true("r4subdata" %in% pkgs)
  expect_true("r4subprofile" %in% pkgs)
})

test_that("is_attached returns logical vector", {
  result <- r4sub:::is_attached(c("r4subcore", "nonexistent"))
  expect_true(is.logical(result))
  expect_equal(length(result), 2L)
})

test_that("r4sub_attach_message returns a character string", {
  msg <- r4sub:::r4sub_attach_message(c("r4subcore"))
  expect_true(is.character(msg))
  expect_true(nchar(msg) > 0L)
})

test_that("attach message contains package names", {
  msg <- r4sub:::r4sub_attach_message(c("r4subcore", "r4subtrace"))
  expect_true(grepl("r4subcore", msg))
  expect_true(grepl("r4subtrace", msg))
})

test_that("attach message contains version numbers", {
  msg <- r4sub:::r4sub_attach_message(c("r4subcore"))
  # Should contain a version like 0.1.0

  expect_true(grepl("\\d+\\.\\d+", msg))
})

test_that("core packages are attached after library(r4sub)", {
  # Since library(r4sub) was called in testthat.R, all should be attached
  pkgs <- core_packages()
  for (pkg in pkgs) {
    expect_true(
      paste0("package:", pkg) %in% search(),
      info = paste(pkg, "should be attached")
    )
  }
})

test_that("r4subui is NOT auto-attached", {
  expect_false("package:r4subui" %in% search())
})
