# BC Vegetation Resources Inventory: Darkwoods extract

**This is the manuscript's host layer**, and the paper's argument does not work without it.
Without an independent map of host abundance there is no way to tell a refugium from a place
that simply has no pine, and the study shows that the pine-poor valley floor would otherwise
have been mapped as the largest refugium on the mountain.

## Source and licence

| | |
|---|---|
| Layer | `WHSE_FOREST_VEGETATION.VEG_COMP_LYR_R1_POLY` |
| Publisher | Province of British Columbia, Ministry of Forests |
| Portal | https://catalogue.data.gov.bc.ca/dataset/vri-forest-vegetation-composite-rank-1-layer-r1- |
| Service | `https://openmaps.gov.bc.ca/geo/pub/WHSE_FOREST_VEGETATION.VEG_COMP_LYR_R1_POLY/ows` (WFS 2.0.0) |
| Licence | Open Government Licence, British Columbia |
| Retrieved | 2026-07-30 |

## Contents

| File | What it is |
|---|---|
| `vri_darkwoods.geojson` | 2,743 polygons clipped to the study window, 6 MB |

Carried in Git LFS.

## How the manuscript uses it

The inventory records up to three species per polygon with a percentage cover for each. The
manuscript accumulates lodgepole pine (`SPECIES_CD_*` matching `^PL`) across all three slots
into a single `PinePct`, and carries `BASAL_AREA` and `PROJ_AGE_1` alongside it. These are
rasterised to the 25 m analysis grid.

## Traps

1. **Basal area is missing on 121,353 of 388,003 cells.** The manuscript drops them explicitly
   rather than leaving it to a silent `na.action`. The modelled area is therefore 168 km²,
   not the 245 km² of terrain coverage. Both numbers are correct for different things and must
   not be conflated.

2. **Quote the CRS as a string literal inside the WFS `BBOX(...)` CQL filter** or the parser
   rejects the request.

3. **Species percentages are polygon-level attributes applied uniformly within each polygon.**
   This is a modelled operational product, not a census, and the manuscript's Limitations
   says so.

## Retrieval

The extract was pulled by WFS bounding box. To reproduce it, request the layer above with a
`BBOX` filter on the study extent and `outputFormat=application/json`. The full request is
recorded in `../README.md`.
