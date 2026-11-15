# Run the R4SUB Readiness Pipeline End to End

Drives the installed R4SUB ecosystem packages over a single body of
evidence and assembles their outputs into one consolidated readiness
object. It is the ecosystem's "front door": instead of calling
r4subscore, r4subrisk, r4subtrace, r4subusability, r4subrepro, and
r4subprofile separately and stitching their results together by hand,
you pass the shared evidence table once and receive every sibling's
native result in a single structure.

## Usage

``` r
r4sub_readiness(
  evidence,
  profile = NULL,
  sci_config = NULL,
  risk_config = NULL,
  include_evidence = FALSE
)

# S3 method for class 'r4sub_readiness'
format(x, ...)

# S3 method for class 'r4sub_readiness'
print(x, ...)
```

## Arguments

- evidence:

  Either a single validated evidence table (conforming to the r4subcore
  evidence schema) or a list of such tables. A list is combined into one
  table with
  [`r4subcore::bind_evidence()`](https://r4sub.github.io/r4subcore/reference/bind_evidence.html)
  before the pipeline runs; the combined table is what every stage sees.

- profile:

  Optional. A `submission_profile` object from
  [`r4subprofile::submission_profile()`](https://r4sub.github.io/r4subprofile/reference/submission_profile.html).
  When supplied, the evidence is checked against it with
  [`r4subprofile::validate_against_profile()`](https://r4sub.github.io/r4subprofile/reference/validate_against_profile.html).
  When `NULL` (default), the profile stage is skipped.

- sci_config:

  Optional scoring configuration from
  [`r4subscore::sci_config_default()`](https://r4sub.github.io/r4subscore/reference/sci_config_default.html),
  passed through to the scoring stage. When `NULL` (default),
  r4subscore's own default configuration is used; r4sub supplies no
  configuration values itself.

- risk_config:

  Optional risk configuration from
  [`r4subrisk::risk_config_default()`](https://r4sub.github.io/r4subrisk/reference/risk_config_default.html),
  passed through to the risk stage. When `NULL` (default), r4subrisk's
  own default configuration is used.

- include_evidence:

  Logical. If `TRUE`, the (possibly combined) evidence table is returned
  in the `evidence` component of the result. Default `FALSE`.

- x:

  An `r4sub_readiness` object, as returned by `r4sub_readiness()`.

- ...:

  Ignored, for compatibility with the
  [`format()`](https://rdrr.io/r/base/format.html) and
  [`print()`](https://rdrr.io/r/base/print.html) generics.

## Value

An object of class `r4sub_readiness`: a list with components

- `study_id`:

  The study identifier read from the evidence.

- `n_evidence`:

  The number of evidence rows the pipeline saw.

- `sci`:

  The Submission Confidence Index from the scoring stage, or `NA` when
  that stage did not run.

- `band`:

  The SCI decision band from the scoring stage, or `NA`.

- `generated_at`:

  When the run was assembled.

- `stages`:

  A named list, one entry per stage, each a list with `stage`,
  `package`, `status` (`"ok"`, `"skipped"`, or `"error"`), `detail` (a
  human-readable headline), `result` (the sibling's native return value,
  or `NULL`), and `message`.

- `summary`:

  A tibble with one row per stage: `stage`, `package`, `status`, and
  `detail`.

- `evidence`:

  The combined evidence table when `include_evidence` is `TRUE`,
  otherwise `NULL`.

Printing the object renders a readable report; the same text is
available from [`format()`](https://rdrr.io/r/base/format.html).

## Details

`r4sub_readiness()` is a pure orchestrator: it **computes no scores,
weights, thresholds, or domain metrics of its own**. Every number it
surfaces is produced by the sibling package that owns that concern (for
example the Submission Confidence Index and its band come from
[`r4subscore::compute_sci()`](https://r4sub.github.io/r4subscore/reference/compute_sci.html),
the overall risk score from
[`r4subrisk::compute_risk_scores()`](https://r4sub.github.io/r4subrisk/reference/compute_risk_scores.html)).
r4sub only validates the evidence, invokes each sibling's existing entry
points in dependency order, and collects what they return.

Each stage is run only when its package is installed (guarded with
[`requireNamespace()`](https://rdrr.io/r/base/ns-load.html)) and is
wrapped so that a sibling raising an error never aborts the whole run:
that stage is recorded with status `"error"` and the others still
complete. A stage whose package is not installed is recorded with status
`"skipped"`. The profile stage runs only when a `profile` is supplied.

## Examples

``` r
ctx <- suppressMessages(
  r4subcore::r4sub_run_context(study_id = "STUDY01", environment = "DEV")
)
ev <- suppressMessages(r4subcore::as_evidence(
  data.frame(
    asset_type = "dataset",
    asset_id = c("ADSL", "ADAE"),
    source_name = "pinnacle21",
    indicator_id = c("Q-001", "R-001"),
    indicator_name = c("Quality check", "Risk check"),
    indicator_domain = c("quality", "risk"),
    severity = c("high", "critical"),
    result = c("fail", "fail"),
    stringsAsFactors = FALSE
  ),
  ctx = ctx
))
readiness <- r4sub_readiness(ev)
readiness$summary
#> # A tibble: 5 × 4
#>   stage     package        status detail                                   
#>   <chr>     <chr>          <chr>  <chr>                                    
#> 1 score     r4subscore     ok     SCI 0 (high_risk)                        
#> 2 risk      r4subrisk      ok     overall risk 0.49 across 2 risks         
#> 3 trace     r4subtrace     ok     no ADaM trace levels in evidence         
#> 4 usability r4subusability ok     no usability indicators in evidence      
#> 5 repro     r4subrepro     ok     no reproducibility indicators in evidence
```
