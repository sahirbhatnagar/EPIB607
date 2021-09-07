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
options(digits = 2)


#knitr::opts_chunk$set(background = '#FFFF00')
library(tools) #needed for include_graphics2 function
pacman::p_load(here)
source(here::here("inst","slides","bin","include_graphics2.R"))
knitr::knit_hooks$set(purl = hook_purl)

## ----numerical, echo=TRUE, size = 'scriptsize', out.width="0.45\\linewidth", fig.subcap=c('base \\texttt{graphics} package', '\\texttt{ggplot2} package')----
library(ggplot2); library(oibiostat); 
data(famuss) 

plot(famuss$height, famuss$weight, xlab = "Height (in)", ylab = "Weight (lb)")

ggplot(data = famuss, mapping = aes(x = height, y = weight)) + 
  geom_point(size = 0.8, pch = 21)

## ----fam-plot, echo=FALSE, fig.asp = 0.681------------------------------------
library(oibiostat)
library(openintro)
data("COL")
data("famuss")


#cor(famuss$height, famuss$weight)
#plot(famuss$height, famuss$weight)

#(1/(nrow(famuss)-1)) * sum(scale(famuss$height)*scale(famuss$weight))

zx <- famuss$height
zy <- famuss$weight


plot(zx,
zy, 
pch = 19,
cex = 1.3,
col = COL[1, 3],
type = "n",
bty = "n",
xlab = "height (inches)",
ylab = "weight (pounds)")

points(zx,
zy,
pch = 19,
cex = 1.3,
col = COL[5,3])
points(zx,
zy,
cex = 1.3,
col = COL[5])

## ----zfam-plot, echo=FALSE, fig.asp = 0.681-----------------------------------
library(oibiostat)
library(openintro)
data("COL")
data("famuss")


#cor(famuss$height, famuss$weight)
#plot(famuss$height, famuss$weight)

#(1/(nrow(famuss)-1)) * sum(scale(famuss$height)*scale(famuss$weight))

zx <- scale(famuss$height)
zy <- scale(famuss$weight)


 
plot(zx,
zy, 
pch = 19,
cex = 1.3,
col = COL[1, 3],
type = "n",
#xlim = xlims,
#ylim = ylims,
bty = "n",
xlab = "height Z-scores",
ylab = "weight Z-scores")
points(zx,
zy,
pch = 19,
cex = 1.3,
col = COL[5,3])
points(zx,
zy,
cex = 1.3,
col = COL[5])

## ----echo=FALSE, fig.asp = 0.681----------------------------------------------
library(oibiostat)
library(openintro)
data("COL")
data("famuss")


#cor(famuss$height, famuss$weight)
#plot(famuss$height, famuss$weight)

#(1/(nrow(famuss)-1)) * sum(scale(famuss$height)*scale(famuss$weight))
#xlims <- c(-ceiling(abs(max(zx))),ceiling(abs(max(zx))))
#ylims <- c(-ceiling(abs(max(zy))),ceiling(abs(max(zy))))
xlims <- range(zx)
ylims <- range(zy)
plot(zx,
zy, 
pch = 19,
cex = 1.3,
col = COL[1, 3],
type = "n",
xlim = xlims,
ylim = ylims,
bty = "n",
xlab = "height Z-scores",
ylab = "weight Z-scores")
polygon(x = c(0,max(xlims), max(xlims), 0)*1.1, y = c(0,0, max(ylims), max(ylims))*1.1, col = "#56B4E9")
polygon(x = c(0,min(xlims), min(xlims), 0)*1.1, y = c(0,0, min(ylims), min(ylims))*1.2, col = "#56B4E9")
polygon(x = c(0,min(xlims), min(xlims), 0)*1.1, y = c(0,0, max(ylims), max(ylims))*1.1, col = "#D55E00")
polygon(x = c(0,max(xlims), max(xlims), 0)*1.1, y = c(0,0, min(ylims), min(ylims))*1.2, col = "#D55E00")
text(-2.7, 4.4, "(-,+)", cex = 1.5)
text(2.7, 4.4, "(+,+)", cex = 1.5)
text(2.7, -2.2, "(+,-)", cex = 1.5)
text(-2.7, -2.2, "(-,-)", cex = 1.5)

