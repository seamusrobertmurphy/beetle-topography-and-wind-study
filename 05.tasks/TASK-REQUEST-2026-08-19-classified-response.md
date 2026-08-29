# Replace the IDS polygons with a classified red-stage series

Date: 2026-08-19
Status: requested, not started
Owner: Seamus Murphy

## Objective

Replace the provincial aerial overview survey (IDS polygons) as the response
layer in `beetle-topography-and-wind-study` with an annual red-stage mountain
pine beetle map classified from Landsat, extended from the 7.78 km2 window of
the parent study to the full 280 km2 analysis grid.

The reason is scale. The refugia question is about wind and topography acting at
tens of metres. Sketch-mapped polygons flown at survey speed cannot resolve that,
and a paper resting on them cannot answer its own question.

## What already exists, verified 2026-08-19

Verified by reading the files named, not from memory.

**Ground plots.** `4.RData/1.Beetle_plots/2.1.darkwoods_beetle_ground_plots.xlsx`,
28 rows, columns `plot`, `pi_mpb_killed`, `pi_mpb_killed_pc`, `ndmi`, `taswet`,
`tasgre`, `tasbri`. Mirrored at `github.com/seamusrobertmurphy/darkwoods_beetles`.

**Spectral sample.** `darkwoods_beetle_plots_data_II` inside
`4.RData/1.Beetle_plots/.RData`, 310 rows, columns `Class_type`, `RA_NonRA`,
`B1Aerosol`, `B2Blue`, `B3Gree`, `B4Red`, `B5NIR`, `B6SW1`, `B7SW2`, `CHI_cp`,
`TASWET`, `TASGRE`, `TASBRI`, `RGI_cp`, `MSI1_c`, `MSI_cp`, `NDMI_c`. Also on
GitHub as `2.2.darkwoods_beetle_spectral_sampling.xlsx`. This is the training set
behind the published classification, and it is the one to carry into Earth Engine
because it holds every band rather than a single derived index.

**Fitted model.** `svm_ndmi_linear` in the same `.RData`. caret `train`,
`svmLinear`, `repeatedcv` 10 folds 10 repeats, `preProcess = center, scale`.
Recovered parameters: C = 2.526316, centre 0.5903275, scale 0.1460209, primal
weight on the scaled predictor 0.7366355, intercept b = 0.0615186, 19 support
vectors, eps-svr with epsilon 0.1. A linear kernel on one predictor reduces to a
band expression, so the model transfers to Earth Engine without refitting.

**Analysis grid.** `3.SpatialData/terrain_environment/Elevation.utm.tif`,
EPSG:32611, 25.11 m, 695 by 639 cells, extent 515617.9 to 531665.3 easting and
5437375 to 5454829 northing, 280.1 km2, elevation 525 to 2301 m, relief 1776 m.
In geographic terms 49.0884 to 49.2460 N, -116.7861 to -116.5649 W. One Landsat
footprint covers it whole.

## Two defects to fix before reuse

**The NDMI validation metrics come from the wrong model.** In
`4.RData/1.Beetle_plots/3.beetle_plots_aug21.R` at lines 92 and 107, and in the
matching chunk of `1.darkwoods_beetles.Rmd`, the objects named
`beetle_ndmi_pred_train` and `beetle_ndmi_pred_test` are produced by
`predict(svm_tasbright_linear, ...)`, the Tasselled Cap brightness model, not
`svm_ndmi_linear`. Every NDMI error statistic downstream of those two lines is
therefore the brightness model's. The published R2 of 0.905 and RMSE of 4.83
attributed to NDMI must be recomputed from `svm_ndmi_linear` before either number
is quoted again, here or anywhere.

**The nmi versus ndmi note is closed.** Line 2 of `3.beetle_plots_aug21.R` records
that two result sets were generated, one with `nmi` and one with `ndmi`, and that
the predictor needed confirming. They are the same variable. In the 28-plot frame
`cor(ndmi, nmi)` is exactly 1.000; `nmi` is the raw scaled integer, mean
16836.1518, which matches the `NDMI_c` mean of the red-attack class in the
310-row frame exactly, and `ndmi` is that rescaled to roughly 0.36 to 0.96. The
choice changes nothing but the units. For the record, `cor(ndmi, pi_mpb_killed)`
is -0.8723.

## What does not exist

There is no code anywhere that applies a model to imagery. The scripts fit on
plots and stop. The paper states classification ran in ArcMap v.10.7, so the
existing red and grey stage rasters came from GIS operations that were never
written down. There is no Landsat imagery in any local repository and no NDMI
raster. The prediction step has to be built, and that is the substance of this
task.

## Method

