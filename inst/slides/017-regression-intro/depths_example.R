# load function to get depths
source("https://github.com/sahirbhatnagar/EPIB607/raw/master/exercises/water/automate_water_task.R")

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
head(depths)

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
     expression(widehat(mu[0])) )
text(2.1, means[2],
     expression(widehat(mu[1])) )
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


# inference
n0 <- nrow(depths_north)
n1 <- nrow(depths_south)

mean0 <- mean(depths_north$alt)
mean1 <- mean(depths_south$alt)

var0 <- var(depths_north$alt)
var1 <- var(depths_south$alt)

sqrt(var0)/sqrt(400)

varb0 <- (1576)^2 * (1/400 + 0.5^2/sum((depths$South-0.5)^2))

sqrt(varb0)
pt(0.513, 398, lower.tail = F)

SEM <- sqrt(var0/n0 + var1/n1)

test_statistic <- (mean0 - mean1) / SEM


# t.test
# unequal variances
t.test(alt ~ South, data = depths, var.equal = FALSE) # default
qt(c(0.025, 0.975), df = 349.61783) * SEM + (mean0 - mean1)
qnorm(c(0.025, 0.975), mean = mean0 - mean1, sd = SEM)

# equal variances
t.test(alt ~ South, data = depths, var.equal = TRUE)
qt(c(0.025, 0.975), df = n0 + n1 - 2) * SEM + (mean0 - mean1)
qnorm(c(0.025, 0.975), mean = mean0 - mean1, sd = SEM)


fit <- lm(alt ~ 1, data = depths)
summary(fit)
mean(depths$alt)
sd(depths$alt) / sqrt(nrow(depths))

mean(depths$alt)/ (sd(depths$alt) / sqrt(nrow(depths)))

sqrt(sum((mean(depths$alt)-depths$alt)^2/(nrow(depths)-1)))
pt(46.8, 399, lower.tail = F)
# regression
fit <- lm(alt ~ South, data = depths)
summary(fit)

sqrt(sum((depths$alt-mean(depths$alt))^2) / 398)

sqrt()

sum((depths$alt-predict(fit))^2) / 398

sqrt(sum(fit$residuals^2)/398)

library(broom)
tt <- tidy(fit)
augment(fit)
# lm assumes equal variances
qt(c(0.025, 0.975), df = n0 + n1 - 2) * SEM + (mean0 - mean1)

head(iris)

fit <- lm(Sepal.Length ~ ., data = iris)
summary(fit)
sqrt(sum(fit$residuals^2)/fit$df.residual)
sqrt(sum((iris$Sepal.Length-mean(iris$Sepal.Length))^2) / fit$df.residual)
