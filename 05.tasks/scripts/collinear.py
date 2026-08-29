import rasterio, numpy as np, os
from rasterio.warp import reproject, Resampling
from scipy import stats as st
os.chdir('/Users/seamus/repos/publications-pending/Darkwoods-Disturbance-Paper/3.SpatialData')
ref = rasterio.open('beetle_stages/Beetle.Outbreak.RedStage.tif'); H,W = ref.shape

years=[2005,2006,2007,2008,2009,2010,2011]
red={}
for y in years:
    p=f'beetle_stages/Beetle.Outbreak.{y}.tif'
    if not os.path.exists(p): p=f'beetle_stages/Beetle.Oubteak.{y}.tif'
    with rasterio.open(p) as s: red[y]=(s.read(1)==44)
stack=np.stack([red[y] for y in years]); union=stack.any(0); count=stack.sum(0)

def grid(path):
    dst=np.full((H,W),np.nan,'float32')
    with rasterio.open(path) as s:
        src=s.read(1).astype('float32')
        if s.nodata is not None: src[src==s.nodata]=np.nan
        reproject(src,dst,src_transform=s.transform,src_crs=s.crs,
                  dst_transform=ref.transform,dst_crs=ref.crs,
                  resampling=Resampling.bilinear,src_nodata=np.nan,dst_nodata=np.nan)
    return dst
names=['Elevation','Slope','RIX','Wind','TWI']
paths=['terrain_environment/Elevation.utm.tif','terrain_environment/Slope.utm.tif',
       'terrain_environment/Rutm.tif','terrain_environment/Wind.utm.tif','terrain_environment/TWI.utm.tif']
T={n:grid(p) for n,p in zip(names,paths)}

print("=== PREDICTOR CROSS-CORRELATION (Pearson, all cells) ===")
flat={n:v.ravel() for n,v in T.items()}
print("            "+"".join(f"{n:>11s}" for n in names))
for a in names:
    row=f"  {a:10s}"
    for b in names:
        row+=f"{np.corrcoef(flat[a],flat[b])[0,1]:+11.3f}"
    print(row)

# multivariable logistic regression, standardised
X=np.column_stack([ (T[n].ravel()-T[n].mean())/T[n].std() for n in names ])
y=union.ravel().astype(float)
import numpy.linalg as la
def logit(X,y,iters=60):
    Xb=np.column_stack([np.ones(len(X)),X]); b=np.zeros(Xb.shape[1])
    for _ in range(iters):
        p=1/(1+np.exp(-Xb@b)); p=np.clip(p,1e-9,1-1e-9)
        Wd=p*(1-p); g=Xb.T@(y-p); Hm=-(Xb.T*Wd)@Xb
        b-=la.solve(Hm,g)
    p=1/(1+np.exp(-Xb@b)); p=np.clip(p,1e-9,1-1e-9)
    se=np.sqrt(np.diag(la.inv((Xb.T*(p*(1-p)))@Xb)))
    return b,se
b,se=logit(X,y)
print("\n=== MULTIVARIABLE LOGISTIC: P(red-attack) ~ standardised terrain ===")
print("  (naive SEs: spatial autocorrelation NOT accounted for)")
print(f"  {'term':12s} {'beta':>8s} {'OR/sd':>8s} {'z':>8s}")
for n,bb,ss in zip(['(int)']+names,b,se):
    print(f"  {n:12s} {bb:+8.3f} {np.exp(bb):8.3f} {bb/ss:+8.1f}")

print("\n=== PARTIAL SPEARMAN: wind vs attack, controlling elevation ===")
def partial(x,y,z):
    rx=x-np.polyval(np.polyfit(z,x,1),z); ry=y-np.polyval(np.polyfit(z,y,1),z)
    return st.spearmanr(rx,ry)
v=np.isfinite(T['Wind'].ravel())
r,p=partial(T['Wind'].ravel()[v], y[v], T['Elevation'].ravel()[v])
print(f"  wind~attack | elevation : rho={r:+.3f} p={p:.2e}")
r,p=partial(T['RIX'].ravel()[v], y[v], T['Elevation'].ravel()[v])
print(f"  RIX ~attack | elevation : rho={r:+.3f} p={p:.2e}")
r,p=st.spearmanr(T['Wind'].ravel()[v], T['Elevation'].ravel()[v])
print(f"  wind~elevation          : rho={r:+.3f}")

print("\n=== SURVEY-YEAR AUDIT: what is in 2008 and 2010? ===")
for y_ in years:
    p=f'beetle_stages/Beetle.Outbreak.{y_}.tif'
    if not os.path.exists(p): p=f'beetle_stages/Beetle.Oubteak.{y_}.tif'
    with rasterio.open(p) as s:
        a=s.read(1); vals,cts=np.unique(a,return_counts=True)
        print(f"  {y_}: {dict(zip(vals.tolist(),cts.tolist()))}")
