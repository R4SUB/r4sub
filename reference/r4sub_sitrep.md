# Situation Report for the R4SUB Ecosystem

Prints a one-shot "situation report" (sitrep) for your current session:
your R version and platform, the installed version and attach status of
every R4SUB ecosystem package, and the number of function conflicts
currently detected. It performs no network access; it only inspects the
packages installed and attached in your session.

## Usage

``` r
r4sub_sitrep()
```

## Value

A list with components `r_version`, `platform`, `packages` (the tibble
returned by
[`r4sub_packages()`](https://r4sub.github.io/r4sub/reference/r4sub_packages.md)),
and `conflicts` (the integer number of conflicts detected). Returned
invisibly; called for its side effect of printing the report.

## Details

`r4sub_sitrep()` is a pure composition of
[`r4sub_packages()`](https://r4sub.github.io/r4sub/reference/r4sub_packages.md),
[`core_packages()`](https://r4sub.github.io/r4sub/reference/core_packages.md),
and
[`r4sub_conflicts()`](https://r4sub.github.io/r4sub/reference/r4sub_conflicts.md),
modelled on the `sitrep` helpers found across the tidyverse.

## Examples

``` r
r4sub_sitrep()
#> 
#> ── R4SUB situation report ──
#> 
#> ℹ R version 4.6.2 (2026-10-29)
#> ℹ Platform: x86_64-pc-linux-gnu
#> → r4sub (meta): 0.2.1 [attached]
#> → r4subcore (core): 0.3.1.9000 [attached]
#> → r4subtrace (core): 0.3.1 [attached]
#> → r4subscore (core): 0.4.1 [attached]
#> → r4subrisk (core): 0.3.1 [attached]
#> → r4subdata (core): 0.1.4 [attached]
#> → r4subprofile (core): 0.3.1 [attached]
#> → r4subusability (core): 0.2.1 [attached]
#> → r4subui (optional): 0.2.1 [not attached]
#> → r4subpharma (optional): not installed [not attached]
#> → r4subrepro (optional): not installed [not attached]
#> → r4agent (optional): not installed [not attached]
#> ✔ No conflicts detected.
```
