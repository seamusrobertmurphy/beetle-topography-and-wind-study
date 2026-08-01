# Task request: beetle topography and wind study

**Date:** 31 July 2026
**For:** the next session
**Status:** full executable draft, rebuilt at landscape extent. HTML renders. Word render is stale.
**Supersedes:** `PHASE1_Contribution_Definition.md` (30 July), whose numbers are wrong. See §6.

---

## 1. What this paper now is

A test of a named, published, previously untested hypothesis.

Krawchuk et al. 2020 (*Front Ecol Environ* 18:235-244, p 239) hypothesise that refugia from
mountain pine beetle occur "in areas with lower host density, allowing for greater wind disruption
of beetle pheromone communication and more vigorous tree growth and chemical defenses." Cartwright
2018 (*Forests* 9:715) confirmed the host-density half empirically at 30 m in Oregon but had no
wind surface. This paper supplies the wind surface and tests the mechanism.

Two results, one firm and one not.

**Firm, methodological.** The Global Wind Atlas surface is largely an elevation transform. Fitted
across the landscape the orthogonalised wind coefficient is negative; fitted inside a 2 by 4 km
clip of the *same landscape with the same model* it is positive. Extent decides the sign. Separately,
without a host layer the pine-poor valley floor would be mapped as the largest refugium present.

**Not firm, ecological.** Above 1,900 m attack halves while lodgepole cover holds and stands thin,
which is exactly the Krawchuk conjunction. In the host-present model the orthogonalised wind term is
the largest negative coefficient and its sign survives 97 per cent of spatial block resamples, but
its 95 per cent interval reaches zero, and it cannot be separated from cold limitation on the same
gradient. Reported as supported in direction, unresolved in magnitude. **Do not upgrade this.**

## 2. Where things stand

| Item | State |
|---|---|
| `01.manuscript/beetle-topography-wind-study.qmd` | Rewritten and current. Single source of truth. |
| HTML render | Current (30 Jul 21:10) |
| **Word render** | **STALE (30 Jul 18:21, previous version). Rerun it first.** |
| `04.references/references-beetle.bib` | 80 entries. All keys used in the qmd verified present. |
| `02.inputs/aos/pest_infestation_poly.gdb` | 950 MB, BC survey, downloaded 30 Jul |
| `02.inputs/vri/vri_darkwoods.geojson` | 2,743 polygons, inventory, pulled 30 Jul |
| `02.inputs/README-data.md` | Current, documents both pulls and the traps |
| `INDEX.md`, `05.tasks/progress.md` | **STALE.** Still describe the old clip-based design. |
| `03.outputs/PNG/*.png` | Two exploratory figures, superseded by in-document versions |

## 3. Do these first

1. **Rerun the Word render.** `quarto render 01.manuscript/beetle-topography-wind-study.qmd --to docx`.
   It failed on 30 July only because the external drive unmounted mid-run, not because of a code fault.
2. **Update `INDEX.md` and `05.tasks/progress.md`** to the landscape design. Both still describe the
   2 by 4 km clip as the study area.
3. **Read the qmd before changing anything.** Every number in the prose is an inline `r` expression.
   There are no hardcoded results left; do not reintroduce any.

## 4. Open work, in order of value

1. **Separate cold from wind exposure.** This is the one thing that would settle the hypothesis. It
   needs a temperature surface that is not itself an elevation transform, which is the same
   identifiability problem the paper is about. ClimateBC or PRISM downscaled products will not do,
   because both are terrain-downscaled. Consider whether any station or reanalysis product with an
   independent lapse structure exists for the South Selkirks.
2. **Model severity ordinally.** The response currently collapses to attacked/not. The survey carries
   an ordinal severity code and Krawchuk explicitly warns against binary refugia coding (p 242).
   Distribution over the outbreak window: trace 7,610, light 34,108, moderate 21,668, severe 2,476,
   very severe 90.
3. **Grain sensitivity.** Extent was varied; grain was held at 25 m. Work et al. 2011 show terrain
   derivatives are grain artefacts, so a referee will ask. Refit at two or three grains.
4. **Verify the RSE guidelines against the live page** before formatting to the Elsevier template
   already vendored in `_extensions/`. Exemplar for depth and layout is Meng et al. 2017,
   *Remote Sensing of Environment* 191:95-109, in `04.references/literature/RSE Publications/`.
5. **Hand-verify the ten flagged bibliography entries** in `references-beetle-manifest.md`.

## 5. Traps that have already cost time

1. **`dplyr::intersect` masks `terra::intersect`.** Namespace it. This broke a render once.
2. **Read the survey geodatabase with an `extent` filter.** Reading the whole provincial layer is
   slow and memory-hostile on this 8 GB machine.
3. **Quote the CRS as a string literal inside a WFS `BBOX(...)` CQL filter** or the parser rejects it.
4. **The bootstrap uses `glm.fit` on a prebuilt model matrix, not formula `glm`.** This is thirty
   times faster and arithmetically identical. Do not "simplify" it back to `glm(formula, ...)`; that
   change alone took the render from 8 minutes to over 28.
