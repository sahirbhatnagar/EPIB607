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

## ----out.width = "0.60\\linewidth",echo=TRUE----------------------------------
mosaic::xpnorm(c(0,1))

## ----out.width = "0.60\\linewidth", echo=TRUE---------------------------------
mosaic::xpnorm(c(0,1/10))

## ----out.width = "0.60\\linewidth", echo=TRUE---------------------------------
mosaic::xpnorm(c(0,1/100))

## ----echo = TRUE, eval = FALSE------------------------------------------------
#  g.y <- function(y) {
#   (pi / 6) * y^3
#  }
#  
#  set.seed(12)
#  B <- 1000; N <- 2000
#  E_g.y <- replicate(B, {
#    diameter <- runif(N, min = 0, max = 10)
#    mean(g.y(diameter)) # E(g(y))
#  })
#  
#  g_E.y <- replicate(B, {
#    diameter <- runif(N, min = 0, max = 10)
#    g.y(mean(diameter)) # g(E(y))
#  })
#  
#  par(mfrow = c(1,2))
#  hist(E_g.y, col = "lightblue", xlab = "mean(g(y))",
#       main = sprintf("Average of E(g(Y)) over 1000\n replications
#       is %0.2f",mean(E_g.y)))
#  abline(v = mean(E_g.y), col = "red", lty = 2, lwd = 3)
#  
#  hist(g_E.y, col = "lightblue", xlab = "g(mean(y))",
#       main = sprintf("Average of g(E(Y)) over 1000\n replications
#       is %0.2f",mean(g_E.y)))
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

## ----out.width="0.85\\linewidth"----------------------------------------------
Y.values = list(y1 = (-1):1,
y2 = (-1):1,
y3 = c(-1,1),
y4 = (-2):2,
y5 = c(-2,2),
y6 = c(-3,-2, 2,3))

Probs = list(p1 = c(1,6,1),
p2 = rep(1,3),
p3 = rep(1,2),
p4 = rep(1,5),
p5 = rep(1,2),
p6 = rep(1,4) )

par(mfrow=c(1,1),mar = rep(0,4))

plot(1, ylim=c(0.5,7.45),xlim=c(-3.75,11.25),
col="white", frame=FALSE)

measure = c("Mean\nAbsolute\nDeviation",
"Mean\nSquared\nDeviation\n(Variance)",
"Root\nMean\nSquared\nDeviation\n(SD; \u{E9}cart type)")
for(i.r in 1:6) {
segments(-3,i.r, 3,i.r)
v = Y.values[[i.r]]
h = Probs[[i.r]]
h.sum = sum(h)
pr = h/h.sum 
for (i in 1:length(v)){
text(v[i], 7-i.r, toString(v[i]), adj=c(0.5,1.25))
segments(v[i],7-i.r,v[i], 7-i.r + pr[i], lwd=2.5  )
text(v[i], 7-i.r + h[i]/h.sum, 
paste(toString(h[i]),"/", toString(h.sum) ),
adj = c(1.1,0),font=3)
for(j in 1:3){
if(j==1) spread = sum(abs(v)*pr) 
if(j==2) spread = sum((v^2)*pr)
if(j==3) spread = sqrt( sum((v^2)*pr)  )
text(2.5 + 2.5*j,7-i.r, toString(round(spread,2)))
if(i==1) text(2.5+2.5*j, 6.85, measure[j], cex=1 )
}
}

}


