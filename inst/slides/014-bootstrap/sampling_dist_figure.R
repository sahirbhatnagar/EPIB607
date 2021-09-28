PointsSubset <- function(x, y, subset, ...) {
  if(any(subset))
    points(x[subset], y[subset], ... )
  return(invisible(NULL))
}

#### Density for Population

# Population is 50% N(-2, 1) and 50% N(2, 2^2); mu = 0, var = 4 + (1+4)/2 = 6.5
n <- 20
populationMean <- c(-2, 2)
mu <- mean(populationMean)
populationSd <- c(1, 2)
populationVar <- populationSd^2
mu1 <- mean(populationMean)
sd1 <- sqrt( (diff(populationMean)/2)^2 + mean(populationVar))

# Some values for use in plotting
Xlim <- c(-6, 8)
Breaks <- seq(Xlim[1], Xlim[2], length = 21)
# density = fraction / barwidth = count / (n*14/20), max = 5/(20*14/20) = .35
Ylim <- c(0, .351)
# max hist density is
XlimMean <- c(-3, 3)
YlimMean <- c(0, 1) # Ylim * sqrt(n) is taller than needed,
segmentTop <- .32

rPopulation <- function(n){
  # Generate observations from population
  i <- sample(1:2, size = n, replace = TRUE)
  rnorm(n, mean = populationMean[i], sd = populationSd[i])
}
dPopulation <- function(x){
  # density from population
  (dnorm(x, populationMean[1], sd = populationSd[1]) +
     dnorm(x, populationMean[2], sd = populationSd[2]))/2
}
dMean <- function(x, n){
  # Density for sampling distribution of the mean.
  # Number of observations from first half of population is Bi(n, .5)
  k <- 0:n
  f <- function(k, x) {
    # density at x, given k observations from first half
    dnorm(x, (k*populationMean[1] + (n-k)*populationMean[2])/n,
          sqrt(k*populationVar[1] + (n-k)*populationVar[2])/n)
  }
  colSums(dbinom(k, n, .5) * outer(k, x, f))
}


#### Some parameters for figure layout.
# left part from 0 to .6 (population & samples), right from .65 to 1 (samp dist)
divideX <- c(.6, .65)
# Of left part, use ranges 0 to .3, .35 to .65, .7 to 1
#divideY <- c(0, .30, .35, .65, .7, 1)
divideY <- c(0, .32, .33, .65, .70, 1)

useFraction <- .9
Fraction2 <- 0:1 + c(1, -1) * (1 - useFraction) / 2

#--------------------------------------------------
# Setup for both figures

# Generate some random samples; I'll pick some with varying mu and sigma
set.seed(0)
A <- lapply(1:300, function(i, n) rPopulation(n), n = n)
if(FALSE) {
  A1means <- sapply(A, mean)
  A1sd <- sapply(A, sd)
  plot(A1means, A1sd)
  abline(h = sqrt(6.5))
  # Don't want any with values outside Xlim
  ii <- which(sapply(A, function(x) (max(x) < Xlim[2]) & (min(x) > Xlim[1])))
  PointsSubset(A1means, A1sd, -ii, col = "red", pch = 3)
  # Don't want any for which any of the bins have more than 5.
  temp <- lapply(A[ii], hist, breaks = Breaks, plot = FALSE)
  table(sapply(temp, function(x) max(x$counts))) # table for number in top bin
  good <- (sapply(temp, function(x) max(x$counts)) <= 5)
  PointsSubset(A1means[ii], A1sd[ii], !good, col = "yellow")
  # text(A1means[Aii], A1sd[Aii], Aii) # So show current selection on plot
  identify(A1means[ii], A1sd[ii], n = 5, labels = ii)
  # Save interesting ones as Aii. Want first to have average sd & moderately
  # extreme mean.
}
Aii <- as.integer(c(277, 100, 191, 186, 218))
first <- Aii[1]
# 277 has moderately high mean & average sd
# 199 has very high mean and avg sd, 191 is low both, 218 is high sd


set.seed(0)
Ameans <- sapply(1:10^4, function(i, n) mean(rPopulation(n)), n = n)
mean(Ameans) # Should be near zero
var(Ameans) # Should be close to population var of 6.5/20 = .325

standardColor <- "blue"

