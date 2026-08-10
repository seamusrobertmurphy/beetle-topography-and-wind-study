# Progress log: topographic refugia from mountain pine beetle (Darkwoods spin-off)

**Started:** 2026-07-30
**Status:** Phase 10 complete. Full pre-submission review run; venue decision now required before further work.
**Last updated:** 2026-08-04
**Current task request:** `TASK-REQUEST-2026-07-31.md`
**Predecessor:** `Archive/writing_outputs/20260613_053044_rs_methods_spinoff/` (Phase 0)

## Timeline

### Phase 0, scoping and novelty audit (13 June 2026, archived)
Overlap audit against the companion seedling paper. Author selected terrain, ruggedness and wind as
predictors of beetle disturbance.

### Phase 1, contribution definition (30 July 2026)
Python diagnostics over the 2 by 4 km clipped rasters. Produced
`PHASE1_Contribution_Definition.md`. **Superseded; several headline numbers are wrong.** See
"Corrections" below.

### Phase 2, first full draft (30 July 2026)
Ported every Phase 1 diagnostic to R and reproduced it exactly before changing anything. Found and
corrected the out-of-survey population error. Added the extent sweep, orthogonalisation, spatial
block bootstrap, block cross-validation and correlogram. Built `references-beetle.bib` from the
local PDF library. Wrote the manuscript as a single executable Quarto document.

Also corrected a citation failure of my own making: the Methods described the terrain derivation
from the companion paper's prose but attached formulation citations chosen from the PDF library
rather than the sources that study actually used. Fixed by restating its procedure and adding its
real sources (NRCan HRDEM, Wang and Liu 2006, Beers and Miller 1973, Parker 1982).

### Phase 3, landscape rebuild and reframing (30 to 31 July 2026)
Triggered by the author supplying seven papers on microsite topography and beetle outbreak, and by
the observation that the extent constraint was never real.

- Verified the seven papers by reading. Four bear on the question, three do not; one is a global
  lake drainage database included by mistake.
- Retrieved the **BC Aerial Overview Survey** pest infestation polygons, 769 MB, giving beetle
  mortality by year, severity class and host species over the whole landscape, 1965 to 2025.
- Retrieved the **BC Vegetation Resources Inventory** for the study window, 2,743 polygons, giving
  the host layer the analysis had been missing.
- Found the 28 beetle ground plots in the companion archive at
  `2.ExcelData/2.1.darkwoods_beetle_ground_plots.xlsx`, with basal area killed 0.62 to 47.37 m²/ha.
- Rebuilt the response at landscape extent and discovered the elevation finding was a truncation
  artefact, and that most of the remaining gradient is host distribution.
- Reframed the paper as a test of the Krawchuk et al. 2020 refugia hypothesis, with Cartwright 2018
  as the precedent it extends.
- Rewrote the manuscript. Rebuilt the bootstrap on `glm.fit` over a prebuilt model matrix after the
  formula version made renders unworkable.

### Phase 4, ordinal severity, grain sensitivity and venue compliance (31 July 2026)

Worked `TASK-REQUEST-2026-07-31.md` §4. Items 2, 3 and 5 are done, item 4 is done as far as
Elsevier will permit, item 1 was scoped rather than solved.

- **Severity modelled ordinally (§4 item 2). This changed the paper's headline result.** Cumulative
  logits at each severity threshold show the orthogonalised wind coefficient strengthening
  monotonically, from -0.176 at trace or worse to -1.002 at severe or worse, and clearing the block
  interval test at every threshold above trace. The binary fit, whose interval reaches zero, is the
  weakest of the four. Proportional odds does not hold, so the threshold-specific fits are reported
  and the single `polr` coefficient (-0.207) is shown only to demonstrate what it conceals. Two
  side results: lodgepole cover reverses sign at severe or worse, so host governs whether a stand is
  attacked and not how hard; elevation turns positive at moderate or worse.
- **Grain tested at 25, 50 and 100 m (§4 item 3). Nothing moved.** R² of wind on elevation held at
  0.617, 0.619, 0.620 and the wind coefficient at -0.176, -0.183, -0.208, with sign stability
  rising from 0.95 to 0.98. This answers the Work et al. 2011 objection directly and sharpens the
  paper: extent reverses the inference, grain does not touch it. New §sec-grain says so.
