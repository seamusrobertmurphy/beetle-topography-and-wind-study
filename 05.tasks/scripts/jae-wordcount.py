#!/usr/bin/env python3
"""Count body prose in a Quarto manuscript the way the JAE 6,000-word limit counts it.

Strips YAML, HTML comments, fenced R chunks and div fences, collapses each inline
`r ...` expression to one word, drops headings, and counts what is left between a
start and an end marker. Used to size the redraft, not to report a manuscript number.
"""
import re, sys

def count(path, start, end=None):
    src = open(path, encoding="utf-8").read()
    src = re.sub(r"^---\n.*?\n---\n", "", src, flags=re.S)
    src = re.sub(r"<!--.*?-->", "", src, flags=re.S)
    src = re.sub(r"^```\{r[^\n]*\n.*?\n```\s*$", "", src, flags=re.S | re.M)
    src = re.sub(r"^:::.*$", "", src, flags=re.M)
    src = re.sub(r"`r [^`]*`", "NUM", src)
    i = src.find(start)
    if i < 0:
        sys.exit(f"start marker not found: {start}")
    j = src.find(end, i) if end else -1
    body = src[i:j] if j > i else src[i:]
    body = re.sub(r"^#+ .*$", "", body, flags=re.M)
    return len(body.split())

if __name__ == "__main__":
    path, start = sys.argv[1], sys.argv[2]
    end = sys.argv[3] if len(sys.argv) > 3 else None
    print(count(path, start, end))
