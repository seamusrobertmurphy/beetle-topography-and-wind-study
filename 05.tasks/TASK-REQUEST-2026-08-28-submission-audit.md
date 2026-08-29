# Task request: exhaustive pre-submission audit

**Target venue.** Journal of Applied Entomology, Original Article. Wiley, ScholarOne.
**Status.** Package assembled and rendering clean. NOT submitted. NOT cleared.
**Written.** 2026-08-28, at the end of a session that refit the study on year-matched
inventory data and changed several reported coefficients.

Read this whole file before touching anything. It names the six files to audit, the rubric
to audit them against, the numbers that must reconcile, the traps that have already cost
hours, and the one item that blocks submission outright.

---

## 1. What is being audited

Six files, all rebuilt 2026-08-28 21:36 from
`01.manuscript/beetle-topography-wind-study-vri-timeseries.qmd`.

| Upload order | Absolute path |
|---|---|
| 00 | `/Volumes/PortableSSD/Github/claude-science-library/publications-academic/beetle-topography-and-wind-study/01.manuscript/submission-jae/package/00 Cover Letter.docx` |
| 01 | `.../submission-jae/package/01 Title Page.docx` |
| 02 | `.../submission-jae/package/02 Main Document.docx` |
| 03 | `.../submission-jae/package/03 Tables.docx` |
| 04 | `.../submission-jae/package/04 Figure 1.png` |
| 05 | `.../submission-jae/package/05 Figure 2.png` |

The package is assembled by `05.tasks/scripts/build-submission-jae.py`, which refuses to
build if any piece is missing. Re-run it after any render.

---

## 2. BLOCKING: the Dryad deposit

**The submission cannot proceed until this is done.** Everything else in this file is an
audit; this is a task.

The journal states that it "mandates data sharing, and authors are required to provide a
data availability statement at the submission stage, including a link to the repository
where your data is stored", and that "Alternatives, e.g. that data be made available on
request or uploaded as supplementary files, are not accepted."

Both the title page and the main document currently carry the literal string
`doi:PLACEHOLDER-DRYAD-DOI`. Grep for it; it must be gone before upload.

What to do, in order:

1. Deposit at Dryad, https://datadryad.org. Wiley pays the archiving charge for papers
   published in this journal, so do not pay it yourself. Materials must be curated by
   Dryad after 2026-01-01 to qualify for fee coverage under the sponsorship.
2. Deposit the derived data and code that reproduce every number, not the raw archives.
   Candidates, with sizes:
   - `02.inputs/beetle-classification/model-data/model_table_vri.csv` (111,707 rows)
   - `02.inputs/beetle-classification/model-data/epoch_model_table_vri.csv` (66,302 rows)
   - `02.inputs/beetle-classification/model-data/vri_year_source.csv`
   - `02.inputs/beetle-classification/model-data/vri_refit_comparison.csv`
   - `02.inputs/beetle-classification/model-data/flight_window_sensitivity.csv`
   - `02.inputs/beetle-classification/study-area/vri-timeseries/` (nine GeoPackages)
   - `02.inputs/beetle-classification/covariates/flight-window/` (hourly climate)
   - every numbered script in `02.inputs/beetle-classification/`
   Do NOT deposit the provincial archives themselves; cite them instead.
3. Take the **Private for Peer Review** link Dryad issues and put it in the data
   availability statement AND in the cover letter, as the journal asks.
4. Substitute the real DOI in:
   - `01.manuscript/submission-jae/title-page.qmd`
   - `01.manuscript/beetle-topography-wind-study-vri-timeseries.qmd`
   then re-render both and rebuild the package.

The GitHub mirror, https://github.com/seamusrobertmurphy/beetle-topography-and-wind-study,
is named alongside the DOI but does not satisfy the requirement on its own.

---

## 3. Audit rubric

Work through every section. Record a verdict per item: PASS, FAIL with the evidence, or
NOT CHECKED with the reason. A finding must name the file, the page or section, and the
exact text or number it rests on. Re-verify against the delivered file, never against this
document.

### 3.1 Journal compliance

Source of truth: `04.references/Submission Guidelines - Journal of Applied Entomology.pdf`,
text layer intact, read 2026-08-20. **Re-read it.** Publishers change these pages without
notice and a fabricated limit is discovered at submission, which is the most expensive
moment to discover it. If the live page disagrees with the PDF, the live page wins and the
discrepancy gets recorded.

