#!/usr/bin/env Rscript
## Trace every column of `2.1.darkwoods_beetle_ground_plots_ndmi.xlsx` to a source.
##
## The workbook's own metadata says it was created 2026-08-24T15:38Z by openpyxl and
## saved from Excel by "Murphy, Seamus", so it is a working file assembled in this
## project, not a delivery from the parent study's archive. Its columns therefore
## carry only the authority of whatever they were copied from, and this script
## establishes what that was for each one.
##
## The reason it matters: 10-verify-plot-ndmi.R found Spearman -0.999 between the
## `ndmi` column and the field mortality across 28 plots, while three tasselled-cap
## components from the same plots and the same imagery return |rho| < 0.04, and this
## project's own 2020 NDMI returns -0.449. Only one of those behaves like an image.

suppressPackageStartupMessages({library(readxl)})

ROOT <- "02.inputs/beetle-classification"
LOC  <- file.path(ROOT, "plot-locations")
NEW  <- file.path(ROOT, "2.1.darkwoods_beetle_ground_plots_ndmi.xlsx")
PAR  <- path.expand(paste0("~/repos/publications-pending/Darkwoods-Disturbance-Paper",
                           "/2.ExcelData/2.1.darkwoods_beetle_ground_plots.xlsx"))
line <- function(s) cat("\n", s, "\n", strrep("-", nchar(s)), "\n", sep = "")

d <- as.data.frame(read_excel(NEW, sheet = 1)); d$plot <- as.integer(d$plot)
p <- as.data.frame(read_excel(PAR, sheet = 1)); p <- p[!is.na(p$plot), ]
p$plot <- as.integer(p$plot)
stopifnot(nrow(d) == 28, nrow(p) == 28)
j <- merge(d, p, by = "plot", suffixes = c("", "_par"))
stopifnot(nrow(j) == 28)

line("7. Column by column against the parent's original workbook")
cat(sprintf("parent columns: %s\n", paste(names(p), collapse = ", ")))
pairs <- list(c("pi_mpb_killed", "pi_mpd_killed"), c("ndmi", "ndmi"),
              c("taswet", "taswet"), c("tasgre", "tasgre"), c("tasbri", "tasbri"))
for (q in pairs) {
  a <- j[[q[1]]]; b <- j[[if (q[1] == q[2]) paste0(q[2], "_par") else q[2]]]
  cat(sprintf("  %-16s vs parent %-16s max abs difference %.3e\n", q[1], q[2],
              max(abs(a - b))))
}
cat(sprintf("  parent pi_mpb_killed%% == 2 x pi_mpd_killed: max abs difference %.3e\n",
            max(abs(j[["pi_mpb_killed%"]] - 2 * j$pi_mpd_killed))))
cat(sprintf("  delivered pi_mpb_killed_pc vs parent pi_mpb_killed%%: max abs difference %.3f\n",
            max(abs(j$pi_mpb_killed_pc - j[["pi_mpb_killed%"]]))))

## the unsourced percentage: is it a rescaling of the ndmi column?
f <- lm(pi_mpb_killed_pc ~ ndmi, data = j)
cat(sprintf("  pi_mpb_killed_pc ~ ndmi: R2 = %.6f, max abs residual %.4f\n",
            summary(f)$r.squared, max(abs(resid(f)))))
tr <- read.csv(file.path(LOC, "beetle_plots_training.csv"))
tc <- aggregate(pi_mpb_killed_pc ~ plot, data = tr, FUN = function(x) x[1])
cat(sprintf("  pi_mpb_killed_pc identical to beetle_plots_training.csv: max abs difference %.3e\n",
            max(abs(merge(j, tc, by = "plot")$pi_mpb_killed_pc.x -
                    merge(j, tc, by = "plot")$pi_mpb_killed_pc.y))))

line("8. The rank lock is in the parent's own file, not in the new one")
## If the parent's ndmi column already rank-orders the parent's own field
## measurement, the circularity predates this project entirely.
rho <- cor(p$ndmi, p$pi_mpd_killed, method = "spearman")
tau <- cor(p$ndmi, p$pi_mpd_killed, method = "kendall")
r   <- cor(p$ndmi, p$pi_mpd_killed)
cat(sprintf("Parent file alone, ndmi vs pi_mpd_killed: pearson %+.4f, spearman %+.4f, kendall %+.4f\n",
            r, rho, tau))
disc <- sum(rank(p$ndmi) != rank(-p$pi_mpd_killed))
cat(sprintf("Plots whose ndmi rank is not the exact reverse of their mortality rank: %d of 28\n", disc))
if (disc > 0) {
  k <- which(rank(p$ndmi) != rank(-p$pi_mpd_killed))
  print(data.frame(plot = p$plot[k], pi_mpd_killed = p$pi_mpd_killed[k], ndmi = p$ndmi[k],
                   rank_ndmi = rank(p$ndmi)[k], rank_mortality_rev = rank(-p$pi_mpd_killed)[k]))
}
## the same test on the controls, which came from the same rows of the same file
for (v in c("taswet", "tasgre", "tasbri"))
  cat(sprintf("  control %s vs pi_mpd_killed: spearman %+.4f, discordant ranks %d of 28\n", v,
              cor(p[[v]], p$pi_mpd_killed, method = "spearman"),
              sum(rank(p[[v]]) != rank(-p$pi_mpd_killed))))

## how unlikely is that ordering if the two were independent?
set.seed(1)
perm <- replicate(1e5, cor(sample(p$ndmi), p$pi_mpd_killed, method = "spearman"))
cat(sprintf("Permutation test, 1e5 draws: %d of 1e5 reach rho <= %+.4f\n",
            sum(perm <= rho), rho))
