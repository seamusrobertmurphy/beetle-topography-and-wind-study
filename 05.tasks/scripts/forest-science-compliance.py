#!/usr/bin/env python3
"""Audit the 01.manuscript submission set against the Forest Science (Springer
Nature) requirements recorded in 05.tasks/FOREST-SCIENCE-GUIDELINES-VERIFIED-2026-08-04.md.

Read-only. Measures what the guidelines put a number on: abstract length, total
length including captions and references, the combined figure and table count,
keywords, the four required end counts, and the reference-style signatures.

Quarto's docx output wraps every figure and table, caption included, in a
single-cell table, so captions are absent from Document.paragraphs and the audit
has to walk the body in document order. The abstract carries the template's
`Author` style rather than an `Abstract` heading, which is itself a finding.

Run:  python3 05.tasks/scripts/forest-science-compliance.py    (from the repo root)
"""

import re
import sys
import pathlib
import docx
from docx.table import Table
from docx.text.paragraph import Paragraph

MS = pathlib.Path("01.manuscript")
DOC = MS / "Manuscript - Murphy 2026 Beetle Topography Wind Refugia Test.docx"

WORD = re.compile(r"[A-Za-z0-9À-ɏ][A-Za-z0-9À-ɏ'’.\-/]*")
CAPTION = re.compile(r"^(Table|Figure)\s+(\d+)\s*[:.]")


def words(text):
    return len(WORD.findall(text))


def blocks(doc):
    """(kind, style, text) for every body-level paragraph and table, in order."""
    body = doc.element.body
    for child in body.iterchildren():
        tag = child.tag.split("}")[-1]
        if tag == "p":
            p = Paragraph(child, doc)
            if p.text.strip():
                yield "p", p.style.name, p.text.strip()
        elif tag == "tbl":
            t = Table(child, doc)
            txt = "\n".join(
                c.text.strip() for r in t.rows for c in r.cells if c.text.strip()
            )
            yield "tbl", "Table", txt


def rule(title):
    print()
    print("=" * 78)
    print(title)
    print("=" * 78)


