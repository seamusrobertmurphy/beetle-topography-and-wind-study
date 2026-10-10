set -e
r.in.gdal input='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/study-area/dem_context.tif' output=dem --q --o
g.region raster=dem
r.slope.aspect elevation=dem slope=slope aspect=aspect --q --o
r.latlong input=dem output=lon -l --q --o
r.horizon elevation=dem step=22.5 output=hor --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=152 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=152 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_152_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_152_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=152 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=152 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_152_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_152_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=152 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=152 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_152_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_152_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=152 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=152 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_152_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_152_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=152 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=152 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_152_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_152_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=153 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=153 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_153_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_153_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=153 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=153 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_153_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_153_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=153 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=153 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_153_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_153_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=153 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=153 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_153_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_153_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=153 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=153 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_153_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_153_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=154 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=154 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_154_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_154_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=154 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=154 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_154_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_154_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=154 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=154 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_154_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_154_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=154 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=154 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_154_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_154_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=154 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=154 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_154_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_154_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=155 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=155 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_155_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_155_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=155 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=155 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_155_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_155_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=155 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=155 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_155_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_155_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=155 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=155 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_155_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_155_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=155 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=155 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_155_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_155_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=156 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=156 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_156_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_156_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=156 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=156 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_156_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_156_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=156 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=156 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_156_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_156_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=156 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=156 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_156_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_156_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=156 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=156 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_156_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_156_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=157 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=157 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_157_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_157_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=157 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=157 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_157_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_157_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=157 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=157 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_157_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_157_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=157 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=157 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_157_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_157_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=157 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=157 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_157_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_157_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=158 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=158 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_158_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_158_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=158 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=158 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_158_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_158_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=158 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=158 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_158_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_158_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=158 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=158 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_158_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_158_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=158 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=158 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_158_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_158_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=159 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=159 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_159_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_159_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=159 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=159 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_159_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_159_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=159 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=159 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_159_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_159_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=159 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=159 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_159_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_159_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=159 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=159 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_159_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_159_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=160 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=160 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_160_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_160_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=160 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=160 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_160_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_160_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=160 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=160 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_160_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_160_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=160 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=160 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_160_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_160_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=160 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=160 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_160_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_160_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=161 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=161 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_161_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_161_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=161 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=161 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_161_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_161_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=161 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=161 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_161_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_161_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=161 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=161 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_161_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_161_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=161 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=161 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_161_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_161_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=162 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=162 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_162_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_162_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=162 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=162 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_162_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_162_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=162 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=162 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_162_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_162_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=162 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=162 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_162_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_162_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=162 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=162 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_162_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_162_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=163 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=163 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_163_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_163_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=163 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=163 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_163_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_163_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=163 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=163 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_163_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_163_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=163 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=163 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_163_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_163_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=163 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=163 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_163_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_163_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=164 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=164 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_164_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_164_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=164 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=164 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_164_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_164_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=164 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=164 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_164_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_164_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=164 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=164 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_164_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_164_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=164 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=164 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_164_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_164_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=165 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=165 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_165_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_165_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=165 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=165 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_165_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_165_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=165 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=165 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_165_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_165_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=165 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=165 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_165_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_165_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=165 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=165 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_165_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_165_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=166 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=166 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_166_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_166_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=166 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=166 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_166_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_166_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=166 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=166 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_166_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_166_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=166 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=166 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_166_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_166_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=166 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=166 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_166_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_166_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=167 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=167 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_167_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_167_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=167 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=167 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_167_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_167_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=167 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=167 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_167_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_167_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=167 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=167 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_167_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_167_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=167 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=167 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_167_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_167_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=168 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=168 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_168_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_168_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=168 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=168 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_168_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_168_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=168 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=168 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_168_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_168_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=168 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=168 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_168_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_168_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=168 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=168 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_168_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_168_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=169 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=169 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_169_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_169_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=169 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=169 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_169_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_169_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=169 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=169 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_169_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_169_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=169 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=169 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_169_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_169_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=169 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=169 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_169_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_169_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=170 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=170 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_170_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_170_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=170 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=170 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_170_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_170_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=170 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=170 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_170_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_170_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=170 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=170 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_170_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_170_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=170 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=170 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_170_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_170_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=171 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=171 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_171_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_171_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=171 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=171 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_171_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_171_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=171 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=171 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_171_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_171_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=171 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=171 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_171_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_171_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=171 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=171 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_171_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_171_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=172 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=172 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_172_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_172_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=172 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=172 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_172_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_172_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=172 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=172 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_172_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_172_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=172 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=172 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_172_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_172_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=172 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=172 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_172_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_172_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=173 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=173 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_173_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_173_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=173 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=173 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_173_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_173_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=173 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=173 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_173_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_173_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=173 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=173 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_173_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_173_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=173 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=173 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_173_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_173_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=174 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=174 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_174_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_174_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=174 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=174 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_174_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_174_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=174 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=174 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_174_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_174_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=174 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=174 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_174_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_174_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=174 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=174 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_174_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_174_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=175 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=175 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_175_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_175_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=175 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=175 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_175_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_175_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=175 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=175 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_175_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_175_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=175 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=175 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_175_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_175_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=175 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=175 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_175_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_175_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=176 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=176 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_176_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_176_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=176 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=176 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_176_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_176_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=176 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=176 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_176_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_176_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=176 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=176 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_176_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_176_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=176 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=176 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_176_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_176_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=177 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=177 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_177_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_177_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=177 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=177 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_177_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_177_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=177 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=177 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_177_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_177_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=177 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=177 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_177_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_177_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=177 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=177 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_177_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_177_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=178 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=178 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_178_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_178_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=178 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=178 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_178_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_178_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=178 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=178 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_178_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_178_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=178 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=178 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_178_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_178_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=178 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=178 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_178_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_178_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=179 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=179 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_179_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_179_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=179 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=179 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_179_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_179_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=179 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=179 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_179_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_179_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=179 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=179 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_179_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_179_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=179 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=179 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_179_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_179_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=180 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=180 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_180_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_180_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=180 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=180 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_180_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_180_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=180 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=180 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_180_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_180_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=180 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=180 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_180_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_180_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=180 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=180 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_180_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_180_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=181 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=181 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_181_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_181_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=181 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=181 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_181_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_181_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=181 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=181 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_181_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_181_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=181 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=181 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_181_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_181_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=181 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=181 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_181_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_181_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=182 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=182 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_182_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_182_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=182 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=182 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_182_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_182_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=182 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=182 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_182_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_182_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=182 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=182 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_182_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_182_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=182 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=182 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_182_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_182_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=183 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=183 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_183_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_183_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=183 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=183 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_183_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_183_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=183 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=183 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_183_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_183_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=183 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=183 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_183_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_183_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=183 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=183 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_183_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_183_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=184 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=184 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_184_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_184_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=184 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=184 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_184_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_184_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=184 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=184 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_184_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_184_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=184 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=184 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_184_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_184_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=184 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=184 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_184_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_184_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=185 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=185 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_185_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_185_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=185 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=185 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_185_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_185_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=185 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=185 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_185_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_185_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=185 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=185 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_185_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_185_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=185 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=185 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_185_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_185_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=186 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=186 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_186_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_186_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=186 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=186 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_186_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_186_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=186 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=186 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_186_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_186_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=186 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=186 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_186_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_186_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=186 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=186 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_186_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_186_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=187 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=187 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_187_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_187_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=187 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=187 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_187_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_187_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=187 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=187 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_187_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_187_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=187 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=187 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_187_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_187_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=187 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=187 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_187_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_187_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=188 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=188 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_188_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_188_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=188 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=188 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_188_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_188_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=188 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=188 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_188_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_188_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=188 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=188 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_188_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_188_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=188 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=188 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_188_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_188_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=189 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=189 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_189_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_189_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=189 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=189 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_189_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_189_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=189 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=189 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_189_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_189_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=189 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=189 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_189_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_189_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=189 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=189 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_189_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_189_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=190 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=190 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_190_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_190_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=190 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=190 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_190_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_190_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=190 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=190 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_190_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_190_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=190 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=190 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_190_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_190_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=190 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=190 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_190_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_190_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=191 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=191 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_191_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_191_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=191 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=191 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_191_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_191_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=191 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=191 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_191_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_191_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=191 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=191 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_191_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_191_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=191 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=191 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_191_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_191_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=192 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=192 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_192_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_192_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=192 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=192 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_192_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_192_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=192 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=192 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_192_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_192_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=192 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=192 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_192_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_192_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=192 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=192 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_192_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_192_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=193 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=193 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_193_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_193_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=193 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=193 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_193_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_193_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=193 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=193 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_193_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_193_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=193 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=193 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_193_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_193_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=193 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=193 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_193_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_193_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=194 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=194 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_194_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_194_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=194 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=194 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_194_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_194_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=194 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=194 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_194_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_194_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=194 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=194 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_194_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_194_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=194 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=194 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_194_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_194_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=195 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=195 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_195_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_195_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=195 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=195 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_195_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_195_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=195 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=195 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_195_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_195_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=195 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=195 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_195_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_195_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=195 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=195 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_195_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_195_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=196 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=196 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_196_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_196_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=196 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=196 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_196_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_196_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=196 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=196 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_196_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_196_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=196 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=196 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_196_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_196_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=196 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=196 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_196_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_196_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=197 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=197 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_197_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_197_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=197 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=197 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_197_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_197_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=197 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=197 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_197_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_197_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=197 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=197 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_197_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_197_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=197 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=197 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_197_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_197_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=198 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=198 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_198_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_198_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=198 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=198 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_198_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_198_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=198 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=198 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_198_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_198_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=198 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=198 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_198_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_198_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=198 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=198 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_198_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_198_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=199 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=199 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_199_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_199_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=199 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=199 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_199_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_199_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=199 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=199 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_199_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_199_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=199 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=199 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_199_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_199_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=199 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=199 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_199_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_199_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=200 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=200 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_200_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_200_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=200 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=200 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_200_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_200_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=200 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=200 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_200_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_200_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=200 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=200 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_200_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_200_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=200 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=200 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_200_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_200_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=201 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=201 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_201_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_201_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=201 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=201 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_201_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_201_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=201 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=201 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_201_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_201_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=201 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=201 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_201_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_201_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=201 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=201 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_201_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_201_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=202 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=202 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_202_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_202_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=202 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=202 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_202_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_202_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=202 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=202 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_202_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_202_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=202 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=202 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_202_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_202_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=202 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=202 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_202_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_202_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=203 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=203 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_203_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_203_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=203 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=203 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_203_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_203_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=203 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=203 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_203_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_203_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=203 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=203 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_203_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_203_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=203 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=203 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_203_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_203_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=204 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=204 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_204_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_204_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=204 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=204 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_204_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_204_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=204 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=204 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_204_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_204_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=204 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=204 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_204_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_204_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=204 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=204 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_204_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_204_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=205 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=205 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_205_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_205_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=205 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=205 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_205_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_205_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=205 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=205 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_205_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_205_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=205 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=205 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_205_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_205_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=205 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=205 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_205_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_205_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=206 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=206 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_206_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_206_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=206 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=206 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_206_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_206_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=206 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=206 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_206_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_206_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=206 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=206 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_206_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_206_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=206 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=206 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_206_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_206_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=207 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=207 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_207_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_207_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=207 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=207 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_207_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_207_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=207 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=207 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_207_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_207_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=207 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=207 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_207_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_207_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=207 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=207 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_207_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_207_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=208 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=208 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_208_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_208_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=208 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=208 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_208_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_208_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=208 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=208 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_208_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_208_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=208 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=208 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_208_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_208_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=208 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=208 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_208_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_208_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=209 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=209 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_209_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_209_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=209 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=209 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_209_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_209_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=209 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=209 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_209_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_209_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=209 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=209 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_209_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_209_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=209 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=209 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_209_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_209_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=210 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=210 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_210_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_210_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=210 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=210 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_210_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_210_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=210 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=210 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_210_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_210_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=210 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=210 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_210_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_210_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=210 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=210 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_210_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_210_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=211 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=211 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_211_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_211_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=211 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=211 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_211_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_211_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=211 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=211 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_211_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_211_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=211 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=211 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_211_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_211_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=211 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=211 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_211_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_211_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=212 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=212 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_212_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_212_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=212 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=212 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_212_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_212_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=212 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=212 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_212_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_212_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=212 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=212 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_212_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_212_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=212 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=212 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_212_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_212_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=213 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=213 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_213_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_213_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=213 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=213 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_213_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_213_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=213 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=213 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_213_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_213_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=213 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=213 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_213_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_213_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=213 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=213 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_213_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_213_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=214 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=214 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_214_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_214_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=214 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=214 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_214_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_214_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=214 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=214 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_214_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_214_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=214 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=214 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_214_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_214_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=214 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=214 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_214_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_214_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=215 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=215 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_215_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_215_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=215 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=215 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_215_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_215_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=215 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=215 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_215_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_215_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=215 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=215 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_215_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_215_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=215 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=215 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_215_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_215_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=216 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=216 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_216_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_216_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=216 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=216 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_216_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_216_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=216 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=216 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_216_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_216_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=216 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=216 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_216_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_216_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=216 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=216 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_216_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_216_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=217 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=217 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_217_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_217_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=217 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=217 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_217_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_217_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=217 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=217 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_217_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_217_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=217 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=217 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_217_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_217_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=217 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=217 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_217_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_217_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=218 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=218 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_218_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_218_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=218 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=218 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_218_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_218_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=218 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=218 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_218_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_218_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=218 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=218 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_218_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_218_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=218 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=218 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_218_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_218_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=219 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=219 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_219_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_219_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=219 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=219 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_219_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_219_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=219 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=219 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_219_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_219_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=219 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=219 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_219_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_219_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=219 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=219 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_219_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_219_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=220 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=220 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_220_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_220_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=220 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=220 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_220_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_220_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=220 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=220 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_220_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_220_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=220 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=220 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_220_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_220_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=220 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=220 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_220_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_220_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=221 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=221 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_221_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_221_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=221 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=221 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_221_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_221_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=221 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=221 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_221_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_221_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=221 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=221 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_221_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_221_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=221 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=221 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_221_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_221_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=222 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=222 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_222_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_222_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=222 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=222 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_222_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_222_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=222 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=222 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_222_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_222_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=222 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=222 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_222_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_222_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=222 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=222 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_222_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_222_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=223 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=223 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_223_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_223_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=223 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=223 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_223_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_223_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=223 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=223 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_223_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_223_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=223 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=223 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_223_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_223_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=223 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=223 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_223_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_223_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=224 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=224 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_224_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_224_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=224 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=224 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_224_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_224_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=224 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=224 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_224_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_224_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=224 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=224 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_224_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_224_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=224 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=224 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_224_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_224_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=225 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=225 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_225_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_225_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=225 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=225 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_225_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_225_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=225 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=225 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_225_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_225_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=225 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=225 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_225_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_225_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=225 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=225 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_225_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_225_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=226 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=226 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_226_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_226_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=226 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=226 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_226_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_226_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=226 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=226 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_226_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_226_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=226 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=226 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_226_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_226_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=226 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=226 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_226_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_226_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=227 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=227 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_227_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_227_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=227 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=227 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_227_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_227_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=227 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=227 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_227_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_227_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=227 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=227 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_227_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_227_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=227 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=227 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_227_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_227_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=228 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=228 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_228_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_228_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=228 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=228 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_228_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_228_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=228 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=228 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_228_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_228_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=228 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=228 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_228_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_228_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=228 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=228 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_228_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_228_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=229 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=229 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_229_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_229_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=229 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=229 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_229_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_229_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=229 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=229 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_229_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_229_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=229 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=229 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_229_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_229_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=229 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=229 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_229_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_229_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=230 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=230 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_230_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_230_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=230 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=230 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_230_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_230_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=230 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=230 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_230_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_230_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=230 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=230 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_230_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_230_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=230 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=230 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_230_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_230_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=231 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=231 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_231_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_231_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=231 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=231 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_231_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_231_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=231 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=231 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_231_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_231_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=231 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=231 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_231_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_231_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=231 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=231 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_231_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_231_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=232 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=232 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_232_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_232_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=232 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=232 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_232_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_232_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=232 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=232 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_232_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_232_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=232 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=232 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_232_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_232_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=232 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=232 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_232_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_232_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=233 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=233 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_233_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_233_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=233 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=233 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_233_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_233_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=233 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=233 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_233_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_233_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=233 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=233 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_233_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_233_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=233 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=233 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_233_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_233_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=234 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=234 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_234_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_234_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=234 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=234 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_234_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_234_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=234 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=234 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_234_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_234_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=234 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=234 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_234_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_234_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=234 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=234 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_234_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_234_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=235 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=235 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_235_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_235_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=235 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=235 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_235_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_235_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=235 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=235 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_235_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_235_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=235 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=235 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_235_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_235_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=235 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=235 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_235_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_235_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=236 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=236 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_236_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_236_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=236 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=236 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_236_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_236_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=236 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=236 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_236_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_236_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=236 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=236 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_236_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_236_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=236 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=236 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_236_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_236_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=237 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=237 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_237_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_237_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=237 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=237 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_237_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_237_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=237 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=237 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_237_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_237_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=237 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=237 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_237_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_237_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=237 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=237 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_237_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_237_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=238 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=238 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_238_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_238_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=238 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=238 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_238_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_238_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=238 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=238 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_238_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_238_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=238 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=238 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_238_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_238_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=238 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=238 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_238_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_238_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=239 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=239 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_239_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_239_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=239 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=239 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_239_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_239_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=239 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=239 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_239_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_239_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=239 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=239 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_239_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_239_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=239 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=239 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_239_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_239_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=240 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=240 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_240_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_240_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=240 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=240 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_240_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_240_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=240 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=240 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_240_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_240_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=240 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=240 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_240_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_240_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=240 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=240 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_240_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_240_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=241 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=241 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_241_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_241_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=241 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=241 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_241_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_241_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=241 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=241 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_241_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_241_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=241 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=241 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_241_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_241_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=241 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=241 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_241_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_241_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=242 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=242 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_242_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_242_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=242 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=242 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_242_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_242_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=242 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=242 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_242_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_242_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=242 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=242 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_242_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_242_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=242 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=242 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_242_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_242_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=243 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=243 time=12.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_243_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_243_12.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=243 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=243 time=13.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_243_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_243_13.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=243 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=243 time=14.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_243_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_243_14.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=243 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=243 time=15.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_243_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_243_15.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.sun elevation=dem aspect=aspect slope=slope horizon_basename=hor horizon_step=22.5 long=lon day=243 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=g --q --o
r.sun elevation=dem aspect_value=270 slope_value=0 horizon_basename=hor horizon_step=22.5 long=lon day=243 time=16.5 civil_time=-7 linke_value=3.0 albedo_value=0.2 glob_rad=f --q --o
r.out.gdal input=g output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/g_243_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
r.out.gdal input=f output='/Volumes/PortableSSD/Github/beetle-topography-and-wind-study/02.inputs/beetle/covariates/radiation-rsun/hours/f_243_16.tif' format=GTiff type=Float32 createopt=COMPRESS=DEFLATE --q --o
