# Show R4SUB Function Conflicts

Reports any exported function name collisions between attached R4SUB
packages and other loaded packages.

## Usage

``` r
r4sub_conflicts()
```

## Value

A tibble with columns: `func`, `r4sub_package`, `other_package`.
Returned invisibly. Prints conflicts if any exist.

## Examples

``` r
r4sub_conflicts()
#> ℹ No R4SUB packages currently attached.
```