- [ ] Body 6,000 words or fewer, references excluded. Last measured 5,797. Tables and
      figure legends are NOT excluded by the journal's wording; confirm what it counts.
- [ ] Abstract 300 words or fewer, unstructured. Last measured 294. Recount from the
      rendered docx, not from source: inline code expands.
- [ ] Exactly six keywords, none appearing in the title. Current set is Dendroctonus
      ponderosae, Landsat time series, stand density, geomorphometry, temporal resolution,
      pheromone communication. Title words are testing, wind, disruption, hypothesis,
      beetle, refugia. An earlier set broke this rule three times over.
- [ ] Running title under 40 characters. Currently "Wind disruption and beetle refugia", 34.
- [ ] Body in four sections: Introduction, Materials and Methods, Results, Discussion.
      Conclusions optional. **Check the current headings actually match this.**
- [ ] References APA 6th. The document uses `04.references/apa-6th-edition.csl`. Note that
      `apa.csl` in the same folder is APA FIFTH despite its name; confirm the right one is
      wired in the YAML.
- [ ] In-text citation rules: one or two authors always named; three to five named on first
      citation then et al.; six or more et al. throughout. Spot-check ten citations.
- [ ] No footnotes anywhere in the text.
- [ ] Species: common name followed by scientific name with authority on first use in the
      title, the abstract and the text.
- [ ] SI units throughout.
- [ ] Numbers under ten spelt out, except with a unit, an age, or in a list with other
      numbers.
- [ ] Title page carries every element the journal lists: title, running title, full author
      names, affiliations, acknowledgements including funding, data availability, funding,
      conflict of interest, ethics approval, patient consent, permission to reproduce,
      clinical trial registration.
- [ ] Main document carries the conflict of interest statement and the CRediT author
      contribution above the references, both of which the journal requires in that file.
- [ ] Figure legends present as a complete list in the main text.
- [ ] Tables self-contained, abbreviations defined in footnotes, footnote symbols in the
      order dagger, double dagger, section, pilcrow, asterisks reserved for P-values, and
      SD or SEM named in the column heading wherever shown.
- [ ] British spelling, or consistent throughout.

### 3.2 Statistical reporting

- [ ] Every coefficient in the prose exists in the model it is attributed to. The document
      carries a `term-guard` chunk that stops the render if not; confirm it is armed, i.e.
      `GUARD_DIAGNOSTIC <- FALSE` in `01.manuscript/_sections/_preamble.qmd`.
- [ ] Every number in the abstract reconciles with a table or a fitted model. Trace each
      one. Nothing may be typed: all are inline R expressions.
- [ ] p-values at thresholds, p < 0.001, p < 0.01, p < 0.05, not to three significant
      figures. R's `%.3g` default produced "p = < 1e-16" in an earlier draft.
- [ ] No scientific notation anywhere in the prose or tables.
- [ ] Effects reported in a unit a reader can hold. Log-odds per standard deviation is not
      such a unit; odds ratios accompany them.
- [ ] Test statistics to two decimals.
- [ ] MAPE and Theil's U are absent, and the model-comparison caption says why: both divide
      by the observed value, which is zero for the majority class of a binary response.
      **This is correct and must not be "fixed".** The companion regeneration paper reports
      Theil's U legitimately because its response is continuous.
- [ ] AIC is not compared across models fitted on different numbers of rows. The
      flight-window table's thermal-gate row has 69,711 cell-epochs against 71,127 and its
      caption says so.
- [ ] Spatial autocorrelation acknowledged wherever a p-value rests on 30 m cells in a
      spreading outbreak. The diameter-class tests are anti-conservative and say so.
- [ ] Confidence intervals are Wilson score intervals on class proportions, and the caption
      says why rather than using the normal approximation.

### 3.3 Numbers that must reconcile

These are the current values. Any disagreement between the prose, the tables and these is a
finding. They come from `model-data/vri_refit_comparison.csv` and
`model-data/flight_window_sensitivity.csv`.

