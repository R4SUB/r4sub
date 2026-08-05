# CRAN submission bundle — R4SUB ecosystem

This is the working checklist for submitting the R4SUB ecosystem to CRAN. It is
not part of the package (it is listed in `.Rbuildignore`). Nothing here submits
anything; each `Submit` step is a manual action you take at
<https://cran.r-project.org/submit.html>, and CRAN emails you a confirmation
link that only you can click.

## Version map

| Package | On CRAN | To submit | Kind |
|---|---|---|---|
| r4subcore | 0.1.0 | 0.2.1 | update |
| r4subdata | 0.1.1 | 0.1.3 | update (docs) |
| r4subscore | 0.1.0 | 0.2.1 | update |
| r4subtrace | 0.1.0 | 0.2.1 | update |
| r4subrisk | 0.1.0 | 0.2.0 | update |
| r4subprofile | 0.1.0 | 0.2.0 | update |
| r4subusability | not on CRAN | 0.2.0 | first submission |
| r4subpharma | not on CRAN | 0.1.0 | first submission |
| r4subui | not on CRAN | 0.1.0 | first submission |
| r4sub | 0.1.0 | 0.2.0 | update |

## Submission order

CRAN requires every package in `Imports`/`Depends` to already be on CRAN, so the
ecosystem must go bottom-up. Submit a wave, wait for each package to be accepted
and appear on CRAN, then start the next wave.

**Wave 1 — foundation (no ecosystem imports)**
1. r4subcore 0.2.1
2. r4subdata 0.1.3

Both are self-contained. r4subcore is imported by almost everything else, so it
must land first.

**Wave 2 — import r4subcore only**
3. r4subscore 0.2.1
4. r4subtrace 0.2.1
5. r4subrisk 0.2.0
6. r4subprofile 0.2.0
7. r4subusability 0.2.0 (first submission)

**Wave 3 — import several ecosystem packages**
8. r4subpharma 0.1.0 (imports r4subcore; suggests r4subscore, r4subprofile)
9. r4subui 0.1.0 (imports r4subcore, r4subscore, r4subtrace, r4subprofile)

**Wave 4 — the meta-package (imports the six core packages)**
10. r4sub 0.2.0 — imports r4subusability, so it can only go once
    r4subusability (wave 2) is on CRAN.

## Reverse-dependency coordination

Updating r4subcore is the one step that touches existing CRAN packages. When
r4subcore 0.2.1 is submitted, CRAN runs the reverse-dependency check against the
versions of r4subscore/r4subtrace/r4subrisk/r4subprofile that are currently on
CRAN (all 0.1.0). This release is deliberately additive: the evidence schema,
the controlled vocabularies, and the existing function signatures are unchanged,
and `hash_id()` keeps the same output shape, so the 0.1.0 reverse dependencies
continue to pass. If CRAN raises a reverse-dependency question, reply that the
updated reverse dependencies (wave 2) are being submitted immediately after.

## Per-package pre-submission checklist

For each package, before you submit:

1. `R CMD check --as-cran` on the built tarball is clean: 0 errors, 0 warnings.
   The three first submissions (usability, pharma, ui) will each show a single
   "New submission" NOTE, which is expected. r4sub shows the expected
   meta-package "non-default packages in Depends/Imports" NOTE.
2. Run a second platform: `devtools::check_win_devel()` and, optionally,
   `rhub::rhub_check()` (Linux + macOS). Address anything new.
3. `cran-comments.md` is present and current (already prepared in each repo).
4. `NEWS.md` top section matches the version being submitted.
5. The version in `DESCRIPTION` matches the git tag.

## Known, acceptable notes

* First submissions show a "New submission" NOTE.
* The `https://r4sub.github.io/<pkg>/` and `https://r4sub.r-universe.dev/<pkg>`
  URLs 404 until the pkgdown site and r-universe build publish for the new
  release. These resolve on their own shortly after release; if CRAN objects,
  either wait for the sites to publish or drop the URL for the submission.

## CRAN policy reminders

* Do not resubmit a package more than about once every one to two months without
  a good reason. Submitting ten packages over a few weeks is fine as long as
  each is a genuine release.
* Respond to CRAN correspondence from the maintainer address
  (prm@outlook.in) only; the confirmation email link must be clicked by the
  maintainer.