## -----------------------------------------------------------------------------
plot.rv = function(v,COL,LAB){
CEX=1.1
par(mfrow=c(1,1),mar = rep(0,4))
plot(-10,-10,xlim=c(-5,40),ylim=c(0.375,0.57),
xaxt="n",yaxt="n",frame=TRUE)
text(v[2]+2,0.52,LAB,cex=1.5,adj=c(0,0))
arrows(mean(v),0.45,v,0.45,length=0.06,angle=35,col=COL)
points(v,rep(0.505,2),pch=19,col=COL)
points(mean(v),0.45,pch=19,cex=CEX/2,col=COL)
text(3,0.55, "PROBABILITY:",cex=1.1*CEX,adj=c(1,0.5),col=COL)
for(i in v){
text(i,0.55,bquote(frac(1, 2)),adj=c(0.5,0.5),col=COL)
txt = toString( i-mean(v))
if(i> mean(v)) txt = paste("+",toString( i-mean(v)),sep="") 
text(i,0.44,txt,adj=c(0.5,1),cex=1.25*CEX,col=COL)
txt = bquote(frac(1, 2) ~ (-3)^2)
if(v[1]==8) txt = bquote(frac(1, 2) ~ (-4)^2)
if(i==v[2]) txt = bquote(frac(1, 2) ~ (+3)^2)
if(i==v[2] & v[1]==8) txt = bquote(frac(1, 2) ~ (+4)^2)
text(i,0.40, txt,cex=1.25*CEX,col=COL)
}
text( 3,0.40, "VARIANCE  = ",cex=1.1*CEX,adj=c(1,0.5),col=COL)
text( mean(v),0.40, "+",cex=1.1*CEX,col=COL)
txt = bquote("= " ~ 3^2)
if(v[1]==8) txt = bquote("= " ~ 4^2)
text(v[2]+6,0.40, txt,cex=1.4*CEX,col=COL)

for(i in seq(0,28,1)){
segments(i,0.495,i,0.50,col=COL)
text(i,0.492,toString(i),cex=CEX/1.5,adj=c(0.5,1),col=COL)
}

} 

## ----out.width="1\\linewidth"-------------------------------------------------
			plot.rv(c(6,12),1,expression(RV[1]))

## ----out.width="1\\linewidth"-------------------------------------------------
plot.rv(c(8,16),1,expression(RV[2]))

