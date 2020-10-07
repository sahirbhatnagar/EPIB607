setwd("/Users/jameshanley/Dropbox/EPIB607/Jim2018/Water")

allLocations=read.csv("EarthLocations20180914 copy.csv")
allLocations=read.csv("~/git_repositories/epib607/data/earth-locations-20180914.csv")
str(allLocations)

# switch back if saving in unshared folder

setwd("/Users/jameshanley/Dropbox/Courses/bios601/Surveys/Oceanography")

allLocations$water  = 1*(allLocations$alt < 0)
summary(allLocations)


par(mfrow=c(2,2),mar = c(4,4,2,1) )

ew=allLocations$lon[allLocations$water==1]
ns=allLocations$lat[allLocations$water==1]

plot(ew*cos(pi*ns/180),
     allLocations$lat[allLocations$water==1],
     col="blue",cex=0.02)

plot( table( round(allLocations$lat) ) )

# water only

depthsOfWater = allLocations[allLocations$water==1,]
depthsOfWater$depth = -depthsOfWater$alt
str(depthsOfWater)
summary(depthsOfWater)
hist(depthsOfWater$depth,breaks=100)

# land only  bios601 extra

heightsOfLand = allLocations[allLocations$water==0,]
str(heightsOfLand)
summary(heightsOfLand)
hist(heightsOfLand$alt,breaks=100)



# Jim's code --------------------------------------------------------------

par(mfrow=c(1,2),mar = c(4,4,1,0.1) )

for (panel in 1:2){
  
  # depths
  panel=1
  if(panel==1) y = round(depthsOfWater$depth/100)
  if(panel==2) y = round(heightsOfLand$alt/100)
  
  ( f = table(y) )
  str(f)
  x=as.numeric(dimnames(f)[[1]])
  Y=0:max(x) ;  
  FREQ=approx(x,f,Y)$y
  #plot(Y,FREQ,type="l")
  
  ( n.bins=length(FREQ) )
  
  max.Y = max(Y); 
  
  max.X = max.Y
  if (panel==2) max.X =25
  
  M = 1.05*max(f)
  
  FREQ[1+Y] =  FREQ/sum(FREQ)
  
  AVE = sum(Y*FREQ)
  SD = sqrt(sum( FREQ*(Y-AVE)^2 ) )
  
  already = FREQ
  
  max.n = 16; show=c(1,2,3,4,5,5,6,7,8,9,16)
  # show=c(4,16)
  YLIM=sqrt(max.n/(panel^2.5))*max(FREQ)*c(-0.11,0.75)
  
  XLAB=c("OCEAN DEPTH","LAND ELEVATION")
  png("~/git_repositories/epib607/slides/sampling_dist/oceanAll.png",
      width = 10, height = 6, units = "in", res = 150)
  plot(Y,already,pch=19,lwd=1,col="white",
       type="l",ylim=YLIM, xlim=c(0,max.X),
       ylab="Density", xlab=XLAB[panel] )
  polygon(c(0,Y),c(0,FREQ),
          col=c("#56B4E9","bisque","grey98")[panel],
          border="grey10",lwd=1)
  RcolNumber = 1
  for(n in 2:max.n){
    f = outer(already,FREQ)
    f[1:5,1:5]
    ff = sapply(split(f, col(f) + row(f)), sum)
    ff[1:5]
    ave = (0:(n* max.Y))/n
    
    if ( n %in% show ) {
      lines(ave,ff*n,
            # col=RColorBrewer::brewer.pal(12,"Set1")[RcolNumber],
            col=viridis::inferno(9, end = 0.7, direction = -1)[RcolNumber],
            lwd=4.5-4*(n-1)/n)
      
      text(1.5*AVE,max(ff*n),
           paste("means of samples of size",toString(n)),
           adj = c(0,0.5),
           # col=RColorBrewer::brewer.pal(12,"Set1")[RcolNumber],
           col = viridis::inferno(9, end=0.7, direction = -1)[RcolNumber],
           cex = 0.95)
      RcolNumber = RcolNumber + 1
    } 
    already=as.numeric(ff)
  }
  segments(AVE,0, AVE, 0.10,lty="dotted")
  text(AVE,  0.35*YLIM[1],toString(round(AVE,0)), adj=c(0.5,1),
       cex=0.85 )
  txt= "Ocean Depths
  (units = 100m)"
  if(panel==2) txt="Land Elevations
  (units = 100m)"
  text(AVE+5,0.7*YLIM[1],txt,
       col="#56B4E9",adj=c(0,0.5),font=2)
  text(0.85*AVE,0.35*YLIM[1],expression(mu), adj=c(0.5,1.25),
       cex=0.95 )
  text(AVE,  0.99*YLIM[1], toString(round(SD,0)), adj=c(0.5,0),
       cex=0.85 )
  text(0.85*AVE,0.99*YLIM[1],expression(sigma), adj=c(0.5,0),
       cex=0.95 )
  for(a in AVE+(-20:20)) segments(a,0,a,0.1*YLIM[1])
  for(a in AVE+c(-20,-15,-10,-5,0,5,10,15,20)) segments(a,0,a,0.2*YLIM[1])
  dev.off()
}


