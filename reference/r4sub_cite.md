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
#>   4c6e7b15bc7bf306a995498e7ad60b455006c703,
#>   <https://github.com/R4SUB/r4subcore>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {r4subcore: Evidence Schema, Parsers, and Shared Primitives},
#>     author = {Pawan Rama Mali},
#>     year = {2026},
#>     note = {R package version 0.3.1.9000, commit 4c6e7b15bc7bf306a995498e7ad60b455006c703},
#>     url = {https://github.com/R4SUB/r4subcore},
#>   }
#> ── r4subtrace ──
#> 
#> To cite package ‘r4subtrace’ in publications use:
#> 
#>   Mali P (2026). _r4subtrace: Traceability Engine for Clinical
#>   Submission Readiness_. R package version 0.3.1, commit
#>   01b4a06216658dc8178ad31144db7cfe2b720f1c,
#>   <https://github.com/R4SUB/r4subtrace>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {r4subtrace: Traceability Engine for Clinical Submission Readiness},
#>     author = {Pawan Rama Mali},
#>     year = {2026},
#>     note = {R package version 0.3.1, commit 01b4a06216658dc8178ad31144db7cfe2b720f1c},
#>     url = {https://github.com/R4SUB/r4subtrace},
#>   }
#> ── r4subscore ──
#> 
#> To cite package ‘r4subscore’ in publications use:
#> 
#>   Mali P (2026). _r4subscore: Submission Confidence Index Engine_. R
#>   package version 0.4.1, commit
#>   ab871ab7bf2014aa4ac90174e00f5c4cb80b81c7,
#>   <https://github.com/R4SUB/r4subscore>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {r4subscore: Submission Confidence Index Engine},
#>     author = {Pawan Rama Mali},
#>     year = {2026},
#>     note = {R package version 0.4.1, commit ab871ab7bf2014aa4ac90174e00f5c4cb80b81c7},
#>     url = {https://github.com/R4SUB/r4subscore},
#>   }
#> ── r4subrisk ──
#> 
#> To cite package ‘r4subrisk’ in publications use:
#> 
#>   Mali P (2026). _r4subrisk: Risk Quantification Engine for Clinical
#>   Submission Readiness_. R package version 0.3.1, commit
#>   3b9422f1b622964c3471bccb59e1cad6c273aa7e,
#>   <https://github.com/R4SUB/r4subrisk>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {r4subrisk: Risk Quantification Engine for Clinical Submission Readiness},
#>     author = {Pawan Rama Mali},
#>     year = {2026},
#>     note = {R package version 0.3.1, commit 3b9422f1b622964c3471bccb59e1cad6c273aa7e},
#>     url = {https://github.com/R4SUB/r4subrisk},
#>   }
#> ── r4subdata ──
#> 
#> To cite package ‘r4subdata’ in publications use:
#> 
#>   Mali P (2026). _r4subdata: Example Datasets for Clinical Submission
#>   Readiness_. R package version 0.1.4, commit
#>   e15a2b6586448f4503259b66a0fb77d9bb208e59,
#>   <https://github.com/R4SUB/r4subdata>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {r4subdata: Example Datasets for Clinical Submission Readiness},
#>     author = {Pawan Rama Mali},
#>     year = {2026},
#>     note = {R package version 0.1.4, commit e15a2b6586448f4503259b66a0fb77d9bb208e59},
#>     url = {https://github.com/R4SUB/r4subdata},
#>   }
#> ── r4subprofile ──
#> 
#> To cite package ‘r4subprofile’ in publications use:
#> 
#>   Mali P (2026). _r4subprofile: Regulatory Authority Profiles for
#>   Submission Readiness_. R package version 0.3.1, commit
#>   e285a5fd80f18b238ec8f0a7b4a9390c663639fd,
#>   <https://github.com/R4SUB/r4subprofile>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {r4subprofile: Regulatory Authority Profiles for Submission Readiness},
#>     author = {Pawan Rama Mali},
#>     year = {2026},
#>     note = {R package version 0.3.1, commit e285a5fd80f18b238ec8f0a7b4a9390c663639fd},
#>     url = {https://github.com/R4SUB/r4subprofile},
#>   }
#> ── r4subusability ──
#> 
#> To cite package ‘r4subusability’ in publications use:
#> 
#>   Mali P (2026). _r4subusability: Usability Indicators for Clinical
#>   Submission Readiness_. R package version 0.2.1, commit
#>   7bf6c3e0bd9dc28e0361d3913f9b712d2e67f6f7,
#>   <https://github.com/R4SUB/r4subusability>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {r4subusability: Usability Indicators for Clinical Submission Readiness},
#>     author = {Pawan Rama Mali},
#>     year = {2026},
#>     note = {R package version 0.2.1, commit 7bf6c3e0bd9dc28e0361d3913f9b712d2e67f6f7},
#>     url = {https://github.com/R4SUB/r4subusability},
#>   }
r4sub_cite("r4subcore")
#> ── r4subcore ──
#> 
#> To cite package ‘r4subcore’ in publications use:
#> 
#>   Mali P (2026). _r4subcore: Evidence Schema, Parsers, and Shared
#>   Primitives_. R package version 0.3.1.9000, commit
#>   4c6e7b15bc7bf306a995498e7ad60b455006c703,
#>   <https://github.com/R4SUB/r4subcore>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {r4subcore: Evidence Schema, Parsers, and Shared Primitives},
#>     author = {Pawan Rama Mali},
#>     year = {2026},
#>     note = {R package version 0.3.1.9000, commit 4c6e7b15bc7bf306a995498e7ad60b455006c703},
#>     url = {https://github.com/R4SUB/r4subcore},
#>   }
```
