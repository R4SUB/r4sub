#' Show R4SUB Function Conflicts
#'
#' Reports any exported function name collisions between attached R4SUB
#' packages and other loaded packages. The returned object carries the
#' `r4sub_conflicts` class, so printing it (or passing it to [format()])
#' renders a readable "pkg::fn overrides other::fn" report in the style of
#' the \pkg{conflicted} package.
#'
#' The underlying object is still a [tibble::tibble()] with columns `func`,
#' `r4sub_package`, and `other_package`, so it can be filtered, counted, or
#' joined like any other data frame. Only its printed representation changes.
#'
#' @param x An `r4sub_conflicts` object, as returned by `r4sub_conflicts()`.
#' @param ... Ignored, for compatibility with the [format()] and [print()]
#'   generics.
#'
#' @return An object of class `r4sub_conflicts` (a tibble with columns
#'   `func`, `r4sub_package`, `other_package`). Returned invisibly. A one-line
#'   summary of the conflict count is printed when the function is called; the
#'   full per-conflict report is produced by the `print`/`format` methods.
#'
#' @examples
#' # Detect conflicts in the current session
#' conflicts <- r4sub_conflicts()
#'
#' # Render the full "overrides" report
#' print(conflicts)
#'
#' # The report is also available as a character vector
#' format(conflicts)
#'
#' @export
r4sub_conflicts <- function() {
  r4sub_pkgs <- core_packages()
  attached <- r4sub_pkgs[is_attached(r4sub_pkgs)]

  empty_result <- new_r4sub_conflicts(tibble::tibble(
    func = character(0),
    r4sub_package = character(0),
    other_package = character(0)
  ))

  if (length(attached) == 0L) {
    cli::cli_alert_info("No R4SUB packages currently attached.")
    return(invisible(empty_result))
  }

  # Get exports from attached R4SUB packages
  r4sub_exports <- list()
  for (pkg in attached) {
    r4sub_exports[[pkg]] <- getNamespaceExports(pkg)
  }

  # Get other attached packages (exclude base and R4SUB)
  base_pkgs <- c(
    "base", "stats", "utils", "graphics", "grDevices",
    "datasets", "methods", "tools"
  )
  all_attached <- gsub("^package:", "",
                       grep("^package:", search(), value = TRUE))
  other_pkgs <- setdiff(all_attached, c(attached, "r4sub", base_pkgs))

  conflicts_list <- list()
  for (pkg in attached) {
    for (other in other_pkgs) {
      other_exports <- tryCatch(
        getNamespaceExports(other),
        error = function(e) character(0)
      )
      overlap <- intersect(r4sub_exports[[pkg]], other_exports)
      if (length(overlap) > 0L) {
        conflicts_list <- c(conflicts_list, list(tibble::tibble(
          func = overlap,
          r4sub_package = pkg,
          other_package = other
        )))
      }
    }
  }

  if (length(conflicts_list) == 0L) {
    cli::cli_alert_success("No conflicts detected between R4SUB and other packages.")
    return(invisible(empty_result))
  }

  result <- do.call(rbind, conflicts_list)
  cli::cli_alert_warning("{nrow(result)} conflict{?s} found.")
  invisible(new_r4sub_conflicts(tibble::as_tibble(result)))
}

# Attach the `r4sub_conflicts` class to a conflicts tibble.
# @noRd
new_r4sub_conflicts <- function(x) {
  if (!inherits(x, "r4sub_conflicts")) {
    class(x) <- c("r4sub_conflicts", class(x))
  }
  x
}

#' @rdname r4sub_conflicts
#' @export
format.r4sub_conflicts <- function(x, ...) {
  if (nrow(x) == 0L) {
    return("No conflicts between R4SUB packages and other loaded packages.")
  }

  header <- paste0(
    "-- R4SUB conflicts (", nrow(x), ") ",
    strrep("-", 30)
  )
  lines <- sprintf(
    "x %s::%s overrides %s::%s",
    x$r4sub_package, x$func,
    x$other_package, x$func
  )
  c(header, lines)
}

#' @rdname r4sub_conflicts
#' @export
print.r4sub_conflicts <- function(x, ...) {
  if (nrow(x) == 0L) {
    cli::cli_alert_success(
      "No conflicts between R4SUB packages and other loaded packages."
    )
    return(invisible(x))
  }

  cli::cli_h2("R4SUB conflicts ({nrow(x)})")
  for (i in seq_len(nrow(x))) {
    r4 <- paste0(x$r4sub_package[i], "::", x$func[i])
    ot <- paste0(x$other_package[i], "::", x$func[i])
    cli::cli_alert_warning("{.fn {r4}} overrides {.fn {ot}}")
  }
  invisible(x)
}

# One-line conflict summary for the attach-time startup message.
#
# Returns `NULL` unless `options(r4sub.conflicts = TRUE)` has been set, so the
# default `library(r4sub)` startup output is unchanged. When enabled it returns
# a single human-readable line describing the current conflict count.
# @noRd
r4sub_conflicts_startup_line <- function() {
  if (!isTRUE(getOption("r4sub.conflicts"))) {
    return(NULL)
  }

  n <- nrow(suppressMessages(r4sub_conflicts()))
  if (n == 0L) {
    "r4sub: no conflicts with other attached packages."
  } else {
    paste0(
      "r4sub: ", n, " conflict", if (n == 1L) "" else "s",
      " with other attached packages (see `r4sub_conflicts()`)."
    )
  }
}
