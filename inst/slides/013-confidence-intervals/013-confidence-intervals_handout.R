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

## ----hanley-fig3, fig.align="center", fig.height=7, fig.width=9, warning=FALSE, message=F----

DA = 10

xmax=0.75
DX=3+xmax
ymax=4

u = 100

par(mar = c(0.01,1,0.01,0.25))

for (example in 1) {

plot(u*c(-3,xmax),u*c(-0.5,ymax),col="white",
xaxt="n", yaxt="n",xlab="",ylab="",
xlim=u*c(-3.35,xmax+0.35),ylim=u*c(-0.5,ymax),
frame=FALSE)
lines(u*c(-4,0,0),u*c(0,0,ymax),lty="dotted")

segments(u*xmax, 0, u*xmax,  u*6)
for(h in seq(0,6,1)){
text(u*xmax,u*h,
paste(toString(u*h),"m",sep=""),
adj=c(-0.2,0.5),cex=0.75)
segments(u*(xmax-0.025), u*h, u*xmax,  u*h)
}
for(d in seq(1,3,1)){
text(-u*d,-0.15*u,
paste(toString(u*d),"m",sep=""),
adj=c(0.5,1),cex=0.75)
segments(-u*d, 0, -u*d,  -u*0.05)
}


H = u*2.25

x=0.15
U=u*5
L=0
COL=1
dd = 1

distances = 1
if(example==2) distances = seq(dd,3,dd)

for (d in u*distances ) {	
ANGLE   = atan( H/d ) * 360/(2*pi) 
angle.hat   = DA*round(ANGLE/DA)
h.hat   = d*tan(  angle.hat       / ( 360/(2*pi) ) )
segments(-d,0,0,h.hat,col=COL)
ii = d/u

text(-d + u*c(0.1,0.2,0.25)[ii], 0,
paste("'",toString(angle.hat),"'",sep="") ,
adj=c(0,-0.3), col=COL)
#h.upper = d*tan( (angle.hat+DA/2) / ( 360/(2*pi) ) )
#h.lower = d*tan( (angle.hat-DA/2) / ( 360/(2*pi) ) )
#segments(u*x,h.lower,u*x,h.upper,col=COL)
#if(example==1){
#text(u*x, h.upper, expression(theta[U]),adj=c(-0.5,0.5))
#text(u*x, h.lower, expression(theta[L]),adj=c(-0.5,0.5))
#} 
points(u*x,h.hat,pch=19,cex=0.4,col=COL)
if(example==1) points(u*xmax,h.hat,pch=19,cex=0.4,col=COL)
#U = min(U,h.upper)
#L = max(L,h.lower)
x=x+0.15
COL=COL+1
}
if(example==2){
segments(u*(xmax),L,u*(xmax),U,lwd=4)
segments(u*(xmax-0.075),L,u*(xmax+0.075),L )
segments(u*(xmax-0.075),U,u*(xmax+0.075),U )
} 

}

## ----hanley-fig2, fig.cap="Estimating the height of an building by measuring subtended angles. The '70' signifies that the real angle was somewhere between 65 and 75 degrees; thus the real height lies between the L and U limits of 214 and 373 metres.", eval=T, echo=F, fig.align="center", fig.height=4, fig.width=9, warning=FALSE, message=F----

DA = 10

xmax=0.75
DX=3+xmax
ymax=4

u = 100

par(mar = c(0.01,1,0.01,0.25))

for (example in 1) {

plot(u*c(-3,xmax),u*c(-0.5,ymax),col="white",
xaxt="n", yaxt="n",xlab="",ylab="",
xlim=u*c(-3.35,xmax+0.35),ylim=u*c(-0.5,ymax),
frame=FALSE)
lines(u*c(-4,0,0),u*c(0,0,ymax),lty="dotted")

segments(u*xmax, 0, u*xmax,  u*6)
for(h in seq(0,6,1)){
text(u*xmax,u*h,
paste(toString(u*h),"m",sep=""),
adj=c(-0.2,0.5),cex=0.75)
segments(u*(xmax-0.025), u*h, u*xmax,  u*h)
}
for(d in seq(1,3,1)){
text(-u*d,-0.15*u,
paste(toString(u*d),"m",sep=""),
adj=c(0.5,1),cex=0.75)
segments(-u*d, 0, -u*d,  -u*0.05)
}


H = u*2.25

x=0.15
U=u*5
L=0
COL=1
dd = 1

distances = 1
if(example==2) distances = seq(dd,3,dd)

for (d in u*distances ) {	
ANGLE   = atan( H/d ) * 360/(2*pi) 
angle.hat   = DA*round(ANGLE/DA)
h.hat   = d*tan(  angle.hat       / ( 360/(2*pi) ) )
segments(-d,0,0,h.hat,col=COL)
ii = d/u

text(-d + u*c(0.1,0.2,0.25)[ii], 0,
paste("'",toString(angle.hat),"'",sep="") ,
adj=c(0,-0.3), col=COL)
h.upper = d*tan( (angle.hat+DA/2) / ( 360/(2*pi) ) )
h.lower = d*tan( (angle.hat-DA/2) / ( 360/(2*pi) ) )
segments(u*x,h.lower,u*x,h.upper,col=COL)
if(example==1){
text(u*x, h.upper, expression(theta[U]),adj=c(-0.5,0.5))
text(u*x, h.lower, expression(theta[L]),adj=c(-0.5,0.5))
} 
points(u*x,h.hat,pch=19,cex=0.4,col=COL)
if(example==1) points(u*xmax,h.hat,pch=19,cex=0.4,col=COL)
U = min(U,h.upper)
L = max(L,h.lower)
x=x+0.15
COL=COL+1
}
if(example==2){
segments(u*(xmax),L,u*(xmax),U,lwd=4)
segments(u*(xmax-0.075),L,u*(xmax+0.075),L )
segments(u*(xmax-0.075),U,u*(xmax+0.075),U )
} 

}

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

## ----eval=FALSE, echo = TRUE--------------------------------------------------
#  plot(dt$Mean.5.depths, 1:nrow(dt), pch=20,
#  xlim=range(pretty(c(dt$lower.mean.5.66, dt$upper.mean.5.66))),
#  xlab='Depth of ocean (m)', ylab='Student (sample)',
#  las=1, cex.axis=0.8, cex=1.5)
#  abline(v = 3700, lty = 2, col = "red", lwd = 2)
#  segments(x0 = dt$lower.mean.5.66, x1=dt$upper.mean.5.66,
#  y0 = 1:nrow(dt), lend=1)

## ----echo=FALSE, comment = NA, size = 'tiny'----------------------------------
print(sessionInfo(), locale = FALSE)