def main():
    if not DOC.exists():
        sys.exit(f"not found: {DOC}")
    doc = docx.Document(DOC)
    bl = list(blocks(doc))

    # ---- classify -----------------------------------------------------------
    heads = [(s, t) for k, s, t in bl if k == "p" and (s.startswith("Heading") or s == "Title")]
    refs = [t for k, s, t in bl if s == "Bibliography"]
    # Quarto sometimes emits two adjacent floats into one docx table element, so
    # scan every line of every float rather than only its first line.
    caps, floats = [], []
    for k, s, t in bl:
        if k != "tbl":
            continue
        for line in t.split("\n"):
            m = CAPTION.match(line)
            if m:
                floats.append((m.group(1), int(m.group(2))))
                caps.append(line)
    cap_w = sum(words(c) for c in caps)
    # Quarto nests the real data table inside the caption wrapper, and
    # cell.text does not descend into a nested table, so walk the XML instead.
    W = "{http://schemas.openxmlformats.org/wordprocessingml/2006/main}"
    float_w = 0
    for child in doc.element.body.iterchildren():
        if child.tag.split("}")[-1] == "tbl":
            float_w += words(" ".join(n.text or "" for n in child.iter(f"{W}t")))
    float_body_w = float_w - cap_w

    # Abstract: the template gives it `Author` style; it is the long one.
    authorish = [t for k, s, t in bl if s in ("Author", "Subtitle")]
    abstract = max(authorish, key=words) if authorish else ""

    # Running text: body paragraphs that are neither front matter nor bibliography.
    skip_styles = {"Title", "Subtitle", "Author", "Bibliography"}
    body = [t for k, s, t in bl
            if k == "p" and s not in skip_styles and not s.startswith("Heading")]
    body = [t for t in body if t != abstract]
    body_w = sum(words(t) for t in body)
    ref_w = sum(words(r) for r in refs)
    abs_w = words(abstract)

    rule("HEADING STRUCTURE")
    for s, t in heads:
        print(f"  {s.replace('Heading ', 'H'):6s} {t[:70]}")

    rule("LENGTH  (limits: abstract 150-250; total incl. figures, tables, refs 10,000)")
    print(f"  abstract                             {abs_w:>7}")
    print(f"  running text (excl. captions, refs)  {body_w:>7}")
    print(f"  captions ({len(caps)})                       {cap_w:>7}")
    print(f"  contents of figures and tables       {float_body_w:>7}")
    print(f"  references ({len(refs)} entries)              {ref_w:>7}")
    print(f"  {'-' * 52}")
    print(f"  TOTAL, as the guidelines count it    {body_w + cap_w + float_body_w + ref_w:>7}")
    print(f"  total excluding references           {body_w + cap_w + float_body_w:>7}")

    rule("FIGURES AND TABLES  (limit: 10 combined)")
    figs = [n for kind, n in floats if kind == "Figure"]
    tbls = [n for kind, n in floats if kind == "Table"]
    print(f"  figures {len(figs)}: {figs}")
    print(f"  tables  {len(tbls)}: {tbls}")
    print(f"  COMBINED {len(floats)}")
    print(f"  inline images embedded: {len(doc.inline_shapes)}")

    rule("FRONT MATTER")
    alltext = "\n".join(t for k, s, t in bl)
    print(f"  'Abstract' label present : {'Abstract' in alltext}")
    print(f"  keywords line present    : {bool(re.search(r'[Kk]ey ?words?', alltext))}")
    orcid = [t for k, s, t in bl if "orcid" in t.lower()]
    print(f"  ORCID present            : {bool(orcid)}  {orcid[:1]}")
    print(f"  affiliation line         : "
          f"{'present' if re.search(r'(University|Department|Faculty|Institute)', alltext[:1500]) else 'ABSENT'}")

    rule("FOUR REQUIRED END COUNTS")
    for probe in ["total word count", "excluding references", "abstract word count",
                  "supplementary information word count"]:
        print(f"  '{probe}': {'FOUND' if probe in alltext.lower() else 'ABSENT'}")

    rule("CITATION STYLE  (Springer author-date: no comma before year, ';' between works)")
    joined = " ".join(body)
    comma = re.findall(r"\([A-Z][A-Za-zÀ-ɏ'\-]+(?: et al\.)?, \d{4}[a-z]?", joined)
    nocomma = re.findall(r"\([A-Z][A-Za-zÀ-ɏ'\-]+(?: et al\.)? \d{4}[a-z]?", joined)
    narrative = re.findall(r"[A-Z][A-Za-zÀ-ɏ'\-]+(?: et al\.)? \(\d{4}[a-z]?\)", joined)
    print(f"  parenthetical WITH comma '(Name, 2020)' : {len(comma)}   must be 0")
    if comma:
        print(f"      e.g. {comma[:6]}")
    print(f"  parenthetical no comma   '(Name 2020)'  : {len(nocomma)}")
    print(f"  narrative                'Name (2020)'  : {len(narrative)}")
    print(f"  multi-work separator ';' : {len(re.findall(r'\d{4}[a-z]?; ', joined))}")

    rule("REFERENCE LIST")
    for r in refs[:3] + ["   ..."] + refs[-2:]:
        print(f"  {r[:112]}")
    sn = [m.group(1) for m in (re.match(r"^([A-Z][A-Za-zÀ-ɏ'\-]+)", r) for r in refs) if m]
    print(f"  alphabetical by first surname : "
          f"{'yes' if sn == sorted(sn, key=str.lower) else 'NO'}")
    print(f"  DOIs as full https links      : {sum('https://doi.org/' in r for r in refs)} of {len(refs)}")
    print(f"  bare 'doi:' form              : {sum(bool(re.search(r'(?<!org/)doi:', r, re.I)) for r in refs)}")
    full_given = sum(bool(re.match(r"^[A-Z][A-Za-zÀ-ɏ'\-]+,? [A-Z][a-z]{2,}", r)) for r in refs)
    print(f"  entries opening with a full given name : {full_given} of {len(refs)}"
          f"   (rest use initials)")

    rule("COLOUR IN CAPTIONS  (triggers a print-colour charge; must be 0)")
    pat = r"\b(colou?r(?:ed|s)?|red|blue|green|grey|gray|orange|purple|yellow)\b"
    hits = [(c, m) for c in caps for m in re.finditer(pat, c, re.I)]
    print(f"  captions naming a colour: {len({c for c, _ in hits})} of {len(caps)}")
    for c, m in hits:
        print(f"    {c[:9]:9s} '{m.group()}'  ...{c[max(0, m.start()-48):m.start()+48]}...")

    rule("RENDER ARTEFACTS")
    for pat, name in [(r"\?@[a-z]+-[a-z-]+", "unresolved cross-reference"),
                      (r"`r ", "raw inline R"),
                      (r"\[-?@[a-z0-9]+", "raw pandoc citation"),
                      (r"nTothing", "known typo")]:
        hits = re.findall(pat, alltext)
        print(f"  {name}: {len(hits)}  {hits[:5]}")


if __name__ == "__main__":
    main()
