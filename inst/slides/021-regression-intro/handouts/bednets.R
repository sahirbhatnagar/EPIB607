df <- data.frame(month = rep(c(paste0(c("june","july","august","september","october",
                                    "november","december"),"2014"),
                           paste0(c("may"),"2015"),
                           paste0(c("june","july","august","september","october",
                                    "november","december"),"2015")
                           ), 
                           each = 2),
                 exposure = rep(c(0,1), 15),
                 years = c(79,0,123,0,103,23,79,39,81,63,78,81,80,84,
                           89,82,
                           59,77,54,99,29,123,0,139,0,166,0,185,0,189),
                 cases = c(33,0,454,0,244,43,177,66,212,155,193,170,111,92,
                           15,14,42,50,146,223,64,266,0,271,0,337,0,304,0,56)
                 )

df <- df[-which(df$years==0),]

sum(df$years)
sum(df$cases)

library(mosaic)
df_stats(cases ~ exposure, data = df, sum)
df_stats(years ~ exposure, data = df, sum)

df <- data.frame(exposure = rep(c(0,1), 1),
                 years = c(844, 1351),
                 cases = c(1691, 2047)
                 )

fit <- glm(cases ~ exposure + offset(log(years)) +month, 
           data = df, family = poisson(link = log))
summary(fit)
exp(confint(fit))
exp(coef(fit))
predict(fit, type = "resp")
df$fitted <- exp(coef(fit)[1] + df$exposure * coef(fit)[2]) * df$years
df$fit2 <- fit$fitted.values
df

tt <- sum((df$cases - df$fit2)^2 / df$fitted)
df$fitted

pchisq(tt, length(df$cases) - 1, lower.tail = F)

chisq.test()
fisher.test()

fit$coefficients
res <- cbind(fit$fitted.values,
             df$cases)
res$diff2 <- res

fit <- glm(cases ~ exposure + offset(log(years)) + month, 
           data = df, family = quasipoisson(link = log))

summary(fit)
exp(coef(fit)[1])
exp(sum(coef(fit)))

fit <- glm(cases ~ -1 + years + years:exposure, 
           data = df, family = poisson(link = identity))
summary(fit)


str(df)
fit <- glm(cases ~ exposure + month + offset(log(years)), 
           data = df, family = poisson(link = log))
summary(fit)
as.matrix(exp(coef(fit)))
exp(confint(fit))

rate_standard <- 1691/844
rate_treat <- 2047/1351


1691 * dpois(0:10, lambda = rate_standard)
sum(1691 * dpois(0:10, lambda = rate_standard))