- **Ten flagged bibliography entries verified (§4 item 5)**, plus two entries added that were cited
  in the task record but missing from the file. See "Bibliography" below.
- **RSE guidelines (§4 item 4): partially blocked.** ScienceDirect served a Cloudflare challenge on
  all eleven routes tried, so the journal-specific requirements are still unverified. The
  Elsevier-wide policies that were verified from live pages are implemented: the generative AI
  declaration, CRediT, competing interests, funding, and figure resolution raised from 200 to the
  300 dpi Elsevier minimum. **The manuscript was deliberately not reformatted to the `elsarticle`
  template and `apa.csl` was deliberately not swapped**, because §4 gates that on verification that
  did not happen, and Elsevier's own policy accepts any consistent reference style at submission.
  See `RSE-GUIDELINES-VERIFIED-2026-07-31.md`.
- **Cold versus wind (§4 item 1): investigated and closed as infeasible.** No temperature surface
  exists, at any extent relevant to this study, whose fine-scale structure over the South Selkirks
  is independent of the elevation model. The reason is structural rather than a catalogue gap: any
  surface of the form intercept plus lapse rate times elevation is an affine rescaling of the
  elevation layer, collinear by construction, whether the lapse rate is physical or fitted to real
  thermometers. Of sixteen gridded products surveyed, the four with genuine sub-10 km structure all
  obtain it by regression onto a DEM. ECCC has operated no station above 1,200 m within 150 km
  during the outbreak window. The Discussion now argues this explicitly and cites Goodsman et al.
  2024, who validated the standard Canadian Forest Service winter mortality model in Banff, found
  its spatial predictions poor, and attributed the failure to mountainous terrain when under-bark
  temperatures are not directly observed. The time-dimension strategy was assessed and does not
  work; do not attempt it. See `COLD-VS-WIND-SCOPING-2026-07-31.md`.

The manuscript's claims were revised to match. The Discussion now separates the statistical half of
the problem, which the ordinal model improves, from the identification half, which it does not
touch: cold limitation predicts a dose-response in severity exactly as wind disruption does, so the
monotone strengthening across thresholds is fully consistent with cold and discriminates nothing.
Smith-McKenna et al. 2013 is now confronted in the Discussion as the task request required, as a
second mechanism that predicts the same sign for an unrelated reason.

## Bibliography

The ten entries flagged in bold in `references-beetle-manifest.md` were verified against the
publisher record, mostly through CrossRef. Two carried errors rather than gaps:

- **`rozycka2016` is a 2017 paper.** CrossRef and the Schweizerbart article page both give
  1 November 2017; only the DOI slug and the proof copyright line say 2016. The year was corrected
  and the key left alone. Not cited in the manuscript, so no prose consequence.
- **`braumandl2005` had the wrong author.** It credited the ministry as a corporate body; the
  supplement is by T. F. Braumandl and P. R. Dykstra.

Two entries were added, both verified from their own PDF text layer and confirmed against CrossRef:
`work2011` (ZooKeys 147:623-639) and `smithmckenna2013` (Écoscience 20(3):215-229). `work2011` was
cited by the new grain section and would otherwise have rendered as a broken reference.

### Phase 5, aspect enters the model (1 August 2026)

The predictor set had carried no aspect at all, so it could not distinguish a warm slope from a
cold one at the same elevation. Two surfaces were added, both computed from the elevation model by
trigonometry rather than draped over it:

- **Heat load index** after McCune and Keon 2002, aspect folded about the southwest to northeast
  axis.
- **Shelter index** after Winstral et al. 2002, the maximum upwind slope within 500 m. The Global
  Wind Atlas gives speed but no direction, so it is computed on all eight bearings and averaged
  rather than assuming a prevailing wind.

**The headline is an orthogonality result.** On the analysis frame, R² on elevation is 0.629 for
the Global Wind Atlas surface, 0.000 for heat load and 0.002 for shelter. Being terrain-derived and
being an elevation transform are not the same thing; the difference is downscaling versus
trigonometry. New `@tbl-orthogonality` states it.

Three findings from the extended model:

