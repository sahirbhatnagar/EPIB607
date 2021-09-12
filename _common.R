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
  devtools::install_github("OI-Biostat/oi_biostat_data")
if(!requireNamespace("openintro"))
  devtools::install_github("OpenIntroStat/openintro")
if(!requireNamespace("cowplot"))
  devtools::install_github("wilkelab/cowplot")
if(!requireNamespace("colorblindr"))
  devtools::install_github("clauswilke/colorblindr")
if(!requireNamespace("dviz.supp"))
  devtools::install_github("clauswilke/dviz.supp")
