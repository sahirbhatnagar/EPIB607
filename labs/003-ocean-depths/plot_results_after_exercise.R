water_results <- read.csv("~/git_repositories/EPIB607/slides/sampling_dist/EPIB607_FALL2018_water_exercise - water.csv", as.is=TRUE)
# read in the results from the Google sheet 
# water_results <- read.csv("EPIB607_FALL2018_water_exercise - water.csv", as.is=TRUE)
water_results <- water_results[,1:6]
water_results <- water_results[complete.cases(water_results), ]

# count the number of students who provided a mean and proportion
N.r <- nrow(water_results)

plot(table(water_results[,"PropnW.5.locations"]), 
     xlim = c(0,1),
     xlab = "Students' Estimates of Proportion Covered by Water",
     main = "n = 5", 
     ylim = c(0, N.r/1.5), 
     ylab = "Frequency")


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




# Number 3 ----------------------------------------------------------------

dev.off()
par(mfrow=c(2,1), mai = c(0.45,0.45,0.45,0.1))

d.BREAKS <- seq(1000,6000,500)
hist(water_results[,"Mean.5.depths"], 
     xlim = c(0,6000),
     ylim = c(0, N.r/1.5), 
     breaks = d.BREAKS,
     xlab = "Students' Estimates of Mean Ocean Depth (m)",
     main = "n = 5")

hist(water_results[,"Mean.20.depths"], 
     xlim = c(0,6000),
     ylim = c(0, N.r/1.5), 
     breaks = d.BREAKS,
     xlab = "Students' Estimates of Mean Ocean Depth (m)",
     main = "n = 20")
plot(table(water_results[,4]),xlim=c(0,1),
     main="n=20",ylim=c(0,N.r/2),ylab="Frequency")

hist(water_results[,6],xlim=c(0,6000),
     ylim=c(0, N.r/1.5),breaks=d.BREAKS,
     main="n=20",xlab="")
