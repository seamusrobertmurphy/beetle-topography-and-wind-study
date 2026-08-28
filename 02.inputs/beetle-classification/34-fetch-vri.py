#!/usr/bin/env python3
"""Pull the Vegetation Resources Inventory over the Darkwoods perimeter.

Why this exists. The refugia hypothesis as Krawchuk et al. (2020) state it runs
through stand density: refugia occur "in areas with lower host density, allowing
for greater wind disruption of beetle pheromone communication". Cartwright (2018)
fits that and finds total basal area the strongest single predictor of refugium
occurrence. Powell and Bentz (2014) state the same relation from the other side:
"higher local host density, which minimizes pheromone plume dispersion, reduces
wind, and promotes successful switching to nearby hosts". None of those variables
was in this study's covariate set, which carried species cover from Beaudoin kNN
and no measure of how dense the stand is.

The cached extract at 02.inputs/vri/vri_darkwoods.geojson covers only 15.3 per cent
of the conservation area, so it is re-pulled here over the perimeter that
33-study-perimeter.R writes.

WFS 2.0.0 caps a response, so the request is paged on startIndex. Two things the
service insists on: the CRS inside the BBOX filter must be a quoted string literal
or the CQL parser rejects it, and paging needs an explicit sortBy, because the
layer has no primary key and the server refuses to order it ("Cannot do natural
order without a primary key, please add it or specify a sortBy").
"""
import json, sys, time, urllib.parse, urllib.request

ROOT = "02.inputs/beetle-classification"
BBOX = open(f"{ROOT}/study-area/perimeter_bbox_3005.txt").read().strip()
OUT = f"{ROOT}/study-area/vri_perimeter.geojson"
URL = ("https://openmaps.gov.bc.ca/geo/pub/"
       "WHSE_FOREST_VEGETATION.VEG_COMP_LYR_R1_POLY/ows?")

# Everything the two pathways need, and nothing else: the response is otherwise
# ~200 fields per polygon. Density and size for the pheromone-disruption pathway,
# species for host, BEC for the climatic control, age and height as stand context.
FIELDS = ["FEATURE_ID", "BASAL_AREA", "CROWN_CLOSURE", "VRI_LIVE_STEMS_PER_HA",
          "QUAD_DIAM_125", "PROJ_AGE_1", "PROJ_HEIGHT_1", "LIVE_STAND_VOLUME_125",
          "SPECIES_CD_1", "SPECIES_PCT_1", "SPECIES_CD_2", "SPECIES_PCT_2",
          "SPECIES_CD_3", "SPECIES_PCT_3", "BEC_ZONE_CODE", "BEC_SUBZONE",
          "BCLCS_LEVEL_4", "PROJECTED_DATE", "REFERENCE_YEAR"]
PAGE = 1000

def page(start):
    q = urllib.parse.urlencode({
        "service": "WFS", "version": "2.0.0", "request": "GetFeature",
        "typeName": "WHSE_FOREST_VEGETATION.VEG_COMP_LYR_R1_POLY",
        "outputFormat": "application/json", "srsName": "EPSG:3005",
        "count": str(PAGE), "startIndex": str(start), "sortBy": "FEATURE_ID",
        "propertyName": ",".join(FIELDS) + ",GEOMETRY",
        "CQL_FILTER": f"BBOX(GEOMETRY,{BBOX},'EPSG:3005')"})
    for attempt in range(4):
        try:
            with urllib.request.urlopen(URL + q, timeout=300) as r:
                return json.load(r)
        except Exception as e:
            print(f"  retry {attempt+1} after {type(e).__name__}", file=sys.stderr)
            time.sleep(5 * (attempt + 1))
    raise SystemExit(f"failed at startIndex {start}")

feats, start = [], 0
while True:
    d = page(start)
    got = d.get("features", [])
    feats.extend(got)
    print(f"startIndex {start:6d}  +{len(got):5d}  total {len(feats)}")
    if len(got) < PAGE:
        break
    start += PAGE

json.dump({"type": "FeatureCollection",
           "crs": {"type": "name",
                   "properties": {"name": "urn:ogc:def:crs:EPSG::3005"}},
           "features": feats}, open(OUT, "w"))
print(f"wrote {OUT}: {len(feats)} polygons")

miss = {f: sum(1 for x in feats if x["properties"].get(f) in (None, ""))
        for f in FIELDS}
print("\nmissing per field, of %d polygons:" % len(feats))
for f in FIELDS:
    print(f"  {f:26s} {miss[f]:6d}  {100*miss[f]/len(feats):5.1f}%")
