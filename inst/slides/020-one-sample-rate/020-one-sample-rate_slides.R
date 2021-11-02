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


## ----echo = TRUE--------------------------------------------------------------
# Vaccine group
qnorm(p = c(0.025, 0.975), mean = 0, sd = sqrt(0)) 

# Placebo
qnorm(p = c(0.025, 0.975), mean = 41, sd = sqrt(41)) 

## ----echo = TRUE--------------------------------------------------------------
# Vaccine group
qnorm(p = c(0.025, 0.975), mean = 6, sd = sqrt(6)) 

# Placebo
qnorm(p = c(0.025, 0.975), mean = 68, sd = sqrt(68)) 

## ----echo = FALSE, fig.asp = 0.731--------------------------------------------
set.seed(12345)
true_lambda <- 6
sims <- rpois(100, lambda = true_lambda)
df <- plyr::ldply(sims, function(i){
z_ci <- qnorm(p = c(0.025, 0.975), mean = i, sd = sqrt(i)) 
c(z_ci,i, dplyr::between(true_lambda, z_ci[1],z_ci[2]))
}) 

df$trial <- factor(seq_along(df$V1))
colnames(df) <- c("lower","upper","mean", "covered", "trial")
df$covered <- factor(df$covered, levels = 0:1, labels = c("no","yes"))
df$width <- df$upper - df$lower

p <- ggplot(df, aes(mean, trial, colour = covered))
p + geom_point() +
geom_errorbarh(aes(xmax = upper, xmin = lower)) + geom_vline(xintercept = true_lambda) + 
theme_classic(base_size = 13L)+ labs(caption = sprintf("Each 95%% CI was calculated using the Normal Approximation. Median CI width is %0.2f", median(df$width)))

## ----echo = FALSE, fig.asp = 0.721--------------------------------------------
set.seed(12345)
true_lambda <- 6
sims <- rpois(100, lambda = true_lambda)
df <- plyr::ldply(sims, function(i){
z_ci <- poisson.test(x = i, T = 1)$conf.int
c(z_ci,i, dplyr::between(true_lambda, z_ci[1],z_ci[2]))
}) 

df$trial <- factor(seq_along(df$V1))
colnames(df) <- c("lower","upper","mean", "covered", "trial")
df$covered <- factor(df$covered, levels = 0:1, labels = c("no","yes"))
df$width <- df$upper - df$lower

p <- ggplot(df, aes(mean, trial, colour = covered))
p + geom_point() +
geom_errorbarh(aes(xmax = upper, xmin = lower)) + geom_vline(xintercept = true_lambda) + 
theme_classic(base_size = 13L)+ labs(caption = sprintf("Each 95%% CI was calculated using Poisson model. Median CI width is %0.2f", median(df$width)))

## ----echo = FALSE, fig.asp = 0.701--------------------------------------------
set.seed(1234)
true_lambda <- 68
sims <- rpois(100, lambda = true_lambda)
df <- plyr::ldply(sims, function(i){
z_ci <- qnorm(p = c(0.025, 0.975), mean = i, sd = sqrt(i)) 
c(z_ci,i, dplyr::between(true_lambda, z_ci[1],z_ci[2]))
}) 

df$trial <- factor(seq_along(df$V1))
colnames(df) <- c("lower","upper","mean", "covered", "trial")
df$covered <- factor(df$covered, levels = 0:1, labels = c("no","yes"))
df$width <- df$upper - df$lower

p <- ggplot(df, aes(mean, trial, colour = covered))
p + geom_point() +
geom_errorbarh(aes(xmax = upper, xmin = lower)) + geom_vline(xintercept = true_lambda) + 
theme_classic(base_size = 13L)+ labs(caption = sprintf("Each 95%% CI was calculated using the Normal Approximation. Median CI width is %0.2f", median(df$width)))

