## Submission notes

This is a meta-package in the style of the 'tidyverse' package. Its sole
purpose is to install and load the R4SUB (R for Regulatory Submission)
ecosystem in one call. All packages listed in `Depends` are available on CRAN:
r4subcore, r4subdata, r4subprofile, r4subrisk, r4subscore, r4subtrace.

---

## Test environments

* local: Windows 11 x64, R 4.5.2
* GitHub Actions: ubuntu-latest, R release
* GitHub Actions: windows-latest, R release

## R CMD check results

0 errors | 0 warnings | 1 note

NOTE: "Depends: includes the non-default packages..."
This is expected and intentional for a meta-package. The behaviour is
identical to the 'tidyverse' package on CRAN.

## Downstream dependencies

None.