PlotSample <- function(data, lineMu = TRUE, star = FALSE, lineM = NULL,
                       col = standardColor){
  # lineMu: logical, add a vertical line at mu
  # star:  logical, label with xbar* instead of xbar
  # lineM: NULL or numeric; add a vertical line there
  
  hist(data, breaks = Breaks, col = col,
       probability = TRUE, axes = FALSE, new = FALSE, border = 0,
       xlab = "", xlim = Xlim, ylim = Ylim, xaxs = "i", yaxs = "i", main = "")
  axis(side = 1, at = Xlim, labels = c(0,80))
  axis(side = 1, at = mean(data),
       if(star) expression(bar(y)^"*") else expression(bar(y)))
  if(lineMu) {
    segments(mu, y0 = 0, y1 = segmentTop)
    axis(side = 1, at = mu, "")
  }
  if(length(lineM)) {
    segments(lineM, y0 = 0, y1 = segmentTop, col = "red", lty = 2)
    axis(side = 1, at = lineM, "", col = "red")
  }
  invisible(NULL)
}

# Shortcut for bootstrap samples
PlotSample2 <- function(data, lineM, ...) {
  PlotSample(data, lineMu = FALSE, star = TRUE, lineM = lineM, ...)
}

#--------------------------------------------------
# Make graph idealWorld3.pdf (only three samples)

# Rescale figures to use only the top two regions
rescaleY <- function(x) (x-.33)/.67
divideY3 <- (c(NA, NA, .33, .65, .70, 1) - .33) / .67
figureHeight <- 4 * .67

# Use lighter color
standardColor <- "gray"


#system("mkdir ../figures")
#pdf("../figures/idealWorld3.pdf", height = figureHeight)

### Population density
par(fig = c(divideX[1] * (1/3 + 1/3 * Fraction2), divideY3[5:6]),
    mar = .1 + c(2, 0, 0, 0), mex = .8)
x <- seq(from = Xlim[1], to = Xlim[2], length = 151)
plot(x, dPopulation(x), xlab = "", ylab = "",
     type = "l", ylim = Ylim, xlim = Xlim,
     axes = FALSE, xaxs = "i", yaxs = "i", lwd = 2)
segments(mu, 0, y1 = segmentTop)
axis(side = 1, at = Xlim, labels = c(0, 80))
axis(side = 1, mu, expression(mu))

### Samples
par(fig = c(divideX[1] * (0/3 + 1/3 * Fraction2), divideY3[3:4]), new = TRUE)
PlotSample(A[[first]])
#axis(1, mu, expression(mu)) #text(mu, segmentTop+.02, adj = .5, expression(mu))
par(fig = c(divideX[1] * (1/3 + 1/3 * Fraction2), divideY3[3:4]), new = TRUE)
PlotSample(A[[Aii[2]]])
par(fig = c(divideX[1] * (2/3 + 1/3 * Fraction2), divideY3[3:4]), new = TRUE)
PlotSample(A[[Aii[3]]])


### Sampling distn (at right)
par(fig = c(divideX[2], 1, 0, .5), new = TRUE)
par(mar = c(4.1, 0, 0, 0))
xd <- seq(from = XlimMean[1], to = XlimMean[2], length = 151)
plot(xd, dMean(xd, n),
     xlim = XlimMean, ylim = YlimMean,
     type = "l", axes = FALSE, main = "", yaxs = "i", lwd = 2,
     xlab = "", ylab = "") # xlab = expression(bar(x))
#plot(density(Ameans), xlim = XlimMean, ylim = YlimMean,
#     type = "l", axes = FALSE, main = "", yaxs = "i", lwd = 2)

axis(side = 1, XlimMean[1:2], labels = c(0, 80))
abline(v = mu, h = 0)
axis(side = 1, mu, expression(mu))
# Need axis call last, not abline, or arrows and text don't show up.

### Arrows
par(mar = c(2.1, 0, 0, 0))
par(fig = c(0, 1, 0, 1), usr = c(0, 1, 0, 1))
arrows(lwd = 1.5, length = .125,
       x0 = divideX[1] * (.29 + .42 * ppoints(5)[c(1,3,5)]),
       x1 = divideX[1] * seq(.3, .7, length = 3),
       y0 = rescaleY(divideY[4:5] %*% c(.2, .77)) - .05,
       y1 = rescaleY(divideY[4] - c(.6, 1, .6) * (divideY[5]-divideY[4])) - .05
)
arrows(divideX[1], c(.1, .2, .3), length = .125,
       divideX[2], lwd = 1.5)

### Text
text(.4, .85, "Population F", adj = 0)
text((divideX[2]+1)/2, .55, adj = .5,
     expression("Sampling\ndistribution of " * bar(y)))
text(0.01, divideY3[4], adj = 0, "Samples")
legend(.01, .9, lty=1, legend = expression(mu))

#dev.off()