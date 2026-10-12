#!/usr/bin/env python3
"""Rebuild the repository README from the Word manuscript.

The README carries the title, the abstract and every figure and table of the
main text in the order they print, all read from 01.manuscript/Manuscript.docx.
That file takes hand edits after each render, so the README shows the latest
wording rather than the last render's. Rerun after the Word file changes:

    python3 01.manuscript/_hooks/build-readme.py

Tables are written as raw HTML that fills the page column, because GitHub sizes
a pipe table to its text. Figures link to Fig1.png onwards, which the
save-figures chunk copies from the render; the script stops if any of them
differs from the image the Word file holds.
"""
import html
import re
import subprocess
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
DOCX = ROOT / "01.manuscript" / "Manuscript.docx"
OUT = ROOT / "README.md"
TH_WIDTH = "2000"
EM = "\x01"


def text(s: str) -> str:
    s = re.sub(r"</?em>", EM, s)
    s = html.unescape(re.sub(r"<[^>]+>", "", s)).replace("\xa0", " ")
    s = re.sub(r"\s+", " ", s).strip()
    s = re.sub(r"<(?=[A-Za-z/!?])", "&lt;", s.replace("&", "&amp;"))
    return s.replace("*", r"\*").replace(EM, "*")


def cell(s: str) -> str:
    s = html.unescape(re.sub(r"<[^>]+>", "", s)).replace("\xa0", " ")
    return html.escape(re.sub(r"\s+", " ", s).strip(), quote=False)


def align(attrs: str) -> str:
    m = re.search(r"text-align:\s*(left|right|center)", attrs or "")
    return m.group(1) if m else "left"


def html_table(inner: str) -> str:
    head = re.search(r"<thead>(.*?)</thead>", inner, re.S).group(1)
    body = re.search(r"<tbody>(.*?)</tbody>", inner, re.S).group(1)
    ths = re.findall(r"<th(\s[^>]*)?>(.*?)</th>", head, re.S)
    al = [align(a) for a, _ in ths]
    out = ["<table>", "<thead>", "<tr>"]
    out += [f'<th width="{TH_WIDTH}" align="{al[i]}">{cell(h)}</th>' for i, (_, h) in enumerate(ths)]
    out += ["</tr>", "</thead>", "<tbody>"]
    for tr in re.findall(r"<tr[^>]*>(.*?)</tr>", body, re.S):
        tds = [cell(c) for c in re.findall(r"<td[^>]*>(.*?)</td>", tr, re.S)]
        tds = (tds + [""] * len(al))[: len(al)]
        out.append("<tr>" + "".join(f'<td align="{al[i]}">{c}</td>' for i, c in enumerate(tds)) + "</tr>")
    return "\n".join(out + ["</tbody>", "</table>"])


def main() -> None:
    doc = subprocess.run(["pandoc", str(DOCX), "-s", "-t", "html", "--wrap=none"], capture_output=True, text=True, check=True).stdout
    media = zipfile.ZipFile(DOCX)

    title = text(re.search(r'<h1 class="title">(.*?)</h1>', doc, re.S).group(1))
    sub = re.search(r'<p class="subtitle">(.*?)</p>', doc, re.S)
    abstract = re.search(r'<h1 id="abstract">Abstract</h1>(.*?)<h1', doc, re.S).group(1)
    items = re.findall(r"<li>(.*?)</li>", abstract, re.S)
    parts = [f"# {title}", ""]
    if sub:
        parts += [f"*{text(sub.group(1))}*", ""]
    parts += ["## Abstract", ""]
    if items:
        parts += [f"{i}. {text(t)}" for i, t in enumerate(items, 1)]
    else:
        parts += [" ".join(text(p) for p in re.findall(r"<p>(.*?)</p>", abstract, re.S))]
    parts += ["", "## Figures and tables", "",
              "Every figure and table of the main text, in the order it appears in the manuscript.", ""]

    n = {"Figure": 0, "Table": 0}
    for m in re.finditer(r'<span id="((?:fig|tbl)-[^"]+)" class="anchor"></span>', doc):
        rest = doc[m.end():]
        if m.group(1).startswith("tbl-"):
            cap = rest[: rest.index("</p>")]
            inner = re.search(r"<table[^>]*>(.*?)</table>", rest, re.S).group(1)
        else:
            img = re.match(r'\s*<img src="([^"]+)"', rest).group(1)
            cap = re.search(r"<p>(.*?)</p>", rest, re.S).group(1)
        kind, num, cap = re.match(r"\s*(Table|Figure)[\s\xa0](\d+):\s*(.*)", cap, re.S).groups()
        n[kind] += 1
        if int(num) != n[kind]:
            raise SystemExit(f"{kind} {num} printed out of order")
        if kind == "Table":
            parts += [f"### Table {num}", "", f"*{text(cap)}*", "", html_table(inner), ""]
        else:
            fig = ROOT / "01.manuscript" / f"Fig{num}.png"
            if not fig.exists() or fig.read_bytes() != media.read("word/" + img):
                raise SystemExit(f"{fig.name} is not the image Figure {num} prints in the Word file")
            parts += [f"### Figure {num}", "", f"![Figure {num}]({fig.relative_to(ROOT).as_posix()})", "",
                      f"*{text(cap)}*", ""]

    OUT.write_text("\n".join(parts).rstrip() + "\n", encoding="utf8")
    print(f"wrote {OUT.name}: {n['Figure']} figures and {n['Table']} tables from {DOCX.name}")


if __name__ == "__main__":
    main()
