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
#options(digits = )


#knitr::opts_chunk$set(background = '#FFFF00')
library(tools) #needed for include_graphics2 function

pacman::p_load(here)

source(here::here("inst","slides","bin","include_graphics2.R"))

knitr::knit_hooks$set(purl = hook_purl)

pacman::p_load(
gapminder,
here,
socviz, 
tidyverse,
kableExtra,
mosaic,
DT
)

theme_set(cowplot::theme_cowplot())

## ----echo=FALSE, fig.width = 8, fig.height = 6--------------------------------
ds=read.table(
"http://www.biostat.mcgill.ca/hanley/bios601/AgeFrequencies.txt",
as.is=TRUE,header=TRUE)

AGES = ds$Age
Proportions = ds$Freq/sum(ds$Freq)

A.50 = AGES[min(which(cumsum(Proportions) > 0.50))]
mu = sum(AGES*Proportions)


# In the following code, AGES refers to the ages (0 to 109) and Proportions the proportions of the population in each 1-year age bin.

no.of.sims = 10000 ;  # no. of samples of each size
# enough to generate relatively smooth histograms  
sample.sizes = c(1) ; 

par(mfrow=c(length(sample.sizes),1),mar = c(0.5,1,0.5,1) )

for (n in sample.sizes ){        # loop over the various sample sizes
ages = matrix(sample(AGES,          # 1 row per simulation
size = n*no.of.sims,     # to save time, do all at once
replace = TRUE,          # only because data compressed
prob = Proportions),     # = FALSE if has indiv. data
nrow = no.of.sims, ncol=n) # put into rows / columns
if(n > 1 & n <= 10){
print( noquote(
paste("Ages of sampled persons in first 2 samples of size",  
toString(n)) )   ) 
print(head(ages,2))
}

if( n == max(sample.sizes) ){
#cat("The first panel shows the age-distribution of the entire population.\n")
#cat("The remaining ones show the  distributions of the sample sums and means.\n")
#message("test")

} 

# compute the row-specific (simulation-specific) sums and means
# apply sum/mean to MARGIN=1, i.e., to each simulation (each row)

sums.samples.of.size.n = apply(ages,MARGIN=1,FUN=sum)
means.samples.of.size.n = apply(ages,MARGIN=1,FUN=mean)

fr = table(sums.samples.of.size.n)          # fr = frequency
Y = max(Proportions*no.of.sims)/sqrt(0.8*n) # scale the y axis
plot(fr,lw=0.4,xlim=c(0,n*(max(AGES)+12) ), 
ylim=c(-0.25,1)*Y, xaxt="n")
text(n*105,0.55*Y,paste("n =",toString(n)),cex=2,font=3,adj=c(0,1))
for(a in seq(0,100,5)) {
text(n*a, -0.01*Y, toString(n*a),adj=c(0.5,1),cex=0.75)
txts = paste("Sum of",toString(n),"Ages")
if(n==1) txts = "Individual Ages"
if(a==100 ) text(n*105, -0.01*Y,
txts,adj=c(0,1),cex=0.8)
if(n > 1) text(n*a, -0.15*Y, toString(a),adj=c(0.5,1),font=4,cex=1.5)
if(a==100 & n > 1) text(n*105, -0.15*Y,
paste("Mean of",toString(n)," Ages"),adj=c(0,1),font=4,cex=1.5)
}

# how big is the spread (sd) of the simulated sums and means ?

sd.sums  = round( sd(sums.samples.of.size.n), 1 )
sd.means = round( sd(means.samples.of.size.n),1 )

txt.s = paste( "SD of Sum:", toString(sd.sums) )
if(n==1) txt.s = paste("SD of Individual Ages:",toString(sd.sums) )
txt.m = paste("\n\n  SD of Mean:",toString(sd.means))
if(n==1) txt.m = "\n\n "
text(n*mu +  sd.sums,Y*0.7,
paste(txt.s,txt.m), cex=1.5,adj=c(0,0.5) )
points(n*mu,0,pch=19,col="red",cex=1.5)
if(n==1){
text(A.50-0.1,0.95*Y,"50% <- | -> 50%",adj=c(0.5,1),cex=1.5,col="blue")
segments(A.50-0.1,0.95*Y, A.50-0.1,0,col="blue")
text(115,Y,
"Reported Ages of Population of Dublin\nIrish Census of 1911",
adj=c(1,1),cex=1.25)
} 
}