1. **Heat load is positive and strengthens sharply with severity**, and is essentially unrelated to
   elevation, so this is not the elevation gradient under another name. At a given elevation,
   southwest-facing ground carries heavier mortality. That is the sign cold limitation predicts and
   is the first evidence here that the thermal axis works independently of elevation. It constrains
   the degree-day half of cold limitation only, not the overwinter minimum half.
2. **The wind residual survives and strengthens** when heat load is controlled for, from -0.176 to
   -0.214 at trace or worse and -0.390 to -0.505 at moderate or worse. It is not the warm-aspect
   effect in disguise.
3. **The two exposure measures disagree.** Shelter is negative, meaning exposed ground carries more
   attack, opposite to the wind residual and to Krawchuk. They correlate only -0.22, so they are
   measuring different things rather than disagreeing about one thing. Reported as a caution
   against treating "wind exposure" as a single measurable quantity, and against our own result,
   which the one geometric exposure predictor does not corroborate. **Do not quietly drop this.**

**Numerical trap found and handled.** Ten terms with 1,522 severe-or-worse events drives the
extended fit into quasi-separation, roughly 14,500 cells at numerically zero fitted probability, and
produced a spurious heat load coefficient near +3.8. `tbl-aspect` now detects separation in code and
drops the affected threshold rather than reporting it. **The eight-term model of `tbl-ordinal` was
checked and is clean at all four cuts**, minimum fitted probability 6.0e-05 at severe or worse, so
the committed -1.002 stands and needed no correction.

The analysis frame was deliberately left unchanged: `MVARS` still defines it, the two new terms
enter only the extended model, so every previously reported number and the grain assertion still
hold.

### Phase 6, the cold-threshold check (1 August 2026)

Retrieved and screened the observational record that the cold explanation depends on. Script,
cached CSV and provenance note are in `02.inputs/climate/`; the 107 MB of raw extracts is
gitignored and regenerable. Rerun with
`/usr/local/bin/Rscript 02.inputs/climate/fetch-station-minima.R`, about nine minutes, verified
idempotent.

**The answer is that it never gets cold enough.** Across 347 usable station-winters from stations
spanning 435 to 2,423 m within 100 km, the coldest defensible winter minimum anywhere is **-28.7 °C**
(Norns, 2,423 m, winter 2014). Zero station-winters reach -35 °C, zero reach -40 °C. Above 1,500 m
the mean winter minimum is -19.4 °C. The conventionally cited lethal figures, near -40 °C in air and
about -37 °C under bark, are roughly ten degrees colder than anything observed.

**This combines with Phase 5.** If larvae are not being killed outright, the surviving cold
mechanism is degree-day accumulation, and that is exactly the axis the heat load index addresses.
The two phases therefore point the same way: the plausible thermal constraint is the one for which
there is an elevation-independent proxy, and the proxy behaves as the constraint predicts.

**Cold-air pooling is now evidenced, not asserted.** Grand Forks at 630 m reaches -28.2 °C, within
0.5 °C of the alpine station 1,793 m higher. The manuscript previously asserted that temperature is
not a linear function of elevation here; it can now show it.

Two data traps, both handled in the saved script:

1. **The -20.0 °C sensor floor.** 16 station-winters over 9 stations are censored at exactly that
   value and are excluded. Concentrated as predicted: 15 of 89 station-winters before 2008, 1 of 93
   after. A naive `min()` would have manufactured a threshold that is not in the data.
2. **A spurious -40.0 °C.** Nelson NE, 570 m, 7 February 2014, with a same-day maximum of -4.5 °C
   and no ECCC quality flag. This single value would have produced exactly the headline the record
   does not support. The script now rejects isolated spikes, colder than both neighbours by more
   than 15 °C, and prints every rejection. **Do not remove that rule.**

**Limits, stated in the manuscript.** No station inside the study area reported during the outbreak
window, and the reporting stations are spread over roughly 100 km of separate massifs. This bounds
the regional cold climate; it is not a temperature surface and does not disturb the Phase 4
conclusion that no such surface exists. It also cannot exclude local cold-air pooling events the
network never sampled, which is the very structure the Grand Forks result shows is present.

