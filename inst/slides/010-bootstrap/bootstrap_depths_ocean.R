source("https://github.com/sahirbhatnagar/EPIB607/raw/master/exercises/water/automate_water_task.R")

index.n.20 <- c(2106,2107,2108,2109,2110,2111,2112,2113,2114,2115,
                2116,2117,2118,2119,2120,2121,2122,2123,2124,2125)
depths.n.20 <- automate_water_task(index = index.n.20, student_id = 260194225, type = "depth")



library(mosaic)
s <- do(2) * resample(depths.n.20)
s


s <- do(20000) * mean( ~ alt, data = resample(depths.n.20))
head(s)

mean(s$mean)
mm <- mean(depths.n.20$alt)
hist(s$mean, data = s, breaks = 50, col = "#56B4E9",
     xlab = "mean depth of the ocean (100m) from \neach bootstrap sample")
abline(v = mm, lty =1, col = "red", lwd = 4)
library(latex2exp)
legend("left", legend = TeX("$\\bar{y} = 36$"), lty = 1, 
       col = "red", lwd = 4)

sd(depths.n.20$alt) / sqrt((length(depths.n.20$alt)))
sd(s$mean)
quantile(s$mean, c(0.025, 0.975))

bootstrap <- do(500) * diffmean( age ~ sex, data=resample(HELPrct) )
confint(bootstrap)
confint(bootstrap, method = "percentile")
confint(bootstrap, method = "boot")
confint(bootstrap, method = "se", df=nrow(HELPrct) - 1)
confint(bootstrap, margin.of.error = FALSE)

confint(s, method = "perc")
confint(s, method = "boot")
confint(s, method = "se")
confint(s, method = "bootstrap-t")
mosaic:::confint.do.data.frame()
plot(s)