## ----echo=FALSE, fig.width = 7, fig.height = 4--------------------------------
ds=read.table(
"http://www.biostat.mcgill.ca/hanley/bios601/AgeFrequencies.txt",
as.is=TRUE,header=TRUE)

AGES = ds$Age
Proportions = ds$Freq/sum(ds$Freq)

A.50 = AGES[min(which(cumsum(Proportions) > 0.50))]
mu = sum(AGES*Proportions)


# In the following code, AGES refers to the ages (0 to 109) and Proportions the proportions of the population in each 1-year age bin.

no.of.sims = 10000 ;  # no. of samples of each size
# enough to generate relatively smooth histograms  
sample.sizes = c(2) ; 

par(mfrow=c(length(sample.sizes),1),mar = c(0.5,1,0.5,1) )

for (n in sample.sizes ){        # loop over the various sample sizes
ages = matrix(sample(AGES,          # 1 row per simulation
size = n*no.of.sims,     # to save time, do all at once
replace = TRUE,          # only because data compressed
prob = Proportions),     # = FALSE if has indiv. data
nrow = no.of.sims, ncol=n) # put into rows / columns
if(n > 1 & n <= 10){
print( noquote(
paste("Ages of sampled persons in first 2 samples of size",  
toString(n)) )   ) 
print(head(ages,2))
}

if( n == max(sample.sizes) ){
#cat("The first panel shows the age-distribution of the entire population.\n")
#cat("The remaining ones show the  distributions of the sample sums and means.\n")
#message("test")

} 

# compute the row-specific (simulation-specific) sums and means
# apply sum/mean to MARGIN=1, i.e., to each simulation (each row)

sums.samples.of.size.n = apply(ages,MARGIN=1,FUN=sum)
means.samples.of.size.n = apply(ages,MARGIN=1,FUN=mean)

fr = table(sums.samples.of.size.n)          # fr = frequency
Y = max(Proportions*no.of.sims)/sqrt(0.8*n) # scale the y axis
plot(fr,lw=0.4,xlim=c(0,n*(max(AGES)+12) ), 
ylim=c(-0.25,1)*Y, xaxt="n")
text(n*105,0.55*Y,paste("n =",toString(n)),cex=2,font=3,adj=c(0,1))
for(a in seq(0,100,5)) {
text(n*a, -0.01*Y, toString(n*a),adj=c(0.5,1),cex=0.75)
txts = paste("Sum of",toString(n),"Ages")
if(n==1) txts = "Individual Ages"
if(a==100 ) text(n*105, -0.01*Y,
txts,adj=c(0,1),cex=0.8)
if(n > 1) text(n*a, -0.15*Y, toString(a),adj=c(0.5,1),font=4,cex=0.75)
if(a==100 & n > 1) text(n*105, -0.15*Y,
paste("Mean of",toString(n)," Ages"),adj=c(0,1),font=4,cex=0.8)
}

# how big is the spread (sd) of the simulated sums and means ?

sd.sums  = round( sd(sums.samples.of.size.n), 1 )
sd.means = round( sd(means.samples.of.size.n),1 )

txt.s = paste( "SD of Sum:", toString(sd.sums) )
if(n==1) txt.s = paste("SD of Individual Ages:",toString(sd.sums) )
txt.m = paste("\n\n  SD of Mean:",toString(sd.means))
if(n==1) txt.m = "\n\n "
text(n*mu +  sd.sums,Y*0.7,
paste(txt.s,txt.m), cex=1.5,adj=c(0,0.5) )
points(n*mu,0,pch=19,col="red",cex=1.5)
if(n==1){
text(A.50-0.1,0.95*Y,"50% <- | -> 50%",adj=c(0.5,1),cex=1.5,col="blue")
segments(A.50-0.1,0.95*Y, A.50-0.1,0,col="blue")
text(115,Y,
"Reported Ages of Population of Dublin\nIrish Census of 1911",
adj=c(1,1),cex=1.25)
} 
}

