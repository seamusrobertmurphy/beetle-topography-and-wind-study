#!/usr/bin/env python3
"""Apply the table geometry a Quarto reference document cannot carry.

Runs over a rendered .docx and sets, on every data table:
  * total width  16.5 cm, written as an explicit dxa so it does not drift
    with the page margins
  * row height   1.1 cm on the header row, 0.6 cm on every body row, as an
    exact height so Word does not grow the row to fit
  * cell text    left justified, overriding the per-cell alignment knitr
    writes as direct formatting
  * table font   8 pt, belt and braces over the Table style

Caption paragraphs are left alone; their 10 pt comes from the Caption styles in
style-formal.docx. Figures are untouched: Quarto wraps each float in a
single-cell table, and those wrappers are skipped by the nested-table test.

Idempotent, so re-running on an already-formatted file changes nothing.

Run:  python3 05.tasks/scripts/format-tables.py <file.docx> [more.docx ...]
Wired into _quarto.yml as a post-render step, so every render comes out formatted.
"""

import sys
import zipfile
import pathlib
import shutil
from lxml import etree

W = "http://schemas.openxmlformats.org/wordprocessingml/2006/main"
w = lambda tag: f"{{{W}}}{tag}"

TABLE_WIDTH_CM = 16.5
HEADER_ROW_CM = 1.1
BODY_ROW_CM = 0.6
TABLE_PT = 8
JUSTIFY = "left"

cm_to_twips = lambda cm: int(round(cm * 1440 / 2.54))


def sub(parent, tag, index=0):
    """Get or create a child element, inserted at index."""
    el = parent.find(w(tag))
    if el is None:
        el = etree.SubElement(parent, w(tag))
        parent.remove(el)
        parent.insert(index, el)
    return el


def sub_rpr(pPr):
    """The paragraph-mark run properties, which must sit last inside w:pPr."""
    rPr = pPr.find(w("rPr"))
    if rPr is None:
        rPr = etree.SubElement(pPr, w("rPr"))
    return rPr


def props(el, tag):
    """Get or create the properties element (tblPr/trPr/pPr/rPr) first in order."""
    pr = el.find(w(tag))
    if pr is None:
        pr = etree.Element(w(tag))
        el.insert(0, pr)
    return pr


def format_table(tbl):
    # width, as an exact dxa rather than a percentage
    tblPr = props(tbl, "tblPr")
    for old in tblPr.findall(w("tblW")):
        tblPr.remove(old)
    tblW = etree.SubElement(tblPr, w("tblW"))
    tblW.set(w("w"), str(cm_to_twips(TABLE_WIDTH_CM)))
    tblW.set(w("type"), "dxa")
    # fixed layout so Word honours the widths instead of autofitting
    for old in tblPr.findall(w("tblLayout")):
        tblPr.remove(old)
    etree.SubElement(tblPr, w("tblLayout")).set(w("type"), "fixed")

    # rescale the column grid to the new total, preserving relative widths
    grid = tbl.find(w("tblGrid"))
    if grid is not None:
        cols = grid.findall(w("gridCol"))
        old = [int(c.get(w("w")) or 0) for c in cols]
        tot = sum(old)
        if tot > 0:
            target = cm_to_twips(TABLE_WIDTH_CM)
            new = [int(round(v * target / tot)) for v in old]
            new[-1] += target - sum(new)          # absorb rounding
            for c, v in zip(cols, new):
                c.set(w("w"), str(v))

    rows = tbl.findall(w("tr"))
    for i, tr in enumerate(rows):
        trPr = props(tr, "trPr")
        for old in trPr.findall(w("trHeight")):
            trPr.remove(old)
        h = etree.SubElement(trPr, w("trHeight"))
        h.set(w("val"), str(cm_to_twips(HEADER_ROW_CM if i == 0 else BODY_ROW_CM)))
        h.set(w("hRule"), "exact")

        for tc in tr.findall(w("tc")):
            for p in tc.findall(w("p")):
                pPr = props(p, "pPr")
                for old in pPr.findall(w("jc")):
                    pPr.remove(old)
                etree.SubElement(pPr, w("jc")).set(w("val"), JUSTIFY)
                # the paragraph mark carries its own rPr; leaving it at the
                # old size is harmless under an exact row height but untidy
                for holder in [pPr] + p.findall(w("r")):
                    rPr = props(holder, "rPr") if holder is not pPr else sub_rpr(pPr)
                    for tag in ("sz", "szCs"):
                        for old in rPr.findall(w(tag)):
                            rPr.remove(old)
                        etree.SubElement(rPr, w(tag)).set(w("val"), str(TABLE_PT * 2))


def process(path):
    path = pathlib.Path(path)
    if not path.exists():
        print(f"  skipped, not found: {path}")
        return
    zin = zipfile.ZipFile(path)
    parts = {n: zin.read(n) for n in zin.namelist()}
    zin.close()

    root = etree.fromstring(parts["word/document.xml"])
    # Quarto wraps every float, figures included, in a single-cell table. A real
    # data table is the innermost one, holds no image, and has more than one
    # cell. Without the last two tests a figure wrapper would be given an exact
    # 0.6 cm row height, which crops the image, and 8 pt, which shrinks its caption.
    n = 0
    for tbl in root.iter(w("tbl")):
        if tbl.find(f".//{w('tbl')}") is not None:
            continue
        if tbl.find(f".//{w('drawing')}") is not None or tbl.find(f".//{w('pict')}") is not None:
            continue
        if len(tbl.findall(f".//{w('tc')}")) < 2:
            continue
        format_table(tbl)
        n += 1
    parts["word/document.xml"] = etree.tostring(root, xml_declaration=True,
                                                encoding="UTF-8", standalone=True)

    tmp = path.with_suffix(".docx.tmp")
    with zipfile.ZipFile(tmp, "w", zipfile.ZIP_DEFLATED) as zout:
        for name, data in parts.items():
            zout.writestr(name, data)
    shutil.move(tmp, path)
    print(f"  {path.name}: {n} tables set to {TABLE_WIDTH_CM} cm, "
          f"{HEADER_ROW_CM}/{BODY_ROW_CM} cm rows, {TABLE_PT} pt, {JUSTIFY}-justified")


if __name__ == "__main__":
    args = sys.argv[1:]
    if not args:
        # Quarto sets this to the newline-separated list of files it just wrote,
        # which is what the post-render hook in _quarto.yml relies on.
        import os
        args = [f for f in os.environ.get("QUARTO_PROJECT_OUTPUT_FILES", "").split("\n")
                if f.strip().endswith(".docx")]
    if not args:
        print("no .docx to format (no argument, no QUARTO_PROJECT_OUTPUT_FILES)")
        sys.exit(0)
    for a in args:
        process(a.strip())
