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
