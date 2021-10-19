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

## ----echo = TRUE, fig.asp=0.601-----------------------------------------------
library(oibiostat); data("famuss")
library(ggplot2)
library(colorspace)

ggplot(famuss, aes(x = actn3.r577x, y = bmi, fill = actn3.r577x)) + 
geom_boxplot() + 
colorspace::scale_fill_discrete_qualitative()

## ----echo = TRUE, fig.asp=0.681-----------------------------------------------
sjPlot::plot_xtab(famuss$race, famuss$actn3.r577x, margin = "row")

## ----echo = TRUE, fig.asp=0.681-----------------------------------------------
ggplot(famuss, aes(x = height, y = weight, color = bmi)) + 
geom_point() + 
colorspace::scale_color_continuous_sequential(palette = "Viridis")

## ----echo=TRUE----------------------------------------------------------------
pacman::p_load(RColorBrewer)
RColorBrewer::display.brewer.all()

## ----echo=FALSE, eval=TRUE, message=FALSE, size = 'footnotesize', comment=''----
df <- read.csv("https://raw.githubusercontent.com/sahirbhatnagar/cleandata/master/data/fullmoon.csv",
header = TRUE)
set.seed(123)
knitr::kable(df[1:7,], row.names = FALSE)

## ----echo=1, eval=FALSE, message=FALSE, size = 'tiny', comment=''-------------
#  tidyr::pivot_longer(data = df, cols = -patient, names_to = "day_type", values_to = "mean_behavior")

## ----echo=FALSE, eval=TRUE, message=FALSE, size = 'footnotesize', comment=''----
df_tidy <- df %>% gather(day_type, mean_behavior,-patient) %>% mutate(patient = factor(patient), day_type = factor(day_type))
set.seed(1234)

## ----echo=TRUE, eval=FALSE, message=FALSE, size = 'tiny', comment=''----------
#  ggplot(data = df_tidy, mapping = aes(x = day_type, y = mean_behavior, group = patient)) + geom_line()

## ----echo=FALSE, eval=TRUE, message=FALSE, size = 'tiny', comment='', fig.asp=0.67----
ggplot(data = df_tidy, mapping = aes(x = day_type, y = mean_behavior, group = patient)) + geom_line() + ggpubr::theme_pubr()

## ----echo=TRUE, eval=TRUE, message=FALSE, size = 'tiny'-----------------------
fit <- lme4::lmer(mean_behavior ~ day_type + (1|patient), data = df_tidy)
summary(fit)

## ----echo = TRUE, fig.asp=0.601, size = 'small'-------------------------------
library(oibiostat); data("famuss")
library(dplyr)

famuss %>% 
dplyr::group_by(actn3.r577x) %>%
dplyr::summarise(mean_bmi = mean(bmi), 
sd_bmi = sd(bmi))


## ----echo = TRUE, fig.asp=0.601, size = 'scriptsize'--------------------------
library(oibiostat); data("famuss")
library(dplyr)

f.male <- famuss %>% 
dplyr::filter(sex == "Male")


f.male.cauc <- famuss %>% 
dplyr::filter(sex == "Male" & race == "Caucasian")

f.bmi.low <- famuss %>% 
dplyr::filter(bmi <= 23)


## ----echo=FALSE, size = 'small'-----------------------------------------------
tab1 = data.frame(Value=c(0,1,2,3),Probability=c(.5,.25,.15,.1),Cum.Prob=c(.5,.75,.9,1))
knitr::kable(
tab1, 
booktabs = TRUE
)

## ----echo = TRUE, eval = FALSE------------------------------------------------
#  g.y <- function(y) {
#  (pi / 6) * y^3
#  }
#  
#  set.seed(12)
#  B <- 1000; N <- 2000
#  E_g.y <- replicate(B, {
#  diameter <- runif(N, min = 0, max = 10)
#  mean(g.y(diameter)) # E(g(y))
#  })
#  
#  g_E.y <- replicate(B, {
#  diameter <- runif(N, min = 0, max = 10)
#  g.y(mean(diameter)) # g(E(y))
#  })
#  
#  par(mfrow = c(1,2))
#  hist(E_g.y, col = "lightblue", xlab = "mean(g(y))",
#  main = sprintf("Average of E(g(Y)) over 1000\n replications
#  is %0.2f",mean(E_g.y)))
#  abline(v = mean(E_g.y), col = "red", lty = 2, lwd = 3)
#  
#  hist(g_E.y, col = "lightblue", xlab = "g(mean(y))",
#  main = sprintf("Average of g(E(Y)) over 1000\n replications
#  is %0.2f",mean(g_E.y)))
#  abline(v = mean(g_E.y), col = "red", lty = 2, lwd = 3)