## ----echo = FALSE, fig.asp = 0.701--------------------------------------------
set.seed(1234)
true_lambda <- 68
sims <- rpois(100, lambda = true_lambda)
df <- plyr::ldply(sims, function(i){
z_ci <- poisson.test(x = i, T = 1)$conf.int
c(z_ci,i, dplyr::between(true_lambda, z_ci[1],z_ci[2]))
}) 

df$trial <- factor(seq_along(df$V1))
colnames(df) <- c("lower","upper","mean", "covered", "trial")
df$covered <- factor(df$covered, levels = 0:1, labels = c("no","yes"))
df$width <- df$upper - df$lower

p <- ggplot(df, aes(mean, trial, colour = covered))
p + geom_point() +
geom_errorbarh(aes(xmax = upper, xmin = lower)) + geom_vline(xintercept = true_lambda) + 
theme_classic(base_size = 13L)+ labs(caption = sprintf("Each 95%% CI was calculated using Poisson model. Median CI width is %0.2f", median(df$width)))

## ----eval=FALSE, echo=FALSE---------------------------------------------------
#  load("~/git_repositories/EPIB607/slides/one_sample_rate/DebTrivedi.rda")
#  plot(table(DebTrivedi$ofp), xlab = "number of physician office visits", ylab = "frequency")

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  dpois(x = 0:15, lambda = 6)

## ----fig.width = 6, fig.height = 5--------------------------------------------
plot(0:15, dpois(x = 0:15, lambda = 6),pch = 19, xlab="k", ylab="P(Y=k)", type = "h", lwd = 2, col="red")
legend("topright", latex2exp::TeX("Poisson($\\mu = 6$)"), 
col = c("red"), lty = c(1), lwd = 2)

## ----fig.width = 6, fig.height = 5--------------------------------------------
plot(0:15, dpois(x = 0:15, lambda = 0.5),pch = 19, xlab="k", ylab="P(Y=k)", type = "h", lwd = 2)
lines(0:15, dpois(0:15, lambda = 6), pch = 19, col = "red", type = "h", lwd = 2)
legend("topright", c(latex2exp::TeX("Poisson($\\mu = 0.5$)"),
latex2exp::TeX("Poisson($\\mu = 6$)")), 
col = c("black","red"), lty = c(1,1), lwd = 2)

## ----fig.cap="Probability mass funtion for Bin(n=100,0.1) and Poisson(10)", fig.asp=0.681----
plot(0:20, dbinom(x = 0:20, size = 100, p=0.1), pch = 19, xlab="k", ylab="P(Y=k)")
points(0:20, dpois(0:20, lambda = 100*0.1), pch = 19, col = "red")
legend("topright", c("Binomial(100,0.1)", "Poisson(10)"), col = c("black","red"), pch=19)

## ----echo=TRUE, eval=TRUE, fig.asp=0.418--------------------------------------
# middle area is not 95%
mosaic::xqpois(c(0.025, 0.975), lambda = 6)

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
qgamma(p = c(0.025,0.975), shape = c(6, 7))

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  qgamma(p = c(0.025,0.975), shape = c(y, y+1))

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
stats::poisson.test(6)

## ----echo=TRUE----------------------------------------------------------------
qgamma(p = c(0.025, 0.975), shape = c(211, 212))	

## ----echo=TRUE----------------------------------------------------------------
qgamma(p = c(0.025, 0.975), shape = c(211, 212)) / 232978 * 1e5	

## ----echo=TRUE----------------------------------------------------------------
qgamma(c(0.025,0.975), c(33,34)) / 131200 * 1e5

## ----echo=TRUE----------------------------------------------------------------
stats::poisson.test(x = 33, T = 131200)

## ----echo=TRUE, fig.asp=0.418-------------------------------------------------
mosaic::xppois(1, lambda = 0.57, lower.tail = FALSE)

## ----echo=TRUE----------------------------------------------------------------
stats::poisson.test(x=2,T=0.57)

## ----echo=FALSE, comment = NA, size = 'tiny'----------------------------------
print(sessionInfo(), locale = FALSE)