## ----echo=FALSE, fig.width = 7, fig.height = 4--------------------------------
ds=read.table(
"http://www.biostat.mcgill.ca/hanley/bios601/AgeFrequencies.txt",
as.is=TRUE,header=TRUE)

AGES = ds$Age
Proportions = ds$Freq/sum(ds$Freq)

A.50 = AGES[min(which(cumsum(Proportions) > 0.50))]
mu = sum(AGES*Proportions)


# In the following code, AGES refers to the ages (0 to 109) and Proportions the proportions of the population in each 1-year age bin.

no.of.sims = 10000 ;  # no. of samples of each size
# enough to generate relatively smooth histograms  
sample.sizes = c(4) ; 

par(mfrow=c(length(sample.sizes),1),mar = c(0.5,1,0.5,1) )

for (n in sample.sizes ){        # loop over the various sample sizes
ages = matrix(sample(AGES,          # 1 row per simulation
size = n*no.of.sims,     # to save time, do all at once
replace = TRUE,          # only because data compressed
prob = Proportions),     # = FALSE if has indiv. data
nrow = no.of.sims, ncol=n) # put into rows / columns
if(n > 1 & n <= 10){
print( noquote(
paste("Ages of sampled persons in first 2 samples of size",  
toString(n)) )   ) 
print(head(ages,2))
}

if( n == max(sample.sizes) ){
#cat("The first panel shows the age-distribution of the entire population.\n")
#cat("The remaining ones show the  distributions of the sample sums and means.\n")
#message("test")

} 

# compute the row-specific (simulation-specific) sums and means
# apply sum/mean to MARGIN=1, i.e., to each simulation (each row)

sums.samples.of.size.n = apply(ages,MARGIN=1,FUN=sum)
means.samples.of.size.n = apply(ages,MARGIN=1,FUN=mean)

fr = table(sums.samples.of.size.n)          # fr = frequency
Y = max(Proportions*no.of.sims)/sqrt(0.8*n) # scale the y axis
plot(fr,lw=0.4,xlim=c(0,n*(max(AGES)+12) ), 
ylim=c(-0.25,1)*Y, xaxt="n")
text(n*105,0.55*Y,paste("n =",toString(n)),cex=2,font=3,adj=c(0,1))
for(a in seq(0,100,5)) {
text(n*a, -0.01*Y, toString(n*a),adj=c(0.5,1),cex=0.75)
txts = paste("Sum of",toString(n),"Ages")
if(n==1) txts = "Individual Ages"
if(a==100 ) text(n*105, -0.01*Y,
txts,adj=c(0,1),cex=0.8)
if(n > 1) text(n*a, -0.15*Y, toString(a),adj=c(0.5,1),font=4,cex=0.75)
if(a==100 & n > 1) text(n*105, -0.15*Y,
paste("Mean of",toString(n)," Ages"),adj=c(0,1),font=4,cex=0.8)
}

# how big is the spread (sd) of the simulated sums and means ?

sd.sums  = round( sd(sums.samples.of.size.n), 1 )
sd.means = round( sd(means.samples.of.size.n),1 )

txt.s = paste( "SD of Sum:", toString(sd.sums) )
if(n==1) txt.s = paste("SD of Individual Ages:",toString(sd.sums) )
txt.m = paste("\n\n  SD of Mean:",toString(sd.means))
if(n==1) txt.m = "\n\n "
text(n*mu +  sd.sums,Y*0.7,
paste(txt.s,txt.m), cex=1.5,adj=c(0,0.5) )
points(n*mu,0,pch=19,col="red",cex=1.5)
if(n==1){
text(A.50-0.1,0.95*Y,"50% <- | -> 50%",adj=c(0.5,1),cex=1.5,col="blue")
segments(A.50-0.1,0.95*Y, A.50-0.1,0,col="blue")
text(115,Y,
"Reported Ages of Population of Dublin\nIrish Census of 1911",
adj=c(1,1),cex=1.25)
} 
}