## ----echo=FALSE, fig.asp = 0.681----------------------------------------------
library(oibiostat)
library(openintro)
data("COL")
data("famuss")


#cor(famuss$height, famuss$weight)
#plot(famuss$height, famuss$weight)

#(1/(nrow(famuss)-1)) * sum(scale(famuss$height)*scale(famuss$weight))

plot(zx,
zy, 
pch = 19,
cex = 1.3,
col = COL[1, 3],
type = "n",
xlim = xlims,
ylim = ylims,
bty = "n",
xlab = "height Z-scores",
ylab = "weight Z-scores")
polygon(x = c(0,max(xlims), max(xlims), 0)*1.1, y = c(0,0, max(ylims), max(ylims))*1.1, col = "#56B4E9")
polygon(x = c(0,min(xlims), min(xlims), 0)*1.1, y = c(0,0, min(ylims), min(ylims))*1.2, col = "#56B4E9")
polygon(x = c(0,min(xlims), min(xlims), 0)*1.1, y = c(0,0, max(ylims), max(ylims))*1.1, col = "#D55E00")
polygon(x = c(0,max(xlims), max(xlims), 0)*1.1, y = c(0,0, min(ylims), min(ylims))*1.2, col = "#D55E00")
text(-2.7, 4.4, "(-,+)", cex = 1.5)
text(2.7, 4.4, "(+,+)", cex = 1.5)
text(2.7, -2.2, "(+,-)", cex = 1.5)
text(-2.7, -2.2, "(-,-)", cex = 1.5)
points(zx,
zy,
pch = 19,
cex = 1.3,
col = COL[5,3])
points(zx,
zy,
cex = 1.3,
col = COL[5])

## ----cor, echo=TRUE, size = 'scriptsize'--------------------------------------
cor(famuss$height, famuss$weight)

## ----cor2, echo=TRUE, size = 'scriptsize'-------------------------------------
summary(lm(height ~ weight, data = famuss))

## ----echo = TRUE, out.width= "0.3\\linewidth"---------------------------------
B <- 1000; N <- 595
R <- replicate(B, {
        dplyr::sample_n(famuss, size = N, replace = TRUE) %>% 
        dplyr::summarize(r = cor(height, weight)) %>% 
        dplyr::pull(r)
})

## ----bootmean, echo=TRUE, size = 'tiny'---------------------------------------
mean(R)
quantile(R, probs = c(0.025, 0.975))

## ----histboot,echo=TRUE, size = "tiny", fig.asp = 0.681-----------------------
hist(R, breaks = 20, col = "lightblue", xlab = "correlation", 
     main = "Distribution of samples of size 595")
abline(v = mean(R), col = "red", lwd = 2)
abline(v = quantile(R, probs = c(0.025, 0.975)), col = "blue", 
       lty = 2, lwd = 2)

## ----echo=FALSE, fig.cap = c('(a) A scatterplot showing height versus weight from the 500 individuals in the sample from NHANES. One participant 163.9 cm tall (about 5 ft, 4 in) and weighing 144.6 kg (about 319 lb) is highlighted. (b) A scatterplot showing height versus BMI from the 500 individuals in the sample from NHANES. The same individual highlighted in (a) is marked here, with BMI 53.83. Fitted regression lines are shown in red with correlation coefficient $r$. BMI = weight/height$^2$ $\\times 703$.'), fig.subcap = c('',''), out.width='0.55\\linewidth'----
library(openintro)
data(COL)
library(oibiostat)
data(nhanes.samp.adult.500)

plot(nhanes.samp.adult.500$Height,
nhanes.samp.adult.500$Weight,
pch = 19,
cex = 1.3,
col = COL[1, 3],
xlab = "",
ylab = "Weight (kg)")
points(nhanes.samp.adult.500$Height,
nhanes.samp.adult.500$Weight,
cex = 1.3,
col = COL[1])
mtext("Height (cm)", 1, 1.9)