> **Superseded in part, 2026-08-28.** The audit recomputed every row of this table. Five are
> stale, and in each case the manuscript is right and this table is wrong: the attack peak is
> 39.7 per cent, not 45.9; the diameter chi-square, df and Cramer's V are 1230.4, 5 and 0.163,
> not 2271.7, 5 and 0.219; the step across the 25 cm boundary is +13.24 points with a 95 per
> cent interval of 12.1 to 14.4, not +9.6 and 8.3 to 11.0; and the cells modelled are 15,092,
> 24.4 per cent of the perimeter, not 15,338 and 24.8. All five are the pre-refit balanced
> sample. The other twelve rows verified exactly. See `05.tasks/AUDIT-2026-08-28-submission.md`
> section 4.3.

| Quantity | Value |
|---|---|
| Stem density x epoch wind, year-matched | -0.0491, p 3.8e-09 |
| Standing volume x epoch wind, year-matched | -0.0169, p 0.038 |
| Same two on the static 2025 composite | -0.0941 and -0.0410 |
| AUC, year-matched against static | 0.6730 against 0.6685 |
| Between-year SD of mean standing volume | 13.68 against 7.95 |
| Stand basal area, annual model M3 | +0.504 |
| Basal area univariate AUC, year-matched against static | 0.602 against 0.517 |
| Live stems univariate AUC, same | 0.616 against 0.572 |
| Standing volume univariate AUC, same | 0.550 against 0.547 |
| Attack peak, 25 to 30 cm diameter class | 45.9 per cent |
| Diameter chi-square, df, Cramer's V | 2271.7, 5, 0.219 |
| Step across the 25 cm boundary | +9.6 points, 95% CI 8.3 to 11.0 |
| Afternoon hours inside the 19-41 C gate, in window against out | 89.5 against 51.4 per cent |
| Wind at 14:00-15:00 against 09:00 | 10.4 against 6.5 km/h |
| Study area | 5,573 ha, 61,923 cells at 30 m |
| Cells actually modelled | 15,338, which is 24.8 per cent of the perimeter |
| Elevation band of the perimeter | 830 to 1744 m |

**Known unresolved.** The maps draw the full 61,923-cell perimeter while the models fit on
15,338 cells. A reader sizing the study from Figure 1 will be wrong by four times. Decide
whether to draw the analysed extent, outline it, or state it in the caption.

**Known unresolved.** The 830 to 1744 m cut truncates the terrain gradient at both ends and
elevation is among the largest terms in the model. This is not in the Limitations.

### 3.4 Prose and style

Match `Murphy et al. 2026, Spatial Patterns of Conifer Regeneration`, at
`/Volumes/PortableSSD/Github/scientific-library/library/pdf/Murphy et al 2026 Spatial Patterns of Confier Regeneration Following Mixed Severity Fire and MPB Outbreaks in Selkirk Mountains.pdf`.
Its measured profile: sentences averaging 18.5 words, median 15; 21 uses of first-person
plural; hypotheses labelled H1 to H3 and restated when the Discussion opens; p at
thresholds; effects in interpretable units with a concrete scenario before the p-value;
signposting connectives, Notably 5, However 4, Specifically 3, Additionally 3.

- [ ] No em-dashes anywhere. Not for emphasis, not for an aside. En-dashes only in numeric
      ranges.
- [ ] No sentence fragments standing as sentences.
- [ ] Every pronoun has an unambiguous antecedent.
- [ ] Jargon defined in the same sentence it first appears, in six words or fewer.
- [ ] Sentences over 45 words justified. Long quotations are exempt and must stay verbatim.
- [ ] H1, H2 and H3 stated in the Introduction and restated at the Discussion opening.
- [ ] No bullet lists where continuous prose belongs.
- [ ] Headings of three words or fewer. **This is currently failing; several exceed it.**
- [ ] Section headings match the journal's required four-section structure.

**Incomplete work.** The prose audit was not finished. Basal area replaced standing volume
in the annual model late in the session, and Discussion and Conclusions sentences still
describe "standing wood in large stems" where the model now selects basal area. Find and
fix every one.

### 3.5 Citations

- [ ] Every cited key exists in `04.references/references-beetle.bib`. Last check: 21 cited,
      all present, no orphans.
- [ ] Every DOI resolves against CrossRef. Query it; do not trust the file.
- [ ] Every quotation is verbatim and checked against the source PDF, not against a paste.
      The project has previously attributed a word to an abstract in which it never appeared.
- [ ] Page numbers given for quotations where the source has them.
- [ ] `cooke2025` is correctly dated 2025 against the print issue, volume 149, pages 309 to
      323, although CrossRef defaults to the 2024 online-first date. Do not "correct" it.