## ----echo=FALSE, fig.width = 7, fig.height = 4--------------------------------
ds=read.table(
"http://www.biostat.mcgill.ca/hanley/bios601/AgeFrequencies.txt",
as.is=TRUE,header=TRUE)

AGES = ds$Age
Proportions = ds$Freq/sum(ds$Freq)

A.50 = AGES[min(which(cumsum(Proportions) > 0.50))]
mu = sum(AGES*Proportions)


# In the following code, AGES refers to the ages (0 to 109) and Proportions the proportions of the population in each 1-year age bin.

no.of.sims = 10000 ;  # no. of samples of each size
# enough to generate relatively smooth histograms  
sample.sizes = c(10) ; 

par(mfrow=c(length(sample.sizes),1),mar = c(0.5,1,0.5,1) )

for (n in sample.sizes ){        # loop over the various sample sizes
ages = matrix(sample(AGES,          # 1 row per simulation
size = n*no.of.sims,     # to save time, do all at once
replace = TRUE,          # only because data compressed
prob = Proportions),     # = FALSE if has indiv. data
nrow = no.of.sims, ncol=n) # put into rows / columns
if(n > 1 & n <= 10){
print( noquote(
paste("Ages of sampled persons in first 2 samples of size",  
toString(n)) )   ) 
print(head(ages,2))
}

if( n == max(sample.sizes) ){
#cat("The first panel shows the age-distribution of the entire population.\n")
#cat("The remaining ones show the  distributions of the sample sums and means.\n")
#message("test")

} 

# compute the row-specific (simulation-specific) sums and means
# apply sum/mean to MARGIN=1, i.e., to each simulation (each row)

sums.samples.of.size.n = apply(ages,MARGIN=1,FUN=sum)
means.samples.of.size.n = apply(ages,MARGIN=1,FUN=mean)

fr = table(sums.samples.of.size.n)          # fr = frequency
Y = max(Proportions*no.of.sims)/sqrt(0.8*n) # scale the y axis
plot(fr,lw=0.4,xlim=c(0,n*(max(AGES)+12) ), 
ylim=c(-0.25,1)*Y, xaxt="n")
text(n*105,0.55*Y,paste("n =",toString(n)),cex=2,font=3,adj=c(0,1))
for(a in seq(0,100,5)) {
text(n*a, -0.01*Y, toString(n*a),adj=c(0.5,1),cex=0.75)
txts = paste("Sum of",toString(n),"Ages")
if(n==1) txts = "Individual Ages"
if(a==100 ) text(n*105, -0.01*Y,
txts,adj=c(0,1),cex=0.8)
if(n > 1) text(n*a, -0.15*Y, toString(a),adj=c(0.5,1),font=4,cex=0.75)
if(a==100 & n > 1) text(n*105, -0.15*Y,
paste("Mean of",toString(n)," Ages"),adj=c(0,1),font=4,cex=0.8)
}

# how big is the spread (sd) of the simulated sums and means ?

sd.sums  = round( sd(sums.samples.of.size.n), 1 )
sd.means = round( sd(means.samples.of.size.n),1 )

txt.s = paste( "SD of Sum:", toString(sd.sums) )
if(n==1) txt.s = paste("SD of Individual Ages:",toString(sd.sums) )
txt.m = paste("\n\n  SD of Mean:",toString(sd.means))
if(n==1) txt.m = "\n\n "
text(n*mu +  sd.sums,Y*0.7,
paste(txt.s,txt.m), cex=1.5,adj=c(0,0.5) )
points(n*mu,0,pch=19,col="red",cex=1.5)
if(n==1){
text(A.50-0.1,0.95*Y,"50% <- | -> 50%",adj=c(0.5,1),cex=1.5,col="blue")
segments(A.50-0.1,0.95*Y, A.50-0.1,0,col="blue")
text(115,Y,
"Reported Ages of Population of Dublin\nIrish Census of 1911",
adj=c(1,1),cex=1.25)
} 
}

