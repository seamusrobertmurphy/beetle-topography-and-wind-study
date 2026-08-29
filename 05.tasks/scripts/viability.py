import rasterio, numpy as np
from rasterio.warp import reproject, Resampling
import os
os.chdir('/Users/seamus/repos/publications-pending/Darkwoods-Disturbance-Paper/3.SpatialData')

# reference grid = beetle raster
ref = rasterio.open('beetle_stages/Beetle.Outbreak.RedStage.tif')
H,W = ref.shape

years = [2005,2006,2007,2008,2009,2010,2011]
red = {}
for y in years:
    p = f'beetle_stages/Beetle.Outbreak.{y}.tif'
    if not os.path.exists(p):
        p = f'beetle_stages/Beetle.Oubteak.{y}.tif'   # 2005 typo
    with rasterio.open(p) as s:
        a = s.read(1)
        red[y] = (a == 44)

stack = np.stack([red[y] for y in years])
union = stack.any(axis=0)
count = stack.sum(axis=0)
print("=== GREY-STAGE UNION CHECK (AOS code 44, 2005-2011) ===")
print(f"  union cells      : {int(union.sum())}")
print(f"  attack-count dist: {dict(zip(*[x.tolist() for x in np.unique(count,return_counts=True)]))}")
for y in years:
    print(f"    {y}: {int(red[y].sum()):5d} red-attack cells")

# onset year (first year attacked)
onset = np.full((H,W), 0, dtype=np.int16)
for y in reversed(years):
    onset[red[y]] = y

# resample terrain onto beetle grid
def grid(path):
    dst = np.full((H,W), np.nan, dtype='float32')
    with rasterio.open(path) as s:
        src = s.read(1).astype('float32')
        if s.nodata is not None:
            src[src == s.nodata] = np.nan
        reproject(src, dst, src_transform=s.transform, src_crs=s.crs,
                  dst_transform=ref.transform, dst_crs=ref.crs,
                  resampling=Resampling.bilinear, src_nodata=np.nan, dst_nodata=np.nan)
    return dst

terr = {n: grid(p) for n,p in [
    ('Elevation','terrain_environment/Elevation.utm.tif'),
    ('Slope','terrain_environment/Slope.utm.tif'),
    ('RIX','terrain_environment/Rutm.tif'),
    ('Wind','terrain_environment/Wind.utm.tif'),
    ('TWI','terrain_environment/TWI.utm.tif'),
    ('Aspect','terrain_environment/Aspect.utm.tif')]}

valid = np.ones((H,W), bool)
for v in terr.values():
    valid &= np.isfinite(v)
print(f"\n  cells with complete terrain: {int(valid.sum())} of {H*W}")

from scipy import stats as st
print("\n=== TERRAIN AT ATTACKED vs UNATTACKED (union) ===")
att = valid & union
un  = valid & ~union
print(f"  attacked n={int(att.sum())}   unattacked n={int(un.sum())}")
print(f"  {'var':10s} {'attacked':>18s} {'unattacked':>18s} {'MWU p':>12s} {'CliffDelta':>11s}")
for n,v in terr.items():
    a,b = v[att], v[un]
    u,p = st.mannwhitneyu(a,b,alternative='two-sided')
    delta = 2*u/(len(a)*len(b)) - 1
    print(f"  {n:10s} {a.mean():9.2f}±{a.std():6.2f} {b.mean():9.2f}±{b.std():6.2f} {p:12.3e} {delta:11.3f}")

print("\n=== TERRAIN vs REPEAT-ATTACK COUNT (Spearman, attacked cells only) ===")
for n,v in terr.items():
    a = v[att]; c = count[att].astype(float)
    r,p = st.spearmanr(a,c)
    print(f"  {n:10s} rho={r:+.3f}  p={p:.3e}")

print("\n=== TERRAIN vs ONSET YEAR (Spearman, attacked cells only) ===")
for n,v in terr.items():
    a = v[att]; o = onset[att].astype(float)
    r,p = st.spearmanr(a,o)
    print(f"  {n:10s} rho={r:+.3f}  p={p:.3e}")
