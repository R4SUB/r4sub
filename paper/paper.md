---
title: "R4SUB: An open-source R ecosystem for quantifying clinical submission readiness"
tags:
  - R
  - clinical trials
  - regulatory submission
  - CDISC
  - data quality
  - traceability
  - reproducibility
authors:
  - name: Pawan Rama Mali
    orcid: 0000-0001-7864-5819
    affiliation: 1
affiliations:
  - name: Independent Researcher
    index: 1
date: 16 November 2026
bibliography: paper.bib
---

# Summary

Preparing a clinical study data package for a regulatory submission to the US
Food and Drug Administration (FDA), the European Medicines Agency (EMA), or
another authority requires checking many largely independent properties of the
deliverables: whether the datasets conform to the Clinical Data Interchange
Standards Consortium (CDISC) foundational standards, whether analysis results
trace back to their source data, whether known risks have been quantified and
mitigated, whether labels and metadata are usable by a reviewer, and whether the
statistical analyses can be reproduced. Today these checks are performed late,
by hand, and with disparate single-purpose tools, and no openly specified,
scriptable measure summarises how ready a package is overall.

`R4SUB` ("Ready for Submission") is an ecosystem of twelve R packages that turns
these checks into reproducible, scriptable R code and combines their results
into a single, transparent **Submission Confidence Index (SCI)** — a 0–100
composite computed across five pillars (data quality, traceability, risk,
usability, and reproducibility). The index, its pillar structure, and its
weights are not hard-coded regulatory truth: they are supplied through
configurable **authority profiles**, so the method is fully inspectable and can
be adapted per regulator rather than asserting one fixed scoring. A single
`library(r4sub)` call attaches the core packages, and a worked flow reduces to
loading evidence, scoring it, and summarising the result:

```r
library(r4sub)
data(evidence_pharma)                                # r4subdata
scores <- compute_indicator_scores(evidence_pharma)  # r4subscore
sci    <- compute_sci(compute_pillar_scores(scores)) # r4subscore
```

# Statement of need

Regulatory submissions fail, or are delayed, for reasons that are often
preventable. An FDA-authored analysis of all Refuse-to-File letters for new drug
applications over 2008–2017 found that 84.5% of refusal reasons were scientific
or quality deficiencies, and that resubmitted applications took a median of 784
days from original submission to approval [@chahal2021]. Each day of avoidable
delay carries a direct and opportunity cost [@smith2024]. Since 2021 the FDA has
automatically rejected eCTD study-data submissions that fail its Technical
Rejection Criteria for conformance. Yet readiness is still assessed with tools
that each cover a single dimension — for example, conformance checkers that grade
CDISC validation findings, or data-quality dashboards built on the
Kahn harmonized framework [@kahn2016; @blacketer2021] — and with manual,
non-reproducible review for everything else.

`R4SUB` addresses the gap between those single-dimension checkers and an
integrated, decision-grade view. It provides an **open, multi-pillar composite
computed directly from the submission artifacts**, with openly specified weights
and a reference implementation, rather than a proprietary score, a
self-assessment questionnaire, or a single conformance dimension. The design
draws on the composite-indicator methodology of the OECD/JRC handbook
[@nardo2008] — including its insistence that an index be transparent and
robustness-tested rather than treated as an authoritative number — and on the
readiness-level tradition established by Technology Readiness Levels and Data
Readiness Levels [@lawrence2017]. The intended users are clinical programmers,
statisticians, data managers, and regulatory teams who want submission readiness
expressed as a reproducible, version-controlled computation rather than the
outcome of a meeting.

`R4SUB` deliberately separates *measurement* from *judgment*: the packages
compute indicators and aggregate them under a stated profile, but the thresholds,
weights, and band definitions that turn a score into a go/no-go decision are
caller-supplied and authority-specific. This keeps the tooling honest about what
it does and does not establish, and makes the empirical validation of any
particular profile a separable, ongoing effort rather than a claim baked into the
software.

# Design and functionality

The ecosystem is organised around a shared evidence schema and one package per
concern:

- **`r4subcore`** — the evidence schema, scoring primitives, and parsers that the
  other packages build on.
- **`r4subdata`** / **`r4subpharma`** — CDISC-shaped example datasets for demos,
  testing, and worked examples.
- **`r4subtrace`** — an ADaM/SDTM traceability engine that grades how analysis
  results link back to source data.
- **`r4subrisk`** — Failure Mode and Effects Analysis (FMEA)-based risk
  quantification.
- **`r4subusability`** — usability indicators such as label quality, Define-XML
  completeness, and annotation coverage.
- **`r4subrepro`** — reproducibility indicators for the analysis environment and
  outputs.
- **`r4subprofile`** — configurable regulatory submission profiles that carry the
  weights and thresholds used to aggregate indicators.
- **`r4subscore`** — aggregation of indicator and pillar scores into the
  Submission Confidence Index.
- **`r4subui`** — an interactive Shiny dashboard over the ecosystem.
- **`r4agent`** — benchmarking utilities for AI/agent-assisted evaluation.
- **`r4sub`** — a thin meta-package that installs, attaches, and reports on the
  ecosystem, in the style of `tidyverse`.

Every package is MIT-licensed, documented with `pkgdown` sites, and covered by an
automated test suite and continuous integration. The packages are designed to be
composed: the end-to-end vignette walks from raw evidence through scoring,
profiling, risk assessment, traceability, and the dashboard.

# Acknowledgements

R4SUB is developed as open-source software for clinical-programming and
regulatory-submission workflows. This paper describes the `r4sub` meta-package
and the wider R4SUB ecosystem it installs and coordinates.

# References
