#!/usr/bin/env python3
"""Splice the parent manuscript's R chunks into the JAE short-form prose template.

The parent `beetle-topography-wind-study.qmd` holds every analysis chunk. The
Journal of Applied Entomology version needs the same computation under a 6,000
word prose limit, so the chunks are copied verbatim by label rather than retyped,
and only the prose is rewritten. Run once to create `01.manuscript/manuscript-short.qmd`;
after that the .qmd is the source of truth and this script is provenance.

Usage: python3 05.tasks/scripts/assemble-short.py
"""
import re, sys, pathlib

ROOT = pathlib.Path(__file__).resolve().parents[2]
PARENT = ROOT / "01.manuscript" / "beetle-topography-wind-study.qmd"
TEMPLATE = ROOT / "05.tasks" / "scripts" / "short-template.qmd"
OUT = ROOT / "01.manuscript" / "manuscript-short.qmd"

def chunks(path):
    """Map chunk label -> the labelled block plus any unlabelled blocks before it.

    The parent manuscript carries nine chunks with options but no label, and four of
    them define objects a following labelled chunk needs (`mt_h` before
    `krawchuk-numbers`, the censoring frame `st` before `cold-numbers`). An
    unlabelled run is therefore attached to the labelled chunk that follows it, so
    requesting a label carries its dependencies with it. A trailing unlabelled run
    with no labelled chunk after it is dropped, which is what the parent's
    supplementary display chunks are.
    """
    text = path.read_text(encoding="utf-8")
    blocks, cur, label = [], None, None
    for line in text.split("\n"):
        if cur is None and line.startswith("```{r"):
            cur, label = [line], None
            continue
        if cur is not None:
            cur.append(line)
            if label is None:
                m = re.match(r"#\|\s*label:\s*(\S+)", line)
                if m:
                    label = m.group(1)
            if line.strip() == "```":
                blocks.append((label, "\n".join(cur)))
                cur, label = None, None
    if cur is not None:
        sys.exit("unterminated chunk in parent manuscript")

    out, pending = {}, []
    for label, body in blocks:
        if label is None:
            pending.append(body)
            continue
        if label in out:
            sys.exit(f"duplicate chunk label: {label}")
        out[label] = "\n\n".join(pending + [body])
        pending = []
    return out

def main():
    have = chunks(PARENT)
    tpl = TEMPLATE.read_text(encoding="utf-8")
    wanted = re.findall(r"<<chunk:([A-Za-z0-9_-]+)>>", tpl)
    missing = [w for w in wanted if w not in have]
    if missing:
        sys.exit("chunk labels not found in parent: " + ", ".join(missing))
    dupes = [w for w in set(wanted) if wanted.count(w) > 1]
    if dupes:
        sys.exit("template requests a chunk twice: " + ", ".join(dupes))
    out = re.sub(r"<<chunk:([A-Za-z0-9_-]+)>>", lambda m: have[m.group(1)], tpl)
    OUT.write_text(out, encoding="utf-8")
    print(f"{len(have)} chunks in parent, {len(wanted)} spliced into {OUT.name}")
    print("carried : " + ", ".join(wanted))
    print("dropped : " + ", ".join(k for k in have if k not in wanted))

if __name__ == "__main__":
    main()