**Stage 1, imagery.** Use `rgee` against Earth Engine rather than downloading
scenes. Collections `LANDSAT/LT05/C02/T1_L2`, `LANDSAT/LE07/C02/T1_L2` and
`LANDSAT/LC08/C02/T1_L2`. Apply the Collection 2 scaling factors, mask cloud,
shadow and snow from `QA_PIXEL`, and build one growing-season composite per year
over the grid bounding box. Record which sensor supplies each year, because the
parent paper's Table 2 lists Landsat 5 for a 2013 acquisition, which is
impossible: Landsat 5 stopped acquiring in November 2011. Resolve that from scene
metadata and state the answer.

**Stage 2, terrain correction.** Mandatory here and not needed at 7.78 km2. With
1776 m of relief the illumination varies enough with slope and aspect to create a
terrain signal in reflectance, and this study tests terrain effects, so an
uncorrected artefact would be indistinguishable from the result. Apply an
SCS+C or Minnaert correction using the same elevation model that defines the
grid, then demonstrate the correction worked by showing residual reflectance no
longer tracks the illumination term. Do not assume it worked.

**Stage 3, index and differencing.** NDMI as (NIR - SWIR1) / (NIR + SWIR1),
Landsat 5 and 7 bands B4 and B5, Landsat 8 bands B5 and B6. Difference each
annual composite against the pre-disturbance baseline. Establish which year is
the baseline first: Table 2 of the parent paper labels 2003 pre-outbreak and 2005
early-outbreak, while the text says images were derived "by subtracting the 2005
pre-disturbance scene from each annual outbreak scene". If 2005 already carries
attack, every difference is biased low by that year's mortality.

**Stage 4, classification.** Upload the 310-row spectral sample as an Earth
Engine asset and train `ee.Classifier.libsvm` with a linear kernel on `RA_NonRA`,
holding the parent's 75/25 split and reporting a confusion matrix. Classify every
annual composite. Where a continuous severity surface is wanted, apply the
recovered `svm_ndmi_linear` expression instead, which needs no training in Earth
Engine at all.

**Stage 5, validation.** Report accuracy stratified by elevation band, not as a
single figure. The 28 plots sit in the fire area and the map now spans 1776 m, so
a pooled kappa would be a statement about the valley dressed up as a statement
about the grid. Where a band has no reference points, say so and mark the map
uncertain there rather than reporting a number that cannot fail.

**Stage 6, export.** Export annual classified rasters to the analysis grid,
EPSG:32611 at 25.11 m, aligned cell for cell with `Elevation.utm.tif`. Commit the
rgee script to `02.inputs/`, and the derived rasters if they fit under the file
size limit, with a manifest recording the Earth Engine asset ids and run date.

## What it buys the manuscript

An annual series changes the question from a map to a timing problem, and that is
what actually tests refugia. In a single mortality layer a cell that resisted
attack and a cell the beetle never reached are indistinguishable, and they mean
opposite things. With a year of first detection per cell, and cells that are never
attacked treated as right-censored, the analysis becomes discrete-time survival:
the hazard of first attack as a function of terrain and wind, conditioned on a
distance-weighted count of cells attacked in prior years.

That infestation-pressure term is what makes the wind test honest. Without it a
low hazard means the cell was far from the front. With it, the wind coefficient
answers whether exposed terrain lowers attack risk given that beetles arrived,
which is the hypothesis the paper claims to test. It also dissolves the
specification problem that killed the current wind result, because elevation can
enter as a smooth term without wind having to carry its curvature.

## Manuscript revisions this forces

The response layer changes in Materials and Methods, and the aerial overview
survey becomes a comparison layer rather than the data. Where the two disagree,
as a function of elevation and terrain, is a result in its own right and supports
the argument that sketch-mapped polygons cannot resolve this question.

The outbreak window must be reconciled. The manuscript declares 1999 to 2015. The
parent series runs 2005 to 2013 with 2012 absent. Either extend the
classification or narrow the stated window, and either way the survival model
needs an unbroken annual sequence, so 2012 must be recovered or its interpolation
declared.

Every number in Results is recomputed. Nothing carries over.

The wind disruption test is rewritten as a hazard model. The nonlinear
respecification section may become unnecessary, since the artefact it diagnoses
is a symptom of the cross-sectional design.

Uncertainty from the classification propagates into the coefficients. The current
intervals treat the response as observed, which will no longer be true.

## Acceptance

The task is done when an annual red-stage raster series exists on the analysis
grid, produced by committed code that runs end to end from Earth Engine, with
accuracy reported by elevation band, the two defects above fixed and their
corrected numbers recorded, and the manuscript refitted against the new response.
