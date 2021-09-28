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

## ----fig.asp = 0.518, fig.cap = 'Ideal world. Sampling distributions are obtained by drawing repeated samples from the population, computing the statistic of interest for each, and collecting (an infinite number of) those statistics as the sampling distribution'----
source("sampling_dist_figure.R")

## ----fig.cap="The original data distribution of sampled depths of the ocean. Note that it has multiple modes and not Normal looking.", fig.asp=0.718----
allLocations <- read.csv("~/git_repositories/EPIB607-f19/data/earth-locations-20180914.csv")
allLocations$water  = 1*(allLocations$alt < 0)

# water only
depthsOfWater = allLocations[allLocations$water==1,]
depthsOfWater$depth = -depthsOfWater$alt
panel = 1
if(panel==1) y = round(depthsOfWater$depth/100)
f = table(y)
x=as.numeric(dimnames(f)[[1]])
Y=0:max(x) 
FREQ=approx(x,f,Y)$y
n.bins=length(FREQ)
max.Y = max(Y); 
max.X = max.Y
M = 1.05*max(f)
FREQ[1+Y] =  FREQ/sum(FREQ)
AVE = sum(Y*FREQ)
SD = sqrt(sum( FREQ*(Y-AVE)^2 ) )
alreadyOrig = FREQ
already = FREQ
max.n = 16; 
show=c(1,2,3,4,5,5,6,7,8,9,16)
YLIM=sqrt(max.n/(panel^2.5))*max(FREQ)*c(-0.11,0.75)
XLAB=c("OCEAN DEPTH (units = 100m)","LAND ELEVATION")

SE <- 4.20
plot(Y,already,pch=19,lwd=1,col="white",
type="l",ylim=YLIM, xlim=c(0,max.X),
ylab="Density", xlab=XLAB[panel] )
polygon(c(0,Y),c(0,FREQ),
col=c("#56B4E9","bisque","grey98")[panel],
border="grey10",lwd=1)
legend("topright", legend = "Y: Depths of the ocean", 
col = "#56B4E9", pch = 15, pt.cex = 2, bty="n")

## ----fig.cap="The sampling distribution for the mean depth of the ocean with samples of size $n=16$, looks normal (centered at $\\mu=37$ and SD equal to $\\sigma/\\sqrt{16}$) ", fig.asp=0.618----
plot(Y,already,pch=19,lwd=1,col="white",
type="l",ylim=YLIM, xlim=c(0,max.X),
ylab="Density", xlab=XLAB[panel] )
polygon(c(0,Y),c(0,FREQ),
col=c("#56B4E9","bisque","grey98")[panel],
border="grey10",lwd=1)
# legend("topright", legend = "Y: Depths of the ocean", 
#        col = "#56B4E9", pch = 15, pt.cex = 2)
curve(dnorm(x,mean = AVE,sd = SE), add = TRUE, lwd = 2) 
# text(1.5*AVE,0.08,
#      paste("means of samples of size",toString(16)),
#      adj = c(0,0.5),
#      col = viridis::inferno(9, end = 0.7, direction = 1)[1],
#      cex = 0.95)
legend("topright", legend = c("Y: Depths of the ocean",
"Sampling distribution for \n means of samples of \n size 16"),
col = c("#56B4E9","black"), 
bty = "n",
pch = c(15,NA), lty = c(NA,1), pt.cex = 2, lwd = c(NA,2))
segments(AVE,0, AVE, 0.10,lty="dotted")
text(AVE*1.05,  0.15*YLIM[1],toString(round(AVE,0)), adj=c(0.5,1),
cex=0.85 )
text(0.95*AVE,0.18*YLIM[1],expression(mu), adj=c(0.5,1.25),
cex=0.95 )
text(.99*AVE,0.07*YLIM[1],"=", adj=c(0.5,1.25),
cex=0.95 )
arrows(x0 = AVE, x1 = AVE + SE, y0 = 0.055, length = 0.05)
segments(AVE + SE,0, AVE + SE, 0.06,lty="dotted")
#text(x = AVE*1.05, y = 0.051, '{', srt = 90, cex = 1.5, family = 'Helvetica Neue UltraLight')
text((AVE)*1.33,0.06,latex2exp::TeX("$\\sigma / \\sqrt{16}=4.2$"), adj=c(0.5,1.25),
cex=0.95 )

