df <- read.csv("~/git_repositories/epib607/slides/regression/handouts/whickham.csv",
               header = TRUE)

fit1 <- glm(cbind(dead, alive) ~ smoking, 
            data = df, 
            family = binomial(link=logit))
summary(fit1)
table(fit1$fitted.values)
plogis(sum(coef(fit1)[1]))
plogis(sum(coef(fit1)))

fit1 <- glm(cbind(dead, alive) ~ (smoking) * 
              (age25+age35+age45+age55+age65+age75), 
            data = df, 
            family = binomial(link=logit))
summary(fit1)
exp(sum(coef(fit1)))
exp(sum(coef(fit1)[1]))

fit2 <- glm(cbind(dead, alive) ~ ., 
            data = df, 
            family = binomial(link=logit))
summary(fit2)
table(fit1$fitted.values)
plogis(sum(coef(fit1)[1]))
plogis(sum(coef(fit1)))

par(mfrow=c(1,2))
curve(log(x / (1-x)), 
      from = min(fit2$fitted.values),
      to = max(fit2$fitted.values))
points(fit2$fitted.values, 
       log(fit2$fitted.values / 
             (1-fit2$fitted.values)),
       pch=19)
curve(log(x ), 
      from = min(fit2$fitted.values),
      to = max(fit2$fitted.values))
points(fit2$fitted.values, 
       log(fit2$fitted.values),
       pch=19)

5+5








































































# str(df)
# 
# df
# 
# fit1 <- glm(cbind(dead, alive) ~ smoking, data = df, family = binomial(link=logit))
# summary(fit1)
# exp(coef(fit1))
# plogis(sum(coef(fit1)))
# 139/582
# 
# 
# fit2 <- glm(cbind(dead, alive) ~ smoking, data = df, family = binomial(link=log))
# summary(fit2)
# exp(coef(fit2))
# 
# table(fit1$fitted.values, fit2$fitted.values)
# 
# 
# 
# fit3 <- glm(cbind(dead, alive) ~ ., data = df, family = binomial(link=logit))
# summary(fit3)
# exp(coef(fit3))
# fit3$fitted.values
# 
# dev.off()
# par(mfrow=c(1, 2))
# curve(log(x/(1-x)), from = range(fit3$fitted.values)[1], to = range(fit3$fitted.values)[2])
# points(fit3$fitted.values, log(fit3$fitted.values / (1-fit3$fitted.values)), pch = 19)
# rug(fit3$fitted.values)
# curve(log(x), from = range(fit3$fitted.values)[1], to = range(fit3$fitted.values)[2])
# rug(fit3$fitted.values)
# points(fit3$fitted.values, log(fit3$fitted.values), pch = 19)
# 
# 
# fit <- glm(cbind(dead, alive) ~ ., data = df, family = binomial)
# summary(fit)
# exp(coef(fit))
# plogis(sum(coef(fit)))
# fit$fitted.values
# 
# 
# 
# 
# # doesnt work
# fit <- glm(cbind(dead, alive) ~ smoking + age25 + age35 + age45 + age55 + age65 + age75, data = df, family = binomial(link=log))
# summary(fit)
# exp(coef(fit))
# 
# fit$fitted.values
