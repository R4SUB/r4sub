# Contributing to r4sub

Thanks for taking the time to contribute. r4sub is the meta-package for
the R4SUB (“Ready for Submission”) ecosystem, so most domain logic lives
in the satellite packages (r4subcore, r4subtrace, r4subscore, r4subrisk,
r4subdata, r4subprofile). Please open changes against the package that
owns the code.

## Reporting a bug

Open an issue with the “Bug report” template and include:

- A minimal reproducible example (a `reprex::reprex()` is ideal).
- What you expected to happen and what happened instead.
- The output of
  [`sessionInfo()`](https://rdrr.io/r/utils/sessionInfo.html) or
  [`r4sub_packages()`](https://r4sub.github.io/r4sub/reference/r4sub_packages.md).

Search the existing issues first so we can avoid duplicates.

## Suggesting a feature

Open an issue with the “Feature request” template. Describe the problem
you are trying to solve before the solution you have in mind, and note
which package in the ecosystem the feature belongs to.

## Submitting a pull request

1.  Fork the repository and create a branch off `main` with a short,
    descriptive name.
2.  Make your change and add tests that cover it.
3.  Run the checks below and make sure they pass.
4.  Update `NEWS.md` with a short bullet describing the change.
5.  Open the pull request against `main` using the PR template, and link
    the issue it resolves.

Keep each pull request focused on one thing. Smaller pull requests are
easier to review and merge.

## Coding standards

- Follow the tidyverse style guide (<https://style.tidyverse.org>). The
  `styler` and `lintr` packages help.
- Document exported functions with roxygen2. Never hand-edit `NAMESPACE`
  or the files under `man/`; regenerate them with
  `roxygen2::roxygenise()`.
- Write tests with testthat (edition 3), one test file per source file.
- User-facing messages use the `cli` package.

## Running checks locally

``` r

# Regenerate docs after changing roxygen comments
roxygen2::roxygenise()

# Run the tests
devtools::test()

# Full package check
devtools::check()
```

Please make sure `devtools::check()` passes with no errors or warnings
before you open a pull request.

## Code of conduct

By participating in this project you agree to abide by the [Code of
Conduct](https://r4sub.github.io/r4sub/CODE_OF_CONDUCT.md).