t1 <- nhanes.samp.adult.500$Height[480]
t2 <- nhanes.samp.adult.500$Weight[480]
lines(c(t1, t1), c(-10, t2),
lty = 2,
col = COL[4])
lines(c(-10, t1), c(t2, t2),
lty = 2,
col = COL[4])
points(t1, t2,
pch = 19,
cex = 1.3,
col = COL[4, 3],)

data("nhanes.samp.adult.500")
nhanes.dat <- nhanes.samp.adult.500[,c("Height","Weight","BMI")]
nhanes.dat <- na.omit(nhanes.dat)
fit <- lm(Weight~Height, data = nhanes.dat)
lines(nhanes.dat$Height,
fit$fitted.values,col="red")
text(190,50, sprintf("r = %0.2f",summary(fit)$r.squared^0.5),cex=2)



plot(nhanes.samp.adult.500$Height,
nhanes.samp.adult.500$BMI,
pch = 19,
cex = 1.3,
col = COL[1, 3],
xlab = "",
ylab = "BMI")
points(nhanes.samp.adult.500$Height,
nhanes.samp.adult.500$BMI,
cex = 1.3,
col = COL[1])
mtext("Height (cm)", 1, 1.9)

t1 <- nhanes.samp.adult.500$Height[480]
t2 <- nhanes.samp.adult.500$BMI[480]
lines(c(t1, t1), c(-10, t2),
lty = 2,
col = COL[4])
lines(c(-10, t1), c(t2, t2),
lty = 2,
col = COL[4])
points(t1, t2,
pch = 19,
cex = 1.3,
col = COL[4, 3],)
fit <- lm(BMI~Height, data = nhanes.dat)
lines(nhanes.dat$Height,
fit$fitted.values,col="red")
text(190,50, sprintf("r = %0.2f",summary(fit)$r.squared^0.5),cex=2)

## ----echo=c(1), size = 'tiny', out.width='0.55\\linewidth', fig.cap = 'All four panels have the exact same linear correlation coefficient'----
library(datasets);data("anscombe")
ff <- y ~ x
mods <- setNames(as.list(1:4), paste0("lm", 1:4))
for(i in 1:4) {
ff[2:3] <- lapply(paste0(c("y","x"), i), as.name)
## or   ff[[2]] <- as.name(paste0("y", i))
##      ff[[3]] <- as.name(paste0("x", i))
mods[[i]] <- lmi <- lm(ff, data = anscombe)
}
## Now, do what you should have done in the first place: PLOTS
op <- par(mfrow = c(2, 2), mar = 0.1+c(4,4,1,1), oma =  c(0, 0, 2, 0))
for(i in 1:4) {
ff[2:3] <- lapply(paste0(c("y","x"), i), as.name)
plot(ff, data = anscombe, col = "red", pch = 21, bg = "orange", cex = 1.2,
xlim = c(3, 19), ylim = c(3, 13))
abline(mods[[i]], col = "blue")
text(15,4,sprintf("r = %0.2f",summary(mods[[i]])$r.squared^0.5), cex = 2)
}
mtext("Anscombe's 4 Regression data sets", outer = TRUE, cex = 1.5)
par(op)

## ----echo=TRUE, fig.asp = 0.481, size = "scriptsize"--------------------------
set.seed(12)
x <- runif(100,-1,1)
y <- x^2
plot(x,y, pch = 19)
cor(x,y)

## ----004-nyt, echo = FALSE, out.width = "0.53\\linewidth", fig.subcap=c('',''), fig.cap=c('(a) per capita income vs. life expectancy (b) log per capita income vs. life expectancy. Fitted regression line in red with correlation coefficient $r$.\\footnote{\\tiny{The World Development Indicators (WDI) is a database of country-level variables (i.e., indicators) recording outcomes for a variety of topics, including economics, health, mortality, fertility, and education}}')----
library(openintro)
library(oibiostat)
data("wdi.2011")
data(COL)

plot(wdi.2011$life.expect,
wdi.2011$gdp.per.capita,
pch = 19,
cex = 1.3,
col = COL[1, 3],
xlab = "Life Expectancy (years)",
ylab = "Per Capita Income (USD)",
axes = FALSE)
fit1 <- lm(gdp.per.capita~life.expect, data = wdi.2011)
lines(wdi.2011$life.expect,
fit1$fitted.values,col="red")
points(wdi.2011$life.expect,
wdi.2011$gdp.per.capita,
cex = 1.3,
col = COL[1])
AxisInDollars(2, pretty(wdi.2011$gdp.per.capita))
axis(1)
text(55,1e5, sprintf("r = %0.2f",summary(fit1)$r.squared^0.5), cex = 2)