## ----fig.asp = 0.325, echo = TRUE, fig.width = 5------------------------------
mosaic::xqnorm(p = c(0.025, 0.975))

## ----fig.cap="68\\% Confidence interval calculated using  \\mbox{\\texttt{qnorm(p = c(0.16,0.84), mean = 37, sd = 4.2)}}", fig.asp=0.618----
# with 68% ci
plot(Y,already,pch=19,lwd=1,col="white",
type="l",ylim=YLIM, xlim=c(0,max.X),
ylab="Density", xlab=XLAB[panel] )
polygon(c(0,Y),c(0,FREQ),
col=c("#56B4E9","bisque","grey98")[panel],
border="grey10",lwd=1)
# legend("topright", legend = "Y: Depths of the ocean", 
#        col = "#56B4E9", pch = 15, pt.cex = 2)
curve(dnorm(x,mean = AVE,sd = SE), add = TRUE, lwd = 2) 
# text(1.5*AVE,0.08,
#      paste("means of samples of size",toString(16)),
#      adj = c(0,0.5),
#      col = viridis::inferno(9, end = 0.7, direction = 1)[1],
#      cex = 0.95)
lower.x <- qnorm(p = c(0.16), AVE, SE)
upper.x <- qnorm(p = c(0.84), AVE, SE)
legend("topright", legend = c("Y: Depths of the ocean",
"Sampling distribution for \n means of samples of size 16",
sprintf("68%% Confidence interval for \n the mean depth of the ocean:\n [%.f, %.f]",
lower.x, upper.x)),
col = c("#56B4E9","black",RColorBrewer::brewer.pal(9, "Set1")[4]), 
y.intersp = 2,
bty = "n",
pch = c(15,NA,15), lty = c(NA,1,NA), pt.cex = 2, lwd = c(NA,2,NA))
segments(AVE,0, AVE, 0.10,lty="dotted")
# text(AVE*1.05,  0.15*YLIM[1],toString(round(AVE,0)), adj=c(0.5,1),
#      cex=0.85 )
# text(0.95*AVE,0.15*YLIM[1],expression(mu), adj=c(0.5,1.25),
#      cex=0.95 )
# text(.99*AVE,0.07*YLIM[1],"=", adj=c(0.5,1.25),
#      cex=0.95 )
# arrows(x0 = AVE, x1 = AVE + SE, y0 = 0.055, length = 0.05)
# segments(AVE + SE,0, AVE + SE, 0.06,lty="dotted")
# #text(x = AVE*1.05, y = 0.051, '{', srt = 90, cex = 1.5, family = 'Helvetica Neue UltraLight')
# text((AVE)*1.25,0.06,latex2exp::TeX("$\\sigma / \\sqrt{16}$"), adj=c(0.5,1.25),
#      cex=0.95 )

step <- (upper.x - lower.x) / 100
bounds <- c(lower.x, upper.x)
cord.x <- c(lower.x,seq(lower.x,upper.x,step),upper.x)
cord.y <- c(0,dnorm(seq(lower.x,upper.x,step),AVE,SE),0)
polygon(cord.x,cord.y,col=RColorBrewer::brewer.pal(9, "Set1")[4])
text(lower.x, -0.005, round(lower.x, 0))
text(upper.x, -0.005, round(upper.x, 0))
segments(AVE,0, AVE, 0.10,lty="dotted")