## ----echo = FALSE, eval = TRUE------------------------------------------------
g.y <- function(y) {
(pi / 6) * y^3
}

set.seed(12)
B <- 1000; N <- 2000
E_g.y <- replicate(B, {
diameter <- runif(N, min = 0, max = 10)
mean(g.y(diameter)) # E(g(y))
})

g_E.y <- replicate(B, {
diameter <- runif(N, min = 0, max = 10)
g.y(mean(diameter)) # g(E(y))
})

par(mfrow = c(2,1))
hist(E_g.y, col = "lightblue", xlab = "mean(g(y))",
main = sprintf("Average of E(g(Y)) over 1000\n replications is %0.2f",mean(E_g.y)))
abline(v = mean(E_g.y), col = "red", lty = 2, lwd = 3)

hist(g_E.y, col = "lightblue", xlab = "g(mean(y))",
main = sprintf("Average of g(E(Y)) over 1000\n replications is %0.2f",mean(g_E.y)))
abline(v = mean(g_E.y), col = "red", lty = 2, lwd = 3)

## ----fig.width=8, fig.height=4, echo = TRUE-----------------------------------
set.seed(12)
B <- 999; N <- 200
var_diff <- replicate(B, {
RV1 <- rnorm(N, mean = 2, sd = 3)
RV2 <- rnorm(N, mean = 4, sd = 4)
var(RV1 - RV2)
})

hist(var_diff, col = "lightblue", xlab = "Var(RV1 - RV2)", 
main = sprintf("Median of Var(RV1-RV2) over 999 replications is %0.2f",median(var_diff)))
abline(v = median(var_diff), col = "red", lty = 2, lwd = 3)

## ----fig.asp = 0.518, fig.cap = 'Ideal world. Sampling distributions are obtained by drawing repeated samples from the population, computing the statistic of interest for each, and collecting (an infinite number of) those statistics as the sampling distribution'----
source("../bin/sampling_dist_figure.R")

## ----echo=FALSE, eval=TRUE----------------------------------------------------
water_results <- read.csv("EPIB607_FALL2018_water_exercise - water.csv", as.is=TRUE)
water_results <- water_results[,1:6]
water_results <- water_results[complete.cases(water_results), ]
#water_results[,1:6]
# count the number of students who provided a mean and proportion
N.r <- nrow(water_results)
#water_results[,"Mean.5.depths"]

## ----echo=FALSE, eval=TRUE, fig.width=6, fig.height=4-------------------------
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

## ----echo=FALSE, eval=TRUE----------------------------------------------------
water_results <- read.csv("EPIB607_FALL2018_water_exercise - water.csv", as.is=TRUE)
water_results <- water_results[,1:6]
water_results <- water_results[complete.cases(water_results), ]
#water_results[,1:6]
# count the number of students who provided a mean and proportion
N.r <- nrow(water_results)
#water_results[,"Mean.5.depths"]

## ----echo=FALSE, fig.width=6, fig.height=4------------------------------------
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

## ----probs2, echo = TRUE, fig.width = 3, fig.asp = 0.618, fig.align = 'center', out.width = "60%"----
stats::pnorm(q = 130, mean = 100, sd = 13)

## ----probs3, echo = TRUE, fig.width = 3, fig.asp = 0.618, fig.align = 'center', out.width = "60%"----
mosaic::xpnorm(q = 130, mean = 100, sd = 13)

## ----probs4, echo = TRUE, fig.width = 3, fig.asp = 0.618, fig.align = 'center', out.width = "60%"----
stats::qnorm(p = 0.0104, mean = 100, sd = 13)

## ----probs5, echo = TRUE, fig.width = 3, fig.asp = 0.618, fig.align = 'center', out.width = "60%"----
mosaic::xqnorm(p = 0.0104, mean = 100, sd = 13)

## ----eval=T, echo=F, fig.align="center", fig.height=7, fig.width=9, warning=FALSE, message=F----

dSemiElliptical = function(q,mean=0,radius=1) ( 2/(pi*radius^2) ) *
sqrt(radius^2 - (q-mean)^2)

pSemiElliptical =  function(q,mean=0,radius=1) 1/2 + 
(q*sqrt(radius^2-q^2))/(pi*radius^2) + asin(q/radius)/pi 

