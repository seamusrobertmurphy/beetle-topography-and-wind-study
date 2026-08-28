#!/usr/bin/env python3
"""Do published Frontiers in Ecology and the Environment papers obey the stated limits?

Why this exists. The March 2026 author guidelines cap a Research Communication at
2500 words and 25 references, a Concise Review at 3000 and 50, and Concepts and
Questions at 2800 and 40. Krawchuk et al. (2020), the paper this manuscript is built
on, runs to about 5400 words of countable main text with 50 references, which those
caps do not allow. Either the rules changed after 2020 or they are not what the
journal prints. Guessing between those is not acceptable, so recent issues are
measured instead.

Method, run 2026-08-27:
  1. OpenAlex source S144797041, type:article, publication_year 2025 or 2026.
  2. Reference counts taken from OpenAlex referenced_works. This UNDERCOUNTS: only
     references OpenAlex could match to a DOI are listed, so a count over the cap is
     evidence and a count under it is not.
  3. Where an open-access PDF exists on a repository that is not Wiley, it is
     downloaded and the printed article-type banner read from the text layer, along
     with the total words and the words before the reference list. Wiley's own PDF
     and article pages return 403 to a script, so they are not used.

Word counts here are of the whole text layer, which includes captions, the "In a
nutshell" box, affiliations and running heads. They are therefore an upper bound on
the main text the guidelines actually limit, and are reported as such.

Writes: fee-article-limits.csv

Run:  python3 02.inputs/literature/audit-fee-article-limits.py
"""
import csv, io, json, re, statistics, urllib.request

MAILTO = "seamusrobertmurphy@gmail.com"
SOURCE = "S144797041"
OUT = "02.inputs/literature/fee-article-limits.csv"
BANNERS = ["RESEARCH COMMUNICATION", "CONCEPTS AND QUESTIONS", "CONCISE REVIEW",
           "REVIEWS", "READER'S FORUM"]
UA = {"User-Agent": "Mozilla/5.0 (compatible; academic-citation-check)"}


def get(url, timeout=90):
    return urllib.request.urlopen(urllib.request.Request(url, headers=UA),
                                  timeout=timeout).read()


url = (f"https://api.openalex.org/works?filter=primary_location.source.id:{SOURCE},"
       f"publication_year:2025|2026,type:article&per-page=200&mailto={MAILTO}")
works = json.loads(get(url, 120))["results"]
print(f"FEE articles 2025-2026: {len(works)}")

rows = []
for w in works:
    nref = len(w.get("referenced_works") or [])
    pdf = next((l["pdf_url"] for l in (w.get("locations") or [])
                if l.get("pdf_url") and "wiley" not in l["pdf_url"]), None)
    banner, total, before = "", "", ""
    if pdf:
        try:
            raw = get(pdf)
            if raw[:5] in (b"%PDF-", b"%PDF"):
                from pypdf import PdfReader
                t = "\n".join((p.extract_text() or "")
                              for p in PdfReader(io.BytesIO(raw)).pages)
                banner = next((b for b in BANNERS if b in t), "")
                total = len(t.split())
                i = t.rfind("References")
                before = len(t[:i].split()) if i > 0 else ""
        except Exception as e:
            banner = f"fetch failed: {type(e).__name__}"
    rows.append({"year": w.get("publication_year"),
                 "doi": (w.get("doi") or "").replace("https://doi.org/", ""),
                 "title": (w.get("title") or "")[:90],
                 "openalex_refs": nref, "banner": banner,
                 "pdf_total_words": total, "words_before_refs": before,
                 "pdf": pdf or ""})

with open(OUT, "w", newline="") as fh:
    wr = csv.DictWriter(fh, fieldnames=list(rows[0]))
    wr.writeheader()
    wr.writerows(rows)

refs = [r["openalex_refs"] for r in rows if r["openalex_refs"] > 0]
over = [r for r in refs if r > 25]
print(f"with references indexed: {len(refs)}")
print(f"  median {statistics.median(refs)}, mean {statistics.mean(refs):.1f}, max {max(refs)}")
print(f"  over the 25-reference Research Communication cap: {len(over)} "
      f"({100*len(over)/len(refs):.0f}%)")
seen = [r for r in rows if r["banner"] and not r["banner"].startswith("fetch")]
print(f"\narticle-type banners read from {len(seen)} open-access PDFs:")
for r in seen:
    print(f"  {r['banner']:24s} refs={r['openalex_refs']:3d} "
          f"words(total/pre-refs)={r['pdf_total_words']}/{r['words_before_refs']}  {r['doi']}")
print(f"\nwrote {OUT}")
