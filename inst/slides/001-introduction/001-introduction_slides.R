## ----setup, include=FALSE, message=FALSE, warning=FALSE-----------------------
library(knitr)
knitr::opts_chunk$set(cache=FALSE, message = FALSE, tidy = FALSE, warning = FALSE,
						echo = TRUE, fig.width = 8, fig.asp = 0.8, 
						fig.align = 'center', out.width = "100%", size = 'scriptsize')
						
# the kframe environment does not work with allowframebreaks, so remove it
#knit_hooks$set(document = function(x) {
#gsub('\\\\(begin|end)\\{kframe\\}', '', x)
#})

library(tidyverse)
#knitr::opts_chunk$set(background = '#FFFF00')
library(tools) #needed for include_graphics2 function
if (!requireNamespace("pacman")) install.packages("pacman")
pacman::p_load(ggpubr)
pacman::p_load(here)
source(here::here("inst","slides","bin","include_graphics2.R"))
knitr::knit_hooks$set(purl = hook_purl)

## ----echo=FALSE, eval=TRUE, message=FALSE, size = 'footnotesize', comment=''----
df <- read.csv("https://raw.githubusercontent.com/sahirbhatnagar/cleandata/master/data/fullmoon.csv",
header = TRUE)
set.seed(123)
knitr::kable(df[1:7,], row.names = FALSE)

## ----echo=FALSE, eval=TRUE, message=FALSE, size = 'footnotesize', comment=''----
df <- read.csv("https://raw.githubusercontent.com/sahirbhatnagar/cleandata/master/data/fullmoon.csv",
header = TRUE)
set.seed(123)
knitr::kable(df[1:3,], row.names = FALSE)

## ----echo=TRUE, eval=TRUE, message=FALSE, size = 'tiny', comment='', fig.asp=0.5----
plot(df$moon_days, df$other_days, pch = 19)
abline(a=0,b=1)

## ----echo=FALSE, eval=TRUE, message=FALSE, size = 'footnotesize', comment=''----
df <- read.csv("https://raw.githubusercontent.com/sahirbhatnagar/cleandata/master/data/fullmoon.csv",
header = TRUE)
set.seed(123)
knitr::kable(df[1:5,], row.names = FALSE)

## ----echo=FALSE, eval=TRUE, message=FALSE, size = 'scriptsize'----------------
#devtools::install_github('droglenc/NCStats')
library(NCStats)
fit <- lm(moon_days ~ other_days, data = df)
print(summary(fit), show.call=TRUE, digits=2, signif.stars = FALSE)

## ----echo=FALSE, eval=TRUE, message=FALSE, size = 'footnotesize', comment=''----

df_tidy <- df %>% gather(day_type, mean_behavior,-patient) %>% mutate(patient = factor(patient), day_type = factor(day_type))
set.seed(1234)
knitr::kable(arrange(df_tidy, patient)[1:10,], row.names = FALSE)

## ----echo=TRUE, eval=FALSE, message=FALSE, size = 'tiny', comment=''----------
#  ggplot(data = df_tidy, mapping = aes(x = day_type, y = mean_behavior, group = patient)) + geom_line()

## ----echo=FALSE, eval=TRUE, message=FALSE, size = 'tiny', comment='', fig.asp=0.67----
ggplot(data = df_tidy, mapping = aes(x = day_type, y = mean_behavior, group = patient)) + geom_line() + ggpubr::theme_pubr()

## ----echo=TRUE, eval=TRUE, message=FALSE, size = 'tiny'-----------------------
fit <- lme4::lmer(mean_behavior ~ day_type + (1|patient), data = df_tidy)
summary(fit)

## ----echo=1, eval=FALSE, message=FALSE, size = 'tiny', comment=''-------------
#  tidyr::pivot_longer(data = df, cols = -patient, names_to = "day_type", values_to = "mean_behavior")

## ----echo=FALSE, comment = NA, size = 'tiny'----------------------------------
print(sessionInfo(), locale = FALSE)

