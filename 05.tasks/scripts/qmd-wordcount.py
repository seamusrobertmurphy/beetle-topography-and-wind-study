#!/usr/bin/env python3
"""Word-count the manuscript .qmd the way the rendered docx counts, so cuts can
be measured without paying for a 10-to-30-minute render.

Counts prose only: YAML abstract, running text, and the `tbl-cap`/`fig-cap`
chunk options that become captions. Code chunks, chunk options that are not
captions, and the YAML apparatus are excluded. An inline `r ...` expression
counts as one word, which is what most of them render to.

Run:  python3 05.tasks/scripts/qmd-wordcount.py [path-to-qmd]
"""

import re
import sys
import pathlib

QMD = pathlib.Path(sys.argv[1] if len(sys.argv) > 1
                   else "archive/beetle-topography-wind-study.qmd")

WORD = re.compile(r"[A-Za-z0-9À-ɏ][A-Za-z0-9À-ɏ'’.\-/]*")
INLINE_R = re.compile(r"`r [^`]*`")


def count(text):
    return len(WORD.findall(INLINE_R.sub(" xword ", text)))


def main():
    lines = QMD.read_text().split("\n")
    in_yaml = False
    in_chunk = False
    yaml_key = None
    abstract, prose, caps = [], [], []
    section = "(front)"
    per_section = {}

    for i, ln in enumerate(lines):
        s = ln.strip()

        if i == 0 and s == "---":
            in_yaml = True
            continue
        if in_yaml:
            if s == "---":
                in_yaml = False
                continue
            m = re.match(r"^(\w[\w-]*):", ln)
            if m:
                yaml_key = m.group(1)
            elif yaml_key == "abstract" and s:
                abstract.append(s)
            continue

        if s.startswith("```"):
            in_chunk = not in_chunk
            continue
        if in_chunk:
            m = re.match(r"^#\|\s*(tbl-cap|fig-cap):\s*(.*)$", s)
            if m:
                caps.append((section, m.group(2).strip().strip('"')))
            continue

        if s.startswith("#"):
            section = re.sub(r"\{#.*\}", "", s.lstrip("# ")).strip()
            per_section.setdefault(section, 0)
            continue
        if s:
            prose.append((section, s))
            per_section[section] = per_section.get(section, 0) + count(s)

    abs_w = count(" ".join(abstract))
    prose_w = sum(count(t) for _, t in prose)
    cap_w = sum(count(t) for _, t in caps)

    print(f"file: {QMD}")
    print()
    print(f"  abstract (YAML)      {abs_w:>6}   limit 250")
    print(f"  running prose        {prose_w:>6}")
    print(f"  captions ({len(caps):>2})         {cap_w:>6}")
    print(f"  prose + captions     {prose_w + cap_w:>6}")
    print()
    print("  by section (prose only, captions listed separately):")
    for sec, w in per_section.items():
        if w:
            print(f"    {w:>6}  {sec[:64]}")
    print()
    print("  captions:")
    for sec, c in caps:
        print(f"    {count(c):>6}  {c[:64]}")


if __name__ == "__main__":
    main()
