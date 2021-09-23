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

## ----cor-hist, echo = c(1,2),fig.asp = 0.381----------------------------------
library(oibiostat); data("famuss"); B <- 1000; N <- 595
R <- replicate(B, {
  dplyr::sample_n(famuss, size = N, replace = TRUE) %>% 
  dplyr::summarize(r = cor(height, weight)) %>% 
  dplyr::pull(r)
})
hist(R, breaks = 20, col = "lightblue", xlab = "", 
    main = "Distribution of samples of size 595")
		abline(v = mean(R), col = "red", lwd = 2)
		abline(v = quantile(R, probs = c(0.025, 0.975)), col = "blue", 
		lty = 2, lwd = 2)

## ----read-data,echo=FALSE, eval=TRUE------------------------------------------
water_results <- read.csv("EPIB607_FALL2018_water_exercise - water.csv", as.is=TRUE)
water_results <- water_results[,1:6]
water_results <- water_results[complete.cases(water_results), ]
# count the number of students who provided a mean and proportion
N.r <- nrow(water_results)

## ----echo=FALSE, fig.asp = 0.681----------------------------------------------
par(mfrow=c(2,1), mai = c(0.45,0.45,0.45,0.1))
plot(table(water_results[,"PropnW.5.locations"]), 
xlim = c(0,1),
xlab = "Students' Estimates of Proportion Covered by Water",
main = "n = 5", 
ylim = c(0, N.r/1.5), 
ylab = "Frequency")
abline(v=0.71, col = "#009E73", lty = 2)
text(0.72, 40, expression(mu))
text(0.76, 41, "=0.71")
plot(table(water_results[,"PropnW.20.locations"]), 
xlim = c(0,1),
xlab = "Students' Estimates of Proportion Covered by Water",
main = "n = 20", 
ylim = c(0, N.r/1.5), 
ylab = "Frequency")
abline(v=0.71, col = "#009E73", lty = 2)
text(0.72, 40, expression(mu))
text(0.76, 41, "=0.71")

## ----echo=FALSE, eval=TRUE, message = FALSE, warning = FALSE, fig.asp = 0.581----
library(mosaic)
library(tidyr)

# first 'melt' the data to get it in plotting form
m.melt <- water_results %>% tidyr::gather(key = "type", value = "value", -X., -student)

# subset for means
m.melt.means <- subset(m.melt, type %in% c("Mean.20.depths","Mean.5.depths"))

# plot for means
#gf_density(~ value, data = m.melt.means, fill = ~ type) + theme_bw()

# subset for proportions
m.melt.props <- subset(m.melt, type %in% c("PropnW.20.locations","PropnW.5.locations"))


## ----echo=FALSE, fig.asp = 0.581----------------------------------------------
# plot for proportions
gf_histogram(~ value, data = m.melt.props, fill = ~ type, position = "dodge") + theme_bw()

## ----echo=FALSE, fig.asp = 0.681----------------------------------------------
d.BREAKS <- seq(1000,6000,500)
par(mfrow=c(2,1), mai = c(0.45,0.45,0.45,0.1))
hist(water_results[,"Mean.5.depths"], 
xlim = c(0,6000),
ylim = c(0, N.r/1.5), 
breaks = d.BREAKS,
xlab = "Students' Estimates of Mean Ocean Depth (m)",
main = "n = 5")
abline(v=3700, col = "#009E73", lty = 2)
text(3800, 45, expression(mu))
text(4100, 46, "=3700m")
hist(water_results[,"Mean.20.depths"], 
xlim = c(0,6000),
ylim = c(0, N.r/1.5), 
breaks = d.BREAKS,
xlab = "Students' Estimates of Mean Ocean Depth (m)",
main = "n = 20")
abline(v=3700, col = "#009E73", lty = 2)
text(3800, 45, expression(mu))
text(4100, 46, "=3700m")

## ----echo=FALSE, fig.asp = 0.681----------------------------------------------
# plot for means
gf_density(~ value, data = m.melt.means, fill = ~ type) + theme_bw()

## ----echo=FALSE, eval=FALSE---------------------------------------------------
#  allLocations <- read.csv("~/git_repositories/epib607/data/earth-locations-20180914.csv")
#  allLocations$water  = 1*(allLocations$alt < 0)
#  plot(allLocations$lon[allLocations$water==1],
#  allLocations$lat[allLocations$water==1],
#  col="#0072B2",cex=0.02, xlab = "longitude", ylab = "latitude")

## ----echo=FALSE, eval=FALSE---------------------------------------------------
#  ew=allLocations$lon[allLocations$water==1]
#  ns=allLocations$lat[allLocations$water==1]
#  plot(ew*cos(pi*ns/180),
#  allLocations$lat[allLocations$water==1],
#  col="#0072B2",cex=0.02, xlab = "longitude", ylab = "latitude")

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

