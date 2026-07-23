# Core R4SUB packages

Returns the names of the R4SUB packages that are automatically attached
when [`library(r4sub)`](https://r4sub.github.io/r4sub/) is called.

## Usage

``` r
core_packages()
```

## Value

A character vector of package names.

## Examples

``` r
core_packages()
#> [1] "r4subcore"    "r4subtrace"   "r4subscore"   "r4subrisk"    "r4subdata"   
#> [6] "r4subprofile"
```