plot(wdi.2011$life.expect,
log(wdi.2011$gdp.per.capita),
pch = 19,
cex = 1.3,
col = COL[1, 3],
xlab = "Life Expectancy (years)",
ylab = "log(Per Capita Income (USD))",
axes = FALSE)
fit2 <- lm(log(gdp.per.capita)~life.expect, data = wdi.2011)
lines(wdi.2011$life.expect,
fit2$fitted.values,col="red")
AxisInDollars(2, pretty(log(wdi.2011$gdp.per.capita)))
axis(1)
text(55,11, sprintf("r = %0.2f",summary(fit2)$r.squared^0.5), cex = 2)

## ----contt-0, echo=TRUE, size = 'scriptsize'----------------------------------
tab1 <- table(famuss$race, 
              famuss$actn3.r577x)
tab1
addmargins(tab1)

## ----contt, echo=TRUE, size = 'tiny'------------------------------------------
addmargins(
  prop.table(tab1, margin = 1)
)

## ----echo=FALSE---------------------------------------------------------------
#old <- theme_set(theme_minimal())
#theme_set(old)
#theme_update(legend.position = "bottom")
library(cowplot)
sjPlot::set_theme(legend.pos = "bottom", base = theme_minimal_hgrid(font_size = 9))

## ----genotype-marginals,echo=TRUE, size = "tiny"------------------------------
sjPlot::plot_xtab(famuss$race, 
                  famuss$actn3.r577x,
                  margin = "row")

## ----contt44, echo=TRUE, size = 'tiny'----------------------------------------
addmargins(prop.table(tab1, margin = 2))

## ----race-marginals,echo=TRUE, size = "tiny", fig.width = 8, fig.height = 4----
sjPlot::plot_xtab(famuss$race, famuss$actn3.r577x, margin = "col", show.total = F, show.n = F)

## ----echo = TRUE, fig.subcap = c('',''), out.width="0.45\\linewidth"----------
table(famuss$race) / nrow(famuss)
sjPlot::plot_frq(famuss$race)
sjPlot::plot_frq(famuss$actn3.r577x)

## ----echo=FALSE---------------------------------------------------------------
old <- theme_set(theme_minimal(base_size = 16L))
theme_set(old)

## ----mosaic-1,echo = TRUE,fig.asp = 0.681-------------------------------------
# devtools::install_github("haleyjeppson/ggmosaic")
pacman::p_load(ggmosaic)
ggplot(data = famuss) +
  geom_mosaic(aes(x = product(race, actn3.r577x),
                  fill = race))

## ----mosaic-2,echo = TRUE,fig.asp = 0.681-------------------------------------
    ggplot(data = famuss) +
      geom_mosaic(aes(x = product(race, actn3.r577x),
                      fill = race, conds = product(sex)),
                      divider = mosaic("v"))

## ----echo=FALSE---------------------------------------------------------------
old <- theme_set(theme_minimal(base_size = 16L))
theme_set(old)

## ----box-1, echo=TRUE, size = 'scriptsize',fig.asp = 0.681--------------------
ggplot(data = famuss, mapping = aes(x = actn3.r577x, y = ndrm.ch, fill = actn3.r577x)) + 
  geom_boxplot()

## ----echo=TRUE, error=TRUE, size = "scriptsize"-------------------------------
cor(famuss$actn3.r577x, famuss$ndrm.ch)
cor(as.numeric(famuss$actn3.r577x), famuss$ndrm.ch, method = "pearson")
cor(as.numeric(famuss$actn3.r577x), famuss$ndrm.ch, method = "kendall")
cor(as.numeric(famuss$actn3.r577x), famuss$ndrm.ch, method = "spearman")

## ----echo=FALSE, comment = NA, size = 'tiny'----------------------------------
print(sessionInfo(), locale = FALSE)