### 3.6 Figures and tables

- [ ] Figure 1 is nine panels at 1:150,000, each with its own north arrow and numerical
      scale, the burn perimeter in red and the study perimeter in white.
- [ ] Esri World Shaded Relief is attributed in the caption. This is a licence condition.
- [ ] Figure 2 is the interaction figure.
- [ ] Figures legible in greyscale. The journal charges 150 GBP for the first colour figure
      in print and 50 GBP for each after, so confirm whether colour is being paid for.
- [ ] Tables editable, not images.
- [ ] Every table referenced in the text and numbered in order of first mention.

---

## 4. Where everything lives

All paths relative to
`/Volumes/PortableSSD/Github/claude-science-library/publications-academic/beetle-topography-and-wind-study/`.

**Manuscript sources**
- `01.manuscript/beetle-topography-wind-study-vri-timeseries.qmd` THE SUBMISSION
- `01.manuscript/beetle-topography-wind-study-short-short.qmd` Frontiers version, 2,500 words
- `01.manuscript/_sections/_preamble.qmd` the shared analysis, included by both
- `01.manuscript/_shared/` map, fit-metrics, descriptive, diameter-test, data-inventory
- `01.manuscript/submission-jae/` title-page.qmd, cover-letter.qmd, tables.qmd, package/
- `archive/superseded-drafts-2026-08-28/` three dead drafts with a README explaining each

**Guidelines and references**
- `04.references/Submission Guidelines - Journal of Applied Entomology.pdf`
- `04.references/references-beetle.bib` 98 entries
- `04.references/apa-6th-edition.csl` the correct style
- `04.references/literature/` source PDFs for quotation checking

**Data and scripts**, all in `02.inputs/beetle-classification/`
- `17-`, `20-`, `22-`, `19-`, `24-` the Landsat classification chain
- `30-`, `36-`, `41-` station wind and the MicroMet field
- `37-geomorphometry.R` SAGA terrain, its unclipped intermediates in `geomorphometry/saga/`
- `42-` to `45-` the 16-day epoch chain
- `46-fetch-basemap.py` Freshwater Atlas water
- `47-context-terrain.R` unclipped DEM and hillshade
- `48-fetch-basemap-relief.R` cached Esri relief base map
- `49-context-covariates.R` unclipped display surfaces
- `50-fetch-vri-timeseries.R` the nine annual inventory snapshots
- `51-flight-window-climate.R` hourly climate through the flight season
- `52-flight-window-sensitivity.R` epoch wind under four window definitions
- `53-refit-flight-window.R` refits under each
- `55-build-vri-timeseries-table.R` year-matched modelling tables
- `56-refit-vri-timeseries.R` the refit comparison

**Project memory**, read this first
- `.claude/memory/memory.md` the index
- `.claude/memory/general.md` every trap found, dated
- `.claude/memory/domain/` five topic files

---

## 5. Traps that have already cost hours

Do not rediscover these.

1. **`terra::vect()` turns an integer column's NA into -2147483648**, and `rasterize`
   carries it through as a value. It hit exactly the three integer inventory fields and left
   the four doubles alone. Cast to `as.numeric()` before `vect()`.
2. **Cached selection chunks are not safe across data.** The docx and html renders of the
   submission disagreed about which variables the model selected, because a selection cached
   from the 2025 composite was reused on year-matched data. Clear
   `01.manuscript/*_cache/` before any render whose result will be believed.
3. **Concurrent writes silently corrupt GeoPackages.** Two processes writing
   `study-area/vri-timeseries/` destroyed two years' data. The file survives at a plausible
   size and fails only when read.
4. **The province's data server answers HEAD with 404**, which breaks GDAL's size probe and
   makes a perfectly good 3.9 GB archive look unopenable. `CPL_VSIL_CURL_USE_HEAD=NO`.
5. **The VRI has three schema generations.** Field names differ before 2008, in 2008, and
   from 2009. Per-species volume alone has three names. See the table in
   `02.inputs/README.md`.
6. **Contours drawn before a raster are invisible.** They must be added after the surface.
7. **`dplyr::summarise` reuses columns created earlier in the same call**, so a share
   computed after a mean of the same name tests the mean and returns 0 or 1.
8. **Archiving a draft that uses `{{< include >}}` breaks every render in the project**
   until the folder is excluded. `_quarto.yml` carries an explicit render list for this.
