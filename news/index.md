# Changelog

## r4sub 0.2.1

- Fix the pkgdown workflow so it resolves every ecosystem dependency,
  and polish metadata for CRAN.

## r4sub 0.2.0

- `r4subusability` is now a core package:
  [`core_packages()`](https://r4sub.github.io/r4sub/reference/core_packages.md)
  returns all seven packages and
  [`library(r4sub)`](https://r4sub.github.io/r4sub/) attaches
  `r4subusability` alongside the others. It moves from Suggests to
  Imports, and the README table is updated to match.
- Add vignette: “R4SUB and pharmaverse”, documenting how R4SUB reads
  what admiral, xportr, and other pharmaverse tools produce, and how
  riskmetric (tooling risk) and r4subrisk (submission risk) complement
  each other.
- Rewrote the README: clearer purpose, quick-start example, and links to
  every ecosystem repository.
- Fixed the `DESCRIPTION` to expand R4SUB as “Ready for Submission” (was
  inconsistent with the rest of the documentation).
- Added a standard R package `.gitignore`.

## r4sub 0.1.0

CRAN release: 2026-03-16

- Initial CRAN release.
- [`core_packages()`](https://r4sub.github.io/r4sub/reference/core_packages.md):
  list the 6 auto-attached ecosystem packages.
- [`r4sub_packages()`](https://r4sub.github.io/r4sub/reference/r4sub_packages.md):
  show all packages with version and attachment status.
- [`r4sub_status()`](https://r4sub.github.io/r4sub/reference/r4sub_status.md):
  check which ecosystem packages are installed.
- [`r4sub_conflicts()`](https://r4sub.github.io/r4sub/reference/r4sub_conflicts.md):
  detect function name conflicts with other loaded packages.
- [`r4sub_news()`](https://r4sub.github.io/r4sub/reference/r4sub_news.md):
  print NEWS for each ecosystem package.
- [`r4sub_cite()`](https://r4sub.github.io/r4sub/reference/r4sub_cite.md):
  print citation information for regulatory or academic use.
- Startup message can be suppressed with `options(r4sub.quiet = TRUE)`.
