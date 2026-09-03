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

Since 2026-09-02 a per-table specification, table-format.json beside this script, records
the geometry Seamus set by hand in Word: column widths, row heights and their rule, header
bold, vertical centring, per-column justification and font size. A table whose number
matches a specification entry takes that geometry; any other table takes the defaults
below. Regenerate the file from a hand-formatted render with capture-table-format.py.

Idempotent, so re-running on an already-formatted file changes nothing.

Run:  python3 01.manuscript/_tools/format-tables.py <file.docx> [more.docx ...]
Wired into _quarto.yml as a post-render step, so every render comes out formatted.
"""

import sys
import json
import re
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

SPEC_PATH = pathlib.Path(__file__).with_name("table-format.json")
SPEC = json.loads(SPEC_PATH.read_text()) if SPEC_PATH.exists() else []


def spec_for(caption, ncols):
    """The hand-set geometry for a table, matched on its number, or None.

    Matched by caption text until 2026-09-02, when a caption edit dropped every table to
    the defaults and cost Seamus his hand layout. The number is the stable key. When the
    column count has changed since the capture, the first column keeps its width and its
    cell style and the remaining columns share the rest, so an added or removed column
    degrades the layout gracefully instead of discarding it."""
    m = re.match(r"Table[\s\u00a0](\d+)", caption or "")
    num = int(m.group(1)) if m else None
    s = next((s for s in SPEC if s.get("table") == num), None)
    if s is None:
        key = re.sub(r"^Table[\s\u00a0]\d+[:.]?\s*", "", caption or "")[:60]
        s = next((s for s in SPEC if key and s["caption_key"] and key[:40] == s["caption_key"][:40]), None)
    if s is None or ncols < 2:
        return s
    if s["cols"] != ncols:
        s = dict(s); g = list(s["grid"]); hc, bc = s["header_cells"], s["body_cells"]
        rest = s["tblW"] - g[0]; each = [rest // (ncols - 1)] * (ncols - 1); each[-1] += rest - sum(each)
        s.update(grid=[g[0]] + each, cols=ncols,
                 header_cells=[hc[0]] + [hc[1] if len(hc) > 1 else hc[0]] * (ncols - 1),
                 body_cells=[bc[0]] + [bc[1] if len(bc) > 1 else bc[0]] * (ncols - 1))
    return s


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


def format_table(tbl, spec=None):
    # width, as an exact dxa rather than a percentage
    tblPr = props(tbl, "tblPr")
    for old in tblPr.findall(w("tblW")):
        tblPr.remove(old)
    tblW = etree.SubElement(tblPr, w("tblW"))
    tblW.set(w("w"), str(spec["tblW"] if spec else cm_to_twips(TABLE_WIDTH_CM)))
    tblW.set(w("type"), "dxa")
    # fixed layout so Word honours the widths instead of autofitting
    for old in tblPr.findall(w("tblLayout")):
        tblPr.remove(old)
    etree.SubElement(tblPr, w("tblLayout")).set(w("type"), "fixed")

    # rescale the column grid to the new total, preserving relative widths, or take the
    # hand-set widths from the specification when this table has one
    grid = tbl.find(w("tblGrid"))
    if grid is not None:
        cols = grid.findall(w("gridCol"))
        old = [int(c.get(w("w")) or 0) for c in cols]
        if spec and len(spec["grid"]) == len(cols):
            old = list(spec["grid"])
        tot = sum(old)
        if tot > 0:
            target = spec["tblW"] if spec else cm_to_twips(TABLE_WIDTH_CM)
            new = [int(round(v * target / tot)) for v in old]
            new[-1] += target - sum(new)          # absorb rounding
            for c, v in zip(cols, new):
                c.set(w("w"), str(v))
            # cell widths follow the grid
            for tr in tbl.findall(w("tr")):
                for tc, v in zip(tr.findall(w("tc")), new):
                    tcPr = props(tc, "tcPr")
                    for old in tcPr.findall(w("tcW")):
                        tcPr.remove(old)
                    tcW = etree.Element(w("tcW")); tcW.set(w("w"), str(v)); tcW.set(w("type"), "dxa")
                    tcPr.insert(0, tcW)

    rows = tbl.findall(w("tr"))
    for i, tr in enumerate(rows):
        trPr = props(tr, "trPr")
        for old in trPr.findall(w("trHeight")):
            trPr.remove(old)
        h = etree.SubElement(trPr, w("trHeight"))
        rh = (spec or {}).get("header_height" if i == 0 else "body_height")
        if rh:
            h.set(w("val"), str(rh["val"]))
            h.set(w("hRule"), rh["hRule"])
        else:
            h.set(w("val"), str(cm_to_twips(HEADER_ROW_CM if i == 0 else BODY_ROW_CM)))
            h.set(w("hRule"), "exact")

        cellspec = (spec or {}).get("header_cells" if i == 0 else "body_cells") or []
        for k, tc in enumerate(tr.findall(w("tc"))):
            cs = cellspec[k] if k < len(cellspec) else None
            if cs and cs.get("vAlign"):
                tcPr = props(tc, "tcPr")
                for old in tcPr.findall(w("vAlign")):
                    tcPr.remove(old)
                etree.SubElement(tcPr, w("vAlign")).set(w("val"), cs["vAlign"])
            for p in tc.findall(w("p")):
                pPr = props(p, "pPr")
                for old in pPr.findall(w("jc")):
                    pPr.remove(old)
                etree.SubElement(pPr, w("jc")).set(w("val"), (cs or {}).get("jc") or JUSTIFY)
                if cs and cs.get("bold"):
                    for r in p.findall(w("r")):
                        rPr = props(r, "rPr")
                        if rPr.find(w("b")) is None:
                            rPr.insert(0, etree.Element(w("b")))
                # the paragraph mark carries its own rPr; leaving it at the
                # old size is harmless under an exact row height but untidy
                for holder in [pPr] + p.findall(w("r")):
                    rPr = props(holder, "rPr") if holder is not pPr else sub_rpr(pPr)
                    for tag in ("sz", "szCs"):
                        for old in rPr.findall(w(tag)):
                            rPr.remove(old)
                        etree.SubElement(rPr, w(tag)).set(w("val"), str((cs or {}).get("sz") or TABLE_PT * 2))


    # A last row whose first cell begins with a footnote marker and whose other cells are
    # empty is a table footnote, the form Seamus set by hand on 2026-09-02; it is merged
    # across the table and allowed to wrap.
    if len(rows) > 1:
        tcs = rows[-1].findall(w("tc"))
        first = "".join(x.text or "" for x in tcs[0].iter(w("t"))).strip()
        rest = "".join("".join(x.text or "" for x in tc.iter(w("t"))).strip() for tc in tcs[1:])
        if len(tcs) > 1 and first[:1] in "#\u2020\u2021" and not rest:
            tcPr = props(tcs[0], "tcPr")
            for old in tcPr.findall(w("gridSpan")):
                tcPr.remove(old)
            gs = etree.Element(w("gridSpan")); gs.set(w("val"), str(len(tcs)))
            tcPr.insert(1 if tcPr.find(w("tcW")) is not None else 0, gs)
            tcW = tcPr.find(w("tcW"))
            if tcW is not None:
                tcW.set(w("w"), str(sum(int(c.get(w("w"))) for c in tbl.find(w("tblGrid")).findall(w("gridCol")))))
            for tc in tcs[1:]:
                rows[-1].remove(tc)
            trPr = props(rows[-1], "trPr")
            for old in trPr.findall(w("trHeight")):
                trPr.remove(old)
            hh = etree.SubElement(trPr, w("trHeight")); hh.set(w("val"), "340"); hh.set(w("hRule"), "atLeast")


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
        outer = next(tbl.iterancestors(w("tbl")), None)
        caption = ""
        if outer is not None:
            for para in outer.iter(w("p")):
                if tbl in para.iterancestors():
                    continue
                t = "".join(x.text or "" for x in para.iter(w("t"))).strip()
                if re.match(r"Table[\s\u00a0]\d+", t):
                    caption = t
                    break
        spec = spec_for(caption, len(tbl.find(w("tblGrid")).findall(w("gridCol"))) if tbl.find(w("tblGrid")) is not None else 0)
        format_table(tbl, spec)
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