9. **A full uncached render takes about 30 minutes** for both formats. Batch edits.

---

## 6. Correction protocol

Finding a fault is half the task. This section governs what happens next, because the
danger in a manuscript audit is not the fault you miss but the fix you apply without
noticing what it moved.

### 6.1 Three classes of finding

Classify every finding before touching anything.

**Class A, fix directly.** Objectively wrong, one correct answer, no judgement about the
science. Typos, grammar, a citation whose DOI does not resolve, a p-value in scientific
notation, an em-dash, a heading over three words, a number in the prose that disagrees with
the table it is drawn from, a missing statement the journal mandates. Fix it, re-render,
record it.

**Class B, fix and flag prominently.** The fix is clear but it changes what the paper
claims or how strongly. A coefficient that turns out not to exist in the model quoted. A
sentence that overstates an effect. A comparison that is not valid, such as AIC across
different sample sizes. Fix it, then state in the report exactly which sentence changed and
what it said before, because Seamus needs to know his paper now says something different.

**Class C, do not fix, put to Seamus.** Anything requiring a decision about the science or
the venue. Dropping a variable, changing a model specification, altering what the study
claims to have shown, restructuring a section, changing the target journal, deciding whether
the maps should show the analysed extent or the perimeter. Write the finding, give the
options with their consequences, recommend one, and stop.

When a finding could be B or C, treat it as C.

### 6.2 Before any fix

- Reproduce the fault and record the exact evidence: file, location, the text or number as
  delivered. A finding that cannot be re-run from its own citation is not issuable.
- Check whether the same fault appears in the Frontiers draft,
  `01.manuscript/beetle-topography-wind-study-short-short.qmd`, and in the shared preamble.
  A fault in `_sections/_preamble.qmd` or `_shared/` reaches both drafts.
- Never edit a number in the prose to match a table. Every number is an inline R expression
  over a fitted object. If the prose disagrees with the table, either the expression names
  the wrong term or the model changed; find which. Typing the number in is the one repair
  that must never be made.

### 6.3 Applying a fix

- Fix at the source. A caption fixed in the docx is lost on the next render.
- Prefer the shared files when the fault is shared. Editing one draft and not the other is
  how this project accumulated four divergent manuscripts.
- One class of fix per commit, with a message saying what was wrong and how it was found.
- If a fix touches any model, variable selection or data table, delete
  `01.manuscript/*_cache/` before re-rendering. A cached selection computed on different
  data is the fault that produced two contradictory renders of one file.

### 6.4 After any fix

- Re-render clean and uncached, both docx and html. The two formats have disagreed before,
  and that disagreement was the only evidence of a real problem.
- Confirm the `term-guard` chunk passes with `GUARD_DIAGNOSTIC <- FALSE`. It is the
  document's own check that every term the prose names exists in the model it is attributed
  to.
- Re-check the whole of section 3.3 in this document. A fix to one model moves numbers in
  the abstract, the Results, the Discussion and two tables at once.
- Recount the body words and the abstract. Both are close to their limits, 5,797 against
  6,000 and 294 against 300, so prose fixes can breach them.
- Rebuild the package with `05.tasks/scripts/build-submission-jae.py`.
- Record the finding and its resolution in `.claude/memory/general.md`, one line, dated,
  naming the artefact.

### 6.5 What must never be done

- Do not remove a citation to satisfy a reference cap. Raise the article type instead.
- Do not restore MAPE or Theil's U. They are undefined on a binary response and their
  absence is explained in the caption.
- Do not change `cooke2025` to 2024.
- Do not swap `apa-6th-edition.csl` for `apa.csl`, which is APA fifth.
- Do not render or cite anything in `archive/`.
- Do not report the audit as passed while `PLACEHOLDER-DRYAD-DOI` appears in any file.

### 6.6 If the audit finds nothing in a section

Say so explicitly, and say what was checked and how. A section reported as clean without a
stated method is not evidence that it is clean.

---

## 7. What a finished audit looks like

A single report naming, for every item in the rubric, PASS, FAIL with evidence, or NOT
CHECKED with the reason. Findings ranked most severe first. Every finding cites the file,
the location, and the exact text or number. Any fix applied is followed by a clean uncached
re-render and a rebuilt package, and the report says which numbers moved.

Do not report the audit as passed while the Dryad DOI is a placeholder.