### Phase 7, everything back inside the manuscript (1 August 2026)

Author's rule, and it governs from here: **if it is not in the manuscript, it is not part of the
study.** All analysis lives in live R chunks in the `.qmd` so it can be reviewed in the render.
Audited and corrected accordingly.

- **The station screening moved in-document.** `tbl-cold` previously trusted the `censored_flag`
  column computed by the retrieval script. It now states and applies the rule itself: a
  station-winter is censored when its minimum sits exactly on the -20.0 °C sensor floor **and** at
  least one observation sits there, applied only to the BC Wildfire network because the floor is an
  artefact of those sensors and not of the ECCC record. A `stopifnot` checks the in-document rule
  reproduces the retrieval script's flag exactly, so the two cannot drift. Getting this right took
  three attempts: the naive rule "any observation at -20.0" flags 50 station-winters, dropping the
  network condition flags 20, and the correct rule flags 16.
- **What legitimately stays outside, and why it is stated in the Methods.** The network fetch
  streams about 2.7 GB and the reduction of hourly series to winter summaries cannot sit in a
  document render. Isolated-spike rejection also has to happen there, because it needs the sub-daily
  series a per-winter summary cannot carry. Every other decision about which records to believe is
  now in `@sec-cold`, in visible code.
- **Fixed a relief cross-reference that was wrong.** The Study area said "as reported in
  `@tbl-relief`, 1,776 m of relief", but that table reports the *modelled* frame, which is 1,740 m.
  Both numbers are right for different things: 1,776 m is the terrain grid, 525 to 2301 m; 1,740 m
  is what survives dropping cells with no inventory basal area. The prose now computes the grid
  relief from the raster (`GRID_RELIEF`, set in the `paths` chunk) and says explicitly that the two
  are not interchangeable. This is the same conflation as the 168 km² versus 245 km² trap.
- **`G` moved to the `paths` chunk** so the analysis grid exists before the Study area section needs
  it. Nothing else changed hands.
- **One remaining approximation made live.** "attack runs between roughly 23 and 37 per cent" is now
  computed from the banded host-present percentages rather than asserted.

Audit result: 23 chunks, every one carrying an explicit `#| echo: true`, none using `echo: false`,
`include: false` or `eval: false`. No hardcoded results remain in the body prose; what looks like a
number there is a year, a list marker, a file path, or a value cited from the literature.

### Phase 7b, README rebuilt from the render

`README.md` now carries the abstract and then every figure and table interleaved **in manuscript
order**, generated by `03.outputs/build-readme.py` from the rendered HTML so it cannot drift from
the paper. Rerun that script after every render. Tables are converted to GitHub-flavoured pipe
tables because GitHub does not render the Pandoc grid tables Quarto emits; the output was checked
against the live GitHub markdown API, not assumed.

Added `README.md` to the input subfolders that lacked one: `aos`, `vri` and `archive`. All seven
dataset folders now document source, licence, retrieval date and their own traps.

**Git LFS trap found here.** The broad `02.inputs/**` patterns match `.md` and `.R` files as well as
data, so new documentation was being committed as three-line LFS pointers. Setting `text` does not
undo that. The override needs `!filter !diff !merge`, which is now in `.gitattributes` and verified:
documentation resolves to unspecified, data still resolves to `lfs`.

### Phase 8, author's editing pass (1 August 2026, evening)

The author edited the `.qmd` directly. Recorded here because two of the changes have consequences
that are not obvious from the diff, which is dominated by a whole-file rewrap (maximum line length
went from 422 to 1,236 characters, so most of the 546 deleted lines are reflow, not lost content).

Deliberate and carried forward:

- Subtitle changed from "A test of the Krawchuk refugia hypothesis" to "Testing refugia hypotheses
  across a 1,776 m relief gradient in the Selkirk Mountains of British Columbia".
- Abstract now opens "It is hypothesised" rather than naming Krawchuk et al. The 13 `@krawchuk2020`
  citations in the body are untouched, so the attribution is intact; only the framing is less
  personalised.

**Needs a decision, and nothing has been restored pending it.** All six back-matter sections were
removed: Data and code availability, CRediT, Declaration of competing interest, Funding,
Declaration of Generative AI, and the `sessionInfo` chunk. The manuscript now runs Conclusions
straight into References.

