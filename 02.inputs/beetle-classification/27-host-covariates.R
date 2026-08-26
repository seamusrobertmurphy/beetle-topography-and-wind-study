#!/usr/bin/env Rscript
## Host abundance and biogeoclimatic zone, so terrain is not credited with host range.
##
## The problem this fixes. Moderate-to-high attack sits 192 m lower, on slopes 7.7
## degrees gentler, less rugged and wetter than unattacked forest, in all eight years.
## Mountain pine beetle cannot attack a tree that is not there, and lodgepole pine is
## itself distributed by elevation and aspect, so that contrast is consistent with the
## refugia hypothesis and equally consistent with nothing more than where the host
## grows. The two cannot be separated without a host layer in the model.
##
## Host comes from the Beaudoin et al. NFI kNN species rasters already held in
## `archive/1.8 GIS Data/BC Species maps`, MODIS 250 m for 2011, the same source the
## parent paper cites for pre-fire composition. Pinus contorta is the host; the other
## seven species are carried as composition so that "pine-dominated" can be separated
## from "pine present in a mixed stand". Resampling 250 m to the 30 m analysis grid
## adds no detail and none is claimed: the host layer constrains at stand scale, not at
## pixel scale, and that limit belongs in the Methods.
##
## BEC subzone is added as a categorical control, from BEC_POLY_polygon.shp. The parent
## records three subzones inside the burn (ESSFwm4, ICHmw4, ICHdw1); across 265,000 ha
## there will be more, and they carry the climate and site differences that neither
## elevation nor slope captures on its own.

suppressPackageStartupMessages({library(terra); library(sf)})
ROOT <- "02.inputs/beetle-classification"
COV  <- file.path(ROOT, "covariates")
SP   <- "archive/1.8 GIS Data/BC Species maps"
BEC  <- paste0("archive/1.8 GIS Data/BC Government Geodatasets/NGO Conservation Areas 2/",
               "BEC_BIOGEOCLIMATIC_POLY/BEC_POLY_polygon.shp")
g <- rast(file.path(ROOT, "ndmi-darkwoods", "analysis_grid.tif"))

SPP <- c(pinu_con = "Pinus_contorta", pice_eng = "Picea_engelmann",
         pseu_men = "Pseudo_mienzii", lari_occ = "Larix_occidentalis",
         thuj_pli = "Thuja_Plicata", tsug_het = "Tsuga_Heterophylia",
         pinu_pon = "Pinus_ponderosa", pinu_alb = "Pinus_albicaulis")
lay <- list()
for (k in names(SPP)) {
  f <- list.files(SP, sprintf("^%s.*tif$", SPP[[k]]), full.names = TRUE)
  if (!length(f)) { cat("missing:", SPP[[k]], "\n"); next }
  r <- project(rast(f[1]), g, method = "bilinear"); names(r) <- k
  lay[[k]] <- r
  cat(sprintf("%-9s %-24s mean %6.2f  max %6.2f  NA %5.1f%%\n", k, basename(f[1]),
              global(r,"mean",na.rm=TRUE)[[1]], global(r,"max",na.rm=TRUE)[[1]],
              100*global(is.na(r),"sum",na.rm=TRUE)[[1]]/ncell(r)))
}
sp <- rast(lay)
tot <- sum(sp, na.rm = TRUE); names(tot) <- "conifer_total"
frac <- sp[["pinu_con"]] / (tot + 0.001); names(frac) <- "pinu_con_frac"
cat(sprintf("\nlodgepole pine: mean cover %.2f, mean fraction of conifer %.3f\n",
            global(sp[["pinu_con"]],"mean",na.rm=TRUE)[[1]],
            global(frac,"mean",na.rm=TRUE)[[1]]))

## BEC subzone as an integer code, with the lookup written beside it
b  <- st_transform(st_read(BEC, quiet = TRUE), 32611)
fld <- grep("SUBZONE|MAP_LABEL|ZONE", names(b), value = TRUE)
cat("BEC fields:", paste(fld, collapse = ", "), "\n")
lab <- if ("MAP_LABEL" %in% names(b)) "MAP_LABEL" else fld[1]
b$code <- as.integer(factor(b[[lab]]))
bz <- rasterize(vect(b), g, field = "code"); names(bz) <- "bec"
write.csv(unique(data.frame(code = b$code, bec = b[[lab]])),
          file.path(COV, "bec_lookup.csv"), row.names = FALSE)
cat(sprintf("BEC units on the grid: %d\n", length(unique(values(bz)[!is.na(values(bz))]))))

out <- c(sp, tot, frac, bz)
writeRaster(out, file.path(COV, "host_covariates.tif"), overwrite = TRUE,
            datatype = "FLT4S", gdal = c("COMPRESS=DEFLATE","PREDICTOR=3"))
cat(sprintf("\nwrote %s (%d layers)\n", file.path(COV,"host_covariates.tif"), nlyr(out)))
