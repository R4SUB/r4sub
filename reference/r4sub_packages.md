# List R4SUB Ecosystem Packages

Returns a tibble of all R4SUB packages with their installed version and
current attachment status.

## Usage

``` r
r4sub_packages(include_self = TRUE)
```

## Arguments

- include_self:

  Logical. If `TRUE` (default), includes the `r4sub` meta-package itself
  in the listing.

## Value

A tibble with columns: `package`, `version`, `attached`.

## Examples

``` r
r4sub_packages()
#> # A tibble: 9 × 3
#>   package        version attached
#>   <chr>          <chr>   <lgl>   
#> 1 r4sub          0.2.1   TRUE    
#> 2 r4subcore      0.3.1   TRUE    
#> 3 r4subtrace     0.3.1   TRUE    
#> 4 r4subscore     0.4.1   TRUE    
#> 5 r4subrisk      0.3.1   TRUE    
#> 6 r4subdata      0.1.4   TRUE    
#> 7 r4subprofile   0.3.1   TRUE    
#> 8 r4subusability 0.2.1   TRUE    
#> 9 r4subui        0.2.1   FALSE   
```
