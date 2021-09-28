## ----setup, include=FALSE-----------------------------------------------------
library(knitr)
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

## ----probs, fig.width = 2, fig.asp = 0.618, results='hide', fig.align = 'center', out.width = "55%"----
library(mosaic)
xpnorm(130, 100,13)
xpnorm(2.31)

## ----probs2, echo = TRUE, fig.width = 3, fig.asp = 0.618, fig.align = 'center', out.width = "60%"----
stats::pnorm(q = 130, mean = 100, sd = 13)

## ----probs3, echo = TRUE, fig.width = 3, fig.asp = 0.618, fig.align = 'center', out.width = "60%"----
mosaic::xpnorm(q = 130, mean = 100, sd = 13)

## ----probs4, echo = TRUE, fig.width = 3, fig.asp = 0.618, fig.align = 'center', out.width = "60%"----
stats::qnorm(p = 0.0104, mean = 100, sd = 13)

## ----probs5, echo = TRUE, fig.width = 3, fig.asp = 0.618, fig.align = 'center', out.width = "60%"----
mosaic::xqnorm(p = 0.0104, mean = 100, sd = 13)

## ----probs6, echo = TRUE, fig.width = 3, fig.asp = 0.618, fig.align = 'center', out.width = "60%"----
# lower.tail = TRUE is the default
stats::pnorm(q = -2.31, mean = 0, sd = 1, lower.tail = TRUE) +
stats::pnorm(q = 2.31, mean = 0, sd = 1, lower.tail = FALSE)

## ----probs7, echo = TRUE, fig.width = 4, fig.asp = 0.618, fig.align = 'center', out.width = "60%"----
mosaic::xpnorm(q = c(-2.31,2.31), mean = 0, sd = 1)

## ----probs8, echo = TRUE, fig.width = 4, fig.asp = 0.618, fig.align = 'center', out.width = "60%"----
mosaic::xqnorm(p = 0.75, mean = 100, sd = 13)

## ----echo=FALSE, comment = NA, size = 'tiny'----------------------------------
print(sessionInfo(), locale = FALSE)

