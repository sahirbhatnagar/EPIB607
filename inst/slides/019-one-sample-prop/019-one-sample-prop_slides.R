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

## ----eval=T, echo=F, fig.align="center", fig.height=7, fig.width=9, warning=FALSE, message=F----
expit = function(x) exp(x)/(1+exp(x)) # antilogit

par(mfrow=c(1,1),mar = rep(0.01,4))

plot(c(-0.75,4),c(1,4.5),col="white",axes=FALSE,frame=FALSE)


segments(0.5,1:4,4,1:4,col="blue",lwd=2)
segments(1:4,1,1:4,4,col="blue",lwd=2)

CEX=1.25

x=0.5
dy=0.2
dx=0.25
for(row in 3:1) {
if(row==3) {txt = expression(mu);TXT="MEAN"}
if(row==2) {txt = expression(pi);TXT="PROPORTION"}
if(row==1) {txt = expression(lambda);TXT="RATE"}
text(x-0.1,row+.5,txt,cex=2*CEX,adj=c(0,.5))
text(x-0.25-0.05,row+.5,TXT,adj=c(1,0.5),cex=CEX)
if(row==1)text(x-0.25-0.05,row+.35,"(Number of events
per unit time)",
adj=c(1,1),cex=0.8*CEX)
arrows(x+dx, row+dy, x+dx,row+1-dy,angle=30,
length=0.07-0.07*(row==2),code=2+(row==3))
if(row<3) text(x+dx,row+dy,"0",adj=c(1.5,0.5))
if(row==2)text(x+dx,row+1-dy,"1",adj=c(1.5,0.5))
}

dy=0.2
text( 2+0.5,4.45, "Number of Parameters",cex=1.75,adj=c(0.5,1))

text( 0,4.3, "Parameter\nGenre", cex=1.75,adj=c(0.5,0))
arrows(0,4.25,0,3.9,length=0.07,angle=35,lwd=2)
for(col in 1:3) {
x=col+0.5; 
text(col+0.5, 4.15, c("1","2","?")[col],
adj=c(0.5,1),cex=1.5)
if(col==1) dx=0.05
if(col==2) dx=0.3
for(row in 3:1){
segments(col+0.5-dx,row+dy,col+0.5+dx,row+dy)
if(col>1)text(col+0.5-dx,row+dy,"0",adj=c(0.5,1.75))
if(col==2) text(col+0.5+dx,row+dy,"1",adj=c(0.5,1.75))
if(col==3) {
xx=seq(col+0.5-dx,col+0.5+dx,dx/10)
segments(xx,row+dy,xx,row+dy-0.03)       
}
txt=expression(X)
if(col==1) txt = expression(X %==% 1)
text(col+0.5,row+dy/3,txt,font=2)
if(col==1) { m= (2/3)*(1-2*dy)
points(col+0.5,row+dy+m,pch=19,cex=0.6)
}
if(col==2) { m= ((1:2)/3)*(1-2*dy)
points(col+0.5+c(-dx,dx),row+dy+m,pch=19,cex=0.6)
}
if(col==3) { m= ((3:12)/14)*(1-2*dy)
xx=seq(-dx,dx,length.out=10)
points(col+0.5+xx,row+dy+m,pch=19,cex=0.6-0.3*(row<3))
if(row==2){
logit = seq(-3,3,length.out=10)
m=expit(logit)*(1-2*dy)
points(col+0.5+xx,row+dy+m,pch=19,cex=0.6)
}
if(row==1){
log.rate = seq(-1.7,0.1,length.out=10)
m=exp(log.rate)*(1-2*dy)
points(col+0.5+xx,row+dy+m,pch=19,cex=0.6)
}
}
} 
}


## ----fig.asp = 0.858, echo = FALSE, eval = TRUE-------------------------------
source("MakeBinomial3.R")

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
stats::dbinom(x = 3, size = 10, prob = 0.2)

## ----echo=TRUE, eval=TRUE, fig.width = 6, fig.height = 4----------------------
plot(0:10/10, dbinom(x = 0:10, size = 10, prob = 0.2), type = "h")

