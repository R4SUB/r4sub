#' Check R4SUB Package Installation Status
#'
#' Reports the installed version of each R4SUB ecosystem package and
#' highlights any packages that are not installed.
#'
#' @return A tibble with columns: `package`, `installed`. Returned invisibly.
#'
#' @examples
#' r4sub_update()
#'
#' @export
r4sub_update <- function() {
  pkgs <- c("r4sub", core_packages(), "r4subui")

  installed <- vapply(pkgs, function(p) {
    tryCatch(
      as.character(utils::packageVersion(p)),
      error = function(e) NA_character_
    )
  }, character(1))

  result <- tibble::tibble(
    package   = pkgs,
    installed = installed
  )

  not_installed <- result$package[is.na(result$installed)]
  n_installed <- sum(!is.na(result$installed))

  if (length(not_installed) > 0L) {
    cli::cli_alert_warning("Not installed: {.pkg {not_installed}}")
  }

  cli::cli_alert_success("{n_installed} R4SUB package{?s} installed.")

  invisible(result)
}
