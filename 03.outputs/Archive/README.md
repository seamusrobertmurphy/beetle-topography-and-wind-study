# Archived outputs

Nothing here belongs to the Journal of Applied Entomology manuscript. Checked on
2026-08-31 by searching every live `.qmd`, `.R` and `.py` in `01.manuscript` and
`02.inputs` for each name.

| Folder | Files | What it is |
|---|---|---|
| `allometry-study/` | 25 | Tables `T1` to `T11` and figures `F1` to `F9`, plus the four `RESULTS-note-*.md` files, all from `canadian-tree-allometry`. Larch refits, bark geometry, the Affleck comparison and the province equations. Nothing to do with beetles. |
| `stale-figures/` | 14 | Beetle figures written by earlier drafts to `03.outputs/PNG`. The manuscript now writes its own into `01.manuscript/beetle-topography-wind-study-vri-timeseries_files/figure-docx/` at render time, and the submission package copies them from there. These are stale duplicates. |
| `superseded-maps/` | 4 | `beetle-plot-locator.html` and the 2020 severity rasters, written by `08-map-2020-severity.R`, itself archived. Only superseded scripts name them. |
| `build-readme.py` | 1 | Rebuilt the repository README from a render. Nothing calls it, and the hard rule of 2026-08-31 is that no script lives outside the manuscript. |

What stayed: `TBL/` holds `table-1-inventory.csv` through `table-8-flight-window.csv`. The
preamble's `save_tbl()` writes them as each table prints, and
`01.manuscript/submission-jae/tables.qmd` reads them back to build the separate tables file
the journal requires, so they cannot drift from the article.
