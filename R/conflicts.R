#' Show R4SUB Function Conflicts
#'
#' Reports any exported function name collisions between attached R4SUB
#' packages and other loaded packages.
#'
#' @return A tibble with columns: `func`, `r4sub_package`, `other_package`.
#'   Returned invisibly. Prints conflicts if any exist.
#'
#' @examples
#' r4sub_conflicts()
#'
#' @export
r4sub_conflicts <- function() {
  r4sub_pkgs <- core_packages()
  attached <- r4sub_pkgs[is_attached(r4sub_pkgs)]

  empty_result <- tibble::tibble(
    func = character(0),
    r4sub_package = character(0),
    other_package = character(0)
  )

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
  invisible(tibble::as_tibble(result))
}