## ----fig.width=8, fig.height=5------------------------------------------------
sum.diff.2rvs = function(v){

CEX=1.1

XLIM=c(-1,42)
is.SUM = mean(v[,2]) > 0 
if(!is.SUM) XLIM= c(-26, 14) 

par(mfrow=c(1,1),mar = rep(0,4))
plot(-10,-10,xlim=XLIM,ylim=c(-0.10,1),
xaxt="n",yaxt="n",frame=TRUE)

DY = c(0.45, 0.25)

y0 = -0.05

SEQ = seq(0,28,1)
if(!is.SUM) SEQ = seq(-10,12,1)
for(i in SEQ){
segments(i,y0,i,y0+0.01)
if((i %% 2)==0) text(i,y0-0.01,toString(i),
cex=CEX/1.5,adj=c(0.5,1))
}

for (rv1.v in 1:2){
MEAN = mean(v[,1])
y = 0.5 + DY[1] * (rv1.v - 1.5)
txt = bquote(frac(1, 2))
text(-0.5,y, txt,cex=CEX/1.5, 
adj=c(1,0.5))
arrows(0, y , 0.98*v[rv1.v,1], y, 
length=0.06, angle=30)
points(v[rv1.v,1], y,  pch=19,cex=0.5 )

text(  v[rv1.v,1]+1, y, "1")
points(v[rv1.v,1]+1, y, pch=1,cex=2.5 )

txt1 = toString(v[rv1.v,1] - MEAN)
if(rv1.v==2) txt1 = paste("+",txt1,sep="")
text(v[rv1.v,1], y, txt1,adj=c(0.5,1.35))
Mean = mean(v[,2])
for (rv2.v in 1:2){
yy = y + DY[2] * (rv2.v - 1.5)
txt = bquote(frac(1, 2))
text(v[rv1.v,1]-0.5*is.SUM +
0.5*(1-is.SUM) ,yy,
txt,cex=CEX/1.5, 
adj=c(!is.SUM,0.5))
arrows(v[rv1.v,1],               yy , 
0.97*(v[rv1.v,1]  + v[rv2.v,2]), yy,
length=0.06, angle=30,
lwd=2)
points(v[rv1.v,1]  + v[rv2.v,2], yy, 
pch=19,cex=0.9 )

xxc = v[rv1.v,1] + v[rv2.v,2] +
1.5*is.SUM  -1.5*(1-is.SUM)
text(  xxc, yy, "2")
points(xxc, yy, pch=1,cex=2.5 )


points(v[rv1.v,1]  + v[rv2.v,2], y0+0.065, 
pch=19,cex=0.9 )
diff = v[rv2.v,2] - Mean
txt2 = toString(diff)
if(diff > 0 ) txt2 = paste("+",txt2,sep="")

text(v[rv1.v,1]  +v[rv2.v,2], yy-0.035, 
paste(txt1,txt2,sep=" "),
adj=c(0.5,0.5))

txt = bquote(frac(1, 4))
text(v[rv1.v,1]  + v[rv2.v,2],yy, 
txt,cex=CEX/1.5, adj=c(1.05,-0.25))

if(is.SUM){
if(rv1.v==1 & rv2.v ==1) Txt = 
bquote((-3)^2 + (-4)^2 + 2(-3)(-4) )
if(rv1.v==1 & rv2.v ==2) Txt = 
bquote((-3)^2 + (+4)^2 + 2(-3)(+4) )
if(rv1.v==2 & rv2.v ==1) Txt = 
bquote((+3)^2 + (-4)^2 + 2(+3)(-4) )
if(rv1.v==2 & rv2.v ==2) Txt = 
bquote((+3)^2 + (+4)^2 + 2(+3)(+4) )
} 

if(!is.SUM){
if(rv1.v==1 & rv2.v ==1) Txt = 
bquote((-3)^2 + (+4)^2 + 2(-3)(+4) )
if(rv1.v==1 & rv2.v ==2) Txt = 
bquote((-3)^2 + (-4)^2 + 2(-3)(-4) )
if(rv1.v==2 & rv2.v ==1) Txt = 
bquote((+3)^2 + (+4)^2 + 2(+3)(+4) )
if(rv1.v==2 & rv2.v ==2) Txt = 
bquote((+3)^2 + (-4)^2 + 2(+3)(-4) )
}


text(41*is.SUM - 26*(1-is.SUM), 
yy-0.035, Txt,
adj=c(is.SUM,0.5))

} #rv2 
} # rv2

text(41*is.SUM -26*(1-is.SUM),1,
"The Squared Deviations",
adj=c(is.SUM,1))
arrows(0 + 13*(1-is.SUM), y0+0.065, 
13*is.SUM +6*(1-is.SUM), y0+0.065,
length=0.06,angle=25 )
txt = "Sum of 2\nrandom variables"
if(!is.SUM) txt = "Difference of 2\nrandom variables"
text(0 + 13*(1-is.SUM) , y0+0.065,txt,
adj=c(1-is.SUM,0.5) )

text(41*is.SUM -26*(1-is.SUM),
y0+0.08, "====================" , 
adj=c(is.SUM,0.5))

text(31*is.SUM - 21*(1-is.SUM), y0+0.02, 
bquote(3^2 ~  ~ + ~  ~ 4^2),
adj=c(1-is.SUM,0.5),
cex=1.5)

txt = "VAR[Sum]"
if(!is.SUM) txt = "VAR[Difference]"
text(31.25*is.SUM - 20.5*(1-is.SUM), 
y0-0.05,txt, adj=c(1-is.SUM,0.5))

segments(41, 0.08, 37, 0.85,lwd=0.6 )
segments(37, 0.08, 41, 0.85,lwd=0.6)

} # fn

v=matrix(c(6,12,8,16),2,2)

sum.diff.2rvs(v)

## ----fig.width=8, fig.height=5------------------------------------------------

par(mfrow=c(1,1),mar = rep(0,4))

XMAX = 25
plot(-10,-10,xlim=c(-6,XMAX),ylim=c(-1,15),
xaxt="n",yaxt="n",frame=TRUE)

Y = seq(2,12,2)
fr =  2*c(1,2,4, 4,2,1)

text(-1,max(Y)+2.5,"Y",adj=c(1,0.5),cex=2,font=3)

abline(h=Y,col="lightblue")

Origin = matrix(NA,max(Y)-min(Y)+3,20)

source(here::here("inst/code/drawStickPerson.R"))

DX = 12
DY = 0.15

f.Y.star = rep(0,max(Y)-min(Y)+3)