## ----fig.cap="95\\% Confidence interval calculated using  \\mbox{\\texttt{qnorm(p = c(0.025,0.975), mean = 37, sd = 4.2)}}", fig.asp=0.618----
# with 95% ci
plot(Y,already,pch=19,lwd=1,col="white",
type="l",ylim=YLIM, xlim=c(0,max.X),
ylab="Density", xlab=XLAB[panel] )
polygon(c(0,Y),c(0,FREQ),
col=c("#56B4E9","bisque","grey98")[panel],
border="grey10",lwd=1)
# legend("topright", legend = "Y: Depths of the ocean", 
#        col = "#56B4E9", pch = 15, pt.cex = 2)
curve(dnorm(x,mean = AVE,sd = SE), add = TRUE, lwd = 2) 
# text(1.5*AVE,0.08,
#      paste("means of samples of size",toString(16)),
#      adj = c(0,0.5),
#      col = viridis::inferno(9, end = 0.7, direction = 1)[1],
#      cex = 0.95)
lower.x <- qnorm(p = c(0.025), AVE, SE)
upper.x <- qnorm(p = c(0.975), AVE, SE)
legend("topright", legend = c("Y: Depths of the ocean",
"Sampling distribution for \n means of samples of size 16",
sprintf("95%% Confidence interval for \n the mean depth of the ocean:\n [%.f, %.f]",
lower.x, upper.x)),
col = c("#56B4E9","black",RColorBrewer::brewer.pal(9, "Set1")[5]), 
y.intersp = 2,
bty = "n",
pch = c(15,NA,15), lty = c(NA,1,NA), pt.cex = 2, lwd = c(NA,2,NA))

# text(AVE*1.05,  0.15*YLIM[1],toString(round(AVE,0)), adj=c(0.5,1),
#      cex=0.85 )
# text(0.95*AVE,0.15*YLIM[1],expression(mu), adj=c(0.5,1.25),
#      cex=0.95 )
# text(.99*AVE,0.07*YLIM[1],"=", adj=c(0.5,1.25),
#      cex=0.95 )
# arrows(x0 = AVE, x1 = AVE + SE, y0 = 0.055, length = 0.05)
# segments(AVE + SE,0, AVE + SE, 0.06,lty="dotted")
# #text(x = AVE*1.05, y = 0.051, '{', srt = 90, cex = 1.5, family = 'Helvetica Neue UltraLight')
# text((AVE)*1.25,0.06,latex2exp::TeX("$\\sigma / \\sqrt{16}$"), adj=c(0.5,1.25),
#      cex=0.95 )

step <- (upper.x - lower.x) / 100
bounds <- c(lower.x, upper.x)
cord.x <- c(lower.x,seq(lower.x,upper.x,step),upper.x)
cord.y <- c(0,dnorm(seq(lower.x,upper.x,step),AVE,SE),0)
polygon(cord.x,cord.y,col=RColorBrewer::brewer.pal(9, "Set1")[5])
text(lower.x, -0.005, round(lower.x, 0))
text(upper.x, -0.005, round(upper.x, 0))
segments(AVE,0, AVE, 0.10,lty="dotted")

## ----fig.asp = 0.518, fig.cap = '\\scriptsize{Ideal world. Sampling distributions are obtained by drawing repeated samples from the population, computing the statistic of interest for each, and collecting (an infinite number of) those statistics as the sampling distribution}'----
source("sampling_dist_figure.R")

## ----fig.asp = 0.518, fig.cap = '\\scriptsize{Bootstrap world. The bootstrap distribution is obtained by drawing repeated samples from an estimate of the population, computing the statistic of interest for each, and collecting those statistics. The distribution is centered at the observed statistic ($\\bar{y}$), not the parameter ($\\mu$).}', eval = FALSE----
#  #rm(list=ls())
#  #source("bootstrap_figure.R")

## ----echo = FALSE, eval = FALSE-----------------------------------------------
#  source("https://raw.githubusercontent.com/sahirbhatnagar/epib607/master/inst/labs/
#          003-ocean-depths/automate_water_task.R")

