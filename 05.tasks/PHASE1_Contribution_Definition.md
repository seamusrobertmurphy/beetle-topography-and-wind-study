# Phase 1 memo: defining the contribution

**Spin-off remote-sensing paper, terrain and wind as predictors of beetle disturbance**
**Date:** 30 July 2026 · **For:** Seamus Murphy · **Status:** decision memo, no manuscript text written
**Follows:** `Archive/writing_outputs/20260613_053044_rs_methods_spinoff/PHASE0_Scoping_Novelty_Memo.md`
**Diagnostics:** `sources/phase1_diagnostics_20260730.txt`, reproducible from `scripts/`

## The decision taken

You chose microsite geomorphology and wind as predictors of beetle disturbance. This memo
tests that choice against the data before any writing begins. The angle is viable and the
overlap problem that killed the index-comparison framing does not apply here. But the two
predictors behave in opposite ways to what the framing assumed, and that reversal is itself
the strongest paper available.

## Why this angle clears the dual-publication constraint

The FEM paper used elevation, slope, aspect, TWI, terrain ruggedness and wind exclusively as
predictors of *seedling intensity*. Beetle and fire rasters entered that same model as
further predictors. At no point did FEM model disturbance itself as a function of terrain.

The direction of the arrow is the novelty. FEM asked what explains regeneration. This paper
asks what explains where, how often, and when the beetle killed trees. Nothing in FEM Tables
5 to 9, nothing in Supplementary S1 to S7, and nothing in the three public GitHub
repositories addresses that. The Phase 0 overlap audit does not bite here.

## What the data says

All figures below come from the 2005 to 2011 annual AOS red-attack rasters (code 44) on the
30 m grid, with terrain resampled bilinearly to match, exactly as FEM did.

### Confirmed: the corrected grey-stage union

Recomputing the union of code 44 across the seven annuals independently reproduces **1,541
cells**, matching the correction memo and confirming the legacy 932-cell raster was wrong.

This also surfaces a stale file. `mpb_grey_attackcount.tif` holds 932 non-zero cells with a
maximum of 4 attacks. The correct repeat-attack surface has **1,541 non-zero cells with a
maximum of 5**. That raster was built from the legacy layer and must be rebuilt before use.

### Terrain does condition beetle attack, strongly

Attacked cells sit higher, on gentler slopes, in windier positions than unattacked cells.
Effect sizes as Cliff's delta, which is what matters here because the p-values are not
interpretable (see the autocorrelation note below):

| Predictor | Attacked | Unattacked | Cliff's delta |
|---|---|---|---|
| Elevation | 1,542 ± 172 m | 1,281 ± 269 m | **+0.572** |
| Wind | 4.75 ± 0.69 m/s | 4.17 ± 0.83 m/s | **+0.409** |
| Slope | 16.3 ± 8.5° | 19.1 ± 6.6° | −0.214 |
| Ruggedness (RIX) | 0.51 ± 0.04 | 0.50 ± 0.04 | +0.120 |
| TWI | −5.17 ± 1.05 | −5.00 ± 1.30 | −0.056 |

Repeat-attack count and onset year are both terrain-conditioned. Higher and windier cells
were attacked earlier and more often (elevation rho = +0.297 with count, −0.296 with onset;
wind rho = +0.256 and −0.272). The outbreak did not move across this landscape at random.

### The finding that reframes the paper: wind is largely elevation

Global Wind Atlas wind speed correlates with elevation at **r = 0.905 inside the fire
footprint** and **r = 0.760 across the full Darkwoods DEM extent** (388,003 cells). A linear
fit of wind on elevation gives R² = 0.577 landscape-wide, so elevation explains most of the
wind surface. Residual wind standard deviation falls from 1.287 to 0.837 m/s once elevation
is removed.

The consequences are severe and specific:

- In a multivariable logistic model the wind coefficient **flips sign**, from a strong
  positive marginal association to β = −2.58 against elevation's β = +4.21. That is textbook
  collinearity-driven instability, not an ecological result.
