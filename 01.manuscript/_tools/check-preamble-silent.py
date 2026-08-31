#!/usr/bin/env python3
"""Fail if the shared preamble contains a chunk that prints.

Why this exists. _sections/_preamble.qmd is included by every live draft before the
Abstract, so any chunk in it that produces output appears at the top of the document rather
than where the author intended. On 2026-08-28 the dataset inventory table sat there and
rendered above the abstract in the submission package. Nothing caught it; Seamus did, by
reading the document.

A chunk is silent if it sets `output: false` or `include: false`. A chunk carrying a
`tbl-cap` or `fig-cap`, or omitting `output: false`, will print.

Run:  python3 01.manuscript/_tools/check-preamble-silent.py
Exits non-zero and names the offending chunks.
"""
import pathlib, re, sys

ROOT = pathlib.Path(__file__).resolve().parents[2]
PRE = ROOT / "01.manuscript" / "_sections" / "_preamble.qmd"
if not PRE.exists():
    sys.exit(f"not found: {PRE}")

chunks = re.findall(r"```\{r\}\n(.*?)\n```", PRE.read_text(), re.S)
bad = []
for c in chunks:
    header = "\n".join(l for l in c.splitlines() if l.startswith("#|"))
    m = re.search(r"#\|\s*label:\s*(\S+)", header)
    name = m.group(1) if m else "(unlabelled)"
    silent = re.search(r"#\|\s*(?:output|include):\s*false", header)
    prints = re.search(r"#\|\s*(?:tbl|fig)-cap:", header)
    if prints or not silent:
        bad.append((name, "has a caption" if prints else "does not set output: false"))

print(f"{PRE.relative_to(ROOT)}: {len(chunks)} chunks checked")
if bad:
    print("\nThese will print at the top of every document that includes the preamble:")
    for name, why in bad:
        print(f"  {name}: {why}")
    print("\nMove them into the section where they belong, or silence them.")
    sys.exit(1)
print("all chunks are silent; the preamble computes and does not print")