## ----echo = c(7,8), message = FALSE, warning = FALSE, tidy = FALSE, fig.width = 7, fig.asp = 0.618----
source("https://raw.githubusercontent.com/sahirbhatnagar/epib607/master/inst/labs/003-ocean-depths/automate_water_task.R")
index.n.20 <- c(2106,2107,2108,2109,2110,2111,2112,
2113,2114,2115,2116,2117,2118,2119,
2120,2121,2122,2123,2124,2125)
depths.n.20 <- automate_water_task(index = index.n.20, 
student_id = 260194225, type = "depth")
depths.n.20$alt = round(depths.n.20$alt/100,0)
mm <- mean(depths.n.20$alt)
B <- 10000; N <- nrow(depths.n.20)
R <- replicate(B, {
  dplyr::sample_n(depths.n.20, size = N, replace = TRUE) %>%
  dplyr::summarize(r = mean(alt)) %>%
  dplyr::pull(r)
})
CI_95 <- quantile(R, probs = c(0.025, 0.975))
hist(R, breaks = 50, col = "#56B4E9",
main="",
xlab = "mean depth of the ocean (100m) from \neach bootstrap sample")
abline(v = mm, lty =1, col = "red", lwd = 4)
abline(v = CI_95[1], lty =2, col = "black", lwd = 4)
abline(v = CI_95[2], lty =2, col = "black", lwd = 4)
library(latex2exp)
#text(mm*1.10, 1150, TeX("$\\bar{y} = 36$"))
legend("topleft", legend = c(TeX("$\\bar{y} = 36$"),sprintf("95%% CI: [%.f, %.f]",CI_95[1], CI_95[2])), 
lty = c(1,1), 
col = c("red","black"), lwd = 4)

## ----eval = FALSE, echo=TRUE--------------------------------------------------
#  # function for sampling ocean depths
#  source("https://raw.githubusercontent.com/sahirbhatnagar/EPIB607/master/labs/
#        003-ocean-depths/automate_water_task.R")
#  
#  # from the in-class exercise
#  index.n.20 <- c(2106,2107,2108,2109,2110,2111,2112,
#  2113,2114,2115,2116,2117,2118,2119,
#  2120,2121,2122,2123,2124,2125)
#  
#  # get depths of ocean sample n=20
#  depths.n.20 <- automate_water_task(index = index.n.20,
#                 student_id = 260194225, type = "depth")
#  
#  # change to 100m units
#  depths.n.20$alt = round(depths.n.20$alt/100,0)
#  
#  B <- 10000; N <- nrow(depths.n.20)
#  R <- replicate(B, {
#  dplyr::sample_n(depths.n.20, size = N, replace = TRUE) %>%
#  dplyr::summarize(r = mean(alt)) %>%
#  dplyr::pull(r)
#  })
#  
#  CI_95 <- quantile(R, probs = c(0.025, 0.975))
#  

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  # plot sampling distribution
#  hist(R, breaks = 50, col = "#56B4E9",
#  main="",
#  xlab = "mean depth of the ocean (100m) from each bootstrap sample")
#  
#  # draw red line at the sample mean
#  abline(v = mean_depth, lty =1, col = "red", lwd = 4)
#  
#  # draw black dotted lines at 95% CI
#  abline(v = CI_95[1], lty =2, col = "black", lwd = 4)
#  abline(v = CI_95[2], lty =2, col = "black", lwd = 4)
#  
#  # include legend
#  library(latex2exp)
#  legend("topleft",
#  legend = c(TeX("$\\bar{y} = 36$"),
#  sprintf("95%% CI: [%.f, %.f]",CI_95[1], CI_95[2])),
#  lty = c(1,1),
#  col = c("red","black"), lwd = 4)
#  
#  
#  
#  

## ----echo=FALSE, comment = NA, size = 'tiny'----------------------------------
print(sessionInfo(), locale = FALSE)

