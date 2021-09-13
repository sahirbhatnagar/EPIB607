# example R options set globally
options(width = 60)
options(bookdown.post.latex = function(x) {
  # x is the content of the LaTeX output file
  c('\\PassOptionsToPackage{table}{xcolor}',x)
})
# example chunk options set globally
knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE
  )

if(!requireNamespace("oibiostat"))
  remotes::install_github("OI-Biostat/oi_biostat_data")
if(!requireNamespace("openintro"))
  remotes::install_github("OpenIntroStat/openintro")
if(!requireNamespace("cowplot"))
  remotes::install_github("wilkelab/cowplot")
if(!requireNamespace("colorblindr"))
  remotes::install_github("clauswilke/colorblindr")
if(!requireNamespace("dviz.supp"))
  remotes::install_github("clauswilke/dviz.supp")


theme_dviz_grid_2 <- function (font_size = 14, line_size = 0.5,
                               rel_small = 12/14, rel_tiny = 11/14, rel_large = 16/14, colour = "grey90") {
  half_line <- font_size/2
  cowplot::theme_minimal_grid(font_size = font_size,
                              line_size = line_size, rel_small = rel_small, rel_tiny = rel_tiny,
                              rel_large = rel_large, colour = colour) %+replace% theme(plot.margin = margin(half_line/2,
                                                                                                            1.5, half_line/2, 1.5), complete = TRUE)
}



theme_dviz_open_2 <- function (font_size = 14, line_size = 0.5,
                               rel_small = 12/14, rel_tiny = 11/14, rel_large = 16/14) {
  half_line <- font_size/2
  cowplot::theme_half_open(font_size = font_size,
                           line_size = line_size, rel_small = rel_small, rel_tiny = rel_tiny,
                           rel_large = rel_large) %+replace% theme(plot.margin = margin(half_line/2,
                                                                                        1.5, half_line/2, 1.5), complete = TRUE)
}

