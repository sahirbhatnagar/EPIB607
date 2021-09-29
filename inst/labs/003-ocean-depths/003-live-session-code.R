pacman::p_load(googlesheets4)
water_results <- googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1Mnxeq9nQcTdQycZ7S_62fYFiNC5_a3fibsyodzfwO58/edit#gid=2023948148")

source("https://github.com/sahirbhatnagar/epib607/raw/master/inst/labs/003-ocean-depths/automate_water_task.R")

water_results <- water_results[,1:6]
water_results <- water_results[complete.cases(water_results), ]
# count the number of students who provided a mean and proportion
N.r <- nrow(water_results)

par(mfrow = c(1,2))
plot(table(water_results$PropnW.5.locations), type = "h")
abline(v = 0.7, lty = 2, lwd = 2, col = "red")

plot(table(water_results$PropnW.20.locations), type = "h")
abline(v = 0.7, lty = 2, lwd = 2, col = "red")

water_results$PropnW.20.locations
sd(water_results$PropnW.20.locations)
sd(water_results$PropnW.5.locations)


par(mfrow = c(1,2))
hist(water_results$Mean.5.depths)
abline(v = mean(water_results$Mean.5.depths), col = "red", lty = 2, lwd = 3)
hist(water_results$Mean.20.depths)
abline(v = mean(water_results$Mean.20.depths), col = "red", lty = 2, lwd = 3)





