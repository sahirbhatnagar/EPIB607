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
DT
)

theme_set(cowplot::theme_cowplot())

## ----echo=FALSE, fig.asp=0.681, message=FALSE, fig.cap='A boxplot and dot plot of \\texttt{clutch.volume} in the \\texttt{frog} dataset from the \\texttt{oibiostat} package. The horizontal dashes indicate the bottom 50\\% of the data and the open circles represent the top 50\\%.'----
library(oibiostat)
library(openintro)
data(COL)
data(frog)

d   <- frog$clutch.volume

par(  mar = c(0, 4, 0, 1),
mgp = c(2.8, 0.7, 0))
boxPlot(d,
ylab = 'Clutch Volume',
xlim = c(0.3, 3),
axes = FALSE,
ylim = range(d))
axis(2)

arrows(2,min(d), 1.4, min(d) - 5, length = 0.08)
text(2, min(d), 'lower whisker', pos = 4)

q1 <- quantile(d, 0.25)
arrows(2, q1, 1.4, q1, length = 0.08)
text(2, q1,
expression(Q[1]~~'(first quartile)'), pos = 4)

m <- median(d)
arrows(2, m, 1.4, m, length = 0.08)
text(2, m, 'median (second quartile)', pos = 4)

q3 <- quantile(d, 0.75)
arrows(2, q3, 1.4, q3, length = 0.08)
text(2, q3,
expression(Q[3]~~'(third quartile)'), pos = 4)

arrows(2, rev(sort(d))[11],
1.4, rev(sort(d))[11], length = 0.08)
text(2, rev(sort(d))[11],
'upper whisker', pos = 4)

#y <- quantile(d, 0.75) + 1.5 * IQR(d)
#arrows(2, y, 1.4, y, length = 0.08)
#lines(c(0.72, 1.28), rep(y, 2),
#lty = 3, col = '#00000066')
#text(2, y,
#'max whisker reach', pos = 4)

m <- rev(tail(sort(d), 9))
s <- m[1] - 0.4 * sd(m)
arrows(2, s - 200, 1.1, m[1] - 0.2, length = 0.08)
arrows(2, s - 200, 1.1, m[2] + 0.3, length = 0.08)
arrows(2, s - 200, 1.1, m[3] + 0.35, length = 0.08)
arrows(2, s - 200, 1.1, m[4] + 0.4, length = 0.08)
arrows(2, s - 200, 1.1, m[5] + 0.45, length = 0.08)
arrows(2, s - 200, 1.1, m[6] + 0.5, length = 0.08)
#arrows(2, s - 200, 1.1, m[7] + 0.55, length = 0.08)
arrows(2, s - 200, 1.1, m[8] + 0.6, length = 0.08)
arrows(2, s - 200, 1.1, m[9] + 0.7, length = 0.08)
text(2, s - 200, 'outliers', pos = 4)

points(rep(0.4, 215), rev(sort(d))[1:215],
cex = rep(1.3, 431),
col = rep(COL[1, 3], 431),
pch = rep(1, 431))
points(rep(0.4, 215), sort(d)[1:215],
cex = rep(1, 215),
col = rep(COL[4,3], 215),
pch = rep("-", 215))

## ----echo=TRUE, size = 'scriptsize'-------------------------------------------
library(dplyr)
library(rio)

heights_sample <- rio::import(
                   here::here("inst/data/heights_sample.csv"))
heights_sample <- heights_sample %>% 
                    dplyr::mutate(sex = factor(sex))

summary(heights_sample)

heights_sample %>%
   dplyr::glimpse()

## ----echo=TRUE, size = 'scriptsize'-------------------------------------------
heights_population <- rio::import(
                 here::here("inst/data/heights_population.csv"))
heights_population <- heights_population %>% 
                    dplyr::mutate(sex = factor(sex))
                    
summary(heights_population)
heights_population %>%
   dplyr::glimpse()

## ----echo=TRUE, size = 'scriptsize', fig.asp = 0.621--------------------------
library(ggplot2); library(cowplot)
ggplot2::theme_set(cowplot::theme_cowplot())
p <- ggplot(data = heights_population, 
             mapping = aes(x = height))
p + geom_bar()

## ----echo=TRUE, size = 'scriptsize'-------------------------------------------
N <- nrow(heights_population)
var(heights_population$height) * (N - 1) / N

## ----echo = TRUE--------------------------------------------------------------
heights_population %>% 
   dplyr::sample_n(size = 1)

## ----echo = TRUE--------------------------------------------------------------
heights_population %>% 
dplyr::sample_n(size = 1)

## ----echo = TRUE--------------------------------------------------------------
heights_population %>% 
dplyr::sample_n(size = 1)

## ----echo = TRUE, size = 'normalsize'-----------------------------------------
Y <- heights_population$height

mean(abs(Y-170) <= 10)

## ----echo = TRUE, size = 'normalsize'-----------------------------------------
Y <- c(6.3, 6.9, 6.6, 3.4, 5.5, 4.3, 6.5, 4.7, 6.1, 5.3)

## ----echo = TRUE, size = 'normalsize'-----------------------------------------
abs(Y-5)

## ----echo = TRUE, size = 'normalsize'-----------------------------------------
abs(Y - 5) <= 1

## ----echo = TRUE, size = 'normalsize'-----------------------------------------
mean(abs(Y - 5) <= 1)

## ----echo=FALSE, size = 'small'-----------------------------------------------
tab1 = data.frame(Value=c(0,1,2,3),Probability=c(.5,.25,.15,.1),Cum.Prob=c(.5,.75,.9,1))
knitr::kable(
tab1, 
booktabs = TRUE
)

## ----echo=FALSE, comment = NA, size = 'tiny'----------------------------------
print(sessionInfo(), locale = FALSE)

## ----eval=T, echo=F, fig.align="center", fig.height=7, fig.width=9, warning=FALSE, message=F----
	plot3 = function(row){
		par(mfrow=c(1,3),mar = c(0,0,0,0.5) )
		TOP="Mean Ocean\ndepth (Km)"
		x=c(0.225,0.775);; dx=0.025
		mu = c(3.6,4.5)
		
		LABEL=c("North", "South")
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
		" ",textstyle(x)," S")),
		expression(mu[S] == paste(mu[0] + Delta * mu ,
		" ",textstyle(x)," S")),
		
		expression(mu[North]), 
		expression(mu[South]),
		expression(mu[North]),
		expression(mu[North] %*% Delta * mu),
		
		expression(mu[S] == paste(mu[0] %*% Delta * mu ,
		" ",textstyle(x)," S")),
		expression(mu[S] == paste(mu[0] %*% Delta * mu ,
		" ",textstyle(x)," S"))
		
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
		%*% Ratio^s), 2)
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
				mean(x),-0.25,"S", adj=c(0.5,1),cex=1.5)
				
			} 
		}
	}
	
	
	plot3(1)
	

## ----eval=T, echo=F, fig.align="center", fig.height=7, fig.width=9, warning=FALSE, message=F----
plot3(2)

## ----eval=T, echo=F, fig.align="center", fig.height=7, fig.width=9, warning=FALSE, message=F----
plot3(3)

## ----eval=T, echo=F, fig.align="center", fig.height=7, fig.width=9, warning=FALSE, message=F----
		plot3(4)

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