Four of those were added on 31 July specifically because they were **verified from live
elsevier.com pages** as Elsevier-wide requirements binding on every Elsevier journal:

- The generative AI declaration is mandatory and must sit "at the end of the manuscript,
  immediately above the references".
- CRediT "should be provided during the submission process", single-author papers included.
- Competing interests and funding statements are standard submission requirements.

They are recoverable verbatim from commit `a4e78ba`. If the removal was deliberate, say so here and
the note can go; if it was a casualty of the reformat, restore them before submission. See
`RSE-GUIDELINES-VERIFIED-2026-07-31.md` for what was verified and from where.

### Phase 9, dead-code sweep (3 August 2026)

Static analysis of the manuscript's R chunks, using R's own parser rather than a grep. Every
top-level assignment was cross-referenced against later chunks **and** against all 54 inline
expressions, since an object used only inline would otherwise look dead.

Result: no unused variables and no unused functions. Four genuinely dead things were found and
removed, and the removal is numerically inert, verified by replaying the pipeline to the analysis
frame: 266,650 analysis cells, 127,604 host cells, 168.2 km², all unchanged.

1. **`first_yr`.** A full `rasterize()` of `CAPTURE_YEAR` over the survey polygons, stacked into `X`
   and named `FirstYear`, then never read. Real compute cost for nothing. Removed.
2. **`Age`.** `PROJ_AGE_1` was pulled from the inventory, rasterized into `host` and named, and
   never entered a model or a table. Removed. **The prose claimed otherwise**, so the Host abundance
   section no longer says the analysis carries projected age.
3. **The `FirstYear` column naming**, which indexed the last three columns of `X`; now the last two.
4. **`tidyr`.** Loaded and never used. Its only apparent hit was `tibble`, which it merely
   re-exports from the tibble package. Zero tidyr-exclusive functions appear anywhere.

**One false positive worth knowing about, because it will recur.** A symbol-level scan reports
`patchwork` as unused: it contributes no named function, only the `+` operator that combines the two
panels of `fig-gradient`. Removing it would break the figure. The setup chunk now carries a comment
saying so, and it is in the traps list. The same scan surfaced that `patchwork::area` masks
`terra::area`, harmless because nothing calls `area()`.

**On tooling.** The `analyze-dead-code` skill was tried. It is built for application codebases and
dispatches to `knip`, `ts-prune`, `vulture` or `deadcode`, none of which handle R, so it falls back
to grep. Its *method* is sound and was followed: classify by confidence, screen for false positives,
report before removing. The detection itself has to be done with R's parser.

Not changed, and deliberately: the extent prose recomputes `lm(Wind ~ Elevation)` inline twice, which
duplicates what `tbl-extent` already computes. That is redundancy, not dead code, and each inline
expression standing on its own is the point of an executable manuscript.

### Phase 10, full pre-submission review (3 to 4 August 2026)

Ran the eight-stage review in `skills/drafts/manuscript-review-request.md`. Report at the repo
root: `review-remote-sensing-of-environment.md`. Three things changed the project's direction.

**The RSE guidelines are verified, and RSE is the wrong journal.** ScienceDirect still 403s every
route, but the Internet Archive holds the Elsevier journal page and the guide came out of it
(`RSE-GUIDELINES-VERIFIED-2026-08-03.md`; caveat, the capture is October 2023). Two sentences
decide it. "The main contribution should be the remote sensing component, rather than
investigation of an environmental problem in which remote sensing data or techniques do not play
a major role", and "a statistically sound accuracy assessment or validation is a requirement of
all research papers". This study analyses no sensor observation and validates nothing, and says
so. **Open item 1 is closed as answered, not as done: stop formatting for RSE and pick a venue.**
Landscape Ecology, Ecography or Forest Ecology and Management fit as written.

Two good pieces of news from the same source: **no abstract word limit is stated**, so open item 3
is dead and the 340-word abstract needs no cut; and the limit is 15,000 words, which is no
constraint. Two bad: **highlights are mandatory** and did not exist (now
`01.manuscript/highlights.docx`), and the reference style is Elsevier author-date, not APA
(`elsevier-harvard.csl` fetched and in use).