- Partial Spearman correlation of wind with attack, controlling elevation, drops from +0.256
  to **−0.124 and changes sign**.
- The confound worsens as extent shrinks. At 2 × 4 km, wind is 82 % elevation. Landscape-wide
  it is 58 %. **The analysis extent determines whether wind is a predictor at all.**

This bears directly on the published FEM model. Its LASSO retained wind and terrain
ruggedness and dropped elevation. On this evidence the published wind coefficient is
substantially carrying an elevation signal. That is worth saying plainly and constructively,
and it is the seed of a genuine methodological contribution rather than an erratum.

### Ruggedness is weak but clean, which is the opposite problem

RIX is close to orthogonal to everything else: r = 0.082 with elevation, 0.052 with slope,
0.053 with wind, landscape-wide. Its marginal effect is small (delta +0.120, odds ratio 1.25
per standard deviation) but it survives control for elevation (partial rho +0.070) precisely
because it is not redundant.

So the two predictors invert. Wind looks strong and is mostly elevation. Ruggedness looks
weak and is genuinely independent information. A paper that simply asserted "terrain and wind
matter" would be wrong in both directions. A paper that demonstrates *why* is novel.

### Three constraints that must be handled, not hidden

1. **Spatial autocorrelation.** Moran's I of the red-attack union is **0.728**. The naive
   n = 8,910 is a large over-count of independent units, so every p-value in the diagnostics
   is inflated and none should be reported as-is. Inference needs spatially explicit models
   or an effective-sample-size correction.
2. **Survey gaps.** 2008 and 2010 contain **zero** code-44 cells; 2008 is effectively an empty
   raster. The nine-year series has two dead years for red attack. Onset-year results are
   confounded by survey coverage until this is addressed.
3. **Extent.** The beetle rasters are clipped to 2 × 4 km (8,910 cells), while terrain covers
   16 × 17.5 km and the AOS source holds 296 polygons over roughly 17 × 17 km. Since the wind
   confound is extent-dependent, the small clip is the worst case. Extending is the single
   highest-value data step. The local AOS shapefiles are missing their `.dbf`, so attributes
   must be re-obtained from the BC Data Catalogue.

## Recommended contribution

**Terrain conditioning of bark beetle disturbance, and the confounding of terrain-derived
climate surfaces in disturbance remote sensing.** Worked through the Darkwoods MPB outbreak.

Three pillars, in order of strength:

1. **Beetle disturbance as the response, terrain as the predictor.** Occurrence, repeat-attack
   count and onset timing, across the full annual series. Entirely absent from FEM. This is
   the empirical core.
2. **A confounding diagnostic for ambient climate surfaces.** Show that a widely used wind
   product is largely an elevation transform, that the collinearity intensifies as extent
   shrinks, and that predictor-selection procedures such as LASSO will retain the confounded
   surface and discard the causal one. This generalises well beyond Darkwoods and is the
   methodological contribution proper.
3. **Ruggedness as the under-weighted orthogonal axis.** Small effect, non-redundant
   information, routinely omitted. The literature scan already establishes that ruggedness
   appears far less often than elevation, slope and aspect despite evidence it can dominate.

This matches the "predictor credibility" theme the June source notes converged on, keeps the
method forward as the RSE scan advises, and leaves the ecological payoff in the discussion.

## What I need from you

1. **Confirm the reframing.** The paper leads with predictor credibility and terrain
   conditioning, not with "terrain and wind drive beetle attack." Are you comfortable with a
   contribution that re-examines a confound present in the FEM model, framed constructively?
2. **Extent.** Should I rebuild the beetle response over the full Darkwoods landscape? This
   needs the BC AOS download and is the difference between a strong paper and a thin one.
3. **Rebuild the stale attack-count raster** from the corrected 1,541-cell union. I would do
   this regardless once you confirm the direction.

Journal selection remains yours and is untouched here. Note the 24 June Forests feature-paper
invitation postdates every earlier note and is not reflected in the June venue scan.
