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

## ----out.width = "0.7\\textwidth"---------------------------------------------
plot3 = function(row){
par(mfrow=c(1,3),mar = c(0,0,0,0.5) )
TOP="Mean Ocean\ndepth (Km)"
x=c(0.225,0.775);; dx=0.025
mu = c(3.6,4.5)

LABEL=c("North\n(X=0)", "South")
delta.mu = mu[2]-mu[1]

PARA = t(matrix( c( toString(mu[1]),
toString(mu[2]),
toString(mu[1]), 
paste( toString(mu[1]), " + ",
toString(delta.mu),sep=""),
rep(paste(toString(mu[1]),
" + ",toString(delta.mu),
" if South",sep=""),2)
),2,3) )

PARA.S = c( expression(mu[North]), 
expression(mu[South]),
expression(mu[North]),
expression(mu[North] + Delta * mu),
expression(mu[S] == paste(mu[0] + Delta * mu ,
" ",textstyle(x)," X")),
expression(mu[S] == paste(mu[0] + Delta * mu ,
" ",textstyle(x)," X")),

expression(mu[North]), 
expression(mu[South]),
expression(mu[North]),
expression(mu[North] %*% Delta * mu),

expression(mu[S] == paste(mu[0] %*% Delta * mu ,
" ",textstyle(x)," X")),
expression(mu[S] == paste(mu[0] %*% Delta * mu ,
" ",textstyle(x)," X"))

)

PARA.R = c( toString(mu[1]),
toString(mu[2]),
toString(mu[1]),
expression(3.6 %*% frac(4.5, 3.6) ),
rep(expression(
paste(3.6 %*% frac(4.5, 3.6)," if South")
), 2)
)

PARA.RS = c(  expression(mu[North]), 
expression(mu[South]),
expression(mu[North]),
expression(mu[North] %*% frac(mu[South], mu[North]) ),
rep(expression(mu[S] == mu[0]
%*% Ratio^X), 2)
)

SRT=38 

dy= 1
for(co in 1:3){
plot(x,mu,yaxt="n",xlim=c(0,1),
ylim=c(-0.2,ceiling(mu[2])))
text(0, ceiling(mu[2]),
c("(a)","(b)","(c)")[co],
adj=c(0,0), cex=2)

rect(x-dx,0,x+dx,mu,
col="lightblue",border=NA)
if(co>=2){
points(x[2],mu[1],cex=1)
polygon( c(x,x[2]), c(mu[1],mu),
col=NA,border="grey50",lwd=0.75)
}

if(co==1){
arrows(x[1]-0.1,0,
x[1]-0.1,ceiling(mu[2]),
length=0.07,angle=30)
text(x[1]-0.15, mean(mu),
"Mean Depth of Oceans (Km)",
adj=c(1.25,0), srt=90, cex=2.0)
}
for( y in seq(0,ceiling(mu[2]),dy)){
segments(x[1], y, x[2],y, col="grey50",lty="dotted")
if (co == 1 & y %in% c(0,1,2,3,5) ) text(x[1]-dx, y,toString(y),
adj=c(1,0.5),cex=1.5)
if(co == 3 & y %in% c(0,1,2,3,4)  ) text(x[2]+dx, y,toString(y), 
adj=c(0,0.5), cex=1.5)

} 
text(0.5,1.05*ceiling(mu[2]),TOP,adj=c(0.5,0),cex=1.2,font=2) 
points(x,mu,pch=19,cex=0.75)
for(j in 1:2){
txt = PARA[co,j]
if(row==2) txt = PARA.S[(co-1)*2+j]
if(row==3) txt = PARA.R[(co-1)*2+j]
if(row==4) txt = PARA.RS[(co-1)*2+j]

xx = x[j]  - 0.00*(j==1) + 0.00*(j==2)
if(co==3) xx = mean(x)

yy = mu[j] + 0.15 + 0.05*(row >= 3)
if(co==3) yy =  mean(mu) +  0.15 + 
0.15*(row >= 3)

text(xx, yy, txt,  adj=c(0.6, 0.5),
cex=1.75,srt=SRT) 

if(row==4 & co==3 & j==1) text(
mean(x), 2.5,
expression(Ratio == frac(mu[South], mu[North] ) ),
cex=1.75)

LAB = LABEL[j]
if(row %in% c(2,4) & co == 3 ) LAB=c("0","1")[j]
text(x[j],-0.15,LAB, adj=c(0.5,1),
cex=1.5)
if(row %in% c(2,4) & co == 3 & j==1 ) text( 
mean(x),-0.25,"X", adj=c(0.5,1),cex=1.5)

} 
}
}

plot3(3)

## ----out.width = "0.7\\textwidth"---------------------------------------------
plot3(4)