qSemiElliptical = function(p,mean=0,radius=1){
cdf = function(x) pSemiElliptical(x) - p 
root = uniroot(cdf, c(-1,1))$root
return(mean + root*radius)
}

rSemiElliptical =  function(n=1,mean=0,radius=1) {
q = rep(NA,n)
Max = dSemiElliptical(mean,mean,radius)
i = 0
while(i < n){
u = mean + runif(1,-radius,radius)
h = runif(1,0,Max)
d = dSemiElliptical(u,mean,radius)
if( h < d ) {i=i+1; q[i] = u}
}
return(q)
}

AGE = 18   # (7/8)*AGE

radius.as.proportion = 0.125

set.seed(1345437)
set.seed(2454375)

age.hats = rSemiElliptical(4, AGE, radius.as.proportion*AGE)

draw = function(conf.level){

q.u = qSemiElliptical( (1+conf.level)/2 )

half.alpha = toString( (1-conf.level)/2 )

a.min=14; a.max=22; da=2
beta = 1

dx=75
dy=0.4

a.bottom = a.min - 1.75*da

AGE = 18   # (7/8)*AGE

par(mar = c(0,0,0,0))


for (example in 1) {

n=1 ; if(example>1) n=4

age.hat = age.hats[1:n]

age.bar = mean(age.hat)

div = 1; if (conf.level < 1) div=sqrt(n)
u.at.a.max = (1+radius.as.proportion/div)*beta*(a.max+1)
l.at.a.max = (1-radius.as.proportion/div)*beta*(a.max+1)

u.at.a.min = (1+radius.as.proportion/div)*beta*a.min
l.at.a.min = (1-radius.as.proportion/div)*beta*a.min

plot(c(a.min,a.max),c(l.at.a.min,u.at.a.max),col="white",
xlim=c(a.min-1.35*da/2,a.max+2.75*da/2),
ylim=c(a.min-2.6*da,a.max+1.6*da), frame=FALSE,
xaxt ="n", yaxt="n")
lines(c(a.min-da/2,a.min-da/2,a.max+da/2),
c(a.max+da,a.min-2*da,a.min-2*da))
text(( a.min+a.max)/2,a.min-2.5*da,
"True Chronological Age (A)", adj=c(0.5,1),cex=1.25)
txt = "Indirect\nMeasure\nof Age (a)"
if(n>1) txt = "Indirect\nMeasures\nof Age (a)"
text(a.min-da/2.5, a.max+da, txt,
adj=c(0,1),cex=1.05,font=4)
for(a in seq(a.min,a.max,da/2)){
text(a,a.min-2*da,toString(a), adj=c(0.5,1.5))
segments(a, a.min-2*da, a, a.min-2.05*da)
text(a.min-da/2,a,toString(a),adj=c(1.5,0.5))
segments(a.min-da/2, a, a.min-da/2-da/20, a)
} 
polygon(c(a.min,a.min,
a.max+1,a.max+1,a.min),
c(l.at.a.min,u.at.a.min,
u.at.a.max,l.at.a.max, l.at.a.min),
col="grey90",border=NA)

segments(a.min,   a.min,
a.max+1, beta*(a.max+1),
col="white",lwd=2)

arrows(a.max+1.2, l.at.a.max,
a.max+1.2, u.at.a.max,
code=3,length=0.05,angle=35)
arrows(a.min-0.2, l.at.a.min,
a.min-0.2, u.at.a.min,
code=3,length=0.05,angle=35)
text(a.min -0.3, a.min, 
paste( toString(100*conf.level),"%",sep=""),
adj=c(0.5,0),srt=90,cex=1)

text(a.max+1.3, a.max+1, 
paste( toString(100*conf.level),"%",sep=""), cex = 1.25,
adj=c(0,0.5))

UU = 100 ; LL = 0

for (i in 1:n){
points(a.min-da/2 + i/6, age.hat[i], pch=19,cex=0.5)
if(conf.level < 1 & i==n & n>1) segments(
a.min-da/2 + 1/6 , age.bar ,
a.min-da/2 + n/6 , age.bar ) 
if(example==1) text(a.min-da/3,age.hat[i],
toString(round(age.hat[i],1)), cex=0.85,
adj=c(0,0.5),font=4)
M = age.hat[i] ; if(conf.level < 1 & n> 1) M = age.bar
L = M/(1+radius.as.proportion/div)
R = M/(1-radius.as.proportion/div)
segments(L, M, R, M, lty="dotted")
for(a in c(L,M,R)){
if(example==1 | conf.level < 1) arrows( 
a, a.bottom+3.5*dy,
a, a.bottom+1.5*dy, 
length=0.07,angle=30)
if(example==1 & a==L){

aA  = toString(round(M,1))
AA  = toString(round(L,1))
txt = substitute(paste(
"P[ a > ",aA,
" | A =",AA, " ] = ", Pval,sep=""),
list(aA=aA,AA=AA,Pval=half.alpha))
arrows( 
a, L,
a, M,lwd=2,angle=35,length=0.07)
text(L,L,toString(round(L,1)),adj=c(0.5,1.5))
text(L,M+0.25,txt,adj=c(0,0.5),srt=75)
} 
if(example==1 & a==R){
aA  = toString(round(M,1))
AA  = toString(round(R,1))
txt = substitute(paste(
"P[ a < ",aA,
" | A =",AA, " ] = ", Pval,sep=""),
list(aA=aA,AA=AA,Pval=half.alpha))
arrows( 
a, R,
a, M,lwd=2,angle=35,length=0.07,code=2)
text(R,R,toString(round(R,1)),adj=c(0.5,-0.5))
text(R,M-0.25,txt,adj=c(0,0.5),srt=-55)
} 
}
if(conf.level ==1 | (conf.level < 1 & i==1 ) ) {
segments(L,a.bottom + i*dy, R,a.bottom + i*dy,lwd=1.25)
points(M,a.bottom+i*dy, pch=19,cex=0.5)
Limits = round(c(L,R),1)
if(conf.level < 1 | example == 1 ) text(L-0.1,a.bottom + i*dy,
toString(Limits[1]), adj=c(1,0.5),cex=0.8,font=2)
if(conf.level < 1 | example == 1)  text(R+0.1,a.bottom + i*dy,
toString(Limits[2]), adj=c(0,0.5),cex=0.8,font=2)
}

UU = min(UU,R)
LL = max(LL,L)
} # i

if(example > 1 & conf.level==1){
segments(LL, a.bottom, UU,  a.bottom, 
lwd=3)
segments(LL, a.bottom+dy, LL,  a.bottom +n*dy,  lty="dotted")
segments(UU, a.bottom+dy, UU,  a.bottom +n*dy,  lty="dotted")
Limits = round(c(LL,UU),1)
text(LL-0.1,a.bottom,toString(Limits[1]), adj=c(1,0.5),cex=0.8,
font=2)
text(UU+0.1,a.bottom,toString(Limits[2]), adj=c(0,0.5),cex=0.8,
font=2)
} 
if(example==1 ){ 
points(age.hat[i],age.hat[i], pch=19,cex=0.75)
points(age.hat[i],-1.0*dy, pch=19,cex=0.75)
}
} 
}