for(i.r in 1:length(Y)){
value = Y[i.r]/2
text(-1,Y[i.r],toString(value),adj=c(1,0.5),cex=2)
n = fr[i.r]

for (j in 1:n){
stickperson(j, Y[i.r]-2.5*DY, 0.15, DY, LWD=2,COL=i.r)
i.y = Y[i.r] + ( (j%%2) == 0 ) - ( (j%%2) == 1 )
J = min(  (1:20)[ is.na(Origin[i.y,])] )
f.Y.star[i.y] = f.Y.star[i.y] + 1
Origin[i.y,J] = i.r
stickperson(DX+J, i.y - 2.5*DY, 0.15, DY, LWD=2,COL=i.r)
} 
}

Y.star = NULL; 

for(i.r in 0:length(Y)){
if(i.r == 0) { yy = Y[1] - 1   
y = Y[1]/2-0.5
txt = toString(y)
}
if(i.r >  0) { yy = Y[i.r] + 1 
y = Y[i.r]/2+0.5
txt = toString(y) 
}
Y.star = c(Y.star,y)
text(XMAX,yy,txt,adj=c(1,0.5),cex=2,font=3)
segments(DX, yy, XMAX, yy, col="lightblue")
}
text(XMAX,max(Y)+2.5,"Y '",adj=c(1,0.5),cex=2,font=3)

f.Y.star = f.Y.star[seq(1,length(f.Y.star),2)]
E.Y.star = sum(Y.star*f.Y.star)/sum(f.Y.star)
VAR.Y.star = sum((Y.star-E.Y.star)^2*f.Y.star)/sum(f.Y.star)
text( DX+ (XMAX-DX)/3, 0, 
format(round(VAR.Y.star,2),nsmall=2),
adj=c(0.5,1),cex=2)

Y = Y/2
fr =  2*c(1,2,4, 4,2,1)
E.Y = sum(Y*fr)/sum(fr)
VAR.Y = sum((Y-E.Y)^2*fr)/sum(fr)
text( DX/3, 0, 
format(round(VAR.Y,2),nsmall=2),
adj=c(0.5,1),cex=2)
text( -6, 0, "VAR:",adj=c(0,1),cex=2)



## ----fig.width = 8, fig.height = 5--------------------------------------------
ds = read.table(
"http://www.biostat.mcgill.ca/hanley/statbook/WH.txt.words.txt",
as.is=TRUE)

L.max = 12

w = ds[ nchar(ds$Word) <= L.max, ]

CEX=1

Y = as.numeric( nchar(w) ) 
E.Y = mean(Y)
SD.Y = sd(Y)
VAR.Y = var(Y)
Max.Y = max(Y)

Fr = table(Y)[1: L.max]
Fr = Fr/sum(Fr)

#to.show = c(1,4,9)
to.show = c(1)
Max.n   = max(to.show)

P = c(0.025,0.975)

n.rows=25

par(mfrow=c(length(to.show),1), mar = rep(0,4))

