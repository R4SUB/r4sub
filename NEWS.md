# r4sub (development version)

- Add `r4sub_readiness()`, a one-call orchestration runner for the whole
  ecosystem. Given a shared evidence table (or a list of tables, combined with
  `r4subcore::bind_evidence()`), it drives the installed sibling packages in
  dependency order -- scoring via `r4subscore`, risk via `r4subrisk`,
  traceability via `r4subtrace`, usability via `r4subusability`,
  reproducibility via `r4subrepro`, and, when a profile is supplied, profile
  conformance via `r4subprofile` -- and assembles every sibling's native result
  into a single classed object with a readable `print()`/`format()` report. It
  computes nothing itself: every number it surfaces (the Submission Confidence
  Index and band, the overall risk score, and so on) is produced by the sibling
  that owns that concern. Each stage is guarded with `requireNamespace()` and is
  wrapped so that a missing package is recorded as `"skipped"` and a sibling
  error as `"error"` without aborting the rest of the run.
- Add `r4sub_deps()`, an ecosystem dependency-compatibility checker. It reads
  each installed member package's declared dependencies and reports every edge
  that points at another R4SUB package, flagging any dependency that is missing
  or whose installed version is older than the member requires. The check is
  purely local (it inspects installed `DESCRIPTION` metadata and performs no
  network access). By default only hard dependencies (`Depends`/`Imports`) are
  examined; pass `include_suggests = TRUE` to include optional edges. The result
  is a classed tibble with a readable `print()`/`format()` report.
- `r4sub_conflicts()` now returns a classed `r4sub_conflicts` object with
  `print()` and `format()` methods that render a readable
  "`pkg::fn` overrides `other::fn`" report, in the style of the conflicted
  package. The object is still a tibble with the same columns, so existing
  code that inspects it keeps working. A one-line conflict summary can also be
  shown at attach time by setting `options(r4sub.conflicts = TRUE)`; this is
  off by default, so the default `library(r4sub)` startup output and attach
  set are unchanged.
- Add `r4sub_sitrep()`, a one-shot situation report composing your R version
  and platform, each ecosystem package's installed version and attach status,
  and the current conflict count. It is a pure composition of existing helpers
  and performs no network access.
- Add a formal internal ecosystem registry that tags each package by role
  (core vs optional). Optional packages (`r4subui`, `r4subpharma`,
  `r4subrepro`, `r4agent`) are now discoverable through `r4sub_packages()` and
  `r4sub_status()`. This is a listing change only: the set of packages attached
  by `library(r4sub)` is unchanged.
- Correct the `r4sub` version shown in the README startup-message example so it
  matches the current package version.
- Quieten expected `utils::citation()` "could not determine year" warnings in
  the `r4sub_cite()` and `r4sub_news()` tests (these originate from the
  dependencies' metadata, not from `r4sub`).

# r4sub 0.2.1

- Fix the pkgdown workflow so it resolves every ecosystem dependency, and polish metadata for CRAN.

# r4sub 0.2.0

- `r4subusability` is now a core package: `core_packages()` returns all seven
  packages and `library(r4sub)` attaches `r4subusability` alongside the others.
  It moves from Suggests to Imports, and the README table is updated to match.
- Add vignette: "R4SUB and pharmaverse", documenting how R4SUB reads what
  admiral, xportr, and other pharmaverse tools produce, and how riskmetric
  (tooling risk) and r4subrisk (submission risk) complement each other.
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
