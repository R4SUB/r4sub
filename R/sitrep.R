#' Situation Report for the R4SUB Ecosystem
#'
#' Prints a one-shot "situation report" (sitrep) for your current session: your
#' R version and platform, the installed version and attach status of every
#' R4SUB ecosystem package, and the number of function conflicts currently
#' detected. It performs no network access; it only inspects the packages
#' installed and attached in your session.
#'
#' `r4sub_sitrep()` is a pure composition of [r4sub_packages()],
#' [core_packages()], and [r4sub_conflicts()], modelled on the `sitrep`
#' helpers found across the tidyverse.
#'
#' @return A list with components `r_version`, `platform`, `packages` (the
#'   tibble returned by [r4sub_packages()]), and `conflicts` (the integer number
#'   of conflicts detected). Returned invisibly; called for its side effect of
#'   printing the report.
#'
#' @examples
#' r4sub_sitrep()
#'
#' @export
r4sub_sitrep <- function() {
  pkgs <- r4sub_packages(include_self = TRUE)
  conflicts <- suppressMessages(r4sub_conflicts())
  n_conflicts <- nrow(conflicts)

  r_version <- R.version.string
  platform  <- R.version$platform

  core <- core_packages()

  cli::cli_h2("R4SUB situation report")
  cli::cli_alert_info("{r_version}")
  cli::cli_alert_info("Platform: {platform}")

  for (i in seq_len(nrow(pkgs))) {
    pkg     <- pkgs$package[i]
    version <- if (is.na(pkgs$version[i])) "not installed" else pkgs$version[i]
    status  <- if (isTRUE(pkgs$attached[i])) "attached" else "not attached"
    role    <- if (identical(pkg, "r4sub")) {
      "meta"
    } else if (pkg %in% core) {
      "core"
    } else {
      "optional"
    }
    cli::cli_alert("{.pkg {pkg}} ({role}): {version} [{status}]")
  }

  if (n_conflicts > 0L) {
    cli::cli_alert_warning("{n_conflicts} conflict{?s} detected.")
  } else {
    cli::cli_alert_success("No conflicts detected.")
  }

  invisible(list(
    r_version = r_version,
    platform  = platform,
    packages  = pkgs,
    conflicts = n_conflicts
  ))
}