for (n in 1:Max.n){

if(n==1) { 
Prev = Fr; max.y = L.max; range = 1:max.y 
}

if(n >1) {
M = outer(Prev,Fr)
Prev = sapply(split(M, col(M) + row(M)), sum)
range = n:(n*max.y)	
}

if(n %in% to.show){

XLIM = c(n-1, 1.05*L.max*n)
YLIM = c(-0.08,1)*max(Prev)
plot(range,Prev, type="h",
yaxt="n", xaxt="n",
xlim=XLIM, ylim=YLIM, 
lwd=1, main=toString(n),col="white")

for(s in range ) if( (n*floor(s/n)) ==s){
text(s, -0.02*max(Prev),toString(s),
cex=1.5,adj=c(0.5,1))
text(s, -0.07*max(Prev),toString(s/n),
cex=1.5,adj=c(0.5,1),font=2)
}
text(1.025*max(range), -0.02*max(Prev),"SUM",
cex=1.5,adj=c(0,1))
text(1.025*max(range), -0.07*max(Prev),"MEAN",
cex=1.5,adj=c(0,1),font=2)

text((9/10)*max(range),0.74*YLIM[2],
paste("SD of \nTOTAL Length\nof n =",
toString(n),
"Word(s):\n\n",
format(round(SD.Y*sqrt(n),1),nsmall=1),
"chars"),
cex=2)

text((9/10)*max(range),0.3*YLIM[2],
paste("SD of \nMEAN Length\nof n =",
toString(n),
"Word(s):\n\n",
format(round(SD.Y/sqrt(n),1),nsmall=1),
"chars"),
cex=2,font=2)

dx = strwidth("1", units = "user", 
cex = CEX, font = 1, family= "mono")


segments(XLIM[1], 0, XLIM[2], 0)
points(n*E.Y + SD.Y* qnorm(P)*sqrt(n), rep(0,2),pch=19,cex=.5)

dy = YLIM[2] / n.rows

mm = matrix(sample(w, n.rows*n,replace=TRUE),
n.rows,n)
L = apply(nchar(mm),1,sum)
mm=mm[order(L),]
for(i.r in 1:n.rows){
if(n >1) Words  = mm[i.r,]
if(n==1) Words  = mm[i.r]
xx = 0.5
for(i.w in 1:n) {
txt = Words[i.w]
if(n==1) txt = paste(
rep("-",nchar(txt)),collapse="")
text(xx,i.r*dy, txt,
family="mono",
adj=c(0,0.5),cex=1/dx,
col=i.w)
xx = xx+nchar(txt)
}
} # i.r
lines(range,Prev, type="h",
lwd=3, col="purple")

} # show

} # n



## ----fig.width = 8, fig.height = 5--------------------------------------------
ds = read.table(
"http://www.biostat.mcgill.ca/hanley/statbook/WH.txt.words.txt",
as.is=TRUE)

L.max = 12

w = ds[ nchar(ds$Word) <= L.max, ]

CEX=1

Y = as.numeric( nchar(w) ) 
E.Y = mean(Y)
SD.Y = sd(Y)
VAR.Y = var(Y)
Max.Y = max(Y)

Fr = table(Y)[1: L.max]
Fr = Fr/sum(Fr)

#to.show = c(1,4,9)
to.show = c(4)
Max.n   = max(to.show)

P = c(0.025,0.975)

n.rows=25

par(mfrow=c(length(to.show),1), mar = rep(0,4))

for (n in 1:Max.n){

if(n==1) { 
Prev = Fr; max.y = L.max; range = 1:max.y 
}

if(n >1) {
M = outer(Prev,Fr)
Prev = sapply(split(M, col(M) + row(M)), sum)
range = n:(n*max.y)	
}

if(n %in% to.show){

XLIM = c(n-1, 1.05*L.max*n)
YLIM = c(-0.08,1)*max(Prev)
plot(range,Prev, type="h",
yaxt="n", xaxt="n",
xlim=XLIM, ylim=YLIM, 
lwd=1, main=toString(n),col="white")

for(s in range ) if( (n*floor(s/n)) ==s){
text(s, -0.02*max(Prev),toString(s),
cex=1.5,adj=c(0.5,1))
text(s, -0.07*max(Prev),toString(s/n),
cex=1.5,adj=c(0.5,1),font=2)
}
text(1.025*max(range), -0.02*max(Prev),"SUM",
cex=1.5,adj=c(0,1))
text(1.025*max(range), -0.07*max(Prev),"MEAN",
cex=1.5,adj=c(0,1),font=2)

text((9/10)*max(range),0.74*YLIM[2],
paste("SD of \nTOTAL Length\nof n =",
toString(n),
"Word(s):\n\n",
format(round(SD.Y*sqrt(n),1),nsmall=1),
"chars"),
cex=2)

text((9/10)*max(range),0.3*YLIM[2],
paste("SD of \nMEAN Length\nof n =",
toString(n),
"Word(s):\n\n",
format(round(SD.Y/sqrt(n),1),nsmall=1),
"chars"),
cex=2,font=2)

dx = strwidth("1", units = "user", 
cex = CEX, font = 1, family= "mono")


segments(XLIM[1], 0, XLIM[2], 0)
points(n*E.Y + SD.Y* qnorm(P)*sqrt(n), rep(0,2),pch=19,cex=.5)

dy = YLIM[2] / n.rows

mm = matrix(sample(w, n.rows*n,replace=TRUE),
n.rows,n)
L = apply(nchar(mm),1,sum)
mm=mm[order(L),]
for(i.r in 1:n.rows){
if(n >1) Words  = mm[i.r,]
if(n==1) Words  = mm[i.r]
xx = 0.5
for(i.w in 1:n) {
txt = Words[i.w]
if(n==1) txt = paste(
rep("-",nchar(txt)),collapse="")
text(xx,i.r*dy, txt,
family="mono",
adj=c(0,0.5),cex=1/dx,
col=i.w)
xx = xx+nchar(txt)
}
} # i.r
lines(range,Prev, type="h",
lwd=3, col="purple")

} # show

} # n



