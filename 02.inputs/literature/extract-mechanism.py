#!/usr/bin/env python3
"""Mechanism evidence for the wind-disruption hypothesis, extracted from full text.

The review's earlier findings (R1-R6) established what prior work does NOT contain: no
study fits a wind term, no product reports the right quantity, no study states a temporal
resolution. This script establishes the positive half, which the model specification has
to be built on: what the published biology says the wind acts THROUGH.

Every sentence in the corpus that mentions wind and a mechanism term is written out
verbatim with its source, so a claim about the mechanism can be checked against the
sentence it came from rather than against a paraphrase. "window", "windthrow", "windfall"
and plural "winds" in a weather sense are excluded from the wind match, the same guard
build-review-screening.py uses: a first run without it counted "temporal window" as a
wind mention.
"""
import csv, os, re, sys
from pypdf import PdfReader

STORE = "/Volumes/PortableSSD/Github/scientific-library/library/pdf/"
OUT = os.path.dirname(os.path.abspath(__file__))

# The corpus: every mountain pine beetle, bark beetle and refugia paper in the central
# store, plus the parent. Selected by filename because the store has no machine-readable
# subject index; the selection is listed here so it can be disputed.
PREFIXES = [
    "Krawchuk 2020", "Cartright 2018", "powell & bentz2014", "Carroll & Safranyik 2003",
    "Safranyik & Wilson 2006", "Shore 2006", "Jones et al 2019", "gray2009",
    "Chen & Walton 2011", "Aukema 2006", "Aukema 2007", "Howe et al 2022",
    "Sambaraju et al 2021", "Wulder et al 2006", "Taylor & Carrol 2003",
    "mccambridge1971", "Larson et al 2005", "Lerch et al 2016", "Work et al 2011",
    "Chen 2014", "Fauria & Johson 2009", "Janes et al 2014", "Murphy et al 2026",
    "Cooke et al 2024", "Zabihi 2021", "Smith-McKenna", "Bright et al 2020",
]

WIND = re.compile(r"\bwind(?!ow|s\b|throw|fall|-throw)\w*", re.I)
MECH = {
    "pheromone":  re.compile(r"pheromon|plume|semiochem|aggregation|olfact|kairomon", re.I),
    "density":    re.compile(r"stand density|host density|basal area|stems per|crown clos|"
                             r"canopy (cover|clos|density)|thinner stand|stocking", re.I),
    "flight":     re.compile(r"flight|flying|disper|emerg|take-?off|flew", re.I),
    "terrain":    re.compile(r"terrain|topograph|ruggedness|slope|aspect|elevation|"
                             r"ridge|valley|exposure|shelter|lee(ward)?|windward", re.I),
    "diameter":   re.compile(r"diameter|dbh|\bqmd\b|stem size|large-?diameter", re.I),
    "temporal":   re.compile(r"hourly|daily|monthly|annual|mean wind|instantaneous|"
                             r"season|July|August|flight period", re.I),
}

def sentences(text):
    text = re.sub(r"-\n", "", text)
    text = re.sub(r"\s+", " ", text)
    return re.split(r"(?<=[.!?]) +", text)

files = os.listdir(STORE)
rows, missing = [], []
for pref in PREFIXES:
    match = [f for f in files if f.startswith(pref)]
    if not match:
        missing.append(pref); continue
    try:
        reader = PdfReader(STORE + match[0])
        text = "\n".join(p.extract_text() or "" for p in reader.pages)
    except Exception as exc:
        missing.append(f"{pref} ({type(exc).__name__})"); continue
    for sent in sentences(text):
        if not WIND.search(sent):
            continue
        tags = [k for k, pat in MECH.items() if pat.search(sent)]
        if not tags:
            continue
        rows.append({"source": pref, "file": match[0], "tags": "|".join(sorted(tags)),
                     "n_tags": len(tags), "sentence": sent.strip()[:1200]})

with open(os.path.join(OUT, "mechanism-evidence.csv"), "w", newline="") as fh:
    w = csv.DictWriter(fh, fieldnames=["source", "file", "tags", "n_tags", "sentence"])
    w.writeheader(); w.writerows(rows)

# Per-source summary: which mechanism each paper actually links wind to. This is the
# table the manuscript reads; the sentence file above is the evidence behind it.
srcs = sorted({r["source"] for r in rows} | {p for p in PREFIXES if p not in missing})
with open(os.path.join(OUT, "mechanism-summary.csv"), "w", newline="") as fh:
    w = csv.writer(fh)
    w.writerow(["source", "wind_sentences"] + list(MECH))
    for s in srcs:
        sr = [r for r in rows if r["source"] == s]
        w.writerow([s, len(sr)] + [sum(1 for r in sr if k in r["tags"].split("|"))
                                   for k in MECH])

print(f"{len(PREFIXES)-len(missing)} papers read, {len(rows)} wind-mechanism sentences")
if missing:
    print("not found:", "; ".join(missing), file=sys.stderr)
for k in MECH:
    print(f"  {k:10s} {sum(1 for r in rows if k in r['tags'].split('|')):4d} sentences, "
          f"{len({r['source'] for r in rows if k in r['tags'].split('|')}):2d} papers")