## ----echo = TRUE, eval = FALSE------------------------------------------------
#  pacman::p_load(mosaic)
#  pacman::p_load(manipulate)
#  
#  mNorm <- function(mean = 0, sd = 1) {
#  lo <- mean - 5 * sd
#  hi <- mean + 5 * sd
#  manipulate(
#  xpnorm(c(A,B), mean, sd, verbose = FALSE, invisible = TRUE),
#  A = slider(lo, hi, initial = mean - sd),
#  B = slider(lo, hi, initial = mean + sd)
#  )
#  }
#  mNorm(mean = 0, sd = 1)

## ----echo=FALSE, comment = NA, size = 'tiny'----------------------------------
print(sessionInfo(), locale = FALSE)

## ----echo=FALSE, fig.show="hold", eval=FALSE----------------------------------
#  depthsOfWater = allLocations[allLocations$water==1,]
#  depthsOfWater$depth = -depthsOfWater$alt
#  par(mar = c(4,4,1,0.1))
#  for (panel in 1){
#  
#  # depths
#  
#  if(panel==1) y = round(depthsOfWater$depth/100)
#  if(panel==2) y = round(heightsOfLand$alt/100)
#  
#  f = table(y)
#  #str(f)
#  x=as.numeric(dimnames(f)[[1]])
#  Y=0:max(x) ;
#  FREQ=approx(x,f,Y)$y
#  #plot(Y,FREQ,type="l")
#  
#  #( n.bins=length(FREQ) )
#  
#  max.Y = max(Y);
#  
#  max.X = max.Y
#  if (panel==2) max.X =25
#  
#  M = 1.05*max(f)
#  
#  FREQ[1+Y] =  FREQ/sum(FREQ)
#  
#  AVE = sum(Y*FREQ)
#  SD = sqrt(sum( FREQ*(Y-AVE)^2 ) )
#  
#  already = FREQ
#  
#  max.n = 16; show=c(1,2,3,4,5,5,6,7,8,9,16)
#  
#  YLIM=sqrt(max.n/(panel^2.5))*max(FREQ)*c(-0.11,0.75)
#  
#  XLAB=c("OCEAN DEPTH","LAND ELEVATION")
#  plot(Y,already,pch=19,lwd=1,col="white",
#  type="l",ylim=YLIM, xlim=c(0,max.X),
#  ylab="Density", xlab=XLAB[panel] )
#  polygon(c(0,Y),c(0,FREQ),
#  col=c("lightblue","bisque","grey98")[panel],
#  border="grey10",lwd=1)
#  for(n in 2:max.n){
#  f = outer(already,FREQ)
#  f[1:5,1:5]
#  ff = sapply(split(f, col(f) + row(f)), sum)
#  ff[1:5]
#  ave = (0:(n* max.Y))/n
#  if( n %in% show ){
#  lines(ave,ff*n,col=n,lwd=4.5-4*(n-1)/n)
#  
#  text(1.5*AVE,max(ff*n),
#  paste("means of samples of size",toString(n)),
#  adj=c(0,0.5),col=n,cex=0.65)
#  }
#  already=as.numeric(ff)
#  }
#  segments(AVE,0, AVE, 1.1*max(FREQ),lty="dotted")
#  text(AVE,  0.35*YLIM[1],toString(round(AVE,0)), adj=c(0.5,1),
#  cex=0.85 )
#  txt= "Ocean Depths
#  (units = 100m)"
#  if(panel==2) txt="Land Elevations
#  (units = 100m)"
#  text(AVE+5,0.7*YLIM[1],txt,
#  col="lightblue",adj=c(0,0.5),font=2)
#  text(0.85*AVE,0.35*YLIM[1],expression(mu), adj=c(0.5,1.25),
#  cex=0.95 )
#  text(AVE,  0.99*YLIM[1], toString(round(SD,0)), adj=c(0.5,0),
#  cex=0.85 )
#  text(0.85*AVE,0.99*YLIM[1],expression(sigma), adj=c(0.5,0),
#  cex=0.95 )
#  for(a in AVE+(-20:20)) segments(a,0,a,0.1*YLIM[1])
#  for(a in AVE+c(-20,-15,-10,-5,0,5,10,15,20)) segments(a,0,a,0.2*YLIM[1])
#  
#  }

## ----eval=FALSE, echo = TRUE--------------------------------------------------
#  plot(dt$Mean.5.depths, 1:nrow(dt), pch=20,
#  xlim=range(pretty(c(dt$lower.mean.5.66, dt$upper.mean.5.66))),
#  xlab='Depth of ocean (m)', ylab='Student (sample)',
#  las=1, cex.axis=0.8, cex=1.5)
#  abline(v = 3700, lty = 2, col = "red", lwd = 2)
#  segments(x0 = dt$lower.mean.5.66, x1=dt$upper.mean.5.66,
#  y0 = 1:nrow(dt), lend=1)

