# Archived beetle-classification data, 2026-08-30

Superseded intermediates from the burn-only phase of this study, before it was rebuilt
across Darkwoods. Nothing here is read by the manuscript or by any script that still
produces a number the manuscript reports. Nothing was deleted.

| Folder | Size | Why it is here |
|---|---|---|
| `1. Beetle Plots Feb01/` | 88 MB | No script or manuscript refers to it. Duplicates the folder below under a different name. |
| `1.beetle_plots_feb01/` | 58 MB | No script or manuscript refers to it. |
| `beetle_stages/` | 24 MB | Read only by `02-parent-raster-audit.R`, an audit of the parent study's rasters. |
| `red-stage-ndmi/` | 23 MB | Written by `16-classify-red-stage.R`, the superseded burn-grid classification. Nothing live consumes it. |
| `ndmi-annual/` | 23 MB | Written by `15-ndmi-annual-grid.R` on the narrow burn grid. Superseded by `ndmi-darkwoods/`, built by `17-ndmi-annual-darkwoods.R`. `20-indices-darkwoods.R` names 17 in a comment only, not this folder. |

The scripts that wrote these are left in place so the chain stays documented. Scripts
`00-recompute-parent-metrics.R`, `01-scene-metadata.R`, `02-parent-raster-audit.R` and
`03-training-provenance.R` reach nothing the manuscript reads and are dead, but were left
alongside the rest for the same reason.

## Superseded scripts, added 2026-08-30

Sixteen files moved to `superseded-scripts/`. Each is either an audit of the parent study
or a phase a later numbered script explicitly replaced, in that later script's own header.

| File | Why it is here |
|---|---|
| `00-recompute-parent-metrics.R` | Gate 1(d), an audit of the parent study's NDMI validation metrics. |
| `01-scene-metadata.R` | Gate 1(a) and 1(c), an audit of which sensor supplied each annual scene. |
| `02-parent-raster-audit.R` | Gate 1(b), an audit of the parent study's differencing baseline. |
| `03-training-provenance.R` | Gate 3 blocker check on the parent's 310-row training sample. |
| `04-` to `14-` | The 28-ground-plot phase. `19-derive-balanced-plots.R` states in its own header why the parent's 28 plots cannot train a landscape classifier, and derives the class-balanced set that replaced them. |
| `landsat-scene-inventory.csv` | Written and read only by `01-scene-metadata.R`. |

`2.1.darkwoods_beetle_ground_plots_ndmi.xlsx` stays in place. `18-svm-red-stage-darkwoods.R`
still reads it, and 18 has not been ruled on.

Not moved, and needing a decision. Each looks superseded but the chain was not verified:
`15-ndmi-annual-grid.R` and `16-classify-red-stage.R`, the narrow burn grid that
`17-ndmi-annual-darkwoods.R` replaced, except that 16 writes `red-stage/`, which the live
scripts 39 and 40 read. `18-`, `21-` and `23-`, the classifier development that ended at
`24-modhigh-binary-svm.R`, named in CLAUDE.md as the manuscript's classifier.
`28-refugia-model.R`, replaced by `31-refugia-model-wind.R`. `29-wind-annual-stations.R`,
replaced by `30-wind-hourly-metrics.R`, whose header describes the replacement.
`32-refugia-coefficients.R`, which builds coefficient tables from 31.
