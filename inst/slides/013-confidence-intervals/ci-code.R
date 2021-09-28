rm(list=ls())
DA = 10

xmax=0.75
DX=3+xmax
ymax=4

u = 100
dev.off()
# par(mfrow=c(1,2),mar = c(0.01,1,0.01,0.25))

par(mar = c(0.01,1,0.01,0.25))
for (example in 1) {

example = 1
  plot(u*c(-3,xmax),u*c(-0.5,ymax),col="white",
       xaxt="n", yaxt="n",xlab="",ylab="",
       xlim=u*c(-3.35,xmax+0.35),ylim=u*c(-0.5,ymax),
       frame=FALSE)
  lines(u*c(-4,0,0),u*c(0,0,ymax),lty="dotted")

  segments(u*xmax, 0, u*xmax,  u*6)
  for(h in seq(0,6,1)){
    text(u*xmax,u*h,
         paste(toString(u*h),"m",sep=""),
         adj=c(-0.2,0.5),cex=0.75)
    segments(u*(xmax-0.025), u*h, u*xmax,  u*h)
  }
  for(d in seq(1,3,1)){
    text(-u*d,-0.15*u,
         paste(toString(u*d),"m",sep=""),
         adj=c(0.5,1),cex=0.75)
    segments(-u*d, 0, -u*d,  -u*0.05)
  }


  H = u*2.25

  x=0.15
  U=u*5
  L=0
  COL=1
  dd = 1

  distances = 1
  # if(example==2) distances = seq(dd,3,dd)
  # distances = seq(dd,3,dd)
  for (d in u*distances ) {

    d = u*distances

    ANGLE   = atan( H/d ) * 360/(2*pi)
    angle.hat   = DA*round(ANGLE/DA)
    h.hat   = d*tan(  angle.hat       / ( 360/(2*pi) ) )
    segments(-d,0,0,h.hat,col=COL)
    ii = d/u

    text(-d + u*c(0.1,0.2,0.25)[ii], 0,
         paste("'",toString(angle.hat),"'",sep="") ,
         adj=c(0,-0.3), col=COL)
    h.upper = d*tan( (angle.hat+DA/2) / ( 360/(2*pi) ) )
    h.lower = d*tan( (angle.hat-DA/2) / ( 360/(2*pi) ) )
    segments(u*x,h.lower,u*x,h.upper,col=COL)
    if(example==1){
      text(u*x, h.upper, expression(theta[U]),adj=c(-0.5,0.5))
      text(u*x, h.lower, expression(theta[L]),adj=c(-0.5,0.5))
    }
    points(u*x,h.hat,pch=19,cex=0.4,col=COL)
    if(example==1) points(u*xmax,h.hat,pch=19,cex=0.4,col=COL)
    U = min(U,h.upper)
    L = max(L,h.lower)
    x=x+0.15
    COL=COL+1
  }
  if(example==2){
    segments(u*(xmax),L,u*(xmax),U,lwd=4)
    segments(u*(xmax-0.075),L,u*(xmax+0.075),L )
    segments(u*(xmax-0.075),U,u*(xmax+0.075),U )
  }

}





# original 2 panel code ---------------------------------------------------

DA = 10

xmax=0.75
DX=3+xmax
ymax=4

u = 100

par(mfrow=c(1,2),mar = c(0.01,1,0.01,0.25))

for (example in 1:2) {


  plot(u*c(-3,xmax),u*c(-0.5,ymax),col="white",
       xaxt="n", yaxt="n",xlab="",ylab="",
       xlim=u*c(-3.35,xmax+0.35),ylim=u*c(-0.5,ymax),
       frame=FALSE)
  lines(u*c(-4,0,0),u*c(0,0,ymax),lty="dotted")

  segments(u*xmax, 0, u*xmax,  u*6)
  for(h in seq(0,6,1)){
    text(u*xmax,u*h,
         paste(toString(u*h),"m",sep=""),
         adj=c(-0.2,0.5),cex=0.75)
    segments(u*(xmax-0.025), u*h, u*xmax,  u*h)
  }
  for(d in seq(1,3,1)){
    text(-u*d,-0.15*u,
         paste(toString(u*d),"m",sep=""),
         adj=c(0.5,1),cex=0.75)
    segments(-u*d, 0, -u*d,  -u*0.05)
  }


  H = u*2.25

  x=0.15
  U=u*5
  L=0
  COL=1
  dd = 1

  distances = 1
  if(example==2) distances = seq(dd,3,dd)

  for (d in u*distances ) {
    ANGLE   = atan( H/d ) * 360/(2*pi)
    angle.hat   = DA*round(ANGLE/DA)
    h.hat   = d*tan(  angle.hat       / ( 360/(2*pi) ) )
    segments(-d,0,0,h.hat,col=COL)
    ii = d/u

    text(-d + u*c(0.1,0.2,0.25)[ii], 0,
         paste("'",toString(angle.hat),"'",sep="") ,
         adj=c(0,-0.3), col=COL)
    h.upper = d*tan( (angle.hat+DA/2) / ( 360/(2*pi) ) )
    h.lower = d*tan( (angle.hat-DA/2) / ( 360/(2*pi) ) )
    segments(u*x,h.lower,u*x,h.upper,col=COL)
    if(example==1){
      text(u*x, h.upper, expression(theta[U]),adj=c(-0.5,0.5))
      text(u*x, h.lower, expression(theta[L]),adj=c(-0.5,0.5))
    }
    points(u*x,h.hat,pch=19,cex=0.4,col=COL)
    if(example==1) points(u*xmax,h.hat,pch=19,cex=0.4,col=COL)
    U = min(U,h.upper)
    L = max(L,h.lower)
    x=x+0.15
    COL=COL+1
  }
  if(example==2){
    segments(u*(xmax),L,u*(xmax),U,lwd=4)
    segments(u*(xmax-0.075),L,u*(xmax+0.075),L )
    segments(u*(xmax-0.075),U,u*(xmax+0.075),U )
  }

}
