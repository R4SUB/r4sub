#' Check R4SUB Ecosystem Dependency Compatibility
#'
#' Inspects the dependencies that R4SUB ecosystem packages declare on *each
#' other* and reports whether the versions you have installed satisfy those
#' declarations. This answers a question a meta-package is well placed to
#' answer: "is my installed R4SUB ecosystem internally consistent, or is some
#' member too old for another member that depends on it?"
#'
#' The check is performed entirely from locally installed package metadata
#' (each package's `DESCRIPTION`). It performs no network access and does not
#' consult CRAN; it only compares the versions already installed on your
#' machine against the version constraints those packages declare.
#'
#' Only edges *within* the R4SUB ecosystem are reported: a dependency on, say,
#' `cli` or `tibble` is ignored, because this helper is about ecosystem
#' self-consistency rather than general package management.
#'
#' The returned object carries the `r4sub_deps` class, so printing it renders a
#' readable report that lists any outdated or missing ecosystem dependencies.
#' The underlying object is a [tibble::tibble()], so it can be filtered,
#' counted, or joined like any other data frame.
#'
#' @param include_suggests Logical. If `FALSE` (default), only hard
#'   dependencies (`Depends` and `Imports`) are examined. If `TRUE`, `Suggests`
#'   edges are included as well; these are optional, so an unsatisfied
#'   `Suggests` edge is reported with status `"suggested-missing"` rather than
#'   `"missing"`.
#' @param x An `r4sub_deps` object, as returned by `r4sub_deps()`.
#' @param ... Ignored, for compatibility with the [format()] and [print()]
#'   generics.
#'
#' @return An object of class `r4sub_deps` (a tibble) with one row per
#'   ecosystem-internal dependency edge and the columns:
#'   \describe{
#'     \item{`package`}{The ecosystem package that declares the dependency.}
#'     \item{`dependency`}{The ecosystem package it depends on.}
#'     \item{`type`}{`"Depends"`, `"Imports"`, or `"Suggests"`.}
#'     \item{`required`}{The declared version constraint (e.g. `">= 0.1.2"`),
#'       or `NA` when no version is pinned.}
#'     \item{`installed`}{The installed version of `dependency`, or `NA` when it
#'       is not installed.}
#'     \item{`status`}{`"ok"`, `"outdated"`, `"missing"`, or, for optional
#'       edges, `"suggested-missing"`.}
#'   }
#'   Returned invisibly; a one-line summary is printed when the function is
#'   called, and the full report is produced by the `print`/`format` methods.
#'
#' @examples
#' # Report ecosystem-internal dependency compatibility
#' deps <- r4sub_deps()
#'
#' # Render the full report (same as printing `deps`)
#' print(deps)
#'
#' # Keep only unsatisfied edges
#' deps[deps$status != "ok", ]
#'
#' @export
r4sub_deps <- function(include_suggests = FALSE) {
  eco <- c("r4sub", r4sub_registry()$package)

  types <- if (isTRUE(include_suggests)) {
    c("Depends", "Imports", "Suggests")
  } else {
    c("Depends", "Imports")
  }

  installed_eco <- eco[vapply(eco, is_installed, logical(1))]

  rows <- list()
  for (pkg in installed_eco) {
    fields <- suppressWarnings(
      utils::packageDescription(pkg, fields = types)
    )
    for (type in types) {
      field <- fields[[type]]
      deps <- parse_dependency_field(field)
      for (d in deps) {
        if (!(d$name %in% eco) || identical(d$name, pkg)) {
          next
        }
        inst <- dependency_version(d$name)
        rows[[length(rows) + 1L]] <- tibble::tibble(
          package    = pkg,
          dependency = d$name,
          type       = type,
          required   = if (is.na(d$op)) {
            NA_character_
          } else {
            paste(d$op, d$version)
          },
          installed  = inst,
          status     = dependency_status(type, d$op, d$version, inst)
        )
      }
    }
  }

  result <- if (length(rows) == 0L) {
    tibble::tibble(
      package    = character(0),
      dependency = character(0),
      type       = character(0),
      required   = character(0),
      installed  = character(0),
      status     = character(0)
    )
  } else {
    do.call(rbind, rows)
  }

  n_problem <- sum(result$status != "ok")
  if (n_problem > 0L) {
    cli::cli_alert_warning(
      "{n_problem} ecosystem dependency issue{?s} found."
    )
  } else {
    cli::cli_alert_success("All R4SUB ecosystem dependencies satisfied.")
  }

  invisible(new_r4sub_deps(result))
}

