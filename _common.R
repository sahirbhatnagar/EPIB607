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


