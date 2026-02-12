#' Core R4SUB packages
#'
#' Returns the names of the R4SUB packages that are automatically attached
#' when `library(r4sub)` is called.
#'
#' @return A character vector of package names.
#'
#' @examples
#' core_packages()
#'
#' @export
core_packages <- function() {
  c("r4subcore", "r4subtrace", "r4subscore", "r4subrisk",
    "r4subdata", "r4subprofile")
}

# Check which packages are attached to the search path
# @noRd
is_attached <- function(pkgs) {
  paste0("package:", pkgs) %in% search()
}

# Format the startup message
# @noRd
r4sub_attach_message <- function(pkgs) {
  versions <- vapply(pkgs, function(p) {
    as.character(utils::packageVersion(p))
  }, character(1))

  max_len <- max(nchar(pkgs))
  lines <- vapply(seq_along(pkgs), function(i) {
    pad <- strrep(" ", max_len - nchar(pkgs[i]))
    paste0("  ", pkgs[i], pad, " ", versions[i])
  }, character(1))

  header <- paste0(
    "-- Attaching R4SUB packages (r4sub ",
    utils::packageVersion("r4sub"), ") ",
    strrep("-", 30)
  )

  paste(c(header, lines), collapse = "\n")
}

.onAttach <- function(libname, pkgname) {
  needed <- core_packages()
  attached <- needed[is_attached(needed)]

  if (length(attached) > 0L) {
    msg <- r4sub_attach_message(attached)
    packageStartupMessage(msg)
  }
}