## ----echo=FALSE, fig.width = 7, fig.height = 4--------------------------------
ds=read.table(
"http://www.biostat.mcgill.ca/hanley/bios601/AgeFrequencies.txt",
as.is=TRUE,header=TRUE)

AGES = ds$Age
Proportions = ds$Freq/sum(ds$Freq)

A.50 = AGES[min(which(cumsum(Proportions) > 0.50))]
mu = sum(AGES*Proportions)


# In the following code, AGES refers to the ages (0 to 109) and Proportions the proportions of the population in each 1-year age bin.

no.of.sims = 10000 ;  # no. of samples of each size
# enough to generate relatively smooth histograms  
sample.sizes = c(16) ; 

par(mfrow=c(length(sample.sizes),1),mar = c(0.5,1,0.5,1) )

for (n in sample.sizes ){        # loop over the various sample sizes
ages = matrix(sample(AGES,          # 1 row per simulation
size = n*no.of.sims,     # to save time, do all at once
replace = TRUE,          # only because data compressed
prob = Proportions),     # = FALSE if has indiv. data
nrow = no.of.sims, ncol=n) # put into rows / columns
if(n > 1 & n <= 10){
print( noquote(
paste("Ages of sampled persons in first 2 samples of size",  
toString(n)) )   ) 
print(head(ages,2))
}

if( n == max(sample.sizes) ){
#cat("The first panel shows the age-distribution of the entire population.\n")
#cat("The remaining ones show the  distributions of the sample sums and means.\n")
#message("test")

} 

# compute the row-specific (simulation-specific) sums and means
# apply sum/mean to MARGIN=1, i.e., to each simulation (each row)

sums.samples.of.size.n = apply(ages,MARGIN=1,FUN=sum)
means.samples.of.size.n = apply(ages,MARGIN=1,FUN=mean)

fr = table(sums.samples.of.size.n)          # fr = frequency
Y = max(Proportions*no.of.sims)/sqrt(0.8*n) # scale the y axis
plot(fr,lw=0.4,xlim=c(0,n*(max(AGES)+12) ), 
ylim=c(-0.25,1)*Y, xaxt="n")
text(n*105,0.55*Y,paste("n =",toString(n)),cex=2,font=3,adj=c(0,1))
for(a in seq(0,100,5)) {
text(n*a, -0.01*Y, toString(n*a),adj=c(0.5,1),cex=0.75)
txts = paste("Sum of",toString(n),"Ages")
if(n==1) txts = "Individual Ages"
if(a==100 ) text(n*105, -0.01*Y,
txts,adj=c(0,1),cex=0.8)
if(n > 1) text(n*a, -0.15*Y, toString(a),adj=c(0.5,1),font=4,cex=0.75)
if(a==100 & n > 1) text(n*105, -0.15*Y,
paste("Mean of",toString(n)," Ages"),adj=c(0,1),font=4,cex=0.8)
}

# how big is the spread (sd) of the simulated sums and means ?

sd.sums  = round( sd(sums.samples.of.size.n), 1 )
sd.means = round( sd(means.samples.of.size.n),1 )

txt.s = paste( "SD of Sum:", toString(sd.sums) )
if(n==1) txt.s = paste("SD of Individual Ages:",toString(sd.sums) )
txt.m = paste("\n\n  SD of Mean:",toString(sd.means))
if(n==1) txt.m = "\n\n "
text(n*mu +  sd.sums,Y*0.7,
paste(txt.s,txt.m), cex=1.5,adj=c(0,0.5) )
points(n*mu,0,pch=19,col="red",cex=1.5)
if(n==1){
text(A.50-0.1,0.95*Y,"50% <- | -> 50%",adj=c(0.5,1),cex=1.5,col="blue")
segments(A.50-0.1,0.95*Y, A.50-0.1,0,col="blue")
text(115,Y,
"Reported Ages of Population of Dublin\nIrish Census of 1911",
adj=c(1,1),cex=1.25)
} 
}