**The methodological headline is not novel.** Wiens 1989, the foundational paper, already states
that correlations within a domain may change sign when extent is enlarged past it, and Dungan et
al. 2002 already published the reporting recommendation. Worse, the sub-claim that resolution is
reported near-universally while extent is not is contradicted by the only audit of it: Estes et
al. 2018 found 63 against 60 per cent. McGarigal et al. 2016 argue the opposite priority. Section
4.3 and the Conclusions were rewritten to concede all of it and to cite Wiens, Dungan, McGarigal,
Sandel and Estes, all verified at CrossRef and added to the bib.

The constructive route out came from the same search and converges with the referee and the
statistician independently. **Sandel 2015: for a genuinely linear relationship the coefficient is
extent-independent and only R² moves, so a sign flip diagnoses an unmodelled nonlinearity.** Which
is almost certainly what this is, because `fig-gradient` shows attack unimodal in elevation while
wind is monotone, and the clip lands on one limb. Elevation is fitted linearly everywhere
(`MODEL_VARS`) and the orthogonalisation removes only the *linear* elevation component of wind, so
the wind residual is the obvious absorber of the curvature. **The single highest-value next step is
to refit with a quadratic or spline in elevation and orthogonalise against that basis.** If the
wind residual survives, the paper is far stronger. If not, it was misspecification.

**Two claims failed against the paper's own output.** The clip's wind interval is
[-1.260, +0.921], which spans zero, so "extent decides the sign" never met the paper's own rule;
`tbl-extent` now carries a `Blocks` column showing the clip rests on 15 blocks, and the section is
retitled and rewritten to claim only what is there. And "host cover holds at the top of the
gradient" held only against a denominator including the pine-poor valley: against the band
immediately below, cover falls from 49.2 to 38.8 per cent. Section `sec-host` now computes and
reports both comparisons and retreats to the weaker claim.

**Caution, recorded because it nearly shipped.** Reconciling prose that said 1,900 m with code that
compared at 1,850 m flipped that host result (41.6 vs 39.3 becomes 38.8 vs 39.7) while the prose
still read "if anything higher". Fixing a prose/code mismatch without re-checking that the result
survives the corrected threshold is a live hazard in an executable manuscript, and `error: false`
does not catch it because nothing errors. A claim that turns on a 50 m change of an arbitrary
breakpoint was never robust.

