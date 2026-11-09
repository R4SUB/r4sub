# Show R4SUB Function Conflicts

Reports any exported function name collisions between attached R4SUB
packages and other loaded packages. The returned object carries the
`r4sub_conflicts` class, so printing it (or passing it to
[`format()`](https://rdrr.io/r/base/format.html)) renders a readable
"pkg::fn overrides other::fn" report in the style of the conflicted
package.

## Usage

``` r
r4sub_conflicts()

# S3 method for class 'r4sub_conflicts'
format(x, ...)

# S3 method for class 'r4sub_conflicts'
print(x, ...)
```

## Arguments

- x:

  An `r4sub_conflicts` object, as returned by `r4sub_conflicts()`.

- ...:

  Ignored, for compatibility with the
  [`format()`](https://rdrr.io/r/base/format.html) and
  [`print()`](https://rdrr.io/r/base/print.html) generics.

## Value

An object of class `r4sub_conflicts` (a tibble with columns `func`,
`r4sub_package`, `other_package`). Returned invisibly. A one-line
summary of the conflict count is printed when the function is called;
the full per-conflict report is produced by the `print`/`format`
methods.

## Details

The underlying object is still a
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with columns `func`, `r4sub_package`, and `other_package`, so it can be
filtered, counted, or joined like any other data frame. Only its printed
representation changes.

## Examples

``` r
# Detect conflicts in the current session
conflicts <- r4sub_conflicts()
#> ✔ No conflicts detected between R4SUB and other packages.

# Render the full "overrides" report
print(conflicts)
#> ✔ No conflicts between R4SUB packages and other loaded packages.

# The report is also available as a character vector
format(conflicts)
#> [1] "No conflicts between R4SUB packages and other loaded packages."
```
