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
#>   6f842565e5afff370b449541f721aba2186cabe5,
#>   <https://github.com/R4SUB/r4subcore>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {r4subcore: Evidence Schema, Parsers, and Shared Primitives},
#>     author = {Pawan Rama Mali},
#>     year = {2026},
#>     note = {R package version 0.3.1.9000, commit 6f842565e5afff370b449541f721aba2186cabe5},
#>     url = {https://github.com/R4SUB/r4subcore},
#>   }
#> ── r4subtrace ──
#> 
#> To cite package ‘r4subtrace’ in publications use:
#> 
#>   Mali P (2026). _r4subtrace: Traceability Engine for Clinical
#>   Submission Readiness_. R package version 0.3.1, commit
#>   9defd9dfc51d771b2ff1b5c49297bba83c8557ad,
#>   <https://github.com/R4SUB/r4subtrace>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {r4subtrace: Traceability Engine for Clinical Submission Readiness},
#>     author = {Pawan Rama Mali},
#>     year = {2026},
#>     note = {R package version 0.3.1, commit 9defd9dfc51d771b2ff1b5c49297bba83c8557ad},
#>     url = {https://github.com/R4SUB/r4subtrace},
#>   }
#> ── r4subscore ──
#> 
#> To cite package ‘r4subscore’ in publications use:
#> 
#>   Mali P (2026). _r4subscore: Submission Confidence Index Engine_. R
#>   package version 0.4.1, commit
#>   d08d555f8912cae8a20c545865dbbefb0847ea6b,
#>   <https://github.com/R4SUB/r4subscore>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {r4subscore: Submission Confidence Index Engine},
#>     author = {Pawan Rama Mali},
#>     year = {2026},
#>     note = {R package version 0.4.1, commit d08d555f8912cae8a20c545865dbbefb0847ea6b},
#>     url = {https://github.com/R4SUB/r4subscore},
#>   }
#> ── r4subrisk ──
#> 
#> To cite package ‘r4subrisk’ in publications use:
#> 
#>   Mali P (2026). _r4subrisk: Risk Quantification Engine for Clinical
#>   Submission Readiness_. R package version 0.3.1, commit
#>   435418fc011b3e8075b2425db2dd2027a3b9917d,
#>   <https://github.com/R4SUB/r4subrisk>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {r4subrisk: Risk Quantification Engine for Clinical Submission Readiness},
#>     author = {Pawan Rama Mali},
#>     year = {2026},
#>     note = {R package version 0.3.1, commit 435418fc011b3e8075b2425db2dd2027a3b9917d},
#>     url = {https://github.com/R4SUB/r4subrisk},
#>   }
#> ── r4subdata ──
#> 
#> To cite package ‘r4subdata’ in publications use:
#> 
#>   Mali P (2026). _r4subdata: Example Datasets for Clinical Submission
#>   Readiness_. R package version 0.1.4, commit
#>   0ca4c4dc03971649bcc91a380583a0e2ab9ad88b,
#>   <https://github.com/R4SUB/r4subdata>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {r4subdata: Example Datasets for Clinical Submission Readiness},
#>     author = {Pawan Rama Mali},
#>     year = {2026},
#>     note = {R package version 0.1.4, commit 0ca4c4dc03971649bcc91a380583a0e2ab9ad88b},
#>     url = {https://github.com/R4SUB/r4subdata},
#>   }
#> ── r4subprofile ──
#> 
#> To cite package ‘r4subprofile’ in publications use:
#> 
#>   Mali P (2026). _r4subprofile: Regulatory Authority Profiles for
#>   Submission Readiness_. R package version 0.3.1, commit
#>   c3396d01b92dcc7434d7779190cee8b45471e5c2,
#>   <https://github.com/R4SUB/r4subprofile>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {r4subprofile: Regulatory Authority Profiles for Submission Readiness},
#>     author = {Pawan Rama Mali},
#>     year = {2026},
#>     note = {R package version 0.3.1, commit c3396d01b92dcc7434d7779190cee8b45471e5c2},
#>     url = {https://github.com/R4SUB/r4subprofile},
#>   }
#> ── r4subusability ──
#> 
#> To cite package ‘r4subusability’ in publications use:
#> 
#>   Mali P (2026). _r4subusability: Usability Indicators for Clinical
#>   Submission Readiness_. R package version 0.2.1, commit
#>   457da1a56b171aac5b9ab31196b1ecd4e11c1bf5,
#>   <https://github.com/R4SUB/r4subusability>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {r4subusability: Usability Indicators for Clinical Submission Readiness},
#>     author = {Pawan Rama Mali},
#>     year = {2026},
#>     note = {R package version 0.2.1, commit 457da1a56b171aac5b9ab31196b1ecd4e11c1bf5},
#>     url = {https://github.com/R4SUB/r4subusability},
#>   }
r4sub_cite("r4subcore")
#> ── r4subcore ──
#> 
#> To cite package ‘r4subcore’ in publications use:
#> 
#>   Mali P (2026). _r4subcore: Evidence Schema, Parsers, and Shared
#>   Primitives_. R package version 0.3.1.9000, commit
#>   6f842565e5afff370b449541f721aba2186cabe5,
#>   <https://github.com/R4SUB/r4subcore>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {r4subcore: Evidence Schema, Parsers, and Shared Primitives},
#>     author = {Pawan Rama Mali},
#>     year = {2026},
#>     note = {R package version 0.3.1.9000, commit 6f842565e5afff370b449541f721aba2186cabe5},
#>     url = {https://github.com/R4SUB/r4subcore},
#>   }
```