mean(rnorm(10))

# SB modifying a little to show one at a time -----------------------------

# par(mfrow=c(1,2),mar = c(4,4,1,0.1) )
par(mar = c(4,4,1,0.1))
dev.off()
for (panel in 1){
  panel=1
  # depths
  
  if(panel==1) y = round(depthsOfWater$depth/100)
  if(panel==2) y = round(heightsOfLand$alt/100)
  
  ( f = table(y) )
  str(f)
  x=as.numeric(dimnames(f)[[1]])
  Y=0:max(x) ;  
  FREQ=approx(x,f,Y)$y
  #plot(Y,FREQ,type="l")
  
  ( n.bins=length(FREQ) )
  
  max.Y = max(Y); 
  
  max.X = max.Y
  if (panel==2) max.X =25
  
  M = 1.05*max(f)
  
  FREQ[1+Y] =  FREQ/sum(FREQ)
  
  AVE = sum(Y*FREQ)
  SD = sqrt(sum( FREQ*(Y-AVE)^2 ) )
  
  alreadyOrig = FREQ
  
  already = FREQ
  
  max.n = 16; 
  show=c(1,2,3,4,5,5,6,7,8,9,16)
  # show=c(4,16)
  
  YLIM=sqrt(max.n/(panel^2.5))*max(FREQ)*c(-0.11,0.75)
  
  XLAB=c("OCEAN DEPTH","LAND ELEVATION")
  png("~/git_repositories/epib607/slides/sampling_dist/ocean1.png", 
      width = 10, height = 6, units = "in", res = 150)
  plot(Y,already,pch=19,lwd=1,col="white",
       type="l",ylim=YLIM, xlim=c(0,max.X),
       ylab="Density", xlab=XLAB[panel] )
  dev.off()
  
  png("~/git_repositories/epib607/slides/sampling_dist/ocean2.png", 
      width = 10, height = 6, units = "in", res = 150)
  plot(Y,already,pch=19,lwd=1,col="white",
       type="l",ylim=YLIM, xlim=c(0,max.X),
       ylab="Density", xlab=XLAB[panel] )
  polygon(c(0,Y),c(0,FREQ),
          col=c("#56B4E9","bisque","grey98")[panel],
          border="grey10",lwd=1)
  dev.off()
  RcolNumber = 1
  for(n in 2:max.n){
    # n=3
    png(sprintf("~/git_repositories/epib607/slides/sampling_dist/ocean%s.png",n+1), 
        width = 10, height = 6, units = "in", res = 150)
    plot(Y,alreadyOrig,pch=19,lwd=1,col="white",
         type="l",ylim=YLIM, xlim=c(0,max.X),
         ylab="Density", xlab=XLAB[panel] )
    polygon(c(0,Y),c(0,FREQ),
            col=c("#56B4E9","bisque","grey98")[panel],
            border="grey10",lwd=1)
    f = outer(already,FREQ)
    f[1:5,1:5]
    ff = sapply(split(f, col(f) + row(f)), sum)
    ff[1:5]
    ave = (0:(n* max.Y))/n
    if( n %in% show ){
      lines(ave,ff*n,
            col = viridis::inferno(9, end = 0.7, direction = -1)[RcolNumber],
            lwd=4.5-4*(n-1)/n)
      
      text(1.5*AVE,max(ff*n),
           paste("means of samples of size",toString(n)),
           adj = c(0,0.5),
           col = viridis::inferno(9, end = 0.7, direction = -1)[RcolNumber],
           cex = 0.95)
      RcolNumber = RcolNumber + 1
      
    } 
    already=as.numeric(ff)
    
    segments(AVE,0, AVE, 0.10,lty="dotted")
    text(AVE,  0.35*YLIM[1],toString(round(AVE,0)), adj=c(0.5,1),
         cex=0.85 )
    txt= "Ocean Depths
(units = 100m)"
    if(panel==2) txt="Land Elevations
(units = 100m)"
    text(AVE+5,0.7*YLIM[1],txt,
         col="#56B4E9",adj=c(0,0.5),font=2)
    text(0.85*AVE,0.35*YLIM[1],expression(mu), adj=c(0.5,1.25),
         cex=0.95 )
    text(AVE,  0.99*YLIM[1], toString(round(SD,0)), adj=c(0.5,0),
         cex=0.85 )
    text(0.85*AVE,0.99*YLIM[1],expression(sigma), adj=c(0.5,0),
         cex=0.95 )
    for(a in AVE+(-20:20)) segments(a,0,a,0.1*YLIM[1])
    for(a in AVE+c(-20,-15,-10,-5,0,5,10,15,20)) segments(a,0,a,0.2*YLIM[1])
    dev.off()
  }
}








