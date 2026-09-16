#!/usr/bin/env python3
"""Apply the page layout Journal of Pest Science asks for and a reference document cannot carry.

The guide for authors says "Provide double line spacing" and "number all lines
consecutively". Both are section and style properties, so they are written into the
rendered .docx after Quarto has finished, the same way format-tables.py sets table
geometry. Applied only to the main document, keyed on its file stem, because the
separate tables file is not a manuscript page and double spacing inside table cells
would fight the exact row heights format-tables.py sets.

  * every section gets continuous line numbering, counting by one
  * the running-text styles, Body Text, First Paragraph and Bibliography, are set to
    double spacing, 480 twentieths of a point on an automatic rule
  * Compact, the style Quarto gives table cells, is pinned to single spacing so it does
    not inherit the double

Idempotent. Run:  python3 01.manuscript/_tools/format-body.py <file.docx> [more.docx ...]
Wired into _quarto.yml as a post-render step, after stamp-wordcounts.py.
"""
import os
import sys
import shutil
import zipfile
import pathlib
from lxml import etree

W = "http://schemas.openxmlformats.org/wordprocessingml/2006/main"
w = lambda tag: f"{{{W}}}{tag}"

APPLY_TO_STEMS = {"Manuscript"}
DOUBLE = "480"
SINGLE = "240"
DOUBLE_STYLES = ("BodyText", "FirstParagraph", "Bibliography")
SINGLE_STYLES = ("Compact",)

# Child order inside w:sectPr, so an inserted element lands where the schema expects it.
SECT_ORDER = ["footnotePr", "endnotePr", "type", "pgSz", "pgMar", "paperSrc", "pgBorders",
              "lnNumType", "pgNumType", "cols", "formProt", "vAlign", "noEndnote", "titlePg",
              "textDirection", "bidi", "rtlGutter", "docGrid"]
PPR_AFTER_SPACING = ["ind", "contextualSpacing", "mirrorIndents", "suppressOverlap", "jc",
                     "textDirection", "textAlignment", "textboxTightWrap", "outlineLvl",
                     "divId", "cnfStyle", "rPr", "sectPr", "pPrChange"]


def insert_ordered(parent, tag, order):
    """Insert a new child so that it precedes the first sibling that the schema places after it."""
    el = etree.Element(w(tag))
    after = order[order.index(tag) + 1:]
    for child in parent:
        if etree.QName(child).localname in after:
            child.addprevious(el)
            return el
    parent.append(el)
    return el


def line_numbers(root):
    n = 0
    for sect in root.iter(w("sectPr")):
        ln = sect.find(w("lnNumType"))
        if ln is None:
            ln = insert_ordered(sect, "lnNumType", SECT_ORDER)
        ln.set(w("countBy"), "1")
        ln.set(w("restart"), "continuous")
        n += 1
    return n


def set_spacing(style, line):
    ppr = style.find(w("pPr"))
    if ppr is None:
        ppr = etree.Element(w("pPr"))
        # pPr comes after name, aliases, basedOn, next, link, autoRedefine, hidden, uiPriority,
        # semiHidden, unhideWhenUsed, qFormat, locked, personal*, rsid and before rPr.
        rpr = style.find(w("rPr"))
        if rpr is not None:
            rpr.addprevious(ppr)
        else:
            style.append(ppr)
    sp = ppr.find(w("spacing"))
    if sp is None:
        sp = insert_ordered(ppr, "spacing", ["spacing"] + PPR_AFTER_SPACING)
    sp.set(w("line"), line)
    sp.set(w("lineRule"), "auto")


def spacing(styles_root):
    done = []
    for style in styles_root.iter(w("style")):
        sid = style.get(w("styleId"))
        if sid in DOUBLE_STYLES:
            set_spacing(style, DOUBLE); done.append(sid)
        elif sid in SINGLE_STYLES:
            set_spacing(style, SINGLE); done.append(sid)
    return done


def process(path):
    path = pathlib.Path(path)
    if not path.exists():
        print(f"  skipped, not found: {path}")
        return
    if path.stem not in APPLY_TO_STEMS:
        print(f"  {path.name}: not a manuscript page, layout left alone")
        return
    zin = zipfile.ZipFile(path)
    parts = {n: zin.read(n) for n in zin.namelist()}
    zin.close()
    doc = etree.fromstring(parts["word/document.xml"])
    sty = etree.fromstring(parts["word/styles.xml"])
    sections = line_numbers(doc)
    styled = spacing(sty)
    parts["word/document.xml"] = etree.tostring(doc, xml_declaration=True, encoding="UTF-8", standalone=True)
    parts["word/styles.xml"] = etree.tostring(sty, xml_declaration=True, encoding="UTF-8", standalone=True)
    tmp = path.with_suffix(".docx.tmp")
    with zipfile.ZipFile(tmp, "w", zipfile.ZIP_DEFLATED) as zout:
        for name, data in parts.items():
            zout.writestr(name, data)
    shutil.move(tmp, path)
    print(f"  {path.name}: continuous line numbers on {sections} section(s); "
          f"double spacing on {', '.join(s for s in styled if s in DOUBLE_STYLES)}; "
          f"single on {', '.join(s for s in styled if s in SINGLE_STYLES)}")


if __name__ == "__main__":
    args = sys.argv[1:]
    if not args:
        args = [f for f in os.environ.get("QUARTO_PROJECT_OUTPUT_FILES", "").split("\n")
                if f.strip().endswith(".docx")]
    if not args:
        print("no .docx to format")
        sys.exit(0)
    for a in args:
        process(a.strip())
