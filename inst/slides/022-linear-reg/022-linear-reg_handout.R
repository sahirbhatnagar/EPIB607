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

## -----------------------------------------------------------------------------
# load function to get depths
source("https://raw.githubusercontent.com/sahirbhatnagar/EPIB607/master/inst/labs/003-ocean-depths/automate_water_task.R")

# get 1000 depths
set.seed(222333444)
depths <- automate_water_task(index = sample(1:50000, 1000), student_id = 222333444, type = "depth")

# separate by north and south hemisphere
depths_north <- depths[which(depths$lat>0),]
depths_south <- depths[which(depths$lat<0),]

# restrict sample to 200 (at random)
depths_north <- depths_north[sample(1:nrow(depths_north), 200), ]
depths_south <- depths_south[sample(1:nrow(depths_south), 200), ]

# add indicator variable
depths_north$South <- 0
depths_south$South <- 1

# combine data
depths <- rbind(depths_north, depths_south)
# regression. lm assumes equal variances
#fit <- lm(alt ~ South, data = depths)
#summary(fit)

## ----echo=TRUE, out.width="99%"-----------------------------------------------
head(depths, n=3)
dim(depths)

## ----echo=TRUE, eval = TRUE---------------------------------------------------
fit <- lm(alt ~ 1, data = depths)
print(summary(fit), signif.stars = F)

## ----echo=FALSE, fig.align='left', fig.width=3, fig.height=2,	fig.asp = 1, eval=FALSE----
#  library(ggplot2)
#  ggplot(depths, aes(x = South, y = alt)) + geom_jitter() + cowplot::theme_cowplot()

## ----echo=TRUE----------------------------------------------------------------
fit <- lm(alt ~ South, data = depths)
print(summary(fit), signif.stars = F)
stats::t.test(alt ~ South, data = depths, var.equal = TRUE)

## ----echo=TRUE----------------------------------------------------------------
coef(fit)
vcov(fit)
confint(fit)

## ----echo=TRUE----------------------------------------------------------------
pacman::p_load(car)
betahat.boot <- car::Boot(fit, R=999)
head(betahat.boot$t)
dim(betahat.boot$t)
deltamuhat.boot <- betahat.boot$t[,2]
median(deltamuhat.boot)
quantile(deltamuhat.boot, probs = c(0.025, 0.975))

## ----echo=FALSE, eval = TRUE--------------------------------------------------
hist(deltamuhat.boot, col = "lightblue")
abline(v = median(deltamuhat.boot), col = "blue") 
abline(v = quantile(deltamuhat.boot, probs = c(0.025, 0.975)), col = "red", lty = 2)

## ----echo=TRUE----------------------------------------------------------------
summary(betahat.boot)
confint(betahat.boot)

## ----echo=FALSE, eval = TRUE--------------------------------------------------
hist(betahat.boot)

## ----echo=TRUE, out.width="99%"-----------------------------------------------
library(boot)
# function to obtain deltamu hat
deltamu <- function(data, indices) {
	# allows boot to select sample
	d <- data[indices,] 
	fit <- lm(alt ~ South, data=d)
	coef(fit)["South"]
}

results <- boot::boot(data = depths,
statistic = deltamu, R=999)

boot.ci(results)

## ----echo=TRUE, eval = TRUE---------------------------------------------------
plot(results)

## ----echo = TRUE, out.width="0.5\\textwidth"----------------------------------
one.test <- function(x,y) {
   xstar <- sample(x)
   mean(y[xstar==1]) - mean(y[xstar==0])
}
	
null.dist <- replicate(1000, one.test(x = depths$South, y = depths$alt))
hist(null.dist)
abline(v=coef(fit)["South"], lwd=2, col="blue")
mean(abs(null.dist) > abs(coef(fit)["South"]))

## ----eval=TRUE, echo=TRUE-----------------------------------------------------
# note: we are now using glm
fit <- glm(alt ~ South, data = depths, family = gaussian(link=log))
print(summary(fit), signif.stars = F)

## ----echo=FALSE, comment = NA, size = 'tiny'----------------------------------
print(sessionInfo(), locale = FALSE)