# Code for bootstrap slides -----------------------------------------------

rm(list=ls())
allLocations <- read.csv("~/git_repositories/epib607/data/earth-locations-20180914.csv")
str(allLocations)

allLocations$water  = 1*(allLocations$alt < 0)

# water only
depthsOfWater = allLocations[allLocations$water==1,]
depthsOfWater$depth = -depthsOfWater$alt
str(depthsOfWater)
summary(depthsOfWater)
hist(depthsOfWater$depth,breaks=100)

panel = 1
if(panel==1) y = round(depthsOfWater$depth/100)
( f = table(y) )
str(f)
x=as.numeric(dimnames(f)[[1]])
Y=0:max(x) ;  
FREQ=approx(x,f,Y)$y

(n.bins=length(FREQ))
max.Y = max(Y); 
max.X = max.Y
M = 1.05*max(f)
FREQ[1+Y] =  FREQ/sum(FREQ)
AVE = sum(Y*FREQ)
SD = sqrt(sum( FREQ*(Y-AVE)^2 ) )
alreadyOrig = FREQ
already = FREQ
max.n = 16; 
show=c(1,2,3,4,5,5,6,7,8,9,16)
YLIM=sqrt(max.n/(panel^2.5))*max(FREQ)*c(-0.11,0.75)
XLAB=c("OCEAN DEPTH","LAND ELEVATION")

# gf_dhistogram( ~ rnorm(100), bins = 20) %>%
#   gf_dist("norm", color = "red")

# plot(Y,already,pch=19,lwd=1,col="white",
#      type="l",ylim=YLIM, xlim=c(0,max.X),
#      ylab="Density", xlab=XLAB[panel] )

# p1 <- gf_polygon(c(0,FREQ) ~ c(0,Y), 
#            xlab = XLAB[panel], ylab = "Density", fill = "#56B4E9", color = "black") + 
#   ylim(YLIM) + theme_bw()
# 
# p1 %>% gf_dist("norm", mean = 37, sd = 4, fill = ~ (x <= 30 , x >= 40), geom = "area", color = "blue") 

SE <- 4.20
dev.off()
plot(Y,already,pch=19,lwd=1,col="white",
     type="l",ylim=YLIM, xlim=c(0,max.X),
     ylab="Density", xlab=XLAB[panel] )
