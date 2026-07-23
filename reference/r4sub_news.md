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
#> ! No NEWS available for r4subcore.
#> 
#> ── r4subtrace ──
#> 
#>                         Changes in version 0.1.0                        
#> 
#>   - Initial CRAN release.
#> ── r4subscore ──
#> 
#>                         Changes in version 0.1.0                        
#> 
#>   - Initial CRAN release.
#> ── r4subrisk ──
#> 
#>                         Changes in version 0.1.0                        
#> 
#>   - Initial CRAN release.
#> ── r4subdata ──
#> 
#>                         Changes in version 0.1.0                        
#> 
#>   - Initial CRAN release.
#> ── r4subprofile ──
#> 
#>                         Changes in version 0.1.0                        
#> 
#>   - Initial CRAN release.
r4sub_news("r4subcore")
#> ! No NEWS available for r4subcore.
```
