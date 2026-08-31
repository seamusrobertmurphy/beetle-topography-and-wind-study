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
