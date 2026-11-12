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

test_that("parse_dependency_field() parses a realistic Depends field", {
  parsed <- parse_dependency_field("R (>= 4.2), r4subcore (>= 0.1.0)")

  expect_length(parsed, 2L)
  expect_identical(parsed[[1]]$name, "R")
  expect_identical(parsed[[1]]$op, ">=")
  expect_identical(parsed[[1]]$version, "4.2")
  expect_identical(parsed[[2]]$name, "r4subcore")
  expect_identical(parsed[[2]]$op, ">=")
  expect_identical(parsed[[2]]$version, "0.1.0")
})

test_that("parse_dependency_field() keeps dotted names and all operators", {
  parsed <- parse_dependency_field(
    "my.pkg (>= 1.0), other.name (<= 2.3.4), exact.one (== 1.2.3), free.form"
  )

  expect_identical(
    vapply(parsed, `[[`, character(1), "name"),
    c("my.pkg", "other.name", "exact.one", "free.form")
  )
  expect_identical(
    vapply(parsed, `[[`, character(1), "op"),
    c(">=", "<=", "==", NA_character_)
  )
  expect_identical(
    vapply(parsed, `[[`, character(1), "version"),
    c("1.0", "2.3.4", "1.2.3", NA_character_)
  )
})

test_that("parse_dependency_field() treats absent/blank fields as no deps", {
  expect_identical(parse_dependency_field(NULL), list())
  expect_identical(parse_dependency_field(NA), list())
  expect_identical(parse_dependency_field(NA_character_), list())
  expect_identical(parse_dependency_field(character(0)), list())
  expect_identical(parse_dependency_field(""), list())
  expect_identical(parse_dependency_field("   \n\t "), list())
})

test_that("parse_dependency_field() drops empty and malformed entries", {
  # Stray commas and whitespace-only entries are ignored.
  padded <- parse_dependency_field("r4subcore, ,  r4subdata (>= 0.1.0) ,")
  expect_length(padded, 2L)
  expect_identical(padded[[1]]$name, "r4subcore")
  expect_identical(padded[[2]]$name, "r4subdata")

  # A token that does not start with a letter is not a package name.
  dropped <- parse_dependency_field("123bad, r4subcore (>= 0.1.0)")
  expect_length(dropped, 1L)
  expect_identical(dropped[[1]]$name, "r4subcore")
})

test_that("dependency_status() covers every branch and operator", {
  # Not installed: hard edges are missing, optional edges suggested-missing.
  expect_identical(
    dependency_status("Imports", ">=", "1.0.0", NA_character_), "missing"
  )
  expect_identical(
    dependency_status("Depends", NA, NA, NA_character_), "missing"
  )
  expect_identical(
    dependency_status("Suggests", ">=", "1.0.0", NA_character_),
    "suggested-missing"
  )

  # Installed but no pinned version is always satisfied.
  expect_identical(dependency_status("Imports", NA, "1.0.0", "0.0.1"), "ok")
  expect_identical(dependency_status("Imports", ">=", NA, "0.0.1"), "ok")

  # >= boundary is inclusive.
  expect_identical(dependency_status("Imports", ">=", "1.0.0", "1.0.0"), "ok")
  expect_identical(
    dependency_status("Imports", ">=", "1.0.0", "0.9.9"), "outdated"
  )
  # > is strict.
  expect_identical(dependency_status("Imports", ">", "1.0.0", "1.0.1"), "ok")
  expect_identical(
    dependency_status("Imports", ">", "1.0.0", "1.0.0"), "outdated"
  )
  # == is exact.
  expect_identical(dependency_status("Imports", "==", "1.2.3", "1.2.3"), "ok")
  expect_identical(
    dependency_status("Imports", "==", "1.2.3", "1.2.4"), "outdated"
  )
  # <= boundary is inclusive.
  expect_identical(dependency_status("Imports", "<=", "2.0.0", "2.0.0"), "ok")
  expect_identical(
    dependency_status("Imports", "<=", "2.0.0", "2.0.1"), "outdated"
  )
  # < is strict.
  expect_identical(dependency_status("Imports", "<", "2.0.0", "1.9.9"), "ok")
  expect_identical(
    dependency_status("Imports", "<", "2.0.0", "2.0.0"), "outdated"
  )
})

test_that("dependency_status() compares versions numerically, not lexically", {
  # 0.10.0 outranks 0.9.0 numerically though it is smaller lexically.
  expect_identical(dependency_status("Imports", ">=", "0.9.0", "0.10.0"), "ok")
  expect_identical(
    dependency_status("Imports", ">=", "0.10.0", "0.9.0"), "outdated"
  )
})

test_that("dependency_status() honours the != operator", {
  # `!=` is a valid DESCRIPTION comparison operator and the field parser
  # already captures it; an installed version equal to the excluded one is
  # unsatisfied, any other version is fine.
  expect_identical(
    dependency_status("Imports", "!=", "1.0.0", "1.0.0"), "outdated"
  )
  expect_identical(dependency_status("Imports", "!=", "1.0.0", "2.0.0"), "ok")
  expect_identical(dependency_status("Imports", "!=", "1.0.0", "0.9.0"), "ok")
})

test_that("format() reports every problem status and hides ok rows", {
  obj <- new_r4sub_deps(tibble::tibble(
    package    = c("r4subui", "r4subcli", "r4subdata", "r4subcore"),
    dependency = c("r4subcore", "r4subcore", "r4subutils", "r4subbase"),
    type       = c("Imports", "Imports", "Suggests", "Imports"),
    required   = c(">= 2.0.0", NA, ">= 1.0.0", ">= 0.1.0"),
    installed  = c("1.0.0", "0.5.0", NA, "0.1.0"),
    status     = c("outdated", "ok", "suggested-missing", "ok")
  ))
  out <- format(obj)

  # Header plus one line per non-ok row (two of the four).
  expect_match(out[1], "issues \\(2\\)")
  expect_length(out, 3L)
  expect_true(any(grepl(
    "r4subui requires r4subcore \\(>= 2.0.0\\) but has 1.0.0 \\[outdated\\]",
    out
  )))
  expect_true(any(grepl(
    "r4subdata requires r4subutils \\(>= 1.0.0\\) but has not installed \\[suggested-missing\\]",
    out
  )))
  # The satisfied rows never appear in the report.
  expect_false(any(grepl("r4subcli", out)))
  expect_false(any(grepl("r4subbase", out)))
})

test_that("new_r4sub_deps() tags the class exactly once", {
  base <- tibble::tibble(
    package = character(0), dependency = character(0), type = character(0),
    required = character(0), installed = character(0), status = character(0)
  )
  once <- new_r4sub_deps(base)
  twice <- new_r4sub_deps(once)

  expect_s3_class(once, "r4sub_deps")
  expect_identical(class(once), class(twice))
  expect_identical(sum(class(twice) == "r4sub_deps"), 1L)
})

test_that("include_suggests only adds Suggests rows, preserving hard edges", {
  hard <- suppressMessages(r4sub_deps())
  all_edges <- suppressMessages(r4sub_deps(include_suggests = TRUE))

  key <- function(d) paste(d$package, d$dependency, d$type, sep = "\r")
  # Every hard edge survives when Suggests are added in.
  expect_true(all(key(hard) %in% key(all_edges)))
  # Anything added by opting in is a Suggests edge.
  added <- all_edges[!(key(all_edges) %in% key(hard)), , drop = FALSE]
  expect_true(all(added$type == "Suggests"))
})