# Is a package installed?
# @noRd
is_installed <- function(pkg) {
  requireNamespace(pkg, quietly = TRUE)
}

# Installed version of a package as a character scalar, or NA.
# @noRd
dependency_version <- function(pkg) {
  tryCatch(
    as.character(utils::packageVersion(pkg)),
    error = function(e) NA_character_
  )
}

# Parse a DESCRIPTION dependency field into a list of
# list(name, op, version) entries. Returns an empty list for an absent field.
# @noRd
parse_dependency_field <- function(field) {
  if (is.null(field) || length(field) == 0L || is.na(field) ||
      !nzchar(trimws(field))) {
    return(list())
  }

  parts <- strsplit(field, ",", fixed = TRUE)[[1]]
  parts <- trimws(parts)
  parts <- parts[nzchar(parts)]

  out <- lapply(parts, function(p) {
    m <- regmatches(
      p,
      regexec(
        "^([A-Za-z][A-Za-z0-9.]*)\\s*(?:\\(\\s*([<>=!]+)\\s*([0-9.-]+)\\s*\\))?",
        p
      )
    )[[1]]
    if (length(m) < 4L || !nzchar(m[2])) {
      return(NULL)
    }
    list(
      name    = m[2],
      op      = if (nzchar(m[3])) m[3] else NA_character_,
      version = if (nzchar(m[4])) m[4] else NA_character_
    )
  })

  out[!vapply(out, is.null, logical(1))]
}

# Compute the status of a single dependency edge.
# @noRd
dependency_status <- function(type, op, required, installed) {
  if (is.na(installed)) {
    return(if (identical(type, "Suggests")) "suggested-missing" else "missing")
  }
  if (is.na(op) || is.na(required)) {
    return("ok")
  }
  cmp <- utils::compareVersion(installed, required)
  satisfied <- switch(
    op,
    ">=" = cmp >= 0,
    ">"  = cmp > 0,
    "==" = cmp == 0,
    "<=" = cmp <= 0,
    "<"  = cmp < 0,
    "!=" = cmp != 0,
    TRUE
  )
  if (isTRUE(satisfied)) "ok" else "outdated"
}

# Attach the `r4sub_deps` class to a deps tibble.
# @noRd
new_r4sub_deps <- function(x) {
  if (!inherits(x, "r4sub_deps")) {
    class(x) <- c("r4sub_deps", class(x))
  }
  x
}

#' @rdname r4sub_deps
#' @export
format.r4sub_deps <- function(x, ...) {
  problems <- x[x$status != "ok", , drop = FALSE]

  if (nrow(problems) == 0L) {
    return("All R4SUB ecosystem dependencies satisfied.")
  }

  header <- paste0(
    "-- R4SUB ecosystem dependency issues (", nrow(problems), ") ",
    strrep("-", 20)
  )
  lines <- vapply(seq_len(nrow(problems)), function(i) {
    req <- if (is.na(problems$required[i])) {
      ""
    } else {
      paste0(" (", problems$required[i], ")")
    }
    have <- if (is.na(problems$installed[i])) {
      "not installed"
    } else {
      problems$installed[i]
    }
    sprintf(
      "x %s requires %s%s but has %s [%s]",
      problems$package[i], problems$dependency[i], req, have,
      problems$status[i]
    )
  }, character(1))

  c(header, lines)
}

#' @rdname r4sub_deps
#' @export
print.r4sub_deps <- function(x, ...) {
  problems <- x[x$status != "ok", , drop = FALSE]

  if (nrow(problems) == 0L) {
    cli::cli_alert_success("All R4SUB ecosystem dependencies satisfied.")
    return(invisible(x))
  }

  cli::cli_h2("R4SUB ecosystem dependency issues ({nrow(problems)})")
  for (i in seq_len(nrow(problems))) {
    req <- if (is.na(problems$required[i])) {
      ""
    } else {
      paste0(" (", problems$required[i], ")")
    }
    have <- if (is.na(problems$installed[i])) {
      "not installed"
    } else {
      problems$installed[i]
    }
    cli::cli_alert_warning(
      "{.pkg {problems$package[i]}} requires {.pkg {problems$dependency[i]}}{req} but has {have} [{problems$status[i]}]"
    )
  }
  invisible(x)
}
