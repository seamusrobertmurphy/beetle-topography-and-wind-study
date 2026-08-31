#!/usr/bin/env python3
"""How does Journal of Applied Entomology actually report statistics?

Why this exists. The manuscript prints p-values in scientific notation, "< 1e-16"
and "4.91e-07", because that is what R's sprintf gives. A reader of an entomology
journal does not expect that, and the guidelines do not say what is expected: they
cover table footnote symbols and SI units and stop. So the convention is read off
the journal's own recent papers rather than assumed.

Method, run 2026-08-27:
  1. OpenAlex source S87930725, type:article, publication_year 2025 or 2026.
  2. Download every open-access PDF hosted somewhere other than Wiley. Wiley's own
     PDF endpoint returns an HTML challenge page to a script, so it cannot be used.
  3. Extract from each text layer: p-value expressions, plus-minus notation, and the
     test statistics that carry degrees of freedom.

Counts are of expressions found in the text layer, so a two-column PDF may split an
expression across a line break and lose it. The counts are therefore a lower bound,
and the point of the exercise is the FORM that recurs, not the tally.

Writes: jae-stats-style.txt

Run:  python3 02.inputs/literature/audit-jae-stats-style.py
"""
import collections, io, json, re, urllib.request

MAILTO = "seamusrobertmurphy@gmail.com"
SOURCE = "S87930725"
OUT = "02.inputs/literature/jae-stats-style.txt"
UA = {"User-Agent": "Mozilla/5.0 (compatible; academic-style-check)"}

PATTERNS = {
    "p-value":      re.compile(r'\b[Pp]\s*[<>=≤≥]\s*[0-9][0-9.eE−\-]*'),
    "plus-minus":   re.compile(r'\d+\.?\d*\s*±\s*\d+\.?\d*'),
    "F statistic":  re.compile(r'\bF\s*\d*,?\s*\d*\s*=\s*\d+\.?\d*'),
    "chi-square":   re.compile(r'[χX]\s*2?\s*=\s*\d+\.?\d*'),
    "t statistic":  re.compile(r'\bt\s*\d*\.?\d*\s*=\s*[-−]?\d+\.?\d*'),
    "CI":           re.compile(r'\b95%\s*(?:CI|confidence interval)'),
    "sci notation": re.compile(r'\d\.?\d*\s*[eE][−\-+]\s*?\d+|\d\s*×\s*10'),
}


def get(url, timeout=120):
    return urllib.request.urlopen(urllib.request.Request(url, headers=UA),
                                  timeout=timeout).read()


url = (f"https://api.openalex.org/works?filter=primary_location.source.id:{SOURCE},"
       f"publication_year:2025|2026,type:article&per-page=200&mailto={MAILTO}")
works = json.loads(get(url))["results"]
urls = []
for w in works:
    for loc in (w.get("locations") or []):
        u = loc.get("pdf_url")
        if u and "wiley" not in u:
            urls.append((w.get("title") or "", u))
            break
print(f"JAE 2025-2026 articles: {len(works)}; non-Wiley PDFs: {len(urls)}")

tally = {k: collections.Counter() for k in PATTERNS}
read = 0
lines = []
for title, u in urls:
    try:
        raw = get(u)
        if raw[:4] != b"%PDF":
            continue
        from pypdf import PdfReader
        t = "\n".join((p.extract_text() or "")
                      for p in PdfReader(io.BytesIO(raw)).pages)
    except Exception:
        continue
    read += 1
    lines.append(f"\n--- {title[:70]} ({len(t.split())} words) ---")
    for name, pat in PATTERNS.items():
        hits = [h.replace(" ", "") for h in pat.findall(t)]
        if hits:
            tally[name].update(hits)
            lines.append(f"  {name}: {len(hits)}  e.g. {', '.join(list(dict.fromkeys(hits))[:5])}")

report = [f"Journal of Applied Entomology statistical reporting, {read} open-access "
          f"PDFs from 2025-2026", "=" * 72]
for name, c in tally.items():
    report.append(f"\n{name}: {sum(c.values())} occurrences, {len(c)} distinct forms")
    for form, n in c.most_common(12):
        report.append(f"    {form:28s} x{n}")
report += lines

open(OUT, "w").write("\n".join(report))
print("\n".join(report[:60]))
print(f"\nwrote {OUT}")
