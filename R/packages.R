#' List R4SUB Ecosystem Packages
#'
#' Returns a tibble of all R4SUB packages with their installed version and
#' current attachment status.
#'
#' @param include_self Logical. If `TRUE` (default), includes the `r4sub`
#'   meta-package itself in the listing.
#'
#' @return A tibble with columns: `package`, `version`, `attached`.
#'
#' @examples
#' r4sub_packages()
#'
#' @export
r4sub_packages <- function(include_self = TRUE) {
  pkgs <- c(core_packages(), "r4subui")
  if (include_self) {
    pkgs <- c("r4sub", pkgs)
  }

  versions <- vapply(pkgs, function(p) {
    tryCatch(
      as.character(utils::packageVersion(p)),
      error = function(e) NA_character_
    )
  }, character(1))

  tibble::tibble(
    package  = pkgs,
    version  = versions,
    attached = is_attached(pkgs)
  )
}
