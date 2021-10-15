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

## ----eval=TRUE, echo=TRUE, results="show", message=FALSE, fig.asp = 0.408-----
mosaic::xpnorm(q = -0.533, mean = -0.540, sd = 0.008/sqrt(5))

## ----eval=TRUE, echo=TRUE, results="show", message=TRUE, fig.asp = 0.358------
SEM <- 0.008/sqrt(5)
z_stat <- (-0.533 - (-0.540)) / SEM
mosaic::xpnorm(q = z_stat, mean = 0, sd = 1)

## ----eval=TRUE, echo=TRUE, results="show", message=TRUE, fig.asp = 0.428------
mosaic::xqnorm(p = 0.95, mean = -0.540, sd = 0.008/sqrt(5))

## ----echo = TRUE, results='hide', fig.cap='critical value under the null distribution'----
mosaic::xqnorm(p = 0.95, 
mean = -0.540, 
sd = 0.008/sqrt(5))

## ----echo = TRUE, message=FALSE, eval=TRUE, results = 'hide', fig.cap='test statistic under the null distribution'----
mosaic::xpnorm(q = -0.533, 
mean = -0.540, 
sd = 0.008/sqrt(5))

## ----echo = TRUE, fig.asp = 0.508---------------------------------------------
mosaic::xqnorm(p = 0.95, mean = -0.540, sd = 0.008/sqrt(5))

## ----echo=FALSE, eval=TRUE----------------------------------------------------
source("https://raw.githubusercontent.com/sahirbhatnagar/EPIB607/master/inst/code/plot_null_alt.R")
n <- 5
s <- 0.0080
mu0 <- -0.540
mha <- 0.99*-0.540
cutoff <- mu0 + qnorm(0.95) * s / sqrt(n)
power_plot(n = n, s = s,  
mu0 = mu0, mha = mha, 
cutoff = cutoff,
alternative = "greater",
xlab = "Freezing point (degrees C)")

## ----echo=FALSE, eval=TRUE----------------------------------------------------
mha <- 0.98*-0.540
cutoff <- mu0 + qnorm(0.95) * s / sqrt(n)
power_plot(n = n, s = s,  
mu0 = mu0, mha = mha, 
cutoff = cutoff,
alternative = "greater",
xlab = "Freezing point (degrees C)")

## ----echo=FALSE, eval=TRUE----------------------------------------------------
mha <- 0.97*-0.540
cutoff <- mu0 + qnorm(0.95) * s / sqrt(n)
power_plot(n = n, s = s,  
mu0 = mu0, mha = mha, 
cutoff = cutoff,
alternative = "greater",
xlab = "Freezing point (degrees C)")

## ----echo=FALSE, eval=TRUE, results='hide', fig.show='hide'-------------------
n=15
mha <- 0.99*-0.540
cutoff <- mu0 + qnorm(0.95) * s / sqrt(n)
power_plot(n = n, s = s,  
mu0 = mu0, mha = mha, 
cutoff = cutoff,
alternative = "greater",
xlab = "Freezing point (degrees C)")
ylims <- par("usr")[3:4]

## ----echo=FALSE, eval=TRUE----------------------------------------------------
n <- 5
s <- 0.0080
mu0 <- -0.540
mha <- 0.99*-0.540
cutoff <- mu0 + qnorm(0.95) * s / sqrt(n)
power_plot(n = n, s = s,  
mu0 = mu0, mha = mha, 
cutoff = cutoff,
ylimit = ylims, 
alternative = "greater",
xlab = "Freezing point (degrees C)")

## ----echo=FALSE, eval=TRUE----------------------------------------------------
n = 10
mha <- 0.99*-0.540
cutoff <- mu0 + qnorm(0.95) * s / sqrt(n)
power_plot(n = n, s = s,  
mu0 = mu0, mha = mha, 
cutoff = cutoff,
alternative = "greater",
ylimit = ylims, 
xlab = "Freezing point (degrees C)")

## ----echo=FALSE, eval=TRUE----------------------------------------------------
n=15
mha <- 0.99*-0.540
cutoff <- mu0 + qnorm(0.95) * s / sqrt(n)
power_plot(n = n, s = s,  
mu0 = mu0, mha = mha, 
cutoff = cutoff,
alternative = "greater",
xlab = "Freezing point (degrees C)")

## ----echo=FALSE, eval=TRUE----------------------------------------------------
n <- 13.6
s <- 0.0080
mu0 <- -0.540
mha <- 0.99*-0.540
cutoff <- mu0 + qnorm(0.95) * s / sqrt(n)
power_plot(n = n, s = s,  
mu0 = mu0, mha = mha, 
cutoff = cutoff,
alternative = "greater",
xlab = "Freezing point (degrees C)")
I = 1
axis(2)
text(-0.5325,600,"qnorm(0.8, \nlower.tail=FALSE)=\n-0.84",
cex=.65,family="mono",adj=c(0,0.5),col="red")
x = (cutoff+mha)/2
text(x-.001, 330,
"0.84 * SEM",col="red",
adj=c(-0.1,0.5),cex=0.65)
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", 
"#F0E442", "#0072B2", "#D55E00", "#CC79A7")
text(-0.548,100,"qnorm(0.05, \nlower.tail=FALSE)=\n 1.645",
cex=0.65,family="mono",adj=c(0,0),col=cbPalette[6])
text(x-.001, 130, "1.645 * SEM",col=cbPalette[6], 
adj=c(1.1,0),cex=0.65)
arrows(mu0,   100,
mha,100,length=0.05,
code=3,angle=20,lwd=1.5)
text(mha-.0054,80, latex2exp::TeX("Delta = 1.645*SEM + 0.84*SEM"),
adj=c(-0.1,0.5), cex=0.75)

## ----eval = FALSE, echo = TRUE, tidy = FALSE----------------------------------
#  source("https://raw.githubusercontent.com/sahirbhatnagar/EPIB607/master/inst/code/plot_null_alt.R")
#  
#  mu0 <- -0.540 # mean under the null
#  mha <- 0.99*-0.540 # mean under the alternative
#  s <- 0.0080 # sample/population SD
#  n <- 5 # sample size
#  cutoff <- mu0 + qnorm(0.95) * s / sqrt(n)
#  
#  power_plot(n = n,
#  s = s,
#  mu0 = mu0,
#  mha = mha,
#  cutoff = cutoff,
#  alternative = "greater",
#  xlab = "Freezing point (degrees C)")

## ----echo=TRUE, message=FALSE, fig.asp = 0.418--------------------------------
mosaic::xqnorm(p = c(0.05,1), 112.8, 15/sqrt(9))

## ----eval = TRUE, echo = TRUE, tidy = FALSE, fig.asp=0.598--------------------
source("https://raw.githubusercontent.com/sahirbhatnagar/EPIB607/master/inst/code/plot_null_alt.R")
power_plot(n = 9, s = 15, mu0 = 100, mha = 110, 
cutoff = 100 + qnorm(0.95) * 15 / sqrt(9),
alternative = "greater", xlab = "Average IQ Score")

## ----echo=FALSE, comment = NA, size = 'tiny'----------------------------------
print(sessionInfo(), locale = FALSE)

