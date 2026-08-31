#!/usr/bin/env python3
"""Extract, from full text, the temporal resolution at which each included study
treats wind.

Why this exists. Finding R5 of the review says no available wind product reports
the quantity the hypothesis is about, and argues that on height and on averaging
over open ground. It does not say what TEMPORAL resolution the hypothesis needs,
and the analysis has since forced that question: a single season mean, a monthly
mean, a flight-window statistic and an hourly series are four different covariates
and they do not agree. Settling it from the literature rather than from preference
requires knowing what temporal resolution these studies actually used or specified.

Method. For each included study, every occurrence of a wind term in the full text
is located and the sentence around it is captured, then scanned for temporal
vocabulary. Nothing is inferred from the abstract and nothing from memory: the
sentence is written to the output so every classification can be disputed against
the text it came from.
"""
import csv, io, contextlib, re, unicodedata
from pathlib import Path
import pypdf

STORE = Path("/Volumes/PortableSSD/Github/scientific-library")
HERE  = Path(__file__).parent
SCREEN = HERE / "review-screening.csv"
OUT_ROWS = HERE / "wind-temporal-sentences.csv"
OUT_SUM  = HERE / "wind-temporal-summary.csv"

# "window" and "windthrow" are not wind. build-review-screening.py already excludes
# them from `wind_mentions`; the same exclusion is applied here so the two agree. A
# first run of this script without it reported six wind mentions in Haukema 2008 that
# were all the phrase "temporal window".
WIND = re.compile(r"\bwind(?!ow|throw)\w*\b", re.I)
# temporal vocabulary, coarsest to finest
SCALES = [
    ("instantaneous", r"\binstantaneous|gust\w*|per second|m\s*s-?1\b|m/s\b"),
    ("hourly",        r"\bhourly|per hour|diurnal|time of day|afternoon|midday\b"),
    ("daily",         r"\bdaily|per day|day-to-day\b"),
    ("flight_window", r"\bflight period|flight season|dispersal period|emergence period|July|August\b"),
    ("monthly",       r"\bmonthly|per month\b"),
    ("seasonal",      r"\bseasonal|growing season|summer mean|season mean\b"),
    ("annual",        r"\bannual|per year|yearly\b"),
    ("climatology",   r"\bclimatolog\w*|long-term mean|30-year|normals?\b"),
]

def norm(t):
    for k, v in {"ﬀ":"ff","ﬁ":"fi","ﬂ":"fl","ﬃ":"ffi","ﬄ":"ffl"}.items():
        t = t.replace(k, v)
    return unicodedata.normalize("NFKD", t)

def text_of(p):
    with contextlib.redirect_stderr(io.StringIO()):
        r = pypdf.PdfReader(str(p))
        return norm("\n".join(pg.extract_text() or "" for pg in r.pages))

rows = list(csv.DictReader(SCREEN.open()))
inc  = [r for r in rows if r["stage2_include"] == "yes"]
pdfs = {p.name: p for p in STORE.rglob("*.pdf")}

sent_rows, summary = [], []
for r in inc:
    fn = r["original_filename"]
    p = pdfs.get(fn)
    if p is None:
        cands = [v for k, v in pdfs.items() if k.lower().startswith(fn.lower()[:28])]
        p = cands[0] if cands else None
    label = r["key"] or r["title"][:40]
    if p is None:
        summary.append(dict(study=label, year=r["year"], pdf="NOT FOUND",
                            n_wind=0, scales="", finest=""))
        print(f"{label:32s} PDF NOT FOUND ({fn[:40]})")
        continue
    t = text_of(p)
    t = re.sub(r"\s+", " ", t)
    hits, found = [], set()
    for m in WIND.finditer(t):
        s = t[max(0, m.start()-260): m.end()+260]
        sc = [name for name, pat in SCALES if re.search(pat, s, re.I)]
        found.update(sc)
        hits.append((s, ";".join(sc)))
        sent_rows.append(dict(study=label, year=r["year"], term=m.group(0),
                              scales=";".join(sc), context=s.strip()))
    finest = next((n for n, _ in SCALES if n in found), "")
    summary.append(dict(study=label, year=r["year"], pdf=p.name,
                        n_wind=len(hits), scales=";".join(sorted(found)), finest=finest))
    print(f"{label:32s} {r['year']:>5s}  wind x{len(hits):<3d} finest={finest or '-':14s} {';'.join(sorted(found))}")

with OUT_ROWS.open("w", newline="") as f:
    w = csv.DictWriter(f, fieldnames=["study","year","term","scales","context"]); w.writeheader()
    w.writerows(sent_rows)
with OUT_SUM.open("w", newline="") as f:
    w = csv.DictWriter(f, fieldnames=["study","year","pdf","n_wind","scales","finest"]); w.writeheader()
    w.writerows(summary)
print(f"\n{len(sent_rows)} wind sentences from {len(inc)} included studies")
print(f"wrote {OUT_ROWS.name} and {OUT_SUM.name}")
