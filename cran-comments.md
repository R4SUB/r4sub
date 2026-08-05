## Submission

This is an update of the r4sub meta-package from 0.1.0 (on CRAN) to 0.2.0. In the
style of the 'tidyverse' package, its purpose is to install and attach the R4SUB
(Ready for Submission) ecosystem in one call. This release attaches
r4subusability as a core package and adds a pharmaverse positioning vignette and
community documentation. See NEWS.md.

Note on ordering: r4sub now imports r4subusability, so this update should be
submitted only after r4subusability is available on CRAN.

## Test environments

* local: Windows 11 x64, R 4.5.x
* GitHub Actions: ubuntu-latest, windows-latest, macos-latest (R release)

## R CMD check results

0 errors | 0 warnings | 1 note

The note is the expected "Depends/Imports includes non-default packages" note
for a meta-package, identical in nature to the 'tidyverse' package on CRAN.

## Reverse dependencies

None. r4sub is the top of the ecosystem and nothing depends on it.
