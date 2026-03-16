# r4sub

<!-- badges: start -->
[![R-CMD-check](https://github.com/R4SUB/r4sub/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/R4SUB/r4sub/actions/workflows/R-CMD-check.yaml)
[![CRAN status](https://www.r-pkg.org/badges/version/r4sub)](https://CRAN.R-project.org/package=r4sub)
[![CRAN downloads](https://cranlogs.r-pkg.org/badges/r4sub)](https://CRAN.R-project.org/package=r4sub)
[![r-universe](https://r4sub.r-universe.dev/badges/r4sub)](https://r4sub.r-universe.dev/r4sub)
<!-- badges: end -->

**r4sub** is the meta-package for the **R4SUB** (Ready for Submission) clinical submission readiness ecosystem. A single `library(r4sub)` call installs and attaches all core packages.

## End-to-End Demo

See the **[End-to-End vignette](https://r4sub.github.io/r4sub/articles/end-to-end.html)** for a complete walkthrough:
load evidence → score → profile → risk → traceability → dashboard.

## Installation

```r
install.packages("r4sub")
```

Development version:

```r
pak::pak("R4SUB/r4sub")
```

## Usage

```r
library(r4sub)
# ── Attaching R4SUB packages ───────────────────────────────────────────
#   r4subcore      0.1.2
#   r4subtrace     0.1.1
#   r4subscore     0.1.1
#   r4subrisk      0.1.1
#   r4subdata      0.1.2
#   r4subprofile   0.1.1
#   r4subusability 0.1.0

# All ecosystem functions are now available
data(evidence_pharma)                                    # r4subdata
scores <- compute_indicator_scores(evidence_pharma)      # r4subscore
sci    <- compute_sci(compute_pillar_scores(scores))     # r4subscore

# Ecosystem utilities
r4sub_packages()   # versions and attachment status
r4sub_status()     # installation check
r4sub_conflicts()  # detect function name collisions
r4sub_news()       # what changed in each package
r4sub_cite()       # citation info for regulatory documents
```

## Suppress Startup Message

```r
options(r4sub.quiet = TRUE)
library(r4sub)
```

## Packages

| Package | Purpose | Auto-attached |
|---|---|---|
| **r4subcore** | Evidence schema, scoring primitives, parsers | Yes |
| **r4subtrace** | ADaM/SDTM traceability engine | Yes |
| **r4subscore** | Submission Confidence Index (SCI) scoring | Yes |
| **r4subrisk** | FMEA-based risk quantification | Yes |
| **r4subdata** | Example datasets for demos and testing | Yes |
| **r4subprofile** | Regulatory submission profiles | Yes |
| **r4subusability** | Usability indicators (label quality, Define-XML, annotations) | Yes |
| **r4subui** | Interactive Shiny dashboard | No (install separately) |

## Key Functions

| Function | Purpose |
|---|---|
| `core_packages()` | List the auto-attached package names |
| `r4sub_packages()` | Show all packages with installed version and status |
| `r4sub_status()` | Check which ecosystem packages are installed |
| `r4sub_conflicts()` | Report function name conflicts with other packages |
| `r4sub_news()` | Show NEWS entries for each ecosystem package |
| `r4sub_cite()` | Print citation information for regulatory or academic use |

## Managing Conflicts

Use the `::` operator to be explicit when conflicts arise:

```r
r4subcore::validate_evidence(ev)
r4subscore::compute_sci(pillar_scores)
```

Run `r4sub_conflicts()` after `library(r4sub)` to see any collisions.

## License

MIT
