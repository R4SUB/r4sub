#' Cite the R4SUB Ecosystem
#'
#' Prints citation information for the R4SUB ecosystem and each installed core
#' package. Use this when citing R4SUB tools in a regulatory submission
#' document, scientific paper, or validation report.
#'
#' @param package Character. Name of a specific R4SUB package to cite. If
#'   `NULL` (default), cites all installed core packages plus the meta-package.
#'
#' @return Invisibly returns a named list of `citation` objects, one per
#'   package. Called for its side effect of printing citation information to
#'   the console.
#'
#' @examples
#' r4sub_cite()
#' r4sub_cite("r4subcore")
#'
#' @export
r4sub_cite <- function(package = NULL) {
  pkgs <- if (is.null(package)) c("r4sub", core_packages()) else package

  results <- list()
  for (pkg in pkgs) {
    if (!requireNamespace(pkg, quietly = TRUE)) {
      cli::cli_alert_warning("{.pkg {pkg}} is not installed.")
      next
    }
    cli::cli_h2("{pkg}")
    cit <- utils::citation(pkg)
    print(cit)
    results[[pkg]] <- cit
  }

  invisible(results)
}
