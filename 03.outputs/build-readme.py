#!/usr/bin/env python3
"""Rebuild the repository README from the rendered manuscript.

The README carries the abstract, every figure and every results table, all taken
from the current render rather than retyped, so the two cannot drift. Rerun this
after any `quarto render`:

    python3 03.outputs/build-readme.py

Tables are emitted as GitHub-flavoured pipe tables. GitHub does not render the
Pandoc grid tables Quarto produces, so a copy-paste of the render would print a
wall of plus signs; the conversion below is the reason this script exists.
"""
import html
import json
import re
import shutil
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
HTML = ROOT / "01.manuscript" / "beetle-topography-wind-study.html"
DOCX = ROOT / "01.manuscript" / "beetle-topography-wind-study.docx"
QMD = ROOT / "01.manuscript" / "beetle-topography-wind-study.qmd"
FIGDIR = ROOT / "03.outputs" / "PNG"
OUT = ROOT / "README.md"


def clean(s: str) -> str:
    s = re.sub(r"<[^>]+>", "", s)
    s = html.unescape(s).replace(" ", " ")
    return re.sub(r"\s+", " ", s).strip()


def abstract() -> str:
    """Pull the abstract out of the qmd front matter without a YAML dependency."""
    text = QMD.read_text(encoding="utf8")
    body = text.split("---", 2)[1]
    lines, keep = [], False
    for line in body.splitlines():
        if line.startswith("abstract:"):
            keep = True
            continue
        if keep:
            if line and not line[0].isspace():
                break
            lines.append(line.strip())
    return " ".join(x for x in lines if x)


def captions(doc: str, kind: str):
    out = []
    for m in re.findall(r"<figcaption[^>]*>(.*?)</figcaption>", doc, re.S):
        c = clean(m)
        if c.startswith(kind):
            label, _, rest = c.partition(":")
            out.append((label.strip(), rest.strip()))
    return out


def tables(doc: str):
    """Convert every rendered HTML table to a GFM pipe table."""
    out = []
    for tb in re.findall(r"<table[^>]*>(.*?)</table>", doc, re.S):
        head = re.search(r"<thead>(.*?)</thead>", tb, re.S)
        body = re.search(r"<tbody>(.*?)</tbody>", tb, re.S)
        if not head or not body:
            continue
        heads = [clean(c) for c in re.findall(r"<th[^>]*>(.*?)</th>", head.group(1), re.S)]
        aligns = []
        for attrs in re.findall(r"<th([^>]*)>", head.group(1)):
            if "text-align: right" in attrs:
                aligns.append("---:")
            elif "text-align: center" in attrs:
                aligns.append(":---:")
            else:
                aligns.append(":---")
        rows = []
        for tr in re.findall(r"<tr[^>]*>(.*?)</tr>", body.group(1), re.S):
            cells = [clean(c) for c in re.findall(r"<t[dh][^>]*>(.*?)</t[dh]>", tr, re.S)]
            if cells:
                rows.append(cells)
        if not heads or not rows:
            continue
        while len(aligns) < len(heads):
            aligns.append(":---")
        esc = lambda s: s.replace("|", "\\|")
        lines = [
            "| " + " | ".join(esc(x) for x in heads) + " |",
            "| " + " | ".join(aligns[: len(heads)]) + " |",
        ]
        for r in rows:
            r = (r + [""] * len(heads))[: len(heads)]
            lines.append("| " + " | ".join(esc(x) for x in r) + " |")
        out.append("\n".join(lines))
    return out


def figures() -> list:
    """Copy rendered figure images out of the docx, largest first.

    The docx reference template contributes its own small images, so only
    images at render resolution are treated as manuscript figures.
    """
    FIGDIR.mkdir(parents=True, exist_ok=True)
    found = []
    with zipfile.ZipFile(DOCX) as z:
        for name in z.namelist():
            if not re.match(r"word/media/.*\.png$", name):
                continue
            data = z.read(name)
            width = int.from_bytes(data[16:20], "big")
            if width < 1000:          # template furniture, not a figure
                continue
            found.append((width, name, data))
    found.sort(reverse=True)
    written = []
    for i, (_, _, data) in enumerate(found, start=1):
        path = FIGDIR / f"fig-{i}-gradient.png" if i == 1 else FIGDIR / f"fig-{i}.png"
        path.write_bytes(data)
        written.append(path.relative_to(ROOT))
    return written


def main() -> None:
    doc = HTML.read_text(encoding="utf8")
    tabs = tables(doc)
    tcaps = captions(doc, "Table")
    fcaps = captions(doc, "Figure")
    figs = figures()

    parts = [
        "# Topographic refugia from mountain pine beetle",
        "",
        "**and why terrain-derived wind surfaces cannot find them at small extents.** "
        "A test of the Krawchuk refugia hypothesis across a 1,776 m relief gradient, "
        "Darkwoods Conservation Area, British Columbia.",
        "",
        "Everything below is generated from the rendered manuscript by "
        "`03.outputs/build-readme.py`. Do not edit this file by hand; edit "
        "`01.manuscript/beetle-topography-wind-study.qmd`, render, and rerun the script.",
        "",
        "## Abstract",
        "",
        abstract(),
        "",
        "## Figures",
        "",
    ]
    for i, path in enumerate(figs):
        label, text = fcaps[i] if i < len(fcaps) else (f"Figure {i+1}", "")
        parts += [f"### {label}", "", f"![{label}]({path.as_posix()})", "", f"*{text}*", ""]

    parts += ["## Results tables", ""]
    for i, tb in enumerate(tabs):
        label, text = tcaps[i] if i < len(tcaps) else (f"Table {i+1}", "")
        parts += [f"### {label}", "", f"*{text}*", "", tb, ""]

    OUT.write_text("\n".join(parts).rstrip() + "\n", encoding="utf8")
    print(f"wrote {OUT.relative_to(ROOT)}: {len(figs)} figures, {len(tabs)} tables")


if __name__ == "__main__":
    main()
