#!/usr/bin/env python3
"""Serialise the manuscript's table and caption formatting into the Quarto
reference document, 04.references/style-formal.docx.

This carries the half of the formatting a reference doc can actually hold:
font sizes and justification, which live in styles.xml, plus the page margins
that decide how wide a 100 per cent width table renders.

What a reference doc CANNOT hold, and why format-tables.py exists:
  * row heights   - a Word table style has no row-height property at all;
                    height is written per row as w:trHeight
  * table width in cm - Pandoc writes w:tblW as 5000 pct (100 per cent of the
                    text column), so the width follows the page margins rather
                    than any style. Setting 1 inch margins on US Letter gives
                    12240 - 2880 = 9360 twips = 16.51 cm, which is the 16.5 cm
                    wanted. That part is durable; the rest is not.
  * per-cell justification - knitr writes alignment into each cell paragraph as
                    direct formatting, which beats the style every time.

Run:  python3 05.tasks/scripts/build-style-formal.py   (from the repo root)
Then re-render; the styles apply to every future render with no hand work.
"""

import re
import shutil
import zipfile
import pathlib
import sys

STYLE = pathlib.Path("04.references/style-formal.docx")

TABLE_PT = 8      # table body text
CAPTION_PT = 10   # table and figure captions
MARGIN_TWIPS = 1440   # 1 inch: text width 16.51 cm on US Letter

# styleId -> (half-point size, justification or None)
TARGETS = {
    "Table":        (TABLE_PT * 2, "left"),
    # "Compact" is deliberately absent: Pandoc uses it for table cells AND for
    # body-level numbered lists (the three research questions in the
    # Introduction). Setting it to 8 pt would shrink those too, so cell font
    # size is left to format-tables.py, which touches runs inside data tables only.
    "Caption":      (CAPTION_PT * 2, "left"),
    "TableCaption": (CAPTION_PT * 2, "left"),
    "ImageCaption": (CAPTION_PT * 2, "left"),
    "CaptionChar":  (CAPTION_PT * 2, None),
}


def set_size(body, half_pt):
    """Force w:sz and w:szCs inside a style body, inserting if absent."""
    had = False
    for tag in ("sz", "szCs"):
        pat = re.compile(rf'<w:{tag} w:val="\d+"\s*/>')
        if pat.search(body):
            body = pat.sub(f'<w:{tag} w:val="{half_pt}"/>', body)
            had = True
    if not had:
        ins = f'<w:sz w:val="{half_pt}"/><w:szCs w:val="{half_pt}"/>'
        if "<w:rPr>" in body:
            body = body.replace("<w:rPr>", "<w:rPr>" + ins, 1)
        else:
            # `body` is the content between the style tags, so there is no
            # </w:style> here to anchor on; append a fresh rPr instead.
            body = body + f"<w:rPr>{ins}</w:rPr>"
    return body


def set_just(body, val):
    if re.search(r'<w:jc w:val="\w+"\s*/>', body):
        return re.sub(r'<w:jc w:val="\w+"\s*/>', f'<w:jc w:val="{val}"/>', body, count=1)
    if "<w:pPr>" in body:
        return body.replace("<w:pPr>", f'<w:pPr><w:jc w:val="{val}"/>', 1)
    return body


def main():
    if not STYLE.exists():
        sys.exit(f"not found: {STYLE}")
    backup = STYLE.with_suffix(".docx.bak")
    if not backup.exists():
        shutil.copy2(STYLE, backup)
        print(f"backup written: {backup}")

    zin = zipfile.ZipFile(STYLE)
    parts = {n: zin.read(n) for n in zin.namelist()}
    zin.close()

    styles = parts["word/styles.xml"].decode("utf8")
    changed = []
    for sid, (half_pt, just) in TARGETS.items():
        pat = re.compile(rf'(<w:style [^>]*w:styleId="{sid}"[^>]*>)(.*?)(</w:style>)', re.S)
        m = pat.search(styles)
        if not m:
            print(f"  style {sid!r} absent, skipped")
            continue
        body = set_size(m.group(2), half_pt)
        if just:
            body = set_just(body, just)
        styles = styles[:m.start()] + m.group(1) + body + m.group(3) + styles[m.end():]
        changed.append(f"{sid}={half_pt/2:g}pt" + (f"/{just}" if just else ""))
    parts["word/styles.xml"] = styles.encode("utf8")

    doc = parts["word/document.xml"].decode("utf8")
    doc, n = re.subn(r'<w:pgMar[^/]*/>',
                     f'<w:pgMar w:top="{MARGIN_TWIPS}" w:right="{MARGIN_TWIPS}" '
                     f'w:bottom="{MARGIN_TWIPS}" w:left="{MARGIN_TWIPS}" '
                     f'w:header="720" w:footer="720" w:gutter="0"/>', doc)
    parts["word/document.xml"] = doc.encode("utf8")

    with zipfile.ZipFile(STYLE, "w", zipfile.ZIP_DEFLATED) as zout:
        for name, data in parts.items():
            zout.writestr(name, data)

    print("styles set: " + ", ".join(changed))
    print(f"page margins set on {n} section(s) to {MARGIN_TWIPS} twips "
          f"({(12240 - 2*MARGIN_TWIPS)/1440*2.54:.2f} cm text width)")


if __name__ == "__main__":
    main()
