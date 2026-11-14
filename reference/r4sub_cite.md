# Cite the R4SUB Ecosystem

Prints citation information for the R4SUB ecosystem and each installed
core package. Use this when citing R4SUB tools in a regulatory
submission document, scientific paper, or validation report.

## Usage

``` r
r4sub_cite(package = NULL)
```

## Arguments

- package:

  Character. Name of a specific R4SUB package to cite. If `NULL`
  (default), cites all installed core packages plus the meta-package.

## Value

Invisibly returns a named list of `citation` objects, one per package.
Called for its side effect of printing citation information to the
console.

## Examples

``` r
r4sub_cite()
#> 
#> ── r4sub ──
#> 
#> To cite package ‘r4sub’ in publications use:
#> 
#>   Mali P (2026). _r4sub: Easily Install and Load the R4SUB Ecosystem_.
#>   R package version 0.2.1, <https://r4sub.github.io/r4sub/>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {r4sub: Easily Install and Load the R4SUB Ecosystem},
#>     author = {Pawan Rama Mali},
#>     year = {2026},
#>     note = {R package version 0.2.1},
#>     url = {https://r4sub.github.io/r4sub/},
#>   }
#> ── r4subcore ──
#> 
#> To cite package ‘r4subcore’ in publications use:
#> 
#>   Mali P (2026). _r4subcore: Evidence Schema, Parsers, and Shared
#>   Primitives_. R package version 0.3.1.9000, commit
#>   f004ce296966bcfc8d2b98b5c17f27ba7d07f285,
#>   <https://github.com/R4SUB/r4subcore>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {r4subcore: Evidence Schema, Parsers, and Shared Primitives},
#>     author = {Pawan Rama Mali},
#>     year = {2026},
#>     note = {R package version 0.3.1.9000, commit f004ce296966bcfc8d2b98b5c17f27ba7d07f285},
#>     url = {https://github.com/R4SUB/r4subcore},
#>   }
#> ── r4subtrace ──
#> 
#> To cite package ‘r4subtrace’ in publications use:
#> 
#>   Mali P (2026). _r4subtrace: Traceability Engine for Clinical
#>   Submission Readiness_. R package version 0.3.1, commit
#>   fc22e66f950b547da7b1febd32456011fef007ab,
#>   <https://github.com/R4SUB/r4subtrace>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {r4subtrace: Traceability Engine for Clinical Submission Readiness},
#>     author = {Pawan Rama Mali},
#>     year = {2026},
#>     note = {R package version 0.3.1, commit fc22e66f950b547da7b1febd32456011fef007ab},
#>     url = {https://github.com/R4SUB/r4subtrace},
#>   }
#> ── r4subscore ──
#> 
#> To cite package ‘r4subscore’ in publications use:
#> 
#>   Mali P (2026). _r4subscore: Submission Confidence Index Engine_. R
#>   package version 0.4.1, commit
#>   a4963f8cbfef75b81e36f4c91d0b519a649766c8,
#>   <https://github.com/R4SUB/r4subscore>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {r4subscore: Submission Confidence Index Engine},
#>     author = {Pawan Rama Mali},
#>     year = {2026},
#>     note = {R package version 0.4.1, commit a4963f8cbfef75b81e36f4c91d0b519a649766c8},
#>     url = {https://github.com/R4SUB/r4subscore},
#>   }
#> ── r4subrisk ──
#> 
#> To cite package ‘r4subrisk’ in publications use:
#> 
#>   Mali P (2026). _r4subrisk: Risk Quantification Engine for Clinical
#>   Submission Readiness_. R package version 0.3.1, commit
#>   55b16a87e90d746d61bf11744213946a9f49d794,
#>   <https://github.com/R4SUB/r4subrisk>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {r4subrisk: Risk Quantification Engine for Clinical Submission Readiness},
#>     author = {Pawan Rama Mali},
#>     year = {2026},
#>     note = {R package version 0.3.1, commit 55b16a87e90d746d61bf11744213946a9f49d794},
#>     url = {https://github.com/R4SUB/r4subrisk},
#>   }
#> ── r4subdata ──
#> 
#> To cite package ‘r4subdata’ in publications use:
#> 
#>   Mali P (2026). _r4subdata: Example Datasets for Clinical Submission
#>   Readiness_. R package version 0.1.4, commit
#>   a1cfe5b1cfee8d46bdc04460741d001f468fc05d,
#>   <https://github.com/R4SUB/r4subdata>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {r4subdata: Example Datasets for Clinical Submission Readiness},
#>     author = {Pawan Rama Mali},
#>     year = {2026},
#>     note = {R package version 0.1.4, commit a1cfe5b1cfee8d46bdc04460741d001f468fc05d},
#>     url = {https://github.com/R4SUB/r4subdata},
#>   }
#> ── r4subprofile ──
#> 
#> To cite package ‘r4subprofile’ in publications use:
#> 
#>   Mali P (2026). _r4subprofile: Regulatory Authority Profiles for
#>   Submission Readiness_. R package version 0.3.1, commit
#>   460f3a1cb3059b7df4842ed94087c0604fa7d314,
#>   <https://github.com/R4SUB/r4subprofile>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {r4subprofile: Regulatory Authority Profiles for Submission Readiness},
#>     author = {Pawan Rama Mali},
#>     year = {2026},
#>     note = {R package version 0.3.1, commit 460f3a1cb3059b7df4842ed94087c0604fa7d314},
#>     url = {https://github.com/R4SUB/r4subprofile},
#>   }
#> ── r4subusability ──
#> 
#> To cite package ‘r4subusability’ in publications use:
#> 
#>   Mali P (2026). _r4subusability: Usability Indicators for Clinical
#>   Submission Readiness_. R package version 0.2.1, commit
#>   72e651b3ffd3a19bc009b70e5d79c47d908fff7a,
#>   <https://github.com/R4SUB/r4subusability>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {r4subusability: Usability Indicators for Clinical Submission Readiness},
#>     author = {Pawan Rama Mali},
#>     year = {2026},
#>     note = {R package version 0.2.1, commit 72e651b3ffd3a19bc009b70e5d79c47d908fff7a},
#>     url = {https://github.com/R4SUB/r4subusability},
#>   }
r4sub_cite("r4subcore")
#> ── r4subcore ──
#> 
#> To cite package ‘r4subcore’ in publications use:
#> 
#>   Mali P (2026). _r4subcore: Evidence Schema, Parsers, and Shared
#>   Primitives_. R package version 0.3.1.9000, commit
#>   f004ce296966bcfc8d2b98b5c17f27ba7d07f285,
#>   <https://github.com/R4SUB/r4subcore>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {r4subcore: Evidence Schema, Parsers, and Shared Primitives},
#>     author = {Pawan Rama Mali},
#>     year = {2026},
#>     note = {R package version 0.3.1.9000, commit f004ce296966bcfc8d2b98b5c17f27ba7d07f285},
#>     url = {https://github.com/R4SUB/r4subcore},
#>   }
```
