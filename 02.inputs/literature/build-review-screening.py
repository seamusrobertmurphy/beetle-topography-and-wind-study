#!/usr/bin/env python3
"""Build the literature review screening table for this manuscript.

The review is written against this manuscript's four research objectives, so the
corpus is screened against them and not assembled as a general survey of the
species.

Two kinds of column, and the difference matters.

  Curated. `stage2_include` and `exclude_reason` are judgements, recorded here so
  they can be disputed. They are the review's editorial record.

  Computed. `wind_predictor`, `host_layer`, `terrain_terms` and `wind_mentions`
  are read from the full text of the PDF at build time, never from the abstract
  and never from memory. The review's central claim is an absence, and an
  absence asserted from titles is not evidence.

Run from the manuscript repository. Reads the central store at
../../../scientific-library. Writes review-screening.csv, which the manuscript
reads at render time to compute every count it reports.
"""
import csv, io, contextlib, re, sys, unicodedata
from pathlib import Path

STORE = Path("/Volumes/PortableSSD/Github/scientific-library")
OUT = Path(__file__).with_name("review-screening.csv")

# Stage 1: the topic filter applied to the whole store.
TOPIC = ["beetle", "dendroctonus", "mpb", "ips typographus", "scolytin", "refugi"]

# Stage 2: studies that model bark-beetle-caused tree mortality spatially against
# terrain, landscape or climate predictors. These are the only studies that can
# speak to objectives 1, 3 and 4.
INCLUDE = {
    "walter2013multi", "wulder2006estimating", "chen2013spatiotempor",
    "meddens2014spatial", "maciasfauria2009large", "haukema2008movement",
    "chen2011mountain", "cartwright2018landscape", "murphy2026spatial",
    "krawchuk2020disturbance",
}
INCLUDE_UNVERIFIED = {"Zabihi 2021"}   # in the store, not resolvable in CrossRef

# Reasons, applied in order; the first that matches is recorded.
EXCLUDE_RULES = [
    (r"carabidae|ground beetle|adelgid|woolly", "not a bark beetle of conifer boles"),
    (r"terpene|pheromone|proteomic|physiolog|flight|dispersal by flight|emergence",
     "mechanism or physiology, not a spatial model of attack"),
    (r"fire severity|burning|wildfire|recruitment|regeneration|seral|growth release",
     "post-disturbance response, attack not the response variable"),
    (r"early detection|hyperspectral|vegetation index|satellite imagery|remote sensing",
     "detection method, terrain not a predictor"),
    (r"range expansion|boreal|host-range|eastern pine|spread to",
     "range or spread projection, not within-landscape attack"),
    (r"review|synthesis|proceedings|report|strategy|control efficacy|assessment of",
     "review, report or management document"),
]

LIG = {"ﬀ": "ff", "ﬁ": "fi", "ﬂ": "fl", "ﬃ": "ffi", "ﬄ": "ffl"}
def norm(t):
    for k, v in LIG.items():
        t = t.replace(k, v)
    return unicodedata.normalize("NFKC", t)

PROBE = {
    # A wind predictor means wind entered the model, not that the word appears.
    # Checked by hand against every hit; see review-protocol.md.
    "wind_predictor": r"wind speed|wind exposure|wind surface|windiness|wind atlas|shelter index",
    # NOTE: this detects whether host vocabulary appears anywhere in the text,
    # including the reference list. It is NOT evidence that the study conditioned
    # its model on host abundance, which cannot be established by search and is
    # recorded per study in review-protocol.md after reading the methods.
    "host_terms_present": r"host (?:density|abundance|cover)|pine cover|percent pine|basal area|"
                  r"stand density|host availability|susceptib",
    "terrain_terms": r"elevation|topograph|aspect|slope",
}

def full_text(p):
    import pypdf
    with contextlib.redirect_stderr(io.StringIO()):
        r = pypdf.PdfReader(str(p))
        t = norm(" ".join((pg.extract_text() or "") for pg in r.pages))
    return re.sub(r"\s+", " ", t), len(r.pages)

def main():
    man = [r for r in csv.DictReader(open(STORE / "library" / "manifest.csv"))
           if r["status"] != "duplicate"]
    def blob(r):
        return f"{r['title']} {r['original_filename']}".lower()
    cand = [r for r in man if any(k in blob(r) for k in TOPIC)]
    out = []
    for r in sorted(cand, key=lambda r: (str(r["year"]), r["key"])):
        key = r["key"] or ""
        ident = key or r["original_filename"]
        inc = key in INCLUDE or any(u.lower() in ident.lower() for u in INCLUDE_UNVERIFIED)
        reason = ""
        if not inc:
            b = blob(r)
            for rx, why in EXCLUDE_RULES:
                if re.search(rx, b):
                    reason = why
                    break
            if not reason:
                reason = "not a spatial model of bark beetle attack"
        row = {
            "key": key, "year": r["year"], "status": r["status"],
            "title": r["title"] or r["original_filename"].replace(".pdf", ""),
            "stage2_include": "yes" if inc else "no", "exclude_reason": reason,
            "wind_predictor": "", "wind_mentions": "", "host_terms_present": "",
            "terrain_terms": "", "n_pages": "", "grain_m": "not extracted",
            "extent": "not extracted", "full_text_checked": "no",
            "original_filename": r["original_filename"],
        }
        if inc:
            p = STORE / "library" / "pdf" / r["original_filename"]
            if p.exists():
                try:
                    txt, npg = full_text(p)
                    for k, rx in PROBE.items():
                        row[k] = "yes" if re.search(rx, txt, re.I) else "no"
                    # exclude window / windthrow / Windows from the count
                    row["wind_mentions"] = len(re.findall(r"\bwind(?!ow|s\b|throw)", txt, re.I))
                    row["n_pages"] = npg
                    row["full_text_checked"] = "yes"
                except Exception as e:
                    row["exclude_reason"] = f"full text unreadable: {type(e).__name__}"
            else:
                row["exclude_reason"] = "PDF not in store"
        out.append(row)
    cols = list(out[0].keys())
    with open(OUT, "w", newline="") as fh:
        w = csv.DictWriter(fh, fieldnames=cols)
        w.writeheader()
        w.writerows(out)
    inc = [r for r in out if r["stage2_include"] == "yes"]
    print(f"screened {len(out)} candidates; {len(inc)} included; "
          f"{sum(1 for r in inc if r['full_text_checked']=='yes')} full-text checked")
    print("  with a wind predictor:",
          sum(1 for r in inc if r["wind_predictor"] == "yes"))
    print("  host terms present   :",
          sum(1 for r in inc if r["host_terms_present"] == "yes"))

if __name__ == "__main__":
    main()