5. **Inventory basal area is missing on 121,353 of 388,003 cells.** The qmd drops them explicitly.
   The modelled area is 168 km², not the 245 km² of terrain coverage. Both numbers are correct for
   different things; do not conflate them.
6. **The old clipped rasters `beetle_stages/Beetle.Outbreak.*.tif` are superseded** and write the
   out-of-survey background as `|128|`, nodata-tagged in only two of seven files. They survive in the
   qmd only to define the small-extent comparison. Do not use them as the response.
7. **Check `/Volumes/PortableSSD` is mounted before a long render.** It detached mid-render on
   30 July under heavy concurrent I/O from an unrelated WhiteboxTools job. Nothing was lost, but the
   Word output was.

## 6. Corrections carried against Phase 1

The Phase 1 memo of 30 July is superseded and several of its headline numbers are wrong. Recorded
here so they are not quoted again.

1. **Phase 1 analysed 8,910 cells of which 3,423 were never surveyed.** Those cells carry the `|128|`
   sentinel, sit 220 m lower than the surveyed area, and fall outside the fire perimeter. Counting
   them as unattacked inflated the elevation effect from Cliff's delta +0.488 to +0.572.
2. **"Elevation dominates, monotone positive" was an artefact of the clip.** Across the full 1,776 m
   gradient attack is strongly unimodal, peaking near 1,430 m. The clip spans 654 to 1,747 m and
   holds 3 per cent of landscape cells, sampling the rising limb and the peak only.
3. **Most of that gradient is host distribution, not a beetle response to terrain.** Conditioning on
   lodgepole presence flattens the curve below 1,900 m. Attack is 30.3 per cent where lodgepole is
   present against 7.4 per cent where it is absent.
4. **The claim that LASSO would retain the confounded wind surface and drop elevation is not
   supported.** Tested directly over 500 spatial block resamples on the clip response, elevation
   entered the path first in 99.8 per cent of replicates. The claim was removed.
5. **The sign of the orthogonalised wind coefficient depends on extent and on the response
   definition.** Both the old clipped raster response and the new survey response show a reversal
   between clip and landscape, but not in the same direction. Only the landscape estimate should be
   interpreted, and §1 states why.

## 7. Things I could not resolve

- **Ground plot coordinates do not exist in the archive.** The 28 beetle plots are in
  `2.ExcelData/2.1.darkwoods_beetle_ground_plots.xlsx` with basal area killed, 0.62 to 47.37 m²/ha.
  Every `.xlsx` sheet in the companion repository was checked; only `dataset_seedlings` and
  `dataset_burnplots` carry x/y. The plots therefore calibrate the severity scale but cannot validate
  spatial placement. If GPS positions exist outside the repository, that closes it.
- **The ruggedness surface formulation is undocumented.** `Rutm.tif` runs 0.3 to 0.7 with a
  near-symmetric distribution, which is inconsistent with a vector ruggedness measure and more
  consistent with a wind-engineering ruggedness index. The qmd states this and confines claims to
  the surface's statistical behaviour. Closing it needs the derivation code from the companion study.
- **The wind surface height is ambiguous.** The companion prose says 10 m; the seedling attribute
  table names the field `wind_100m`. The raster spans 1.2 to 9.9 m/s. Flight-relevant wind above
  canopy is not 10 m wind, so this matters for the mechanism. Unresolved; the qmd does not assert
  a height.
- **Cartwright 2018 PDF** is in `04.references/literature/` (user-supplied). MDPI blocks automated
  download, so retrieve manually if it is ever needed again.

## 8. Papers that matter, and one that does not

Verified by reading, not by title.

| Paper | Bearing |
|---|---|
| Krawchuk et al. 2020 | The hypothesis under test. p 239 names the mechanism, p 242 warns against binary refugia coding, p 240 gives 900 m² as the canonical refugia grain. |
| Cartwright 2018 | Closest precedent. 30 m, lodgepole and whitebark, 2009 MPB outbreak. Refugia in convergent positions and thinner stands. Her 2001 drought-only models give **opposite** signs on elevation and topographic position, an internal control worth citing. |
| Hadley 1994 | Predicted heavier beetle mortality on hot dry south slopes, found the reverse: host density, not moisture stress. The precedent for §1's host warning. |
| Smith-McKenna et al. 2013 | The strongest counter-argument. Exposed windy positions *intercept* wind-borne propagules. Must be confronted, not ignored. |
| Work et al. 2011 | Carabid ground beetles, not bark beetles. Value is the grain-dependence result and the DEM-error mechanism behind it. |
| Baker 2021 | No beetle content, but a citable instance of the failure this paper warns about: elevation and an 800 m gridded temperature surface entered as co-equal Random Forest predictors over 1.1 km of relief with no collinearity treatment. |
| Baker 2018 | No topographic analysis at all. Passing citation only. |
| Sikder et al. 2023 | A global lake drainage database. Zero forest or insect content. Included in the July batch by mistake; the filename also misspells the first author. Do not cite as ecology. |
