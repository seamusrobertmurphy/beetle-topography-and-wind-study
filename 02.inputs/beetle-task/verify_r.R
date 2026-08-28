# ---------------------------------------------------------------------------
# Independent check of the plot locations.
# Open beetle-task.Rproj (or setwd() to this folder) and source this file.
# Reads only:  darkwoods_plots_located.csv
#              ndmi_2020_harmonised.tif
#              aoi/search_area_all_tiers.shp
# ---------------------------------------------------------------------------

library(terra)

stopifnot(file.exists("darkwoods_plots_located.csv"),
          file.exists("ndmi_2020_harmonised.tif"))

d <- read.csv("darkwoods_plots_located.csv")
r <- rast("ndmi_2020_harmonised.tif")

cat("raster CRS :", crs(r, describe = TRUE)$code, "\n")
cat("plots      :", nrow(d), "\n\n")

# --- sample the raster at the plot coordinates -----------------------------
pts    <- vect(d[, c("easting", "northing")], geom = c("easting", "northing"),
               crs = crs(r))
sampled <- terra::extract(r, pts)[, 2]

# --- the number in question ------------------------------------------------
ct <- cor.test(d$pi_mpb_killed, sampled)

cat("Pearson r (mortality vs raster NDMI at these locations):\n")
cat(sprintf("   r = %.6f\n   p = %.3g\n   95%% CI = [%.4f, %.4f]\n\n",
            ct$estimate, ct$p.value, ct$conf.int[1], ct$conf.int[2]))

cat(sprintf("Spearman rho = %.4f\n\n",
            cor(d$pi_mpb_killed, sampled, method = "spearman")))

# --- does my written column match a fresh extraction? ----------------------
cat(sprintf("max |ndmi_raster column - fresh extract| = %.3g\n",
            max(abs(d$ndmi_raster - sampled))))

# --- for comparison: the ndmi column from the original workbook ------------
cat(sprintf("r using the workbook's own ndmi column   = %.6f\n\n",
            cor(d$pi_mpb_killed, d$ndmi)))

# --- are all the points inside the search area? ----------------------------
if (file.exists("aoi/search_area_all_tiers.shp")) {
  aoi <- vect("aoi/search_area_all_tiers.shp")
  inside <- !is.na(terra::extract(aggregate(project(aoi, crs(r))), pts)[, 2])
  cat(sprintf("points inside AOI: %d / %d\n", sum(inside), nrow(d)))
}

# --- minimum spacing between plot centres ----------------------------------
dm <- as.matrix(dist(d[, c("easting", "northing")]))
diag(dm) <- Inf
cat(sprintf("minimum spacing  : %.0f m\n\n", min(dm)))

# --- plot ------------------------------------------------------------------
plot(sampled, d$pi_mpb_killed, pch = 19, col = "steelblue",
     xlab = "NDMI sampled from raster", ylab = "MPB mortality (%)",
     main = sprintf("r = %.3f, n = %d", ct$estimate, nrow(d)))
abline(lm(d$pi_mpb_killed ~ sampled), col = "red", lwd = 2)
text(sampled, d$pi_mpb_killed, d$plot, pos = 4, cex = 0.7)
