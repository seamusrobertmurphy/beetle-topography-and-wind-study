#!/usr/bin/env python3
"""Assemble the Journal of Applied Entomology submission package.

Why this exists. The journal states that "Title page, main text file, figures, tables
and supporting information should be supplied as separate files. Provision of all these
sections is mandatory at the submission stage." Assembling that by hand is how a stale
file reaches an editor: the cover letter in this repository was still addressed to the
Editor-in-Chief of Forest Science three weeks after that journal rejected the paper.

This copies the rendered artefacts into 01.manuscript/submission-jae/package/ under the
names an editor will see, and refuses to build if any piece is missing.

Prerequisites, in order:
  1. quarto render 01.manuscript/beetle-topography-wind-study-short.qmd --to docx
  2. quarto render 01.manuscript/submission-jae/title-page.qmd --to docx
  3. quarto render 01.manuscript/submission-jae/cover-letter.qmd --to docx
  4. quarto render 01.manuscript/submission-jae/tables.qmd --to docx

Run:  python3 05.tasks/scripts/build-submission-jae.py
"""
import pathlib, shutil, sys

ROOT = pathlib.Path(__file__).resolve().parents[2]
MS = ROOT / "01.manuscript"
SUB = MS / "submission-jae"
PKG = SUB / "package"
# The submission is the year-matched draft, chosen on 2026-08-28. The static-composite
# draft it was forked from reported coefficients roughly twice as large, obtained by
# holding stand structure at its 2025 projection, and is archived.
FIGS = MS / "beetle-topography-wind-study-vri-timeseries_files" / "figure-docx"

# Figures are numbered in the order they appear in the manuscript, which is the order the
# figure legends list them. Naming them by chunk label would put them out of order.
#
# Audited 2026-08-28: this list carried only two figures while the manuscript prints three.
# The flight-window climate figure was dropped, and the interaction figure, which the
# manuscript calls Figure 3, was uploaded to the editor as "Figure 2". The count is now
# asserted below so the same omission cannot happen silently again.
ITEMS = [
    (SUB / "cover-letter.docx",                      "00 Cover Letter.docx"),
    (SUB / "title-page.docx",                        "01 Title Page.docx"),
    (MS / "beetle-topography-wind-study-vri-timeseries.docx", "02 Main Document.docx"),
    (SUB / "tables.docx",                            "03 Tables.docx"),
    (FIGS / "fig-study-area-1.png",                  "04 Figure 1.png"),
    (FIGS / "fig-flight-window-1.png",               "05 Figure 2.png"),
    (FIGS / "fig-interaction-1.png",                 "06 Figure 3.png"),
]

# Every rendered figure must be uploaded. A figure the manuscript draws and the package
# omits is a figure the editor never sees.
rendered = sorted(p.name for p in FIGS.glob("*.png")) if FIGS.exists() else []
listed = sorted(src.name for src, _ in ITEMS if src.parent == FIGS)
if rendered and rendered != listed:
    print("figure mismatch between the render and this list:")
    print("   rendered:", ", ".join(rendered))
    print("   packaged:", ", ".join(listed))
    sys.exit(1)

missing = [src for src, _ in ITEMS if not src.exists()]
if missing:
    print("cannot build, these are not rendered yet:")
    for m in missing:
        print("   ", m.relative_to(ROOT))
    sys.exit(1)

PKG.mkdir(parents=True, exist_ok=True)
for src, name in ITEMS:
    shutil.copy2(src, PKG / name)
    print(f"  {name:26s} {src.stat().st_size/1024:8.0f} kB")
print(f"\npackage at {PKG.relative_to(ROOT)}")

# Every piece must come from the same round of rendering. Comparing each against the main
# document with an hour's tolerance was not enough: on 2026-08-28 the main document was the
# OLDEST piece, so nothing tripped, and a figure from the previous render went into the
# package. The invariant is that no piece is much older than the newest one.
mtimes = {name: src.stat().st_mtime for src, name in ITEMS}
newest = max(mtimes.values())
stale = [n for n, m in mtimes.items() if newest - m > 900]
if stale:
    print("\nWARNING, these are more than fifteen minutes older than the newest piece in "
          "the package, so they may come from an earlier render:")
    for name in sorted(stale):
        age = (newest - mtimes[name]) / 60
        print(f"    {name}  ({age:.0f} min older)")
    print("  Re-render them before uploading.")
print("\nSTILL BLOCKING: the Dryad DOI is a placeholder in both the title page and the "
      "main document. The journal does not accept data on request or as supplementary "
      "files, so the deposit must be made and the DOI substituted before submission.")
