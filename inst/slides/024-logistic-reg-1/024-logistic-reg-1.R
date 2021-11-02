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

## ----echo=TRUE, size = 'small'------------------------------------------------
dead <- c(0,1,218,104)
censored <- c(15,129,311,124)
z <- c(1,0,1,0); x <- c(0,0,1,1)
cbind(dead,censored,z,x)

## ----eval=FALSE, echo=TRUE, size = 'normalsize'-------------------------------
#  model <- glm(cbind(dead,censored) ~ z + x,
#                 family=binomial(link="logit"))

## ----eval=TRUE, echo=TRUE,size = 'normalsize'---------------------------------
model <- glm(cbind(dead,censored) ~ z + x, 
              family=binomial(link="logit"))
print(summary(model), signif.stars = FALSE)

## ----eval=FALSE, echo=TRUE, size = 'normalsize'-------------------------------
#  	model <- glm(cbind(dead,censored) ~ z + x,
#  	             family=binomial(link="log"))

## ----eval=TRUE, echo=TRUE,size = 'normalsize'---------------------------------
model <- glm(cbind(dead,censored) ~ z + x, 
             family=binomial(link="log"))
print(summary(model), signif.stars = FALSE)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
cases <- c(77, 61)
controls <- c(273, 289)
open <- c(1,0)
df <- as.data.frame(cbind(cases, controls, open))

fit <- glm(cbind(cases,controls) ~ open, data = df, family=binomial(link="logit"))
print(summary(fit), signif.stars = F)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
cases <- c(6,36,71,25)
controls <- c(81,234,192,55)
open <- c(1,0, 1, 0)
size <- c(0,0,1,1)
df <- as.data.frame(cbind(cases, controls, open, size))

fit <- glm(cbind(cases,controls) ~ open + size, data = df,
           family=binomial(link="logit"))
print(summary(fit), signif.stars = F)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
cases <- c(218, 105)
controls <- c(326, 253)
type <- c(1,0)
df <- as.data.frame(cbind(cases, controls, type))

fit <- glm(cbind(cases,controls) ~ type, data = df,
family=binomial(link="logit"))
print(summary(fit), signif.stars = F)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
dead <- c(0,1,218,104)
censored <- c(15,129,311,124)
type <- c(1,0,1,0); age <- c(0,0,1,1)
df <- as.data.frame(cbind(dead,censored,type,age))
fit <- glm(cbind(dead,censored) ~ type + age, data=df, family=binomial(link="logit"))
print(summary(fit), signif.stars = F)

## ----echo=FALSE, comment = NA, size = 'tiny'----------------------------------
print(sessionInfo(), locale = FALSE)

## ----echo=FALSE, eval=TRUE, message=FALSE, size = 'small'---------------------
ds.for.mh=read.csv("~/git_repositories/epib607/inst/slides/024-logistic-reg-1/hiv_Transmission_mantel_haenszel.csv",
header=TRUE)

## ----echo=FALSE, eval=TRUE, message=FALSE, size = 'small'---------------------
# devtools::install_github('droglenc/NCStats')
ds=read.csv("~/git_repositories/epib607/inst/slides/024-logistic-reg-1/hiv_Transmission.csv",header=TRUE)
ds$n.hivneg= ds$n.pairs - ds$n.hivpos
ds$propn = round(ds$n.hivpos/ds$n.pairs,3)
#overall proportion hiv positive
#round(sum(ds$n.hivpos)/sum(ds$n.pairs),3)
# intercept-only logit model
fit0 <- glm(cbind(n.hivpos,n.hivneg) ~ 1, family=binomial(link=logit), data=ds)
print(summary(fit0), show.call=TRUE, digits=2)
#checks
#plogis(fit0$coefficients)

## ----echo=FALSE, eval=TRUE, message=FALSE, size = 'small'---------------------
fit.cae=glm(cbind(n.hivpos,n.hivneg) ~ caesarian, family=binomial(link=logit), data=ds)
print(summary(fit.cae), show.call=TRUE, digits=2)

## ----echo=FALSE, eval=TRUE, message=FALSE, size = 'small'---------------------
fit.all4 = glm(cbind(n.hivpos,ds$n.hivneg) ~ caesarian + ART1or2 + ART3 + m.advancedHIV + c.LBW,
family=binomial(link=logit), data=ds)
print(summary(fit.all4), show.call=TRUE, digits=2)

## ----echo=FALSE, eval=TRUE, message=FALSE, size = 'small'---------------------
fit.all4 = glm(cbind(n.hivpos,ds$n.hivneg) ~ caesarian + ART1or2 + ART3 + m.advancedHIV + c.LBW,
family=binomial(link=log), data=ds)
print(summary(fit.all4), show.call=TRUE, digits=2)

## ----echo=FALSE, comment = NA, size = 'tiny'----------------------------------
print(sessionInfo(), locale = FALSE)

