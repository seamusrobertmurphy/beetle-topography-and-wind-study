#!/usr/bin/env python3
"""Fill the four word counts the target journal requires at the end of the manuscript.

The manuscript carries placeholders written by the .qmd:

    {{WC_TOTAL}}  {{WC_NOREFS}}  {{WC_ABSTRACT}}  {{WC_SUPP}}

This counts the rendered document and substitutes them, so the declared counts
are the document's own and cannot drift from it. Counting has to happen after
the render, not inside it, because a document cannot count itself while it is
still being written.

Counting follows the guidelines' inclusion rule: the total covers running text,
captions and the contents of figures and tables as well as references. The
abstract is counted separately and is not in either total.

Idempotent only in the sense that it is a one-shot substitution; once the
placeholders are gone a second run reports that and changes nothing.

Run:  python3 01.manuscript/_tools/stamp-wordcounts.py <file.docx> [more.docx ...]
Wired into _quarto.yml as a post-render step, after format-tables.py.
"""

import os
import re
import sys
import shutil
import zipfile
import pathlib
from lxml import etree

# Limits are per target venue, keyed on the output file's stem, because this project
# renders more than one manuscript and one set of limits cannot be right for all of them.
#
# Journal of Pest Science, Original Research Paper, read from the Wayback capture of
# 2025-12-05 of the submission guidelines on 2026-09-01, the live page being behind a
# script challenge that day. "Original articles are limited to 7,000 words per article
# (all text excluding tables, figure legends, and reference list)" and "Please provide an
# abstract of 150 to 250 words." Key message bullets are "3 to 5 bullet points of
# maximum 100 characters, including spaces".
#
# Journal of Applied Entomology, the target until 2026-09-01, was 6000 and 300. Frontiers
# in Ecology and the Environment, Research Communication, checked 2026-08-27, is 2500 and
# 150 and applies to the archived short-short draft.
LIMITS = {
    "beetle-topography-wind-study-short-short": (2500, 150),   # Front Ecol Environ
    "Manuscript": (7000, 250),                                  # J Pest Sci, submission
}
DEFAULT_LIMITS = (7000, 250)                                   # J Pest Sci
KEY_MESSAGE_MAX = 100

W = "http://schemas.openxmlformats.org/wordprocessingml/2006/main"
w = lambda tag: f"{{{W}}}{tag}"

WORD = re.compile(r"[A-Za-z0-9À-ɏ][A-Za-z0-9À-ɏ'’.\-/]*")
SUPP_WORDS = 0        # no supplementary information yet; update when one exists


def words(text):
    return len(WORD.findall(text))


def para_text(p):
    return "".join(n.text or "" for n in p.iter(w("t")))


def style_of(p):
    s = p.find(f"{w('pPr')}/{w('pStyle')}")
    return s.get(w("val")) if s is not None else ""


def is_heading(p):
    return style_of(p).startswith("Heading")


def measure(root):
    body = root.find(w("body"))
    abstract_w = refs_w = running_w = float_w = 0
    # The abstract is found by position, between the Abstract heading and the next heading.
    # Keying on an "Abstract" paragraph style, as this did until 2026-08-28, always returned
    # zero: style-formal.docx has no such style, so the abstract fell into the running text
    # and the 300-word cap was never actually tested by anything.
    in_abstract = False
    in_key = False
    in_legends = False
    key_lines = []
    prose_w = 0   # the journal's measure: text excluding tables, figure legends, references
    for child in body:
        if child.tag == w("p"):
            st, txt = style_of(child), para_text(child)
            if is_heading(child):
                h = re.sub(r"^[\d.]+\s*", "", txt.strip().lower())
                in_abstract = h == "abstract"
                in_key = h == "key message"
                in_legends = h == "figure legends"
                running_w += words(txt)
                continue
            if in_key and txt.strip():
                key_lines.append(txt.strip())
            if st == "Bibliography":
                refs_w += words(txt)
            elif in_abstract:
                abstract_w += words(txt)
            elif st in ("Author", "Subtitle", "Title", "Date", "AbstractTitle"):
                # front matter, counted in neither total
                pass
            else:
                running_w += words(txt)
                if not in_legends and st != "SourceCode" and "aption" not in st:
                    prose_w += words(txt)
        elif child.tag == w("tbl"):
            in_abstract = False
            float_w += words(" ".join(n.text or "" for n in child.iter(w("t"))))
    total_norefs = running_w + float_w   # abstract is excluded, per the note above
    return {
        "WC_TOTAL": total_norefs + refs_w,
        "WC_NOREFS": total_norefs,
        "WC_ABSTRACT": abstract_w,
        "WC_SUPP": SUPP_WORDS,
        "WC_PROSE": prose_w,
        "KEY_LINES": key_lines,
    }


