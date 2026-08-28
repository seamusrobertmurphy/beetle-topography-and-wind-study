#!/usr/bin/env python3
"""Pull water bodies around the study perimeter, for the manuscript's base maps.

Why this exists. The maps in the manuscript showed a raster clipped to the study
perimeter and nothing else. The perimeter is the 2015 burn buffered 5 km and then
cut to the parent study's elevation band, so its edge is ragged, and with no
surrounding feature on the page that raggedness reads as a rendering fault rather
than as a study boundary. A reader cannot place the site. Kootenay Lake is the one
landmark that fixes this stretch of the Selkirks at a glance, so it is fetched here
and drawn under every map.

Source is the BC Freshwater Atlas through the same WFS the VRI comes from, so the
provenance of the base map is the provincial catalogue rather than a screenshot.
Paging, the quoted CRS literal inside BBOX and the explicit sortBy are all required
for the same reasons 34-fetch-vri.py documents.

Writes:
  study-area/basemap_water.geojson   lakes and river polygons, EPSG:3153

Run:  python3 02.inputs/beetle-classification/46-fetch-basemap.py
"""
import json, sys, urllib.parse, urllib.request

ROOT = "02.inputs/beetle-classification"
OUT = f"{ROOT}/study-area/basemap_water.geojson"

# The perimeter bbox, buffered so the map can show ground beyond the study area.
# 30 km each way reaches Kootenay Lake to the west and the Duncan arm to the north
# without pulling in half the province.
BUFFER_M = 30_000
x0, y0, x1, y1 = (float(v) for v in
                  open(f"{ROOT}/study-area/perimeter_bbox_3005.txt").read().strip().split(","))
BBOX = f"{x0-BUFFER_M},{y0-BUFFER_M},{x1+BUFFER_M},{y1+BUFFER_M}"

LAYERS = [
    ("WHSE_BASEMAPPING.FWA_LAKES_POLY", "WATERBODY_POLY_ID", "lake"),
    ("WHSE_BASEMAPPING.FWA_RIVERS_POLY", "WATERBODY_POLY_ID", "river"),
]
PAGE = 1000


def fetch(layer, key):
    feats, start = [], 0
    while True:
        q = urllib.parse.urlencode({
            "service": "WFS", "version": "2.0.0", "request": "GetFeature",
            "typeName": layer, "outputFormat": "application/json",
            "srsName": "EPSG:3153", "count": str(PAGE), "startIndex": str(start),
            "sortBy": key,
            "CQL_FILTER": f"BBOX(GEOMETRY,{BBOX},'EPSG:3153')"})
        with urllib.request.urlopen("https://openmaps.gov.bc.ca/geo/pub/"
                                    f"{layer}/ows?" + q, timeout=180) as r:
            got = json.load(r).get("features", [])
        feats += got
        print(f"  {layer}: {len(feats)} features", flush=True)
        if len(got) < PAGE:
            return feats
        start += PAGE


out = []
for layer, key, kind in LAYERS:
    for f in fetch(layer, key):
        # Only the name and the area are kept. Everything else on an FWA polygon is
        # hydrological bookkeeping the map does not draw.
        props = f.get("properties", {})
        out.append({"type": "Feature", "geometry": f["geometry"],
                    "properties": {"kind": kind,
                                   "name": props.get("GNIS_NAME_1"),
                                   "area_ha": props.get("AREA_HA")}})

if not out:
    sys.exit("no water features returned; the request or the bbox is wrong")

with open(OUT, "w") as fh:
    json.dump({"type": "FeatureCollection",
               "crs": {"type": "name",
                       "properties": {"name": "urn:ogc:def:crs:EPSG::3153"}},
               "features": out}, fh)
print(f"wrote {OUT}: {len(out)} features")
