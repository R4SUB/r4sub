# Show R4SUB Ecosystem News

Prints the NEWS entries for each installed R4SUB ecosystem package.
Useful for tracking what has changed across the ecosystem after
updating.

## Usage

``` r
r4sub_news(package = NULL)
```

## Arguments

- package:

  Character. Name of a specific R4SUB package to show news for. Must be
  one of the core R4SUB packages. If `NULL` (default), shows news for
  all installed core packages.

## Value

Invisibly returns a named list of news database objects, one per
package. Called for its side effect of printing NEWS entries to the
console.

## Examples

``` r
r4sub_news()
#> 
#> ── r4subcore ──
#> 
#>                         Changes in version 0.3.1                        
#> 
#>   - Metadata and documentation polish for CRAN submission; no
#>     user-facing changes.
#> 
#>                         Changes in version 0.3.0                        
#> 
#>   - Add evidence_diff(), which compares two evidence tables and reports
#>     what changed between them: which findings were added, removed, or
#>     changed, and whether each change made the submission better or
#>     worse. Rows are matched on the indicator and asset, duplicate keys
#>     collapse to the worst row, and the result is ordered with
#>     regressions first so a team sees what to act on. This turns the
#>     evidence table into something you can track run over run, and it is
#>     the raw material behind higher-level trend views such as sci_diff().
#> 
#>                         Changes in version 0.2.1                        
#> 
#>   - hash_id() now hashes in memory with rlang::hash() instead of writing
#>     a temporary file and calling tools::md5sum on every call. The result
#>     is the same shape (a 32-character hex string, deterministic) but
#>     roughly three orders of magnitude faster, which removes the main
#>     bottleneck when building a trace model or generating identifiers for
#>     a large submission. The exact hash values change; they are opaque
#>     identifiers, not a persisted contract.
#>   - Add check_define_consistency() and define_variables(). The first
#>     compares the variables declared in Define-XML against the variables
#>     actually present in the datasets and emits evidence for each: a
#>     match, a variable documented but absent from the data, or a variable
#>     present but not documented. Drift between Define-XML and the data is
#>     a common submission problem, and this makes it a scored quality
#>     indicator. The second extracts the dataset and variable pairs from a
#>     Define-XML file.
#> 
#>                         Changes in version 0.2.0                        
#> 
#>   - Add read_p21_report(), which loads a Pinnacle 21 validation report
#>     from disk (CSV natively, Excel through the optional readxl package)
#>     ready for p21_to_evidence(). A team can now go from the report
#>     Pinnacle 21 already produces to scored evidence without
#>     hand-building a table.
#>   - canon_severity() now recognizes "notice", the severity Pinnacle 21
#>     uses for its lowest level, mapping it onto info.
#>   - The evidence table now carries a schema version. as_evidence()
#>     stamps it, evidence_schema_version() reports the current version or
#>     the version of a given table, and migrate_evidence() upgrades a
#>     table written by an older release. validate_evidence() tolerates an
#>     unstamped table but refuses an unknown or newer version, so a table
#>     written by a future release cannot be silently mis-scored.
#>   - Fix import_evidence(): a CSV or JSON round-trip could leave an
#>     all-NA character column (for example source_version) typed as
#>     logical, which then failed validation. Every schema column is now
#>     coerced back to its declared type on import.
#>   - Add evidence_schema_spec(), which publishes the evidence schema as a
#>     tidy table (column, type, required, allowed values, description) for
#>     use as a data dictionary or reference.
#>   - Add vignette: "The R4SUB Evidence Schema", the formal specification
#>     of the evidence table shared across the ecosystem.
#>   - Add adrg_to_evidence() and adrg_sections() for Analysis Data
#>     Reviewer's Guide coverage. Given a structured summary of which
#>     standard ADRG sections a guide contains, this emits usability
#>     evidence: missing required sections fail, missing recommended
#>     sections warn. The same machinery covers the SDRG via source_name.
#>   - Add evidence_sources(), a reference table of supported and planned
#>     evidence sources with their format, pillar, and entry point.
#>   - Harden define_xml_to_evidence() for real-world Define-XML
#>     variability. It now matches elements by local name, so it reads
#>     files regardless of how they mix the ODM and def: namespaces (a
#>     plain //ItemGroupDef query silently missed namespace-prefixed
#>     elements). Derivations are resolved from a referenced MethodDef when
#>     the Origin carries no inline text, missing optional elements are
#>     tolerated, and a partially parseable file now returns an informative
#>     warning.
#>   - Clarified the package DESCRIPTION: "R4SUB" expands to "Ready for
#>     Submission" (previously "R for Regulatory Submission", inconsistent
#>     with the rest of the ecosystem).
#> 
#>                         Changes in version 0.1.2                        
#> 
#>   - define_xml_to_evidence(): Parse Define-XML 2.0/2.1 files into
#>     evidence, emitting Q-DEFINE-001 (dataset present), Q-DEFINE-002
#>     (variable documented), and Q-DEFINE-003 (derivation present)
#>     indicators.
#>   - export_evidence() / import_evidence(): Save and reload validated
#>     evidence tables in CSV, RDS, or JSON format with metadata
#>     attributes.
#> 
#>                         Changes in version 0.1.1                        
#> 
#>   - Added ORCID for package author in Authors@R.
#>   - Added r4subdata to Suggests - the companion example-data package is
#>     now on CRAN.
#> 
#>                         Changes in version 0.1.0                        
#> 
#>   - Initial CRAN release.
#> ── r4subtrace ──
#> 
#>                         Changes in version 0.3.1                        
#> 
#>   - Complete the pkgdown reference index so the documentation site
#>     builds, and polish metadata for CRAN.
#> 
#>                         Changes in version 0.3.0                        
#> 
#>   - Add trace_impact(), impact analysis for a changed source variable.
#>     Given a variable that is about to change, it walks the derivation
#>     graph in reverse and returns every ADaM variable that derives from
#>     it, directly or through a chain, each with its distance from the
#>     change and a readable path back to it. This is the question a data
#>     team asks before editing a source: what breaks downstream. Circular
#>     references are handled and multi-step chains are followed through
#>     adam_derivations, the same input trace_chains() uses.
#> 
#>                         Changes in version 0.2.1                        
#> 
#>   - Add trace_problems(), a focused view of just the traceability issues
#>     worth acting on: variables that are not traced to the required
#>     level, and, when a derivation table is supplied, chains that never
#>     reach SDTM, that are circular, or that were cut off at the depth
#>     limit. On a large submission this is what a team consumes rather
#>     than the full per-variable coverage table. The engine is verified on
#>     a 10,000-variable synthetic model.
#> 
#>                         Changes in version 0.2.0                        
#> 
#>   - Add export_traceability_report() and traceability_coverage(), which
#>     summarize traceability coverage per ADaM dataset (percent traced,
#>     untraced variables listed) with an overall summary row, and export
#>     the table as a data.frame, CSV, or Excel file for ADRG appendices.
#>   - Add trace_chains(), which follows multi-step derivation chains back
#>     to source (ADaM derived from ADaM derived from SDTM), reports the
#>     depth and whether each variable is grounded in SDTM, caps the walk
#>     with trace_depth, and detects circular references. Add
#>     plot_trace_graph() to draw the derivation graph with igraph.
#>   - Add vignette: "Case study: tracing ADaM back to SDTM", a worked
#>     walkthrough building a trace model from the example CDISC pilot
#>     metadata in r4subdata, finding orphan variables, and reading the
#>     coverage indicators.
#>   - Clarified the package DESCRIPTION: "R4SUB" expands to "Ready for
#>     Submission" (previously "R for Regulatory Submission", inconsistent
#>     with the rest of the ecosystem).
#> 
#>                         Changes in version 0.1.1                        
#> 
#>   - Add vignette: "Traceability Analysis with r4subtrace" covering
#>     build_trace_model(), compute_trace_levels(),
#>     trace_indicator_scores(), and orphan variable detection.
#> 
#>                         Changes in version 0.1.0                        
#> 
#>   - Initial CRAN release.
#> ── r4subscore ──
#> 
#>                         Changes in version 0.4.1                        
#> 
#>   - Complete the pkgdown reference index so the documentation site
#>     builds, and polish metadata for CRAN.
#> 
#>                         Changes in version 0.4.0                        
#> 
#>   - Add sci_report(), an end-to-end readiness report that composes the
#>     SCI, the decision band and its critical gate, the per-pillar
#>     breakdown, the findings most worth acting on, and the pillars that
#>     offer the biggest improvement into one object with a readable print
#>     method. Pass targets for a distance-to-goal section, or a profile
#>     configuration as config for an authority-calibrated report. This is
#>     the single call that answers "where do we stand and what do we fix
#>     next" from an evidence table.
#> 
#>                         Changes in version 0.3.0                        
#> 
#>   - Add sci_targets() and sci_gap_to_target(). The first records the
#>     readiness goal a submission is aiming for, either a band name such
#>     as "ready" or a numeric SCI, with optional per-pillar minimums. The
#>     second measures how far a scored run is from that goal and, for each
#>     pillar, reports the SCI points that closing it would add, ordered so
#>     the biggest lever comes first. Where sci_diff() answers "are we
#>     moving in the right direction", this answers "how far are we from
#>     filing, and what should we fix next".
#> 
#>                         Changes in version 0.2.1                        
#> 
#>   - Add sci_snapshot(), sci_diff(), and sci_snapshot_history() for
#>     tracking readiness over time. A snapshot records the SCI, band, and
#>     pillar and indicator scores for one run under a label; sci_diff()
#>     reports what moved between two runs (overall SCI change, band
#>     change, per-pillar deltas, and which indicators improved, regressed,
#>     were added, or removed); and sci_snapshot_history() binds a series
#>     into a tidy table for a trend plot. This turns the SCI from a
#>     single-run report card into a way to answer whether a submission is
#>     on trajectory to file.
#> 
#>                         Changes in version 0.2.0                        
#> 
#>   - Add a non-compensatory gate to the SCI. An open critical finding
#>     (severity critical, result fail) now caps the reported band at
#>     conditional by default, so a strong score in one pillar cannot wash
#>     out a critical failure in another. The numeric SCI is left
#>     unchanged; only the band is capped, and compute_sci() records
#>     n_critical, gated, and a gate_reason. The gate is configurable
#>     through sci_config_default(gate = ...) and applies automatically
#>     through the standard pipeline. The default is a starting point
#>     sponsors should calibrate, not validated truth.
#>   - Add indicator_contributions(), which breaks a pillar score down into
#>     per-indicator contributions, ranks indicators by how many SCI points
#>     a fix could recover, and attaches a short remediation hint to each
#>     one.
#>   - Add sci_what_if(), which recomputes the pillar score and the SCI
#>     exactly as if one indicator had a different score, for planning
#>     remediation.
#>   - Add sci_confidence_interval(), a bootstrap confidence interval for
#>     the SCI so a readiness decision can account for measurement noise,
#>     with a format_sci_ci() helper for the compact SCI = 82.0
#>     [76.0, 88.0] form and a print method that flags when the interval
#>     straddles two decision bands.
#>   - Document confidence-interval interpretation in the scoring vignette.
#>   - Add vignette: "Case study: scoring a CDISC pilot for submission
#>     readiness", a worked walkthrough of the SCI on the example pharma
#>     evidence from r4subdata.
#>   - Add validation helpers: sci_degradation_curve() records how the SCI
#>     responds as passing checks are turned into failures,
#>     sci_monotone_check() confirms a curve never rises, and
#>     conformance_findings() produces an independent severity-weighted
#>     finding count for concurrent-validity checks.
#>   - Add vignette: "Validating the Submission Confidence Index", covering
#>     construct, discriminant, concurrent, and robustness validity, and
#>     documenting a calibration finding about how severity discounts
#>     passing credit.
#>   - Clarified the package DESCRIPTION: "R4SUB" expands to "Ready for
#>     Submission" (previously "R for Regulatory Submission", inconsistent
#>     with the rest of the ecosystem).
#> 
#>                         Changes in version 0.1.1                        
#> 
#>   - Add vignette: "Submission Confidence Index (SCI) Scoring" covering
#>     compute_pillar_scores(), compute_sci(), sci_explain(),
#>     sci_sensitivity_analysis(), and custom weight configuration.
#> 
#>                         Changes in version 0.1.0                        
#> 
#>   - Initial CRAN release.
#> ── r4subrisk ──
#> 
#>                         Changes in version 0.3.1                        
#> 
#>   - Metadata and documentation polish for CRAN submission; no
#>     user-facing changes.
#> 
#>                         Changes in version 0.3.0                        
#> 
#>   - Add risk_monte_carlo(), which puts uncertainty on the FMEA scores.
#>     An RPN is built from three integer judgements, so a single number
#>     hides how confident the assessment is. The simulation samples each
#>     probability, impact, and detectability around its assessed value and
#>     reports the distribution of RPN, per risk and for the register as a
#>     whole, including a 90% interval and the probability that each risk
#>     is actually critical. The random state is set and restored per call
#>     when a seed is given, so results are reproducible without disturbing
#>     the caller's RNG.
#> 
#>                         Changes in version 0.2.0                        
#> 
#>   - Add risk_reduction_summary(), which quantifies the risk removed
#>     between two registers: total and mean RPN reduction, percentage
#>     reduction, and counts of risks reduced, downgraded, added, and
#>     resolved.
#>   - Add plot_risk_heatmap() and risk_heatmap_data() for the standard
#>     FMEA probability by impact heatmap, with an optional interactive
#>     plotly version.
#>   - Add a pluggable risk-model interface: risk_model() plus the
#>     pre-built risk_model_fmea(), risk_model_probability_impact(), and
#>     risk_model_ich_q9(). apply_risk_model() scores any set of risks to a
#>     normalized 0-100 value so alternative models feed the same Risk
#>     pillar.
#>   - Add vignette: "Case study: FMEA risk on a pilot submission", a
#>     worked before-and-after mitigation walkthrough using the example
#>     risk register from r4subdata.
#>   - Clarified the package DESCRIPTION: "R4SUB" expands to "Ready for
#>     Submission" (previously "R for Regulatory Submission", inconsistent
#>     with the rest of the ecosystem).
#> 
#>                         Changes in version 0.1.1                        
#> 
#>   - Add vignette: "Risk Management with r4subrisk" covering
#>     create_risk_register(), compute_risk_scores(), apply_mitigations(),
#>     compare_risk_registers(), and evidence_to_risks() integration.
#> 
#>                         Changes in version 0.1.0                        
#> 
#>   - Initial CRAN release.
#> ── r4subdata ──
#> 
#>                         Changes in version 0.1.4                        
#> 
#>   - Exclude the pkgdown config and site from the build to clear an R CMD
#>     check NOTE.
#> 
#>                         Changes in version 0.1.3                        
#> 
#>   - Clarified the package DESCRIPTION: "R4SUB" expands to "Ready for
#>     Submission" (previously "R for Regulatory Submission", inconsistent
#>     with the rest of the ecosystem).
#> 
#>                         Changes in version 0.1.2                        
#> 
#>   - Added oncology_metadata: ADaM variable-level metadata for a
#>     synthetic oncology trial (ADSL, ADRS, ADTTE).
#>   - Added oncology_evidence: 29-row R4SUB evidence table for study
#>     ONCO-2025-001, covering all four pillars.
#> 
#>                         Changes in version 0.1.1                        
#> 
#>   - Fixed version conflict warning on load.
#>   - Added ORCID to author metadata.
#> 
#>                         Changes in version 0.1.0                        
#> 
#>   - Initial CRAN release.
#> ── r4subprofile ──
#> 
#>                         Changes in version 0.3.1                        
#> 
#>   - Fix the pkgdown reference index: drop stale print entries and add
#>     the rule-pack topics so the site builds.
#> 
#>                         Changes in version 0.3.0                        
#> 
#>   - Add compare_authorities(), a side-by-side comparison of submission
#>     profiles across regulatory authorities: pillar weights, the SCI
#>     needed to be ready, minimum coverage, the number of required
#>     indicators, and the detectability default. A sponsor filing in more
#>     than one region can see how the readiness bar changes between, say,
#>     the FDA and the EMA without building and reading each profile by
#>     hand. Authority names match case-insensitively and the submission
#>     type can be chosen per authority.
#> 
#>                         Changes in version 0.2.0                        
#> 
#>   - Add versioned rule packs: rule_packs() lists the available packs,
#>     rule_pack() selects one by id (for example "fda-2026.1") with an
#>     authority, a version, and an effective date, rule_pack_indicators()
#>     returns its indicators, and rule_pack_provenance() returns the
#>     identifying fields to record on a scored result so a score can be
#>     traced to the exact ruleset that produced it. Each indicator carries
#>     a source field for its authoritative citation; the built-in packs
#>     ship these as NA (pending entry from a controlled reference list
#>     rather than filled with unverified section numbers) and they can be
#>     supplied through the sources argument.
#> 
#>                         Changes in version 0.1.1                        
#> 
#>   - Add vignette: "Regulatory Authority Profiles" covering
#>     submission_profile(), profile_summary(), validate_against_profile(),
#>     and authority weight comparisons.
#> 
#>                         Changes in version 0.1.0                        
#> 
#>   - Initial CRAN release.
#> ── r4subusability ──
#> 
#>                         Changes in version 0.2.1                        
#> 
#>   - Fix the pkgdown workflow so it resolves ecosystem dependencies, and
#>     polish metadata for CRAN.
#> 
#>                         Changes in version 0.2.0                        
#> 
#>   - Add vignette: "Case study: reviewer experience from ADaM metadata",
#>     which builds a Define-style view from the example CDISC pilot
#>     metadata in r4subdata and measures its usability.
#> 
#>   - Clarified the package DESCRIPTION: "R4SUB" expands to "Ready for
#>     Submission" (previously "R for Regulatory Submission", inconsistent
#>     with the rest of the ecosystem).
#> 
#>                         Changes in version 0.1.0                        
#> 
#>   - Initial release.
#>   - usability_config_default(): default configuration for usability
#>     assessments.
#>   - assess_label_quality(): check variable label presence and length
#>     (U-001).
#>   - assess_define_completeness(): check Define-XML origin and derivation
#>     fields (U-002).
#>   - assess_annotation_coverage(): check proportion of derived variables
#>     annotated (U-003).
#>   - assess_reviewer_guide(): check reviewer guide presence in submission
#>     package (U-004).
#>   - usability_indicators(): run all four assessments in one call.
#>   - usability_summary() and print.usability_result(): summarise and
#>     display results.
r4sub_news("r4subcore")
#> ── r4subcore ──
#> 
#>                         Changes in version 0.3.1                        
#> 
#>   - Metadata and documentation polish for CRAN submission; no
#>     user-facing changes.
#> 
#>                         Changes in version 0.3.0                        
#> 
#>   - Add evidence_diff(), which compares two evidence tables and reports
#>     what changed between them: which findings were added, removed, or
#>     changed, and whether each change made the submission better or
#>     worse. Rows are matched on the indicator and asset, duplicate keys
#>     collapse to the worst row, and the result is ordered with
#>     regressions first so a team sees what to act on. This turns the
#>     evidence table into something you can track run over run, and it is
#>     the raw material behind higher-level trend views such as sci_diff().
#> 
#>                         Changes in version 0.2.1                        
#> 
#>   - hash_id() now hashes in memory with rlang::hash() instead of writing
#>     a temporary file and calling tools::md5sum on every call. The result
#>     is the same shape (a 32-character hex string, deterministic) but
#>     roughly three orders of magnitude faster, which removes the main
#>     bottleneck when building a trace model or generating identifiers for
#>     a large submission. The exact hash values change; they are opaque
#>     identifiers, not a persisted contract.
#>   - Add check_define_consistency() and define_variables(). The first
#>     compares the variables declared in Define-XML against the variables
#>     actually present in the datasets and emits evidence for each: a
#>     match, a variable documented but absent from the data, or a variable
#>     present but not documented. Drift between Define-XML and the data is
#>     a common submission problem, and this makes it a scored quality
#>     indicator. The second extracts the dataset and variable pairs from a
#>     Define-XML file.
#> 
#>                         Changes in version 0.2.0                        
#> 
#>   - Add read_p21_report(), which loads a Pinnacle 21 validation report
#>     from disk (CSV natively, Excel through the optional readxl package)
#>     ready for p21_to_evidence(). A team can now go from the report
#>     Pinnacle 21 already produces to scored evidence without
#>     hand-building a table.
#>   - canon_severity() now recognizes "notice", the severity Pinnacle 21
#>     uses for its lowest level, mapping it onto info.
#>   - The evidence table now carries a schema version. as_evidence()
#>     stamps it, evidence_schema_version() reports the current version or
#>     the version of a given table, and migrate_evidence() upgrades a
#>     table written by an older release. validate_evidence() tolerates an
#>     unstamped table but refuses an unknown or newer version, so a table
#>     written by a future release cannot be silently mis-scored.
#>   - Fix import_evidence(): a CSV or JSON round-trip could leave an
#>     all-NA character column (for example source_version) typed as
#>     logical, which then failed validation. Every schema column is now
#>     coerced back to its declared type on import.
#>   - Add evidence_schema_spec(), which publishes the evidence schema as a
#>     tidy table (column, type, required, allowed values, description) for
#>     use as a data dictionary or reference.
#>   - Add vignette: "The R4SUB Evidence Schema", the formal specification
#>     of the evidence table shared across the ecosystem.
#>   - Add adrg_to_evidence() and adrg_sections() for Analysis Data
#>     Reviewer's Guide coverage. Given a structured summary of which
#>     standard ADRG sections a guide contains, this emits usability
#>     evidence: missing required sections fail, missing recommended
#>     sections warn. The same machinery covers the SDRG via source_name.
#>   - Add evidence_sources(), a reference table of supported and planned
#>     evidence sources with their format, pillar, and entry point.
#>   - Harden define_xml_to_evidence() for real-world Define-XML
#>     variability. It now matches elements by local name, so it reads
#>     files regardless of how they mix the ODM and def: namespaces (a
#>     plain //ItemGroupDef query silently missed namespace-prefixed
#>     elements). Derivations are resolved from a referenced MethodDef when
#>     the Origin carries no inline text, missing optional elements are
#>     tolerated, and a partially parseable file now returns an informative
#>     warning.
#>   - Clarified the package DESCRIPTION: "R4SUB" expands to "Ready for
#>     Submission" (previously "R for Regulatory Submission", inconsistent
#>     with the rest of the ecosystem).
#> 
#>                         Changes in version 0.1.2                        
#> 
#>   - define_xml_to_evidence(): Parse Define-XML 2.0/2.1 files into
#>     evidence, emitting Q-DEFINE-001 (dataset present), Q-DEFINE-002
#>     (variable documented), and Q-DEFINE-003 (derivation present)
#>     indicators.
#>   - export_evidence() / import_evidence(): Save and reload validated
#>     evidence tables in CSV, RDS, or JSON format with metadata
#>     attributes.
#> 
#>                         Changes in version 0.1.1                        
#> 
#>   - Added ORCID for package author in Authors@R.
#>   - Added r4subdata to Suggests - the companion example-data package is
#>     now on CRAN.
#> 
#>                         Changes in version 0.1.0                        
#> 
#>   - Initial CRAN release.
```