polygon(c(0,Y),c(0,FREQ),
        col=c("#56B4E9","bisque","grey98")[panel],
        border="grey10",lwd=1)
# legend("topright", legend = "Y: Depths of the ocean", 
#        col = "#56B4E9", pch = 15, pt.cex = 2)
curve(dnorm(x,mean = AVE,sd = SE), add = TRUE, lwd = 2) 
# text(1.5*AVE,0.08,
#      paste("means of samples of size",toString(16)),
#      adj = c(0,0.5),
#      col = viridis::inferno(9, end = 0.7, direction = 1)[1],
#      cex = 0.95)
legend("topright", legend = c("Y: Depths of the ocean",
                              "Sampling distribution for \n means of samples of size 16"),
       col = c("#56B4E9","black"), 
       bty = "n",
       pch = c(15,NA), lty = c(NA,1), pt.cex = 2, lwd = c(NA,2))
segments(AVE,0, AVE, 0.10,lty="dotted")
text(AVE*1.05,  0.15*YLIM[1],toString(round(AVE,0)), adj=c(0.5,1),
     cex=0.85 )
text(0.95*AVE,0.15*YLIM[1],expression(mu), adj=c(0.5,1.25),
     cex=0.95 )
text(.99*AVE,0.07*YLIM[1],"=", adj=c(0.5,1.25),
     cex=0.95 )
arrows(x0 = AVE, x1 = AVE + SE, y0 = 0.055, length = 0.05)
segments(AVE + SE,0, AVE + SE, 0.06,lty="dotted")
#text(x = AVE*1.05, y = 0.051, '{', srt = 90, cex = 1.5, family = 'Helvetica Neue UltraLight')
text((AVE)*1.25,0.06,latex2exp::TeX("$\\sigma / \\sqrt{16}$"), adj=c(0.5,1.25),
     cex=0.95 )

# with 68% ci
plot(Y,already,pch=19,lwd=1,col="white",
     type="l",ylim=YLIM, xlim=c(0,max.X),
     ylab="Density", xlab=XLAB[panel] )
polygon(c(0,Y),c(0,FREQ),
        col=c("#56B4E9","bisque","grey98")[panel],
        border="grey10",lwd=1)
# legend("topright", legend = "Y: Depths of the ocean", 
#        col = "#56B4E9", pch = 15, pt.cex = 2)
curve(dnorm(x,mean = AVE,sd = SE), add = TRUE, lwd = 2) 
# text(1.5*AVE,0.08,
#      paste("means of samples of size",toString(16)),
#      adj = c(0,0.5),
#      col = viridis::inferno(9, end = 0.7, direction = 1)[1],
#      cex = 0.95)
lower.x <- qnorm(p = c(0.16), AVE, SE)
upper.x <- qnorm(p = c(0.84), AVE, SE)
legend("topright", legend = c("Y: Depths of the ocean",
                              "Sampling distribution for \n means of samples of size 16",
                              sprintf("68%% Confidence interval for \n the mean depth of the ocean:\n [%.f, %.f]",
                                      lower.x, upper.x)),
       col = c("#56B4E9","black",RColorBrewer::brewer.pal(9, "Set1")[4]), 
       y.intersp = 2,
       bty = "n",
       pch = c(15,NA,15), lty = c(NA,1,NA), pt.cex = 2, lwd = c(NA,2,NA))
segments(AVE,0, AVE, 0.10,lty="dotted")
# text(AVE*1.05,  0.15*YLIM[1],toString(round(AVE,0)), adj=c(0.5,1),
#      cex=0.85 )
# text(0.95*AVE,0.15*YLIM[1],expression(mu), adj=c(0.5,1.25),
#      cex=0.95 )
# text(.99*AVE,0.07*YLIM[1],"=", adj=c(0.5,1.25),
#      cex=0.95 )
# arrows(x0 = AVE, x1 = AVE + SE, y0 = 0.055, length = 0.05)
# segments(AVE + SE,0, AVE + SE, 0.06,lty="dotted")
# #text(x = AVE*1.05, y = 0.051, '{', srt = 90, cex = 1.5, family = 'Helvetica Neue UltraLight')
# text((AVE)*1.25,0.06,latex2exp::TeX("$\\sigma / \\sqrt{16}$"), adj=c(0.5,1.25),
#      cex=0.95 )