**Five sources were cited for things they do not say**, one for the reverse. `smithmckenna2013`
reports exposed positions favouring *interception* of wind-borne spores, not escaping it, and was
carrying the whole counter-mechanism paragraph, now recast as the authors' own hypothesis. The
lethal-temperature attribution was wrong in both halves (-40 °C is Safranyik's *under-bark* figure;
-37 is Cooke's laboratory supercooling point, not an under-bark temperature). `cartwright2018`
ranks TPI 7th of 10, not "among the strongest". `krawchuk2020` describe the 900 m² Landsat grain
rather than proposing it. And `badger2014` is a KAMM paper: the Global Wind Atlas has never used
KAMM, so `davis2023` was added and cited for the construction claim the whole paper rests on.
Mechanically the bibliography is clean: 25 keys cited, all present, all 14 DOIs resolving.

Also applied: back matter restored from `a4e78ba` (open item from Phase 8, resolved as "restore");
`number-sections` added to docx; `error: true` to `false`; dpi 300 to 500, the Elsevier minimum for
combination artwork; the "200 resamples" caption corrected against `B_BOOT` of 150.

**Not applied, and these are the real work.** B_BOOT of 150 is too few for percentile intervals and
the light-or-worse verdict flips on a different seed with probability ~0.16, though re-running at
five seeds showed it holding; the block size is asserted and the polygon size distribution that
would justify it is one line away; heat load's independence from elevation is computed on the full
landscape (R² 0.000) while its coefficient is estimated on the host-present frame (R² 0.119), and
it is more collinear with slope (0.141) than with elevation; the severe-threshold headline may rest
on two to six survey polygons; and **the VRI was pulled live on 2026-07-30 with no reference year
recorded anywhere**, so the host layer may postdate the 1999-2015 mortality by a decade, which
would mechanically explain the pine-cover sign flip at severe+. Establish that reference year
first; it is the cheapest of the outstanding items and potentially the most damaging.

## Key findings in the current draft

1. **Attack is unimodal across 1,776 m of relief**, peaking near 1,430 m. The clip-based monotone
   elevation result was an artefact of sampling only the rising limb.
2. **Below 1,900 m the gradient is host.** Conditioning on lodgepole presence flattens it. Attack is
   30.3 per cent where lodgepole is present against 7.4 per cent where absent.
3. **Above 1,900 m it is not host.** Attack halves while pine cover holds and basal area falls, the
   conjunction the Krawchuk hypothesis requires.
4. **The wind result is statistically supported once severity is ordinal, and still not
   attributable.** Coded as a binary the orthogonalised wind term's interval reaches zero. Coded as
   the ordinal severity class it clears the interval test at every threshold above trace and
   strengthens monotonically with severity. But cold limitation predicts that same dose-response,
   and so does dispersal interception, so the ecological attribution is open. **Do not report this
   as a demonstrated wind effect.**
5. **Extent decides the sign.** Same response, predictors and model; landscape gives a negative
   orthogonalised wind coefficient, the 2 by 4 km clip gives a positive one.
6. **Grain does not.** Refitting at 50 m and 100 m leaves the collinearity, the sign and the
   magnitude essentially unchanged. The contrast with finding 5 is now part of the argument.
7. **A missing host layer would manufacture a refugium.** The pine-poor valley floor would be mapped
   as the largest refugium present.
8. **Binary coding would have hidden the main result.** Reported the conventional way, the study's
   most orderly relationship reads as a null.

## Corrections carried against Phase 1

1. Phase 1 analysed 8,910 cells of which 3,423 were never surveyed, inflating the elevation effect
   from Cliff's delta +0.488 to +0.572.
2. "Elevation dominates, monotone positive" is a clip artefact; the true relation is unimodal.
3. Most of the gradient is host distribution, not a beetle response to terrain.
4. The claim that LASSO would retain wind and drop elevation is **not supported**: elevation entered
   the path first in 99.8 per cent of 500 spatial block resamples. Removed.
5. The sign of the orthogonalised wind coefficient depends on extent and on how the response is
   defined. Only the landscape estimate is interpreted.

## Incidents

- **30 July, external drive detached mid-render** under heavy concurrent I/O from an unrelated
  WhiteboxTools job at load average 19. Nothing was lost; the HTML render completed beforehand and
  the Word render was rerun on 31 July. Check the mount before long renders.

## Next steps

`TASK-REQUEST-2026-07-31.md` §4 is fully worked out, and the two analysis items that followed from
it, aspect and the cold-threshold check, are done in Phases 5 and 6. What is left needs either a
person or a decision:

1. **Get a human with a browser onto the RSE guide for authors.** Fourteen requirements remain
   unverified, above all the reference style and the abstract word limit. Only then format to the
   `elsarticle` template and swap `apa.csl`. This is the one item blocking submission.
2. **Confirm the generative AI declaration wording**, which is an assertion about how the author
   produced the work and should not be left to a machine to settle.
3. **The abstract is 341 words**, up from 282, because Phases 5 and 6 added two results to it. If
   the unverified RSE limit turns out to be 250 it needs a hard cut, and the material to cut is
   probably the shelter-index caveat, which the Discussion carries in full anyway.
4. **A directional shelter index**, if a prevailing wind direction can be established for this
   landscape. The current index is omnidirectional because the Global Wind Atlas supplies no
   direction, and an omnidirectional index cannot represent a direction-dependent process. This is
   the obvious way to resolve the shelter-versus-wind-residual disagreement in Phase 5, which is
   currently the least settled thing in the paper.
5. **Repository hygiene**, unchanged: `.gitignore` ignores both itself and `INDEX.md`, so a fresh
   clone gets no ignore rules and no index. The allometry project's leftovers still sit in this
   repo and are now in LFS.

## Notes

- The manuscript is the only analysis artefact. The Python scripts in `scripts/` are the Phase 1
  record, superseded; do not quote numbers from them.
- Every reported quantity comes from code visible in the rendered document.