## ----fig.asp = 0.681----------------------------------------------------------
par(mfrow=c(2,2))
hist(rbinom(1000, 5, 0.3)/5)
hist(rbinom(1000, 10, 0.3)/10)
hist(rbinom(1000, 20, 0.3)/20)
hist(rbinom(1000, 100, 0.3)/100)

## ----fig.width = 6, fig.height = 5--------------------------------------------
par(mfrow=c(2,2))
hist(rbinom(1000, 5, 0.3))
hist(rbinom(1000, 10, 0.3))
hist(rbinom(1000, 20, 0.3))
hist(rbinom(1000, 100, 0.3))

## ----echo = TRUE, eval = TRUE, fig.asp = 0.618--------------------------------
mosaic::xpbinom(q = c(165, 180), size = 200, prob = 0.85)

## ----echo = TRUE, eval = TRUE, fig.asp = 0.618--------------------------------
mosaic::xpnorm(q = c(165,180), mean = 200 * 0.85, 
sd = sqrt(200*0.85*0.15))

## ----echo = TRUE, eval = TRUE-------------------------------------------------
stats::dbinom(x = 0, size = 5, prob = 0.066)
(1-0.066)^5

## ----echo = TRUE, eval = TRUE-------------------------------------------------
stats::dbinom(x = 1, size = 5, prob = 0.066)

## ----echo = TRUE, eval = TRUE, fig.asp = 0.218--------------------------------
stats::dbinom(x = 0, size = 5, prob = 0.066) + 
stats::dbinom(x = 1, size = 5, prob = 0.066)
stats::pbinom(q = 1, size = 5, prob = 0.066)
mosaic::xpbinom(q = 1, size = 5, prob = 0.066)

## ----echo = TRUE, eval = TRUE, fig.asp = 0.318--------------------------------
1 - stats::pbinom(q = 1, size = 5, prob = 0.066)
mosaic::xpbinom(q = 1, size = 5, prob = 0.066, lower.tail = FALSE)

## ----echo = TRUE, eval = TRUE, fig.asp = 0.308--------------------------------
n <- 1921
number_infected <- 515
p <- number_infected / n
s <- sqrt(p * (1 - p))
SEP <- s / sqrt(n)
mosaic::xqnorm(p=c(0.005,0.995), mean = p, sd = SEP)

## ----echo = TRUE, eval = TRUE, fig.asp = 0.308, size = "tiny"-----------------
mosaic::binom.test(x = 515, n = 1921, ci.method=c("wald"), conf.level=0.99)

## ----echo = TRUE, eval = TRUE, fig.asp = 0.308, size = "tiny"-----------------
mosaic::binom.test(x = 4, n = 5, ci.method=c("wald"), conf.level=0.95)

## ----echo = TRUE, eval = TRUE, fig.asp = 0.308--------------------------------
stats::qnorm(p=c(0.025,0.975), mean = 0, sd = sqrt(0 * 1 / 5))
stats::qnorm(p=c(0.025,0.975), mean = 0.2, sd = sqrt(0.2 * 0.8 / 5))
stats::qnorm(p=c(0.025,0.975), mean = 0.4, sd = sqrt(0.4 * 0.6 / 5))
stats::qnorm(p=c(0.025,0.975), mean = 0.6, sd = sqrt(0.6 * 0.4 / 5))
stats::qnorm(p=c(0.025,0.975), mean = 0.8, sd = sqrt(0.8 * 0.2 / 5))
stats::qnorm(p=c(0.025,0.975), mean = 1, sd = sqrt(1 * 0 / 5))

## ----wilson, echo = FALSE, eval = TRUE, fig.asp=.75, cache=FALSE--------------
source("wilsonCI.R")

## ----echo=TRUE----------------------------------------------------------------
mosaic::binom.test(x=4, n=5, ci.method=c("Clopper-Pearson"))
mosaic::binom.test(x=16, n=20, ci.method=c("Clopper-Pearson"))

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
fit <- glm(cbind(16,4) ~ 1, family=binomial)

## ----results='asis', echo = FALSE---------------------------------------------
xtable::xtable(fit)

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
plogis(fit$coef[1])
round(plogis(confint(fit)),2)

## ----echo=FALSE, comment = NA, size = 'tiny'----------------------------------
print(sessionInfo(), locale = FALSE)

