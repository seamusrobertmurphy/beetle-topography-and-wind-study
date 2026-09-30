## The diameter-class table, with the tests it was missing.
##
## Sourced by every draft. The earlier table gave the class, the cell count and the
## attacked percentage, and nothing else. Three per cent between two classes could be
## anything at those counts, and the paper rests a threshold claim on exactly such a
## step, so the table has to carry the evidence for it.
##
## What is added, and why each one.
##
## A Wilson score interval on every class proportion. Wilson rather than the normal
## approximation because the smallest class holds a few hundred cells at proportions
## near 0.2, where the normal interval runs outside [0, 1] and understates coverage.
##
## A Pearson chi-square test of independence across all classes, which asks the blunt
## question the table implies: does attack depend on diameter class at all.
##
## A two-proportion test across the 25 cm boundary specifically, comparing the 20-25 and
## 25-30 classes. This is the source-sink threshold of the species' bionomics and the
## only step the manuscript makes a claim about, so it is tested rather than eyeballed.
## Cramer's V accompanies the chi-square, because with tens of thousands of cells a
## chi-square is significant on trivial differences and an effect size is what a reader
## should read.
##
## The cells are not independent: they are 30 m pixels in a spatially autocorrelated
## outbreak, so these p-values are anti-conservative. That is stated in the table
## footnote rather than left for a referee to find.

diameter_table <- function(qmd_bin) {
  ci <- mapply(function(k, n) {
    h <- stats::prop.test(k, n, correct = FALSE)$conf.int
    sprintf("%.1f-%.1f", 100 * h[1], 100 * h[2])
  }, round(qmd_bin$attack * qmd_bin$n), qmd_bin$n)
  data.frame(
    `QMD class (cm)`  = as.character(qmd_bin$bin),
    n                 = formatC(qmd_bin$n, format = "d", big.mark = ","),
    Attacked          = formatC(round(qmd_bin$attack * qmd_bin$n), format = "d", big.mark = ","),
    `Attacked (%)`    = sprintf("%.1f", 100 * qmd_bin$attack),
    `95% CI (%)`      = ci,
    check.names = FALSE)
}

diameter_tests <- function(qmd_bin) {
  k <- round(qmd_bin$attack * qmd_bin$n)
  tab <- cbind(attacked = k, unattacked = qmd_bin$n - k)
  chi <- suppressWarnings(stats::chisq.test(tab))
  ## Cramer's V for an r x 2 table: sqrt(X2 / (N * (min(r, c) - 1))), and min - 1 is 1.
  V <- sqrt(as.numeric(chi$statistic) / sum(tab))

  i <- match(c("20-25", "25-30"), as.character(qmd_bin$bin))
  step <- suppressWarnings(stats::prop.test(k[i], qmd_bin$n[i], correct = FALSE))
  d <- diff(100 * qmd_bin$attack[i])

  list(chi = chi, V = V, step = step, step_diff = d,
       df = as.numeric(chi$parameter), X2 = as.numeric(chi$statistic),
       step_ci = 100 * step$conf.int)
}
