# r4sub

<!-- badges: start -->
[![R-CMD-check](https://github.com/R4SUB/r4sub/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/R4SUB/r4sub/actions/workflows/R-CMD-check.yaml)
[![CRAN status](https://www.r-pkg.org/badges/version/r4sub)](https://CRAN.R-project.org/package=r4sub)
[![CRAN downloads](https://cranlogs.r-pkg.org/badges/r4sub)](https://CRAN.R-project.org/package=r4sub)
[![r-universe](https://r4sub.r-universe.dev/badges/r4sub)](https://r4sub.r-universe.dev/r4sub)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
<!-- badges: end -->

**r4sub** is the meta-package for the **R4SUB** (*Ready for Submission*) ecosystem. It
provides a toolkit for quantifying how ready clinical study data is for regulatory submission.
A single `library(r4sub)` call installs and attaches every core package, the same way
`library(tidyverse)` loads the tidyverse.

## Why r4sub?

Preparing an ADaM/SDTM data package for an FDA or EMA submission means checking
traceability, scoring submission confidence, and quantifying risk across dozens of
datasets. R4SUB turns those checks into reproducible, scriptable R code. `r4sub`
itself is intentionally thin. It loads the ecosystem and helps you manage it; the
domain logic lives in the satellite packages listed below.

## Installation

```r
# Released version (CRAN)
install.packages("r4sub")

# Development version (GitHub)
pak::pak("R4SUB/r4sub")
```

## Quick start

```r
library(r4sub)
#> -- Attaching R4SUB packages (r4sub 0.2.0) ------------------------------
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

See the **[End-to-End vignette](https://r4sub.github.io/r4sub/articles/end-to-end.html)**
for the full walkthrough: load evidence, score, profile, assess risk, check traceability, and build the dashboard.

## The ecosystem

| Package | Purpose | Attached on `library(r4sub)` |
|---|---|:--:|
| [r4subcore](https://github.com/R4SUB/r4subcore) | Evidence schema, scoring primitives, parsers | ✅ |
| [r4subtrace](https://github.com/R4SUB/r4subtrace) | ADaM/SDTM traceability engine | ✅ |
| [r4subscore](https://github.com/R4SUB/r4subscore) | Submission Confidence Index (SCI) scoring | ✅ |
| [r4subrisk](https://github.com/R4SUB/r4subrisk) | FMEA-based risk quantification | ✅ |
| [r4subdata](https://github.com/R4SUB/r4subdata) | Example datasets for demos and testing | ✅ |
| [r4subprofile](https://github.com/R4SUB/r4subprofile) | Regulatory submission profiles | ✅ |
| [r4subusability](https://github.com/R4SUB/r4subusability) | Usability indicators (label quality, Define-XML, annotations) | ✅ |
| [r4subui](https://github.com/R4SUB/r4subui) | Interactive Shiny dashboard | Install separately |

`core_packages()` returns the seven packages that are auto-attached.

## Ecosystem utilities

r4sub exports six helpers for working with the ecosystem as a whole:

| Function | Purpose |
|---|---|
| `core_packages()` | List the auto-attached package names |
| `r4sub_packages()` | Show all packages with installed version and status |
| `r4sub_status()` | Check which ecosystem packages are installed |
| `r4sub_conflicts()` | Report function-name conflicts with other packages |
| `r4sub_news()` | Show NEWS entries for each ecosystem package |
| `r4sub_cite()` | Print citation information for regulatory or academic use |

```r
r4sub_packages()   # versions and attachment status
r4sub_conflicts()  # detect name collisions after attaching
```

## Managing conflicts

When two packages export the same name, use `::` to be explicit:

```r
r4subcore::validate_evidence(ev)
r4subscore::compute_sci(pillar_scores)
```

Run `r4sub_conflicts()` after `library(r4sub)` to list any collisions.

## Suppress the startup message

```r
options(r4sub.quiet = TRUE)
library(r4sub)
```

## Documentation

- Package site: <https://r4sub.github.io/r4sub/>
- End-to-end walkthrough: [vignette](https://r4sub.github.io/r4sub/articles/end-to-end.html)
- Issues and feature requests: <https://github.com/R4SUB/r4sub/issues>

## License

MIT © Pawan Rama Mali. See [LICENSE](LICENSE).
