# r4sub

**r4sub** is the meta-package for the R4SUB clinical submission readiness ecosystem.

A single `library(r4sub)` call installs and attaches all core packages.

## Installation

```r
pak::pak("R4SUB/r4sub")
```

## Usage

```r
library(r4sub)
# -- Attaching R4SUB packages (r4sub 0.1.0) -----
#   r4subcore     0.1.0
#   r4subtrace    0.1.0
#   r4subscore    0.1.0
#   r4subrisk     0.1.0
#   r4subdata     0.1.0
#   r4subprofile  0.1.0

# All functions are now available
data(evidence_pharma)
scores <- compute_indicator_scores(evidence_pharma)
sci <- compute_sci(compute_pillar_scores(evidence_pharma))

# Check ecosystem status
r4sub_packages()
r4sub_update()
r4sub_conflicts()
```

## Packages

| Package | Purpose | Auto-attached? |
|---|---|---|
| **r4subcore** | Evidence schema, scoring primitives, parsers | Yes |
| **r4subtrace** | ADaM/SDTM traceability engine | Yes |
| **r4subscore** | Submission Confidence Index (SCI) scoring | Yes |
| **r4subrisk** | FMEA-based risk quantification | Yes |
| **r4subdata** | Example datasets for demos and testing | Yes |
| **r4subprofile** | Regulatory submission profiles | Yes |
| **r4subui** | Interactive Shiny dashboard | No (install separately) |

## Exported Functions

| Function | Purpose |
|---|---|
| `core_packages()` | List the 6 auto-attached packages |
| `r4sub_packages()` | Show all packages with version and status |
| `r4sub_update()` | Check installation status |
| `r4sub_conflicts()` | Report function name conflicts |

## License

MIT
