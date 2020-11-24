# setwd("/Users/jameshanley/Dropbox/EPIB607/Jim2018/IntroRegression")

# this has ART as factor
# ds=read.table("~/git_repositories/epib607/slides/regression/handouts/hivTransmsion.txt",
#               header=TRUE)

# this has ART as indicators
ds=read.csv("~/git_repositories/epib607/slides/regression/handouts/hiv_Transmission.csv",
              header=TRUE)
ds$n.hivneg= ds$n.pairs - ds$n.hivpos
str(ds)
# ds$ART1or2 <- ifelse(ds$m.trimesters.tx==1.5, 1, 0)
# ds$ART3 <- ifelse(ds$m.trimesters.tx==3, 1, 0)
# ds$m.trimesters.tx <- NULL
# head(ds)
# write.table(ds, file = "hiv_Transmission.csv", quote = FALSE, row.names = FALSE, 
#             sep = ",")

ds$propn = round(ds$n.hivpos/ds$n.pairs,3)

#overall proportion hiv positive

round(sum(ds$n.hivpos)/sum(ds$n.pairs),3)

# intercept-only logit model

# devtools::install_github('droglenc/NCStats')
library(NCStats)

fit0=glm(cbind(n.hivpos,ds$n.hivneg) ~ 1,
  family=binomial, data=ds)
summary(fit0)


logistic.regression.or.ci <- function(regress.out, level=0.95){
  ################################################################
  #                                                              #
  #  This function takes the output from a glm                   #
  #  (logistic model) command in R and provides not              #
  #  only the usual output from the summary command, but         #
  #  adds confidence intervals for all coefficients and OR's.    #
  #                                                              #
  #  This version accommodates multiple regression parameters    #
  #                                                              #
  ################################################################
  usual.output <- summary(regress.out)
  z.quantile <- qnorm(1-(1-level)/2)
  number.vars <- length(regress.out$coefficients)
  OR <- exp(regress.out$coefficients[-1])
  temp.store.result <- matrix(rep(NA, number.vars*2), nrow=number.vars)
  for(i in 1:number.vars)
  {
    temp.store.result[i,] <- summary(regress.out)$coefficients[i] +
      c(-1, 1) * z.quantile * summary(regress.out)$coefficients[i+number.vars]
  }
  intercept.ci <- temp.store.result[1,]
  slopes.ci <- temp.store.result[-1,]
  OR.ci <- exp(slopes.ci)
  output <- list(regression.table = usual.output, intercept.ci = intercept.ci,
                 slopes.ci = slopes.ci, OR=OR, OR.ci = OR.ci)
  return(output)
}


summary(fit0)

#checks
 
plogis(fit0$coefficients)

round(cbind(ds$propn,fit0$fitted.values) ,3)

# caesarian-only model ----

# 1st  raw data

( n.s=aggregate(ds$n.pairs,
 by=list(caesarian=ds$caesarian),sum) )


( pos=aggregate(ds$n.hivpos,
 by=list(caesarian=ds$caesarian),sum) )

( neg=aggregate(ds$n.hivneg,
 by=list(caesarian=ds$caesarian),sum) )

( or = round(pos$x[2]/neg$x[2]/(pos$x[1]/neg$x[1]),2))

( rr = round((pos$x[2]/n.s$x[2]) / (pos$x[1]/n.s$x[1]),2) )

# fitted or

fit.cae=glm(cbind(n.hivpos,ds$n.hivneg) ~ caesarian,
  family=binomial, data=ds)
summary(fit.cae)

# proportion +ve in reg. category (no caesarian)

round(plogis(fit.cae$coefficients[1]),2)

# odds  (+ve : -ve) in reg. category & or (index:ref)

round(exp(fit.cae$coefficients),2)

# check: odds 0.20:1 in ref. category
 
 => prop. pos = 0.2/(1+0.2) = 1/6 = 17% (approx)

# check: odds (0.20 x 0.44) :1 in index category

# ie 0.088:1 => prop. pos = 0.088/(1+0.088) 
#                           = 8% (approx)

round(cbind(ds$propn,fit.cae$fitted.values),2)

###

fit.all4 = glm(cbind(n.hivpos,ds$n.hivneg) ~ 
  caesarian + as.factor(m.trimesters.tx)+m.advancedHIV+c.LBW,
   family=binomial, data=ds)

fit.all4 = glm(cbind(n.hivpos,ds$n.hivneg) ~ 
                 caesarian + ART1or2 + ART3 + 
                 m.advancedHIV+c.LBW,
               family=binomial, data=ds)

