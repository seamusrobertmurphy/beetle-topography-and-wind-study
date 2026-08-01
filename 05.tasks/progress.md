# Progress log: topographic refugia from mountain pine beetle (Darkwoods spin-off)

**Started:** 2026-07-30
**Status:** Phase 4 complete. Severity modelled ordinally, grain tested, Elsevier declarations added.
**Last updated:** 2026-07-31
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

`TASK-REQUEST-2026-07-31.md` §4 is worked out. Items 2, 3 and 5 are done, item 1 is closed as
infeasible, item 4 is done as far as Elsevier's bot protection permits. What is left:

1. **Add aspect to the predictor set.** The model currently has none, so it cannot distinguish a
   warm slope from a cold one at the same elevation. A Beers heat load index and a directional
   shelter index relative to the prevailing wind are both derivable from the elevation model
   already in hand, and because radiation load and shelter vary with aspect differently they are
   the one route to partial identification that needs no temperature surface. Partial only: aspect
   bears on degree-day accumulation, hardly at all on the overwinter minimum. The Limitations
   section already names this as the next step, so the manuscript is consistent either way.
2. **Run the cold-threshold plausibility check and check the code into the pipeline.** BC Wildfire
   station records suggest winter minima on this landscape may not reach the classical lethal
   threshold near -40 °C, which would narrow the confound from freeze mortality to degree-day
   accumulation and so strengthen step 1. **The scoping memo's station diagnostics were ad hoc and
   are not in the pipeline, so under the repo rule none of those numbers may be quoted in the
   manuscript until the code is checked in.** Two traps found while scoping: a large share of BC
   Wildfire sensors are censored at exactly -20.0 °C before about 2008, and the DARKWOODS station
   was only installed in October 2014.
3. **Get a human with a browser onto the RSE guide for authors.** Fourteen requirements remain
   unverified, above all the reference style and the abstract word limit. Only then format to the
   `elsarticle` template.
4. **Confirm the generative AI declaration wording**, which is an assertion about how the author
   produced the work and should not be left to a machine to settle.

## Notes

- The manuscript is the only analysis artefact. The Python scripts in `scripts/` are the Phase 1
  record, superseded; do not quote numbers from them.
- Every reported quantity comes from code visible in the rendered document.
