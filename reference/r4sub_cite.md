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
#>   3a6c1c8278edb68a2a3fafe95655a2f84cbeadb2,
#>   <https://github.com/R4SUB/r4subcore>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {r4subcore: Evidence Schema, Parsers, and Shared Primitives},
#>     author = {Pawan Rama Mali},
#>     year = {2026},
#>     note = {R package version 0.3.1.9000, commit 3a6c1c8278edb68a2a3fafe95655a2f84cbeadb2},
#>     url = {https://github.com/R4SUB/r4subcore},
#>   }
#> ── r4subtrace ──
#> 
#> To cite package ‘r4subtrace’ in publications use:
#> 
#>   Mali P (2026). _r4subtrace: Traceability Engine for Clinical
#>   Submission Readiness_. R package version 0.3.1, commit
#>   fdd4d136805c9e62f4d17808b89b35ce56dbffca,
#>   <https://github.com/R4SUB/r4subtrace>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {r4subtrace: Traceability Engine for Clinical Submission Readiness},
#>     author = {Pawan Rama Mali},
#>     year = {2026},
#>     note = {R package version 0.3.1, commit fdd4d136805c9e62f4d17808b89b35ce56dbffca},
#>     url = {https://github.com/R4SUB/r4subtrace},
#>   }
#> ── r4subscore ──
#> 
#> To cite package ‘r4subscore’ in publications use:
#> 
#>   Mali P (2026). _r4subscore: Submission Confidence Index Engine_. R
#>   package version 0.4.1, commit
#>   2d223a43d0af5d80ddee8ec69806faed99e84fc1,
#>   <https://github.com/R4SUB/r4subscore>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {r4subscore: Submission Confidence Index Engine},
#>     author = {Pawan Rama Mali},
#>     year = {2026},
#>     note = {R package version 0.4.1, commit 2d223a43d0af5d80ddee8ec69806faed99e84fc1},
#>     url = {https://github.com/R4SUB/r4subscore},
#>   }
#> ── r4subrisk ──
#> 
#> To cite package ‘r4subrisk’ in publications use:
#> 
#>   Mali P (2026). _r4subrisk: Risk Quantification Engine for Clinical
#>   Submission Readiness_. R package version 0.3.1, commit
#>   70b3d15eb992c84951e3b5c9124f01be265c5906,
#>   <https://github.com/R4SUB/r4subrisk>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {r4subrisk: Risk Quantification Engine for Clinical Submission Readiness},
#>     author = {Pawan Rama Mali},
#>     year = {2026},
#>     note = {R package version 0.3.1, commit 70b3d15eb992c84951e3b5c9124f01be265c5906},
#>     url = {https://github.com/R4SUB/r4subrisk},
#>   }
#> ── r4subdata ──
#> 
#> To cite package ‘r4subdata’ in publications use:
#> 
#>   Mali P (2026). _r4subdata: Example Datasets for Clinical Submission
#>   Readiness_. R package version 0.1.4, commit
#>   14e52a0f10fb3bf6a0d308da7263d2ef6d628328,
#>   <https://github.com/R4SUB/r4subdata>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {r4subdata: Example Datasets for Clinical Submission Readiness},
#>     author = {Pawan Rama Mali},
#>     year = {2026},
#>     note = {R package version 0.1.4, commit 14e52a0f10fb3bf6a0d308da7263d2ef6d628328},
#>     url = {https://github.com/R4SUB/r4subdata},
#>   }
#> ── r4subprofile ──
#> 
#> To cite package ‘r4subprofile’ in publications use:
#> 
#>   Mali P (2026). _r4subprofile: Regulatory Authority Profiles for
#>   Submission Readiness_. R package version 0.3.1, commit
#>   c79bd14b67a6186cd86d442ed8bac71ba9bb29e1,
#>   <https://github.com/R4SUB/r4subprofile>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {r4subprofile: Regulatory Authority Profiles for Submission Readiness},
#>     author = {Pawan Rama Mali},
#>     year = {2026},
#>     note = {R package version 0.3.1, commit c79bd14b67a6186cd86d442ed8bac71ba9bb29e1},
#>     url = {https://github.com/R4SUB/r4subprofile},
#>   }
#> ── r4subusability ──
#> 
#> To cite package ‘r4subusability’ in publications use:
#> 
#>   Mali P (2026). _r4subusability: Usability Indicators for Clinical
#>   Submission Readiness_. R package version 0.2.1, commit
#>   86a8df2a4e6beb8534e11efd121bc68bd0bf269e,
#>   <https://github.com/R4SUB/r4subusability>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {r4subusability: Usability Indicators for Clinical Submission Readiness},
#>     author = {Pawan Rama Mali},
#>     year = {2026},
#>     note = {R package version 0.2.1, commit 86a8df2a4e6beb8534e11efd121bc68bd0bf269e},
#>     url = {https://github.com/R4SUB/r4subusability},
#>   }
r4sub_cite("r4subcore")
#> ── r4subcore ──
#> 
#> To cite package ‘r4subcore’ in publications use:
#> 
#>   Mali P (2026). _r4subcore: Evidence Schema, Parsers, and Shared
#>   Primitives_. R package version 0.3.1.9000, commit
#>   3a6c1c8278edb68a2a3fafe95655a2f84cbeadb2,
#>   <https://github.com/R4SUB/r4subcore>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {r4subcore: Evidence Schema, Parsers, and Shared Primitives},
#>     author = {Pawan Rama Mali},
#>     year = {2026},
#>     note = {R package version 0.3.1.9000, commit 3a6c1c8278edb68a2a3fafe95655a2f84cbeadb2},
#>     url = {https://github.com/R4SUB/r4subcore},
#>   }
```
