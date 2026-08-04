# r4sub 0.2.0

- `r4subusability` is now a core package: `core_packages()` returns all seven
  packages and `library(r4sub)` attaches `r4subusability` alongside the others.
  It moves from Suggests to Imports, and the README table is updated to match.
- Rewrote the README: clearer purpose, quick-start example, and links to every
  ecosystem repository.
- Fixed the `DESCRIPTION` to expand R4SUB as "Ready for Submission" (was
  inconsistent with the rest of the documentation).
- Added a standard R package `.gitignore`.

# r4sub 0.1.0

- Initial CRAN release.
- `core_packages()`: list the 6 auto-attached ecosystem packages.
- `r4sub_packages()`: show all packages with version and attachment status.
- `r4sub_status()`: check which ecosystem packages are installed.
- `r4sub_conflicts()`: detect function name conflicts with other loaded packages.
- `r4sub_news()`: print NEWS for each ecosystem package.
- `r4sub_cite()`: print citation information for regulatory or academic use.
- Startup message can be suppressed with `options(r4sub.quiet = TRUE)`.
