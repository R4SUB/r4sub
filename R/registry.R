# Internal ecosystem registry
#
# A single source of truth tagging every R4SUB ecosystem package by its role:
#   - "core"     packages are auto-attached by `.onAttach` when `library(r4sub)`
#                is called (see `core_packages()`);
#   - "optional" packages belong to the ecosystem but are installed separately
#                and are never auto-attached (e.g. `r4subui`).
#
# This registry only changes which packages are *listed* by helpers such as
# `r4sub_packages()` and `r4sub_status()`. It does NOT affect which packages
# are attached: the attach set is defined by `core_packages()` alone.
# @noRd
r4sub_registry <- function() {
  tibble::tibble(
    package = c(
      # core (auto-attached, order matches the startup message)
      "r4subcore", "r4subtrace", "r4subscore", "r4subrisk",
      "r4subdata", "r4subprofile", "r4subusability",
      # optional (install separately, never auto-attached)
      "r4subui", "r4subpharma", "r4subrepro", "r4agent"
    ),
    role = c(
      rep("core", 7L),
      rep("optional", 4L)
    )
  )
}

# Optional R4SUB ecosystem packages (never auto-attached).
# @noRd
optional_packages <- function() {
  reg <- r4sub_registry()
  reg$package[reg$role == "optional"]
}
