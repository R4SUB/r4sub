# Check R4SUB Ecosystem Dependency Compatibility

Inspects the dependencies that R4SUB ecosystem packages declare on *each
other* and reports whether the versions you have installed satisfy those
declarations. This answers a question a meta-package is well placed to
answer: "is my installed R4SUB ecosystem internally consistent, or is
some member too old for another member that depends on it?"

## Usage

``` r
r4sub_deps(include_suggests = FALSE)

# S3 method for class 'r4sub_deps'
format(x, ...)

# S3 method for class 'r4sub_deps'
print(x, ...)
```

## Arguments

- include_suggests:

  Logical. If `FALSE` (default), only hard dependencies (`Depends` and
  `Imports`) are examined. If `TRUE`, `Suggests` edges are included as
  well; these are optional, so an unsatisfied `Suggests` edge is
  reported with status `"suggested-missing"` rather than `"missing"`.

- x:

  An `r4sub_deps` object, as returned by `r4sub_deps()`.

- ...:

  Ignored, for compatibility with the
  [`format()`](https://rdrr.io/r/base/format.html) and
  [`print()`](https://rdrr.io/r/base/print.html) generics.

## Value

An object of class `r4sub_deps` (a tibble) with one row per
ecosystem-internal dependency edge and the columns:

- `package`:

  The ecosystem package that declares the dependency.

- `dependency`:

  The ecosystem package it depends on.

- `type`:

  `"Depends"`, `"Imports"`, or `"Suggests"`.

- `required`:

  The declared version constraint (e.g. `">= 0.1.2"`), or `NA` when no
  version is pinned.

- `installed`:

  The installed version of `dependency`, or `NA` when it is not
  installed.

- `status`:

  `"ok"`, `"outdated"`, `"missing"`, or, for optional edges,
  `"suggested-missing"`.

Returned invisibly; a one-line summary is printed when the function is
called, and the full report is produced by the `print`/`format` methods.

## Details

The check is performed entirely from locally installed package metadata
(each package's `DESCRIPTION`). It performs no network access and does
not consult CRAN; it only compares the versions already installed on
your machine against the version constraints those packages declare.

Only edges *within* the R4SUB ecosystem are reported: a dependency on,
say, `cli` or `tibble` is ignored, because this helper is about
ecosystem self-consistency rather than general package management.

The returned object carries the `r4sub_deps` class, so printing it
renders a readable report that lists any outdated or missing ecosystem
dependencies. The underlying object is a
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html),
so it can be filtered, counted, or joined like any other data frame.

## Examples

``` r
# Report ecosystem-internal dependency compatibility
deps <- r4sub_deps()
#> ✔ All R4SUB ecosystem dependencies satisfied.

# Render the full report (same as printing `deps`)
print(deps)
#> ✔ All R4SUB ecosystem dependencies satisfied.

# Keep only unsatisfied edges
deps[deps$status != "ok", ]
#> ✔ All R4SUB ecosystem dependencies satisfied.
```
