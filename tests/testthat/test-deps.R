test_that("r4sub_deps() returns a classed tibble with the expected columns", {
  deps <- suppressMessages(r4sub_deps())

  expect_s3_class(deps, "r4sub_deps")
  expect_s3_class(deps, "tbl_df")
  expect_identical(
    names(deps),
    c("package", "dependency", "type", "required", "installed", "status")
  )
})

test_that("r4sub_deps() only reports edges within the ecosystem", {
  deps <- suppressMessages(r4sub_deps(include_suggests = TRUE))
  eco <- c("r4sub", r4sub_registry()$package)

  expect_true(all(deps$package %in% eco))
  expect_true(all(deps$dependency %in% eco))
  # No package depends on itself.
  expect_false(any(deps$package == deps$dependency))
  # Non-ecosystem deps such as cli / tibble are excluded.
  expect_false(any(c("cli", "tibble", "rlang") %in% deps$dependency))
})

test_that("default scope excludes Suggests, opt-in includes them", {
  hard <- suppressMessages(r4sub_deps())
  all_edges <- suppressMessages(r4sub_deps(include_suggests = TRUE))

  expect_false("Suggests" %in% hard$type)
  expect_true(all(hard$type %in% c("Depends", "Imports")))
  # Adding Suggests can only add rows, never remove them.
  expect_gte(nrow(all_edges), nrow(hard))
})

test_that("installed ecosystem is internally consistent", {
  deps <- suppressMessages(r4sub_deps(include_suggests = TRUE))
  # Every dependency that is declared with a version is satisfied in this
  # (fully installed) ecosystem.
  expect_true(all(deps$status == "ok"))
})

test_that("dependency_status() classifies each case", {
  expect_identical(dependency_status("Imports", NA, NA, NA_character_), "missing")
  expect_identical(
    dependency_status("Suggests", NA, NA, NA_character_),
    "suggested-missing"
  )
  expect_identical(dependency_status("Imports", ">=", "2.0.0", "1.0.0"), "outdated")
  expect_identical(dependency_status("Imports", ">=", "0.1.2", "0.1.4"), "ok")
  expect_identical(dependency_status("Imports", ">", "1.0.0", "1.0.0"), "outdated")
  expect_identical(dependency_status("Imports", "==", "1.0.0", "1.0.0"), "ok")
  # A bare presence requirement (no version) is satisfied by any install.
  expect_identical(dependency_status("Imports", NA, NA, "0.0.1"), "ok")
})

test_that("parse_dependency_field() parses names and version constraints", {
  parsed <- parse_dependency_field("r4subcore,\nr4subdata (>= 0.1.2),\ncli")

  expect_length(parsed, 3L)
  expect_identical(parsed[[1]]$name, "r4subcore")
  expect_true(is.na(parsed[[1]]$op))
  expect_identical(parsed[[2]]$name, "r4subdata")
  expect_identical(parsed[[2]]$op, ">=")
  expect_identical(parsed[[2]]$version, "0.1.2")

  expect_identical(parse_dependency_field(NA), list())
  expect_identical(parse_dependency_field(NULL), list())
  expect_identical(parse_dependency_field("   "), list())
})

test_that("format()/print() report problems and clean states", {
  clean <- new_r4sub_deps(tibble::tibble(
    package = character(0), dependency = character(0), type = character(0),
    required = character(0), installed = character(0), status = character(0)
  ))
  expect_match(format(clean), "satisfied")
  expect_invisible(print(clean))

  problems <- new_r4sub_deps(tibble::tibble(
    package = c("r4subusability", "r4subui"),
    dependency = c("r4subdata", "r4subscore"),
    type = c("Suggests", "Imports"),
    required = c(">= 9.9.9", NA),
    installed = c("0.1.4", NA),
    status = c("outdated", "missing")
  ))
  out <- format(problems)
  expect_match(out[1], "dependency issues \\(2\\)")
  expect_true(any(grepl("r4subusability requires r4subdata \\(>= 9.9.9\\)", out)))
  expect_true(any(grepl("not installed", out)))
  expect_invisible(print(problems))
})

test_that("r4sub_deps() returns invisibly", {
  expect_invisible(suppressMessages(r4sub_deps()))
})