## ----eval=FALSE, echo=TRUE, size='tiny'---------------------------------------
#  # load function to get depths
#  source("https://raw.githubusercontent.com/sahirbhatnagar/EPIB607/master/inst/labs/
#          003-ocean-depths/automate_water_task.R")
#  
#  # get 1000 depths
#  set.seed(222333444)
#  depths <- automate_water_task(index = sample(1:50000, 1000),
#  student_id = 222333444, type = "depth")
#  
#  # separate by north and south hemisphere
#  depths_north <- depths[which(depths$lat>0),]
#  depths_south <- depths[which(depths$lat<0),]
#  
#  # restrict sample to 200 (at random)
#  depths_north <- depths_north[sample(1:nrow(depths_north), 200), ]
#  depths_south <- depths_south[sample(1:nrow(depths_south), 200), ]
#  
#  # add indicator variable
#  depths_north$South <- 0
#  depths_south$South <- 1
#  
#  # combine data
#  depths <- rbind(depths_north, depths_south)
#  head(depths)
#  
#  # calculate mean and sd by hemisphere
#      mean.sd <- depths %>% group_by(South) %>%
#      summarise(means = mean(alt), sds = sd(alt))
#  
#      means <- mean.sd$means
#      sds <- mean.sd$sds

## ----eval=TRUE, echo=FALSE, size='tiny', fig.asp=0.81-------------------------
# load function to get depths
source("https://raw.githubusercontent.com/sahirbhatnagar/EPIB607/master/inst/labs/003-ocean-depths/automate_water_task.R")

# get 1000 depths
set.seed(222333444)
depths <- automate_water_task(index = sample(1:50000, 1000), 
student_id = 222333444, type = "depth")

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

# calculate mean and sd by hemisphere
means <- aggregate(x = depths, by = list(depths$South), FUN = "mean")$alt
sds <- aggregate(x = depths, by = list(depths$South), FUN = "sd")$alt

# create boxplot and annotate plot
boxplot(alt ~ South, data = depths,
ylab="Ocean Depth (metres)",
xlab="NORTH                                                                       SOUTH",
pch=19,cex=0.25)
points(c(1,2), means, pch=19)
text(0.9, means[1],
expression(widehat(y[0])) )
text(2.1, means[2],
expression(widehat(y[1])) )
segments(1,means[1],2,means[1],
lty="dotted")
segments(1,means[1],2,means[2],
lty="dotted")
segments(2.2,means[1],2.45,means[1],
lty="dotted")
segments(2.2,means[2],2.45,means[2],
lty="dotted")
text((2.2+2.45)/2,means[2],
sprintf("+ %0.2f m", means[2]-means[1]), adj=c(0.5,-0.25),cex=0.75)
text(2.5,means[1],
expression(hat(Delta)),adj=c(0.5,0)) 
arrows(0.8,means[1],0.43,means[1],
length=0.05,angle=20)
arrows(0.8,means[2],0.43,means[2],
length=0.05,angle=20)

## ----eval=TRUE, echo=TRUE, size='scriptsize'----------------------------------
n0 <- nrow(depths_north)
n1 <- nrow(depths_south)

mean0 <- mean(depths_north$alt)
mean1 <- mean(depths_south$alt)

var0 <- var(depths_north$alt)
var1 <- var(depths_south$alt)

(SEM <- sqrt(var0/n0 + var1/n1))

## ----eval=TRUE, echo=TRUE, size='scriptsize'----------------------------------
# assuming equal variances
(mean1 - mean0) + qt(c(0.025, 0.975), df = n0 + n1 - 2) * SEM 

# similar to z interval
qnorm(c(0.025, 0.975), mean = mean1 - mean0, sd = SEM)

## ----eval=TRUE, echo=TRUE, size='scriptsize'----------------------------------
# regression. lm assumes equal variances
fit <- lm(alt ~ South, data = depths)
summary(fit)

## ----eval=TRUE, echo=TRUE, size='scriptsize'----------------------------------
confint(fit)

## ----eval=TRUE, echo=TRUE, size='scriptsize'----------------------------------
stats::t.test(alt ~ South, data = depths, var.equal = FALSE) 
(mean0 - mean1) + qt(c(0.025, 0.975), df = 349.61783) * SEM 

## ----eval=TRUE, echo=TRUE, size='scriptsize'----------------------------------
stats::t.test(alt ~ South, data = depths, var.equal = TRUE)
(mean0 - mean1) + qt(c(0.025, 0.975), df = n0 + n1 - 2) * SEM 

## ----echo=FALSE, comment = NA, size = 'tiny'----------------------------------
print(sessionInfo(), locale = FALSE)

