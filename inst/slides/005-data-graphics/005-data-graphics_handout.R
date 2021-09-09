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
options(digits = 2)


#knitr::opts_chunk$set(background = '#FFFF00')
library(tools) #needed for include_graphics2 function
pacman::p_load(here)
source(here::here("inst","slides","bin","include_graphics2.R"))
knitr::knit_hooks$set(purl = hook_purl)

## ----echo = TRUE, fig.asp=0.681-----------------------------------------------
library(oibiostat); data("famuss")
library(ggplot2)
library(colorspace)

ggplot(famuss, aes(x = actn3.r577x, y = bmi, fill = actn3.r577x)) + 
  geom_boxplot() + 
  colorspace::scale_fill_discrete_qualitative()
	
ggplot(famuss, aes(x = height, y = weight, color = bmi)) + 
  geom_point() + 
  colorspace::scale_color_continuous_sequential(palette = "Viridis")

## ----echo = TRUE, fig.asp=0.681-----------------------------------------------
ggplot(famuss, aes(x = height, y = weight, color = bmi)) + 
  geom_point() + 
  colorspace::scale_color_continuous_sequential(palette = "Viridis")

## ----echo=FALSE, comment = NA, size = 'tiny'----------------------------------
print(sessionInfo(), locale = FALSE)

