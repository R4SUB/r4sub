# r4sub

**r4sub** is the meta-package for the **R4SUB** (*Ready for Submission*)
ecosystem. It provides a toolkit for quantifying how ready clinical
study data is for regulatory submission. A single
[`library(r4sub)`](https://r4sub.github.io/r4sub/) call installs and
attaches every core package, the same way
[`library(tidyverse)`](https://tidyverse.tidyverse.org) loads the
tidyverse.

## Why r4sub?

Preparing an ADaM/SDTM data package for an FDA or EMA submission means
checking traceability, scoring submission confidence, and quantifying
risk across dozens of datasets. R4SUB turns those checks into
reproducible, scriptable R code. `r4sub` itself is intentionally thin.
It loads the ecosystem and helps you manage it; the domain logic lives
in the satellite packages listed below.

## Installation

``` r

# Released version (CRAN)
install.packages("r4sub")

# Development version (GitHub)
pak::pak("R4SUB/r4sub")
```

## Quick start

``` r

library(r4sub)
#> -- Attaching R4SUB packages (r4sub 0.2.1) ------------------------------
#>   r4subcore      0.1.2
#>   r4subtrace     0.1.1
#>   r4subscore     0.1.1
#>   r4subrisk      0.1.1
#>   r4subdata      0.1.2
#>   r4subprofile   0.1.1
#>   r4subusability 0.1.0

# A worked example: load evidence -> score -> summarise
data(evidence_pharma)                                # r4subdata
scores <- compute_indicator_scores(evidence_pharma)  # r4subscore
sci    <- compute_sci(compute_pillar_scores(scores)) # r4subscore
```

See the **[End-to-End
vignette](https://r4sub.github.io/r4sub/articles/end-to-end.html)** for
the full walkthrough: load evidence, score, profile, assess risk, check
traceability, and build the dashboard.

## The ecosystem

| Package | Purpose | Attached on [`library(r4sub)`](https://r4sub.github.io/r4sub/) |
|----|----|:--:|
| [r4subcore](https://github.com/R4SUB/r4subcore) | Evidence schema, scoring primitives, parsers | ✅ |
| [r4subtrace](https://github.com/R4SUB/r4subtrace) | ADaM/SDTM traceability engine | ✅ |
| [r4subscore](https://github.com/R4SUB/r4subscore) | Submission Confidence Index (SCI) scoring | ✅ |
| [r4subrisk](https://github.com/R4SUB/r4subrisk) | FMEA-based risk quantification | ✅ |
| [r4subdata](https://github.com/R4SUB/r4subdata) | Example datasets for demos and testing | ✅ |
| [r4subprofile](https://github.com/R4SUB/r4subprofile) | Regulatory submission profiles | ✅ |
| [r4subusability](https://github.com/R4SUB/r4subusability) | Usability indicators (label quality, Define-XML, annotations) | ✅ |
| [r4subui](https://github.com/R4SUB/r4subui) | Interactive Shiny dashboard | Install separately |

[`core_packages()`](https://r4sub.github.io/r4sub/reference/core_packages.md)
returns the seven packages that are auto-attached.

### Optional packages

Beyond the seven core packages, the ecosystem includes optional packages
that are installed separately and are never auto-attached: `r4subui`
(above), `r4subpharma`, `r4subrepro`, and `r4agent`. These are tracked
in an internal core/optional registry, so
[`r4sub_packages()`](https://r4sub.github.io/r4sub/reference/r4sub_packages.md)
and
[`r4sub_status()`](https://r4sub.github.io/r4sub/reference/r4sub_status.md)
list them with their installed version and status even though
[`library(r4sub)`](https://r4sub.github.io/r4sub/) does not load them.
The default attach behavior is unchanged:
[`library(r4sub)`](https://r4sub.github.io/r4sub/) still attaches
exactly the seven core packages.

## Ecosystem utilities

r4sub exports seven helpers for working with the ecosystem as a whole:

| Function | Purpose |
|----|----|
| [`core_packages()`](https://r4sub.github.io/r4sub/reference/core_packages.md) | List the auto-attached package names |
| [`r4sub_packages()`](https://r4sub.github.io/r4sub/reference/r4sub_packages.md) | Show all packages (core and optional) with installed version and status |
| [`r4sub_status()`](https://r4sub.github.io/r4sub/reference/r4sub_status.md) | Check which ecosystem packages are installed |
| [`r4sub_conflicts()`](https://r4sub.github.io/r4sub/reference/r4sub_conflicts.md) | Report function-name conflicts with other packages |
| [`r4sub_sitrep()`](https://r4sub.github.io/r4sub/reference/r4sub_sitrep.md) | One-shot situation report of your session |
| [`r4sub_news()`](https://r4sub.github.io/r4sub/reference/r4sub_news.md) | Show NEWS entries for each ecosystem package |
| [`r4sub_cite()`](https://r4sub.github.io/r4sub/reference/r4sub_cite.md) | Print citation information for regulatory or academic use |

``` r

r4sub_packages()   # versions and attachment status
r4sub_conflicts()  # detect name collisions after attaching
r4sub_sitrep()     # full session report in one call
```

### Situation report

[`r4sub_sitrep()`](https://r4sub.github.io/r4sub/reference/r4sub_sitrep.md)
prints a one-shot situation report for your current session: your R
version and platform, the installed version and attach status of every
ecosystem package (core and optional), and the current conflict count.
It is a pure composition of the helpers above and performs no network
access.

``` r

r4sub_sitrep()
```

## Managing conflicts

When two packages export the same name, use `::` to be explicit:

``` r

r4subcore::validate_evidence(ev)
r4subscore::compute_sci(pillar_scores)
```

Run
[`r4sub_conflicts()`](https://r4sub.github.io/r4sub/reference/r4sub_conflicts.md)
after [`library(r4sub)`](https://r4sub.github.io/r4sub/) to list any
collisions. It prints a formatted conflict report in the style of the
[conflicted](https://conflicted.r-lib.org/) package, with one
`pkg::fn overrides other::fn` line per collision. The returned object is
still a tibble (columns `func`, `r4sub_package`, `other_package`), so
you can filter, count, or join it like any other data frame.

To see a one-line conflict summary at attach time, opt in with
`options(r4sub.conflicts = TRUE)` before loading. This is off by
default, so the standard
[`library(r4sub)`](https://r4sub.github.io/r4sub/) startup output is
unchanged.

``` r

options(r4sub.conflicts = TRUE)
library(r4sub)
```

## Suppress the startup message

``` r

options(r4sub.quiet = TRUE)
library(r4sub)
```

## Documentation

- Package site: <https://r4sub.github.io/r4sub/>
- End-to-end walkthrough:
  [vignette](https://r4sub.github.io/r4sub/articles/end-to-end.html)
- Issues and feature requests: <https://github.com/R4SUB/r4sub/issues>

## Maintained by

R4SUB is part of the open-source work of
[TechWorksLab](https://techworkslab.com) - clinical programming and
regulatory submissions. Maintainer: Pawan Rama Mali.

## License

MIT © Pawan Rama Mali. See
[LICENSE](https://r4sub.github.io/r4sub/LICENSE).

## Further reading

Background on the ideas behind R4SUB, from TECHWORKSLAB:

- [Submission readiness as a number, not a
  meeting](https://techworkslab.com/insights-submission-confidence-index)
- [More R4SUB articles on the TECHWORKSLAB
  blog](https://techworkslab.com/insights)
