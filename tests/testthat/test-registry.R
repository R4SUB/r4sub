test_that("r4sub_registry tags every package with a known role", {
  reg <- r4sub:::r4sub_registry()
  expect_s3_class(reg, "tbl_df")
  expect_true(all(c("package", "role") %in% names(reg)))
  expect_true(all(reg$role %in% c("core", "optional")))
})

test_that("optional_packages returns the expected optional packages", {
  opt <- r4sub:::optional_packages()
  expect_setequal(
    opt,
    c("r4subui", "r4subpharma", "r4subrepro", "r4agent")
  )
})

test_that("core and optional roles do not overlap", {
  expect_equal(
    length(intersect(core_packages(), r4sub:::optional_packages())),
    0L
  )
})

test_that("the attach set is unchanged by the registry", {
  # core_packages() defines exactly what library(r4sub) attaches. This must
  # stay the same 7 packages, in the same order, regardless of the registry.
  expect_identical(
    core_packages(),
    c("r4subcore", "r4subtrace", "r4subscore", "r4subrisk",
      "r4subdata", "r4subprofile", "r4subusability")
  )
})

test_that("optional packages are never auto-attached", {
  for (pkg in r4sub:::optional_packages()) {
    expect_false(
      paste0("package:", pkg) %in% search(),
      info = paste(pkg, "must not be auto-attached")
    )
  }
})