## ----echo=FALSE, fig.width = 7, fig.height = 4--------------------------------
ds=read.table(
"http://www.biostat.mcgill.ca/hanley/bios601/AgeFrequencies.txt",
as.is=TRUE,header=TRUE)

AGES = ds$Age
Proportions = ds$Freq/sum(ds$Freq)

A.50 = AGES[min(which(cumsum(Proportions) > 0.50))]
mu = sum(AGES*Proportions)


# In the following code, AGES refers to the ages (0 to 109) and Proportions the proportions of the population in each 1-year age bin.

no.of.sims = 10000 ;  # no. of samples of each size
# enough to generate relatively smooth histograms  
sample.sizes = c(64) ; 

par(mfrow=c(length(sample.sizes),1),mar = c(0.5,1,0.5,1) )

for (n in sample.sizes ){        # loop over the various sample sizes
ages = matrix(sample(AGES,          # 1 row per simulation
size = n*no.of.sims,     # to save time, do all at once
replace = TRUE,          # only because data compressed
prob = Proportions),     # = FALSE if has indiv. data
nrow = no.of.sims, ncol=n) # put into rows / columns
if(n > 1 & n <= 10){
print( noquote(
paste("Ages of sampled persons in first 2 samples of size",  
toString(n)) )   ) 
print(head(ages,2))
}

if( n == max(sample.sizes) ){
#cat("The first panel shows the age-distribution of the entire population.\n")
#cat("The remaining ones show the  distributions of the sample sums and means.\n")
#message("test")

} 

# compute the row-specific (simulation-specific) sums and means
# apply sum/mean to MARGIN=1, i.e., to each simulation (each row)

sums.samples.of.size.n = apply(ages,MARGIN=1,FUN=sum)
means.samples.of.size.n = apply(ages,MARGIN=1,FUN=mean)

fr = table(sums.samples.of.size.n)          # fr = frequency
Y = max(Proportions*no.of.sims)/sqrt(0.8*n) # scale the y axis
plot(fr,lw=0.4,xlim=c(0,n*(max(AGES)+12) ), 
ylim=c(-0.25,1)*Y, xaxt="n")
text(n*105,0.55*Y,paste("n =",toString(n)),cex=2,font=3,adj=c(0,1))
for(a in seq(0,100,5)) {
text(n*a, -0.01*Y, toString(n*a),adj=c(0.5,1),cex=0.75)
txts = paste("Sum of",toString(n),"Ages")
if(n==1) txts = "Individual Ages"
if(a==100 ) text(n*105, -0.01*Y,
txts,adj=c(0,1),cex=0.8)
if(n > 1) text(n*a, -0.15*Y, toString(a),adj=c(0.5,1),font=4,cex=0.75)
if(a==100 & n > 1) text(n*105, -0.15*Y,
paste("Mean of",toString(n)," Ages"),adj=c(0,1),font=4,cex=0.8)
}

# how big is the spread (sd) of the simulated sums and means ?

sd.sums  = round( sd(sums.samples.of.size.n), 1 )
sd.means = round( sd(means.samples.of.size.n),1 )

txt.s = paste( "SD of Sum:", toString(sd.sums) )
if(n==1) txt.s = paste("SD of Individual Ages:",toString(sd.sums) )
txt.m = paste("\n\n  SD of Mean:",toString(sd.means))
if(n==1) txt.m = "\n\n "
text(n*mu +  sd.sums,Y*0.7,
paste(txt.s,txt.m), cex=1.5,adj=c(0,0.5) )
points(n*mu,0,pch=19,col="red",cex=1.5)
if(n==1){
text(A.50-0.1,0.95*Y,"50% <- | -> 50%",adj=c(0.5,1),cex=1.5,col="blue")
segments(A.50-0.1,0.95*Y, A.50-0.1,0,col="blue")
text(115,Y,
"Reported Ages of Population of Dublin\nIrish Census of 1911",
adj=c(1,1),cex=1.25)
} 
}