def report(path, counts, word_limit, abstract_max):
    """Say the length out loud, and say loudly when it is over."""
    body = counts["WC_PROSE"]
    abstract = counts["WC_ABSTRACT"]
    print(f"  {path.name}: prose excluding tables, figure legends, code and references "
          f"{body:,} against a {word_limit:,} limit; inclusive of tables and code "
          f"{counts['WC_NOREFS']:,}; abstract {abstract:,} against {abstract_max:,}.")
    over = []
    if body > word_limit:
        over.append(f"body over by {body - word_limit:,} words")
    if abstract > abstract_max:
        over.append(f"abstract over by {abstract - abstract_max:,} words")
    keys = counts.get("KEY_LINES", [])
    if keys:
        print(f"  {path.name}: key message, {len(keys)} bullets, longest "
              f"{max(len(k) for k in keys)} characters against {KEY_MESSAGE_MAX}.")
        for k in keys:
            if len(k) > KEY_MESSAGE_MAX:
                over.append(f"key message bullet of {len(k)} characters: {k[:40]}...")
        if not 3 <= len(keys) <= 5:
            over.append(f"key message has {len(keys)} bullets, not 3 to 5")
    if over:
        bar = "!" * 74
        print(f"\n{bar}\n  OVER THE LIMIT: {'; '.join(over)}.\n"
              f"  {path.name} cannot be submitted at this length.\n{bar}\n")


def process(path):
    path = pathlib.Path(path)
    if not path.exists():
        print(f"  skipped, not found: {path}")
        return
    word_limit, abstract_max = LIMITS.get(path.stem, DEFAULT_LIMITS)
    zin = zipfile.ZipFile(path)
    parts = {n: zin.read(n) for n in zin.namelist()}
    zin.close()

    root = etree.fromstring(parts["word/document.xml"])
    counts = measure(root)

    # The placeholder may be split across runs by the renderer, so substitute on
    # the joined text of each paragraph and write it back as a single run.
    hits = 0
    for p in root.iter(w("p")):
        txt = para_text(p)
        if "{{WC_" not in txt:
            continue
        new = txt
        for k, v in counts.items():
            if k in ("KEY_LINES",):
                continue
            new = new.replace("{{" + k + "}}", f"{v:,}")
        runs = p.findall(w("r"))
        if not runs:
            continue
        for extra in runs[1:]:
            p.remove(extra)
        for tnode in runs[0].findall(w("t")):
            runs[0].remove(tnode)
        tnode = etree.SubElement(runs[0], w("t"))
        tnode.text = new
        tnode.set("{http://www.w3.org/XML/1998/namespace}space", "preserve")
        hits += 1

    # Report the length whether or not the document asked to be stamped. Until 2026-08-28
    # this returned quietly when the placeholders were absent, and the placeholders had
    # been removed from the manuscript, so the only check on the body length was a number
    # typed into a YAML comment. That number said 5,797 while the rendered body was 8,902.
    # A guard that cannot fail is not a guard.
    report(path, counts, word_limit, abstract_max)
    if not hits:
        print(f"  {path.name}: no {{{{WC_*}}}} placeholders in the document, so nothing was "
              f"substituted; the counts above are reported only.")
        return

    parts["word/document.xml"] = etree.tostring(root, xml_declaration=True,
                                                encoding="UTF-8", standalone=True)
    tmp = path.with_suffix(".docx.tmp")
    with zipfile.ZipFile(tmp, "w", zipfile.ZIP_DEFLATED) as zout:
        for name, data in parts.items():
            zout.writestr(name, data)
    shutil.move(tmp, path)
    print(f"  {path.name}: total {counts['WC_TOTAL']:,} "
          f"(excl. refs {counts['WC_NOREFS']:,}), abstract {counts['WC_ABSTRACT']:,}, "
          f"supplementary {counts['WC_SUPP']:,}; venue prose cap {word_limit:,}")
    # WC_NOREFS is the document as rendered, which in this project includes every
    # line of echoed R code, so it is not the journal's prose measure and is not
    # compared against the limit here. The .qmd's own word-budget chunk measures
    # body prose from the source and stops the render if that exceeds the limit.
    if counts["WC_ABSTRACT"] > abstract_max:
        print(f"    OVER the {abstract_max}-word abstract limit by "
              f"{counts['WC_ABSTRACT'] - abstract_max:,}")
    elif counts["WC_ABSTRACT"] == 0:
        print("    abstract not detected: check the Word style the template applies")


if __name__ == "__main__":
    args = sys.argv[1:]
    if not args:
        args = [f for f in os.environ.get("QUARTO_PROJECT_OUTPUT_FILES", "").split("\n")
                if f.strip().endswith(".docx")]
    if not args:
        print("no .docx to stamp")
        sys.exit(0)
    for a in args:
        process(a.strip())
