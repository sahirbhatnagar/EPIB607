set.seed(12)
TrueParameter = rep(c(10,15,18), each=8)
Estimate = rep(c(rnorm(8, 10, 1), rnorm(8, 15, 0.5), rnorm(8, 18, 2)))
LowBound95 = Estimate - abs(rnorm(24, 0, 5))
HighBound95 = Estimate + abs(rnorm(24, 0, 5))
LowBound99 = LowBound95 - abs(rnorm(24, 0, 5))
HighBound99 = HighBound95 + abs(rnorm(24, 0, 5))
dt = data.frame(TrueParameter = TrueParameter, Estimate = Estimate, 
                LowBound95 = LowBound95, HighBound95 = HighBound95, 
                LowBound99 = LowBound99, HighBound99 = HighBound99)
head(dt)
plot(dt$Mean.5.depths, 1:nrow(dt), pch=20, 
xlim=range(pretty(c(dt$lower.mean.5.66, dt$upper.mean.5.66))),
xlab='Depth of ocean (m)', ylab='Student (sample)', 
las=1, cex.axis=0.8, cex=1.5)
abline(v = 3700, lty = 2, col = "red", lwd = 2)
segments(x0 = dt$lower.mean.5.66, x1=dt$upper.mean.5.66, 
         y0 = 1:nrow(dt), lend=1)

