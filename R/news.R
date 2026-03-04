#' Show R4SUB Ecosystem News
#'
#' Prints the NEWS entries for each installed R4SUB ecosystem package.
#' Useful for tracking what has changed across the ecosystem after updating.
#'
#' @param package Character. Name of a specific R4SUB package to show news for.
#'   Must be one of the core R4SUB packages. If `NULL` (default), shows news
#'   for all installed core packages.
#'
#' @return Invisibly returns a named list of news database objects, one per
#'   package. Called for its side effect of printing NEWS entries to the
#'   console.
#'
#' @examples
#' r4sub_news()
#' r4sub_news("r4subcore")
#'
#' @export
r4sub_news <- function(package = NULL) {
  pkgs <- if (is.null(package)) core_packages() else package

  results <- list()
  for (pkg in pkgs) {
    if (!requireNamespace(pkg, quietly = TRUE)) {
      cli::cli_alert_warning("{.pkg {pkg}} is not installed.")
      next
    }
    db <- tryCatch(
      utils::news(package = pkg),
      error = function(e) NULL
    )
    if (is.null(db) || nrow(db) == 0L) {
      cli::cli_alert_warning("No NEWS available for {.pkg {pkg}}.")
      next
    }
    cli::cli_h2("{pkg}")
    print(db)
    results[[pkg]] <- db
  }

  invisible(results)
}
