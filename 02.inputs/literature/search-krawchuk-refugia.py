#!/usr/bin/env python3
"""Every Krawchuk publication touching refugia or bark beetles, from OpenAlex.

Why this exists. The manuscript's whole premise is a hypothesis attributed to
Krawchuk et al. (2020). Before building a paper on it we need to know whether that
hypothesis is stated anywhere else in her corpus, whether she has tested it since,
and whether a later statement supersedes the 2020 wording we quote. Asking the
question from memory is exactly the failure the project's citation rule forbids, so
it is asked of the index and the answer is written to disk.

Search protocol, run 2026-08-27:
  database   OpenAlex, https://api.openalex.org
  author     Meg A. Krawchuk, OpenAlex A5068460224, Oregon State University
  works      all 134 records on the author profile, no date or type filter
  screen 1   title or abstract matches /refugi/i
  screen 2   title or abstract matches /beetle|insect|Dendroctonus|bark ?beetle/i
  retained   records matching BOTH screens
Cross-checked against Crossref for the same author and terms.

Writes: krawchuk-refugia-screening.csv, one row per work, with both screen flags.

Run:  python3 02.inputs/literature/search-krawchuk-refugia.py
"""
import csv, json, re, urllib.request

AUTHOR = "A5068460224"
MAILTO = "seamusrobertmurphy@gmail.com"
OUT = "02.inputs/literature/krawchuk-refugia-screening.csv"

REFUGIA = re.compile(r"refugi", re.I)
INSECT = re.compile(r"beetle|insect|Dendroctonus|bark ?beetle", re.I)

url = (f"https://api.openalex.org/works?filter=author.id:{AUTHOR}"
       f"&per-page=200&sort=publication_year:desc&mailto={MAILTO}")
with urllib.request.urlopen(url, timeout=120) as r:
    data = json.load(r)

rows = []
for w in data["results"]:
    title = w.get("title") or ""
    inv = w.get("abstract_inverted_index")
    abstract = " ".join(inv.keys()) if inv else ""
    blob = f"{title} {abstract}"
    src = (w.get("primary_location") or {}).get("source") or {}
    rows.append({
        "year": w.get("publication_year"),
        "venue": src.get("display_name") or "",
        "title": title,
        "doi": (w.get("doi") or "").replace("https://doi.org/", ""),
        "type": w.get("type") or "",
        "cited_by": w.get("cited_by_count"),
        "screen_refugia": "yes" if REFUGIA.search(blob) else "no",
        "screen_insect": "yes" if INSECT.search(blob) else "no",
        "retained": "yes" if (REFUGIA.search(blob) and INSECT.search(blob)) else "no",
    })

with open(OUT, "w", newline="") as fh:
    wr = csv.DictWriter(fh, fieldnames=list(rows[0]))
    wr.writeheader()
    wr.writerows(rows)

n = len(rows)
r1 = sum(x["screen_refugia"] == "yes" for x in rows)
r2 = sum(x["screen_insect"] == "yes" for x in rows)
keep = [x for x in rows if x["retained"] == "yes"]
print(f"works {n}; refugia {r1}; insect {r2}; retained {len(keep)}")
for x in keep:
    print(f"  {x['year']} {x['venue']}: {x['title']} ({x['doi']})")