step <- (upper.x - lower.x) / 100
bounds <- c(lower.x, upper.x)
cord.x <- c(lower.x,seq(lower.x,upper.x,step),upper.x)
cord.y <- c(0,dnorm(seq(lower.x,upper.x,step),AVE,SE),0)
polygon(cord.x,cord.y,col=RColorBrewer::brewer.pal(9, "Set1")[5])
text(lower.x, -0.005, round(lower.x, 0))
text(upper.x, -0.005, round(upper.x, 0))




pacman::p_load(latex2exp)

txt= "Ocean Depths
(units = 100m)"
if(panel==2) txt="Land Elevations
(units = 100m)"
text(AVE+5,0.7*YLIM[1],txt,
     col="#56B4E9",adj=c(0,0.5),font=2)

# 68% CI
lower.x <- qnorm(p = c(0.16), AVE, SE)
upper.x <- qnorm(p = c(0.84), AVE, SE)
step <- (upper.x - lower.x) / 100
bounds <- c(lower.x, upper.x)
cord.x <- c(lower.x,seq(lower.x,upper.x,step),upper.x)
cord.y <- c(0,dnorm(seq(lower.x,upper.x,step),AVE,SE),0)
polygon(cord.x,cord.y,col=RColorBrewer::brewer.pal(3, "Set1")[1])
text(lower.x, -0.005, round(lower.x, 0))
text(upper.x, -0.005, round(upper.x, 0))


dev.off()
plot(Y,already,pch=19,lwd=1,col="white",
     type="l",ylim=YLIM, xlim=c(0,max.X),
     ylab="Density", xlab=XLAB[panel] )
polygon(c(0,Y),c(0,FREQ),
        col=c("lightgrey","bisque","grey98")[panel],
        border="grey10",lwd=1)
curve(dnorm(x,mean = AVE,sd = SE), add = TRUE, lwd = 2) 
# 95% CI
lower.x <- qnorm(p = c(0.025), AVE, SE)
upper.x <- qnorm(p = c(0.975), AVE, SE)
step <- (upper.x - lower.x) / 100
bounds <- c(lower.x, upper.x)
cord.x <- c(lower.x,seq(lower.x,upper.x,step),upper.x)
cord.y <- c(0,dnorm(seq(lower.x,upper.x,step),AVE,SE),0)
polygon(cord.x,cord.y,col=RColorBrewer::brewer.pal(3, "Set1")[2])
text(lower.x, -0.005, round(lower.x, 0))
text(upper.x, -0.005, round(upper.x, 0))

AVE + qnorm(c(0.025, 0.975)) * SE


library(mosaic)
p <- mosaic::xqnorm(p = c(0.025, 0.975), mean = 105.84, sd = 15/sqrt(31), return = "plot")
# geom_text() + 
p +   annotate("text", label = "fsf", x = 100, y = 0.05, size = 8, colour = "red")







segments(AVE,0, AVE, 0.10,lty="dotted")
text(AVE,  0.35*YLIM[1],toString(round(AVE,0)), adj=c(0.5,1),
     cex=0.85 )
txt= "Ocean Depths
(units = 100m)"
if(panel==2) txt="Land Elevations
(units = 100m)"
text(AVE+5,0.7*YLIM[1],txt,
     col="#56B4E9",adj=c(0,0.5),font=2)
text(0.85*AVE,0.35*YLIM[1],expression(mu), adj=c(0.5,1.25),
     cex=0.95 )
text(AVE,  0.99*YLIM[1], toString(round(SD,0)), adj=c(0.5,0),
     cex=0.85 )
text(0.85*AVE,0.99*YLIM[1],expression(sigma), adj=c(0.5,0),
     cex=0.95 )