## ----fig.width = 8, fig.height = 5--------------------------------------------
ds = read.table(
"http://www.biostat.mcgill.ca/hanley/statbook/WH.txt.words.txt",
as.is=TRUE)

L.max = 12

w = ds[ nchar(ds$Word) <= L.max, ]

CEX=1

Y = as.numeric( nchar(w) ) 
E.Y = mean(Y)
SD.Y = sd(Y)
VAR.Y = var(Y)
Max.Y = max(Y)

Fr = table(Y)[1: L.max]
Fr = Fr/sum(Fr)

#to.show = c(1,4,9)
to.show = c(9)
Max.n   = max(to.show)

P = c(0.025,0.975)

n.rows=25

par(mfrow=c(length(to.show),1), mar = rep(0,4))

for (n in 1:Max.n){

if(n==1) { 
Prev = Fr; max.y = L.max; range = 1:max.y 
}

if(n >1) {
M = outer(Prev,Fr)
Prev = sapply(split(M, col(M) + row(M)), sum)
range = n:(n*max.y)	
}

if(n %in% to.show){

XLIM = c(n-1, 1.05*L.max*n)
YLIM = c(-0.08,1)*max(Prev)
plot(range,Prev, type="h",
yaxt="n", xaxt="n",
xlim=XLIM, ylim=YLIM, 
lwd=1, main=toString(n),col="white")

for(s in range ) if( (n*floor(s/n)) ==s){
text(s, -0.02*max(Prev),toString(s),
cex=1.5,adj=c(0.5,1))
text(s, -0.07*max(Prev),toString(s/n),
cex=1.5,adj=c(0.5,1),font=2)
}
text(1.025*max(range), -0.02*max(Prev),"SUM",
cex=1.5,adj=c(0,1))
text(1.025*max(range), -0.07*max(Prev),"MEAN",
cex=1.5,adj=c(0,1),font=2)

text((9/10)*max(range),0.74*YLIM[2],
paste("SD of \nTOTAL Length\nof n =",
toString(n),
"Word(s):\n\n",
format(round(SD.Y*sqrt(n),1),nsmall=1),
"chars"),
cex=2)

text((9/10)*max(range),0.3*YLIM[2],
paste("SD of \nMEAN Length\nof n =",
toString(n),
"Word(s):\n\n",
format(round(SD.Y/sqrt(n),1),nsmall=1),
"chars"),
cex=2,font=2)

dx = strwidth("1", units = "user", 
cex = CEX, font = 1, family= "mono")


segments(XLIM[1], 0, XLIM[2], 0)
points(n*E.Y + SD.Y* qnorm(P)*sqrt(n), rep(0,2),pch=19,cex=.5)

dy = YLIM[2] / n.rows

mm = matrix(sample(w, n.rows*n,replace=TRUE),
n.rows,n)
L = apply(nchar(mm),1,sum)
mm=mm[order(L),]
for(i.r in 1:n.rows){
if(n >1) Words  = mm[i.r,]
if(n==1) Words  = mm[i.r]
xx = 0.5
for(i.w in 1:n) {
txt = Words[i.w]
if(n==1) txt = paste(
rep("-",nchar(txt)),collapse="")
text(xx,i.r*dy, txt,
family="mono",
adj=c(0,0.5),cex=1/dx,
col=i.w)
xx = xx+nchar(txt)
}
} # i.r
lines(range,Prev, type="h",
lwd=3, col="purple")

} # show

} # n



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

