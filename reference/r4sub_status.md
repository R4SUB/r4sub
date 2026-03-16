# Check R4SUB Package Installation Status

Reports the installed version of each R4SUB ecosystem package and
highlights any packages that are not installed.

## Usage

``` r
r4sub_status()
```

## Value

A tibble with columns: `package`, `installed`. Returned invisibly.
Called for its side effect of printing installation status to the
console.

## Examples

``` r
r4sub_status()
#> ! Not installed: r4subui
#> ✔ 7 R4SUB packages installed.
```