## ----echo=FALSE, fig.show="hold", eval=FALSE----------------------------------
#  depthsOfWater = allLocations[allLocations$water==1,]
#  depthsOfWater$depth = -depthsOfWater$alt
#  par(mar = c(4,4,1,0.1))
#  for (panel in 1){
#  
#  # depths
#  
#  if(panel==1) y = round(depthsOfWater$depth/100)
#  if(panel==2) y = round(heightsOfLand$alt/100)
#  
#  f = table(y)
#  #str(f)
#  x=as.numeric(dimnames(f)[[1]])
#  Y=0:max(x) ;
#  FREQ=approx(x,f,Y)$y
#  #plot(Y,FREQ,type="l")
#  
#  #( n.bins=length(FREQ) )
#  
#  max.Y = max(Y);
#  
#  max.X = max.Y
#  if (panel==2) max.X =25
#  
#  M = 1.05*max(f)
#  
#  FREQ[1+Y] =  FREQ/sum(FREQ)
#  
#  AVE = sum(Y*FREQ)
#  SD = sqrt(sum( FREQ*(Y-AVE)^2 ) )
#  
#  already = FREQ
#  
#  max.n = 16; show=c(1,2,3,4,5,5,6,7,8,9,16)
#  
#  YLIM=sqrt(max.n/(panel^2.5))*max(FREQ)*c(-0.11,0.75)
#  
#  XLAB=c("OCEAN DEPTH","LAND ELEVATION")
#  plot(Y,already,pch=19,lwd=1,col="white",
#  type="l",ylim=YLIM, xlim=c(0,max.X),
#  ylab="Density", xlab=XLAB[panel] )
#  polygon(c(0,Y),c(0,FREQ),
#  col=c("lightblue","bisque","grey98")[panel],
#  border="grey10",lwd=1)
#  for(n in 2:max.n){
#  f = outer(already,FREQ)
#  f[1:5,1:5]
#  ff = sapply(split(f, col(f) + row(f)), sum)
#  ff[1:5]
#  ave = (0:(n* max.Y))/n
#  if( n %in% show ){
#  lines(ave,ff*n,col=n,lwd=4.5-4*(n-1)/n)
#  
#  text(1.5*AVE,max(ff*n),
#  paste("means of samples of size",toString(n)),
#  adj=c(0,0.5),col=n,cex=0.65)
#  }
#  already=as.numeric(ff)
#  }
#  segments(AVE,0, AVE, 1.1*max(FREQ),lty="dotted")
#  text(AVE,  0.35*YLIM[1],toString(round(AVE,0)), adj=c(0.5,1),
#  cex=0.85 )
#  txt= "Ocean Depths
#  (units = 100m)"
#  if(panel==2) txt="Land Elevations
#  (units = 100m)"
#  text(AVE+5,0.7*YLIM[1],txt,
#  col="lightblue",adj=c(0,0.5),font=2)
#  text(0.85*AVE,0.35*YLIM[1],expression(mu), adj=c(0.5,1.25),
#  cex=0.95 )
#  text(AVE,  0.99*YLIM[1], toString(round(SD,0)), adj=c(0.5,0),
#  cex=0.85 )
#  text(0.85*AVE,0.99*YLIM[1],expression(sigma), adj=c(0.5,0),
#  cex=0.95 )
#  for(a in AVE+(-20:20)) segments(a,0,a,0.1*YLIM[1])
#  for(a in AVE+c(-20,-15,-10,-5,0,5,10,15,20)) segments(a,0,a,0.2*YLIM[1])
#  
#  }

## ----echo=FALSE, comment = NA, size = 'tiny'----------------------------------
print(sessionInfo(), locale = FALSE)

## ----eval=FALSE, echo = TRUE--------------------------------------------------
#  plot(dt$Mean.5.depths, 1:nrow(dt), pch=20,
#  xlim=range(pretty(c(dt$lower.mean.5.66, dt$upper.mean.5.66))),
#  xlab='Depth of ocean (m)', ylab='Student (sample)',
#  las=1, cex.axis=0.8, cex=1.5)
#  abline(v = 3700, lty = 2, col = "red", lwd = 2)
#  segments(x0 = dt$lower.mean.5.66, x1=dt$upper.mean.5.66,
#  y0 = 1:nrow(dt), lend=1)