summary(fit.all4)
round(cbind(ds$n.pairs,ds$propn,fit.all4$fitted.values),2)
round(exp(fit.all4$coefficients),3)


par(mfrow=c(1,2))
curve(log(x/(1-x)), from = range(fit.all4$fitted.values)[1],
      to = range(fit.all4$fitted.values)[2])
curve(log(x), from = range(fit.all4$fitted.values)[1],
      to = range(fit.all4$fitted.values)[2])

# log(or) for caesarian not that different from crude model 

# CI for OR

( log.or = summary(fit.all4)$coefficients[2,1] )

( se.log.or = summary(fit.all4)$coefficients[2,2] )

qnorm(c(.025,.5,0.975),mean=log.or,sd=se.log.or)

round(exp(qnorm(c(.025,.5,0.975),mean=log.or,sd=se.log.or)),2)

### risk ratio ----

# fit caesarian-only model first ----

fitRisk.cae = glm(cbind(n.hivpos,ds$n.hivneg) ~ 
  caesarian,
  family=binomial(link="log"), data=ds)
summary(fitRisk.cae)
round(fitRisk.cae$fitted.values,3)

round(exp(fitRisk.cae$coefficients),3)

# (these are easy to check: 0.167 and 0.167 x 0.488

# fit larger model ----

fitRisk.all4 = glm(cbind(n.hivpos,ds$n.hivneg) ~ 
  caesarian + as.factor(m.trimesters.tx)+m.advancedHIV+c.LBW,
   family=binomial(link="log"), data=ds)
summary(fitRisk.all4)
round(cbind(ds$n.pairs,ds$propn,fitRisk.all4$fitted.values),3)


round(exp(fitRisk.all4$coefficients),3)

plot(ds$caesarian,ds$,xlab="Body size",ylab="Probability of survival") # plot with body size on x-axis and survival (0 or 1) on y-axis
g=glm(survive~bodysize,family=binomial,dat) # run a logistic regression model (in this case, generalized linear model with logit link). see ?glm

curve(predict(fitRisk.all4,
              data.frame(bodysize=x),type="resp"),add=TRUE) # draws a curve based on prediction from logistic regression model

points(bodysize,fitted(g),pch=20) # optional: you could skip this draws an invisible set of points of body size survival based on a 'fit' to glm model. pch= changes type of dots.


# not very different as far as 
# caesarian vs. not is concerened

# you can fill in more from these...



#########  NOW (maybe this should be first)
#########  dataset for mantel-haenszel or and rr -----
#########  for caeasarian vs. not [3 x 2 x 2 = 12 strata]

# make 12 rows, 1 per stratum, 

# this has ART as factor
ds=read.table("~/git_repositories/epib607/slides/regression/handouts/hivTransmsion.txt",
              header=TRUE)
ds$n.hivneg= ds$n.pairs - ds$n.hivpos
ds$propn = round(ds$n.hivpos/ds$n.pairs,3)

ds.for.mh=ds[seq(1,23,2),c(2,3,4,6,7)]
ds.for.mh[,c(6,7)] = ds[seq(2,24,2),c(6,7)]
colnames(ds.for.mh)[4:7] = c(
"HIV.pos.indexCat", "HIV.neg.indexCat",
"HIV.pos.refCat",   "HIV.neg.refCat")
ds.for.mh$n = apply(ds.for.mh[,4:7],1,sum)

# used for RR
ds.for.mh$n.ref = ds.for.mh$HIV.pos.refCat +
  ds.for.mh$HIV.neg.refCat

ds.for.mh$n.index = ds.for.mh$HIV.pos.indexCat +
  ds.for.mh$HIV.neg.indexCat


write.csv(ds.for.mh, file = "hiv_Transmission_mantel_haenszel.csv", 
          row.names = FALSE, quote = FALSE)

# stratum-specific or's ----
ds.for.mh=read.csv("~/git_repositories/epib607/slides/regression/handouts/hiv_Transmission_mantel_haenszel.csv",
              header=TRUE)
# dput(colnames(ds.for.mh))
# knitr::kable(ds.for.mh, 
#              col.names = c("tx", "advHIV", "LBW", "HIV.pos.indexCat", 
#                     "HIV.neg.indexCat", "HIV.pos.refCat", "HIV.neg.refCat", "n"))
head(ds.for.mh)
round(
 ds.for.mh$HIV.pos.indexCat * ds.for.mh$HIV.neg.refCat /
(ds.for.mh$HIV.neg.indexCat * ds.for.mh$HIV.pos.refCat ),2) 

