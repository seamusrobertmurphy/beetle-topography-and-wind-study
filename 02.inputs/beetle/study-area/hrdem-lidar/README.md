# HRDEM lidar, 1 m

Natural Resources Canada, High Resolution Digital Elevation Model (HRDEM), CanElevation
Series, project BC-Kootenay_Columbia_2017-1m, EPSG:3979, 1 m, lidar 2017. Dataset page
https://open.canada.ca/data/en/dataset/957782bf-847c-4644-a757-e383c0057995 and STAC item
https://datacube.services.geo.ca/stac/api/search?collections=hrdem-lidar (bbox
-116.8206,49.0732,-116.5676,49.2722). Licence Open Government Licence - Canada.

Downloaded on 2026-10-03 as a window over the context box of dem_context.tif plus 100 m,
projwin -1562176 298913 -1538603 273471 in EPSG:3979, given to GDAL as the pixel window
-srcwin 38861 113926 23573 25442 because its parser reads a negative easting as an option, with:

    gdal_translate -srcwin 38861 113926 23573 25442 -co COMPRESS=LZW -co TILED=YES -co BIGTIFF=YES \
      /vsicurl/https://canelevation-dem.s3.ca-central-1.amazonaws.com/hrdem-lidar/BC-Kootenay_Columbia_2017-1m-dtm.tif dtm_1m_context.tif

and the same for -dsm.tif to dsm_1m_context.tif. The project's coverage layer covered
100.0 per cent of the 5,573.1 ha study perimeter and 95.7 per cent of the context box.