## ----eval=T, echo=F, fig.align="center", fig.height=6, fig.width=9, warning=FALSE, message=F, fig.cap="100\\% Confidence Intervals for a person's chronological age when error distributions (that in this example are wider at the  older ages) are 100\\% confined within the shaded ranges. "----
conf.level = 1; 
draw(conf.level)

## ----echo=FALSE---------------------------------------------------------------
allLocations <- read.csv("earth-locations-20180914.csv")
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
source("../bin/sampling_dist_figure.R")

## ----fig.asp = 0.518, fig.cap = '\\scriptsize{Bootstrap world. The bootstrap distribution is obtained by drawing repeated samples from an estimate of the population, computing the statistic of interest for each, and collecting those statistics. The distribution is centered at the observed statistic ($\\bar{y}$), not the parameter ($\\mu$).}', eval = FALSE----
#  #rm(list=ls())
#  #source("bootstrap_figure.R")

## ----echo = FALSE, eval = FALSE-----------------------------------------------
#  source("https://raw.githubusercontent.com/sahirbhatnagar/EPIB607/master/labs/
#  003-ocean-depths/automate_water_task.R")

## ----echo = c(7,8), message = FALSE, warning = FALSE, tidy = FALSE, fig.width = 7, fig.asp = 0.618----
source("https://raw.githubusercontent.com/sahirbhatnagar/EPIB607/master/inst/labs/003-ocean-depths/automate_water_task.R")
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

## ----echo=FALSE, eval=TRUE----------------------------------------------------
source("https://raw.githubusercontent.com/sahirbhatnagar/EPIB607/master/slides/bin/plot_null_alt.R")
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