## ----fig.width=8, fig.height=5------------------------------------------------
par(mfrow=c(1,1), mar = rep(0,4))

x = c(12.5,17.5)
Y = 32 + (9/5)*x

XLIM = c(x[1]-1, x[2]+1)
YLIM = c(Y[1]-2, Y[2]+2)

plot(-100,-100,xlim=XLIM,ylim=YLIM)

yy  = seq( floor(YLIM[1]), ceiling(YLIM[2]),1)
yyy = seq( floor(YLIM[1]), ceiling(YLIM[2]),1/2)
abline(h=yy, col="lightblue",lwd=1.5)
abline(h=yyy,col="lightblue",lwd=0.52)

for(Yy in yy) text(XLIM[1],Yy,
toString(Yy),
adj=c(1,1) )

text(XLIM[1],YLIM[2] - 0.25, "Temperature (F)",
adj=c(0,0),font=2)

text(mean(x),YLIM[1]-0.25, "Temperature (C)",
adj=c(0.5,0),font=2)

H = seq(floor(XLIM[1]),ceiling(XLIM[2]),1)
for(h in H ) text(h,YLIM[1]+0.25,
toString(h),
adj=c(0.5,0))
abline(v=H,col="lightblue")
segments(x[1],Y[1],x[2],Y[2],col="blue")

e = c(-0.5,0.5)
for( i.1  in 1:2  ){
y1 =  Y[1]+e[i.1]
text(x[1],y1,toString(y1),adj=c(1.25,0.5))
for( i.2  in 1:2  ){
y2 =  Y[2]+e[i.2]
if(i.1==1) text(x[2],y2,
toString(y2),adj=c(-0.25,0.5))
dy = y2-y1
slope = dy/(x[2]-x[1])
segments(x[1], y1, x[2], y2, lwd=0.5 )
}
}

y = Y[2]

text(x[1],y,
bquote("slope = " ~ frac(y[2]-y[1],5) ~ " = " ~ frac(63.5+e[2] - 54.5 - e[1],5 ) ~ " = "  ~ frac(9 + e[2] - e[1],5 ) ~ "  =  " ~ frac(9,5) + frac(e[2] - e[1],5)  ),
adj=c(0,0.5)
)

points(x[1],Y[1],cex=0.5,pch=19,col="blue")
arrows(x[1],Y[1]-1/2, x[1],Y[1]+1/2,
length=0.06, angle=45,code=3,lwd=1)
points(x[2],Y[2],cex=0.5,pch=19,col="blue")
arrows(x[2],Y[2]-1/2, x[2],Y[2]+1/2,
length=0.06, angle=45,code=3,lwd=1)
text(x[1]-1/5,Y[1],
bquote(e[1]),  adj=c(1,0.5), 
cex=1)
text(x[2]+2/5,Y[2],
bquote(e[2]),  adj=c(1,0.5), 
cex=1)
text(x[1]-4/5,Y[1]+4.5,
bquote("Var[" ~ e[1] ~ "] = " ~ frac( (-0.5)^2 + (+0.5)^2,2) ~ " = " ~ 0.5^2 ),
adj=c(0,1), cex=1)

text(x[2]+1,Y[2]-3.25,
bquote("Var[" ~ e[2] ~ "] = " ~ frac( (-0.5)^2 + (+0.5)^2,2) ~ " = " ~ 0.5^2 ),
adj=c(1,1), cex=1)


text(x[2]+1,Y[1],
bquote("Var[possible slopes] = Var[ " ~ frac(9,5) + frac(e[2] - e[1],5) ~ " ] = " ~ frac(Var(e[1])+Var(e[2]),5^2) ~ " = " ~ frac(0.5^2 +0.5^2,5^2) ~ " = " ~ frac(1,50) ),
adj=c(1,0.5)
)


## ----echo=FALSE, comment = NA, size = 'tiny'----------------------------------
print(sessionInfo(), locale = FALSE)

