import sys, re, json, zipfile
from lxml import etree
W = "http://schemas.openxmlformats.org/wordprocessingml/2006/main"; w = lambda t: f"{{{W}}}{t}"
def cellspec(tc):
    tcPr = tc.find(w("tcPr")); va = tcPr.find(w("vAlign")) if tcPr is not None else None
    p = tc.find(w("p")); pPr = p.find(w("pPr")) if p is not None else None
    jc = pPr.find(w("jc")) if pPr is not None else None
    sz = None; bold = False
    for r in (p.findall(w("r")) if p is not None else []):
        rPr = r.find(w("rPr"))
        if rPr is not None:
            s = rPr.find(w("sz")); sz = int(s.get(w("val"))) if s is not None else sz
            bold = bold or rPr.find(w("b")) is not None
    return {"vAlign": va.get(w("val")) if va is not None else None, "jc": jc.get(w("val")) if jc is not None else None, "sz": sz, "bold": bold}
def capture(path):
    root = etree.fromstring(zipfile.ZipFile(path).read("word/document.xml"))
    out = {}
    for tbl in root.iter(w("tbl")):
        if tbl.find(f".//{w('tbl')}") is not None or tbl.find(f".//{w('drawing')}") is not None: continue
        if len(tbl.findall(f".//{w('tc')}")) < 2: continue
        outer = next(tbl.iterancestors(w("tbl")), None); cap = ""
        if outer is not None:
            for para in outer.iter(w("p")):
                if tbl in para.iterancestors(): continue
                t = "".join(x.text or "" for x in para.iter(w("t"))).strip()
                if re.match(r"Table[\s ]\d+", t): cap = t; break
        m = re.match(r"Table[\s ](\d+)", cap); num = int(m.group(1)) if m else None
        tblPr = tbl.find(w("tblPr")); tblW = tblPr.find(w("tblW"))
        grid = [int(c.get(w("w"))) for c in tbl.find(w("tblGrid")).findall(w("gridCol"))]
        rows = tbl.findall(w("tr"))
        def rh(tr):
            trPr = tr.find(w("trPr")); h = trPr.find(w("trHeight")) if trPr is not None else None
            return {"val": int(h.get(w("val"))), "hRule": h.get(w("hRule")) or "auto"} if h is not None else None
        spec = {"table": num, "caption_key": re.sub(r"^Table[\s ]\d+[:.]?\s*", "", cap)[:60], "cols": len(grid),
                "tblW": int(tblW.get(w("w"))) if tblW is not None else sum(grid), "grid": grid,
                "header_height": rh(rows[0]), "body_height": rh(rows[1]) if len(rows) > 1 else None,
                "header_cells": [cellspec(tc) for tc in rows[0].findall(w("tc"))],
                "body_cells": [cellspec(tc) for tc in rows[1].findall(w("tc"))] if len(rows) > 1 else []}
        out.setdefault(num, []).append(spec)
    return out
if __name__ == "__main__":
    out = capture(sys.argv[1])
    for num, specs in sorted(out.items(), key=lambda kv: (kv[0] is None, kv[0] or 0)):
        for s in specs:
            print(num, s["cols"], s["tblW"], s["grid"], "hdr", s["header_height"], "body", s["body_height"], "| hdr0", s["header_cells"][0], "| body0", s["body_cells"][0] if s["body_cells"] else None, "| body1", s["body_cells"][1] if len(s["body_cells"])>1 else None, "|", s["caption_key"][:40])
    json.dump(out, open(sys.argv[2], "w"), indent=1)
