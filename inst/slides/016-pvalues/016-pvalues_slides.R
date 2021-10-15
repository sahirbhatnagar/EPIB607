## ----setup-slides, echo=FALSE, warning=FALSE, message=FALSE, eval=TRUE--------
knitr::opts_chunk$set(cache=FALSE, message = FALSE, tidy = FALSE, warning = FALSE,
                      echo = FALSE,
                      #fig.width = 8,
                      #fig.asp = 0.8,
                      fig.align = 'center',
                      #out.width = "0.50\\linewidth",
                      size = 'tiny')

# the kframe environment does not work with allowframebreaks, so remove it
#knit_hooks$set(document = function(x) {
#gsub('\\\\(begin|end)\\{kframe\\}', '', x)
#})

library(tidyverse)
library(NCStats)
#options(digits = )


#knitr::opts_chunk$set(background = '#FFFF00')
library(tools) #needed for include_graphics2 function

pacman::p_load(here)

source(here::here("inst","slides","bin","include_graphics2.R"))

knitr::knit_hooks$set(purl = hook_purl)

pacman::p_load(
  gapminder,
  here,
  socviz,
  tidyverse,
  kableExtra,
  mosaic,
  DT
)

theme_set(cowplot::theme_cowplot())