mean(
  ds.for.mh$HIV.pos.indexCat * ds.for.mh$HIV.neg.refCat /
    (ds.for.mh$HIV.neg.indexCat * ds.for.mh$HIV.pos.refCat )) 

round(
  (ds.for.mh$HIV.pos.indexCat / ds.for.mh$n.index) /
    (ds.for.mh$HIV.pos.refCat / ds.for.mh$n.ref ),2) 


mean(
  (ds.for.mh$HIV.pos.indexCat / ds.for.mh$n.index) /
    (ds.for.mh$HIV.pos.refCat / ds.for.mh$n.ref )
)

# summary or (see Rothman 2012 p 187 eq 10.6

# doesnt matter that it isn't case-control 

( mh.num = sum(ds.for.mh$HIV.pos.indexCat * 
               ds.for.mh$HIV.neg.refCat / ds.for.mh$n) )

( mh.den = sum(ds.for.mh$HIV.neg.indexCat * 
               ds.for.mh$HIV.pos.refCat / ds.for.mh$n) )

round(mh.num/mh.den, 2) # MH or

# very close to or fitted by full logistic model


########## 

## summary rr (see Rothman 2012 p 179 eq 10.2 ) ----


( mh.num = sum(ds.for.mh$HIV.pos.indexCat * 
               ds.for.mh$n.ref / ds.for.mh$n) )

( mh.den = sum(ds.for.mh$HIV.pos.refCat * 
               ds.for.mh$n.index / ds.for.mh$n) )

round(mh.num / mh.den, 2)

# just about same as regression-based one


###### CI's for these 

## (Rothman 2012, p183) or (easier) ones from regression

 
#######  what about additive risk model? how well does it fit?

#  caesarian.only

fitRiskDiffs.cae = glm(cbind(n.hivpos,ds$n.hivneg) ~ 
  caesarian ,
   family=binomial(link="identity"), data=ds   )
   
#  caesarian + lbw

fitRiskDiffs.caeLBW = glm(cbind(n.hivpos,ds$n.hivneg) ~ 
  caesarian + c.LBW,
   family=binomial(link="identity"), data=ds   )
   
  #  caesarian + lbw + m.advancedHIV

fitRiskDiffs.caeLBWadv = glm(cbind(n.hivpos,ds$n.hivneg) ~ 
  caesarian + c.LBW + m.advancedHIV,
   family=binomial(link="identity"), data=ds   )
   
# not working

# caesarian + lbw + m.advancedHIV + Tx (as interval var.)
   
 fitRiskDiffs.caeLBWadv.Tx = glm(cbind(n.hivpos,ds$n.hivneg) ~ 
  caesarian + c.LBW + m.advancedHIV + m.trimesters.tx,
   family=binomial(link="identity"), data=ds ,
   start = c(0.14,  -0.09,  0.09,   0.05, -0.02)  )
 
 round(cbind(ds$n.pairs,ds$propn,
       fitRiskDiffs.caeLBWadv.Tx$fitted.values),2)


# not working:  caes. + lbw + m.advancedHIV + Tx (as factor)
   
fitRiskDiffs.all4 = glm(cbind(n.hivpos,ds$n.hivneg) ~ 
  caesarian + as.factor(m.trimesters.tx)+m.advancedHIV+c.LBW,
   family=binomial(link="identity"), data=ds,
   start = c(0.14,  -0.09,   0.09,   0.05, -0.02, -0.05)   )

# try: fit naive (unweighted) model to fitted logistic propn.s

ds$p.fitted.by.logistic = fitRisk.all4$fitted.values

simple = lm(p.fitted.by.logistic ~ caesarian + 
  as.factor(m.trimesters.tx)+m.advancedHIV+c.LBW,
  data = ds)
  
round(cbind(ds$n.pairs,ds$p.fitted.by.logistic,
       simple$fitted.values),2)
       
# some are negative!

# another S curve [favourite in econ]

probit.fit = glm(cbind(n.hivpos,ds$n.hivneg) ~ caesarian + 
  as.factor(m.trimesters.tx)+m.advancedHIV+c.LBW,
  data = ds,family=binomial(link="probit"))
round(cbind(ds$n.pairs,ds$propn,
       probit.fit$fitted.values),2)
       
  # downsides: no easily interpreted comparative parameters


