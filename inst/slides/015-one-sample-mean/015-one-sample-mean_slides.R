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

## ----echo = TRUE, message=FALSE, eval=FALSE-----------------------------------
#  library(mosaic)
#  xqnorm(p = c(0.025, 0.975))

## ----echo = FALSE, message=FALSE, eval=TRUE-----------------------------------
library(mosaic)
xqnorm(p = c(0.025, 0.975),
xlim = c(-6,6))

## ----echo = TRUE--------------------------------------------------------------
library(mosaic)
xqt(p = c(0.025, 0.975), df = 5)

## ----echo = TRUE, message=FALSE, eval=FALSE-----------------------------------
#  library(mosaic)
#  xqnorm(p = c(0.025, 0.975))

## ----echo = FALSE, message=FALSE, eval=TRUE-----------------------------------
library(mosaic)
xqnorm(p = c(0.025, 0.975),
xlim = c(-4,4))

## ----echo = TRUE, message=FALSE, eval=FALSE-----------------------------------
#  library(mosaic)
#  xqt(p = c(0.025, 0.975), df = 30)

## ----echo = FALSE, message=FALSE, eval=TRUE-----------------------------------
library(mosaic)
xqt(p = c(0.025, 0.975), df = 30,
xlim = c(-4,4))

## ----fig.align='center',echo=FALSE, fig.asp = 0.598---------------------------
curve(dnorm(x), -4,4, lty=1, ylab="density", col=1, lwd=2)
curve(dt(x,3), -4,4, add=TRUE, lty=2, col=2,lwd=2)
#curve(dt(x,30), -4,4, add=TRUE, lty=4, col=3,lwd=3)
legend(1.5, .4, c("N(0,1)", "t(df=3)"), col = c(1,2), lty = c(1,2),
merge = TRUE, bg = "gray90", lwd=c(2,2))
#legend(1.5, .4, c("N(0,1)", "t(df=15)","t(df=30)"), col = c(1,2,3), lty = c(1,2,4),
#merge = TRUE, bg = "gray90", lwd=c(2,2,3))

## ----fig.align='center',echo=FALSE, fig.asp = 0.598---------------------------
curve(dnorm(x), -4,4, lty=1, ylab="density", col=1, lwd=2)
#curve(dt(x,3), -4,4, add=TRUE, lty=2, col=2,lwd=2)
curve(dt(x,30), -4,4, add=TRUE, lty=4, col="blue",lwd=3)
legend(1.5, .4, c("N(0,1)", "t(df=30)"), col = c(1,"blue"), lty = c(1,4),
merge = TRUE, bg = "gray90", lwd=c(2,3))

## ----echo = TRUE, message=FALSE, eval=TRUE, fig.asp = 0.428-------------------
mosaic::xqnorm(p = c(0.025, 0.975))

## ----echo = TRUE, message=FALSE, eval=TRUE, fig.asp = 0.428-------------------
mosaic::xqt(p = c(0.025, 0.975), df = 3)

## ----echo = TRUE--------------------------------------------------------------
reaction.times <- c(325,327,357,299,378)/1000
summary(reaction.times)
round(sd(reaction.times),3)
length(reaction.times)

## ----echo = c(-3,-5,-7,-9)----------------------------------------------------
n <- length(reaction.times)
SEM <- sd(reaction.times)/sqrt(n)
(SEM <- sd(reaction.times)/sqrt(n))
ybar <- mean(reaction.times)
(ybar <- mean(reaction.times))
multiple.for.95pct <- stats::qt(p = c(0.025, 0.975), df = n-1)
(multiple.for.95pct <- stats::qt(p = c(0.025, 0.975), df = n-1))
by_hand_CI <- ybar + multiple.for.95pct * SEM
round(by_hand_CI, 5)

## ----echo = TRUE--------------------------------------------------------------
n <- length(reaction.times)
SEM <- sd(reaction.times)/sqrt(n)
ybar <- mean(reaction.times)

# scaled version of the standard t distribution
qt_ls <- function(p, df, mean, sd) qt(p = p, df = df) * sd + mean

qt_ls(p = c(0.025, 0.975), df = n - 1, mean = ybar, sd = SEM)

## ----echo = TRUE--------------------------------------------------------------
fit <- stats::lm(reaction.times ~ 1)
summary(fit)
stats::confint(fit)

## -----------------------------------------------------------------------------
options(digits = 3)

## ----echo = TRUE--------------------------------------------------------------
stats::t.test(reaction.times)

## ----echo = 1:3, fig.asp=0.498------------------------------------------------
df_react <- data.frame(reaction.times) # need data.frame to bootstrap
B <- 10000 ; N <- nrow(df_react)
R <- replicate(B, {
  dplyr::sample_n(df_react, size = N, replace = TRUE) %>%
  dplyr::summarize(r = mean(reaction.times)) %>%
  dplyr::pull(r)
})
CI_95 <- quantile(R, probs = c(0.025, 0.975))
CI_95

# plot sampling distribution
hist(R, breaks = 50, col = "#56B4E9",
     main="",
     xlab = "mean reaction time (s) from each bootstrap sample")

# draw red line at the sample mean
abline(v = mean(reaction.times), lty =1, col = "red", lwd = 4)

# draw black dotted lines at 95% CI
abline(v = CI_95[1], lty =2, col = "black", lwd = 4)
abline(v = CI_95[2], lty =2, col = "black", lwd = 4)

# include legend
library(latex2exp)
legend("topright", 
  legend = c(TeX("$\\bar{y} = 0.3372$"),
  sprintf("95%% CI: [%.3f, %.3f]",CI_95[1], CI_95[2])), 
  lty = c(1,1), 
  col = c("red","black"), lwd = 4)

## ----echo=FALSE, comment = NA, size = 'tiny'----------------------------------
print(sessionInfo(), locale = FALSE)

