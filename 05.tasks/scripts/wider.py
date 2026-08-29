import rasterio, numpy as np, os
from rasterio.warp import reproject, Resampling
os.chdir('/Users/seamus/repos/publications-pending/Darkwoods-Disturbance-Paper/3.SpatialData')
# use the DEM extent (16 x 17.5 km, whole Darkwoods) as reference
ref = rasterio.open('terrain_environment/Elevation.utm.tif'); H,W=ref.shape
def grid(path):
    dst=np.full((H,W),np.nan,'float32')
    with rasterio.open(path) as s:
        src=s.read(1).astype('float32')
        if s.nodata is not None: src[src==s.nodata]=np.nan
        reproject(src,dst,src_transform=s.transform,src_crs=s.crs,
                  dst_transform=ref.transform,dst_crs=ref.crs,
                  resampling=Resampling.bilinear,src_nodata=np.nan,dst_nodata=np.nan)
    return dst
elev=ref.read(1).astype('float32'); elev[elev==ref.nodata]=np.nan
wind=grid('terrain_environment/Wind.utm.tif')
rix =grid('terrain_environment/Rutm.tif')
slope=grid('terrain_environment/Slope.utm.tif')
v=np.isfinite(elev)&np.isfinite(wind)&np.isfinite(rix)&np.isfinite(slope)
print(f"cells over full Darkwoods DEM extent: {int(v.sum())}")
print(f"  corr(wind, elevation) = {np.corrcoef(wind[v],elev[v])[0,1]:+.3f}")
print(f"  corr(RIX , elevation) = {np.corrcoef(rix[v],elev[v])[0,1]:+.3f}")
print(f"  corr(RIX , slope    ) = {np.corrcoef(rix[v],slope[v])[0,1]:+.3f}")
print(f"  corr(RIX , wind     ) = {np.corrcoef(rix[v],wind[v])[0,1]:+.3f}")
# linear fit wind ~ elevation, how much variance is elevation?
A=np.polyfit(elev[v],wind[v],1); pred=np.polyval(A,elev[v])
r2=1-np.sum((wind[v]-pred)**2)/np.sum((wind[v]-wind[v].mean())**2)
print(f"  wind = {A[0]:.5f}*elev + {A[1]:.3f}   R2 = {r2:.3f}")
resid=wind[v]-pred
print(f"  residual wind sd = {resid.std():.3f} m/s  (raw wind sd = {wind[v].std():.3f})")

# spatial autocorrelation of the beetle response: Moran's I via lag-1 rook
b=rasterio.open('beetle_stages/Beetle.Outbreak.RedStage.tif')
years=[2005,2006,2007,2008,2009,2010,2011]; st_=[]
for y in years:
    p=f'beetle_stages/Beetle.Outbreak.{y}.tif'
    if not os.path.exists(p): p=f'beetle_stages/Beetle.Oubteak.{y}.tif'
    with rasterio.open(p) as s: st_.append(s.read(1)==44)
u=np.stack(st_).any(0).astype(float)
z=u-u.mean()
num=(z[:-1,:]*z[1:,:]).sum()+(z[:,:-1]*z[:,1:]).sum()
n_pairs=z[:-1,:].size+z[:,:-1].size
I=(z.size/ (2*n_pairs)) * (2*num)/ (z**2).sum()
print(f"\n  Moran's I (rook lag-1) of red-attack union = {I:.3f}")
print(f"  -> strong clustering; naive n=8910 is a large over-count of independent units")
