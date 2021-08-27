wilsonCP=TRUE

if(wilsonCP){
  
  
  nn=c(5,20); yy=c(4,16)
  
  par(mfrow=c(1,2),mar = c(2.5,0.1,0.1,0.1) )
  
  for(J in 1:2){
    
    y=yy[J] ; n=nn[J]
    
    p.O=y/n
    z=1.96
    ( p.L = round((p.O + z^2/(2*n) - 1.96*sqrt(p.O*(1-p.O)/n +z^2/(4*n^2))) / ( 1+ z^2/n),6 ))
    
    p.L + 1.96 * sqrt(p.L*(1-p.L)/n) 
    
    ( p.U = round((p.O + z^2/(2*n) + 1.96*sqrt(p.O*(1-p.O)/n +z^2/(4*n^2))) / ( 1+ z^2/n),4 ))
    
    p.U - 1.96 * sqrt(p.U*(1-p.U)/n)
    
    pi=seq(0,1,0.01)
    Y = max(dnorm(pi,mean=p.U,
                  sd=sqrt(p.U*(1-p.U)/n) )
    )
    
    YLIM=c(-1.2,1.25)*Y           
    # blue
    
    SE = sqrt(p.L*(1-p.L)/n)
    h=dnorm(pi,mean=p.L,sd=SE)
    H = max(h)
    
    plot(c(0,1),c(0,5),col="white",
         ylim=YLIM,xlim=c(-0.05,1.01),
         yaxt="n")
    points(p.O,-0.1*H,cex=0.75,pch=19)
    segments(0,0,1,0,lwd=0.25)
    arrows(p.L,0,
           p.L,-0.2*max(h),length=0.06,
           angle=25,col="blue",lwd=1.5)
    text(p.L,-0.35*max(h),
         expression(P[L]),
         adj=c(0.5,1),col="blue")
    txt="4/5" ; if(J==2) txt="16/20"
    text(p.O,-0.35*max(h),txt,adj=c(0.5,1))
    #text(p.L,-0.22*max(h),"0.376",adj=c(0.5,1),col="blue")
    
    lines(pi,h,col="blue")
    #segments(p.L,   0.6*max(h),
    #         p.L+SE,0.6*max(h),col="blue")
    #text(p.L + SE/2,0.6*max(h),
    #expression( paste("SE = ",sqrt(over(0.376(1-0.376),5)) ) ),
    #adj=c(0.5,1.25),col="blue",cex=0.75)
    
    arrows(p.L,  -0.2*max(h),
           p.O,  -0.2*max(h),col="blue",
           length=0.08,angle=35,lwd=2)
    #text( (p.L + p.O)/2,-0.13*max(h),
    #"1.96 x SE",adj=c(0.5,1),col="blue")
    
    tail=seq(p.O,1,length.out=50)
    h=dnorm(tail,mean=p.L,sd=SE)
    polygon(c(p.O,tail,1),c(0,h,0),col="blue", border=NA)
    
    # red
    
    SE.U = sqrt(p.U*(1-p.U)/n)
    
    arrows(p.U,0,
           p.U,-0.2*H,length=0.06,angle=25,col="red")
    text(p.U,-0.35*H,
         expression(P[U]),
         adj=c(0.5,1),col="red")
    #text(p.U,-0.22*H,"0.864",adj=c(0.5,1),col="red")
    
    h = dnorm(pi,mean=p.U,sd=SE.U)
    HH= max(h)
    lines(pi[60:101], h[60:101],col="red")
    
    #segments(p.U,     0.6*max(h),
    #        p.U-SE.U,0.6*max(h),col="red")
    #text(p.U,0.58*max(h),
    #expression( paste("SE = ",sqrt(over(0.864(1-0.864),5)) ) ),adj=c(1,1),col="red",cex=0.65)
    
    tail=seq(0.6,p.O,length.out=50)
    h=dnorm(tail,mean=p.U,sd=SE.U)
    polygon(c(0.6,tail,p.O),c(0,h,0),col="red", border=NA)
    
    arrows(p.U,  -0.2*H,
           p.O,  -0.2*H,col="red",
           length=0.08,angle=35,lwd=2)
    #text( (p.U + p.O)/2,-0.13*H,
    #"1.96 x SE",adj=c(0.5,1),col="red",cex=0.75)
    
    text(0.7,H/6,"2.5%",col="red",cex=0.8)
    #segments(0.7,H/8 , p.O,0,col="red")
    
    text(0.9,H/6,"2.5%",col="blue",cex=0.8)
    #segments(0.9,H/8 , p.O,0,col="blue")
    
    txt="WILSON 1927. CI for  proportion P, based on observed sample proportion p.
    
    Probable Inference (USUAL). Say we observe a certain proportion, p, 
    in a sample of n. We compute an interval using a statistical model
    (binomial or Gaussian) that uses (the statistic) p as the parameter
    for the sampling distribution.
    
    It is common to say that the probability that the true proportion, P say,
    lies below/above the 2.5/97.5-%ile [of this sampling distribution 
    centered on p] is 0.05."
    
    if(J==2)
      txt="WILSON 1927 (continued...)
    
    Strictly speaking, this statement is elliptical. Really the chance that
    P lies outside a specified range is either 0 or 1. It is the observed
    proportion p which has a greater or less chance of lying within a certain
    interval of P. If the observer was unlucky to have observed a rare 
    event and to have based his inference thereon, he may be fairly wide
    of the mark.
    
    Probable Inference (IMPROVED). A better way is to reason:
    
    There is some [true] P. Consider 2 scenarios:"
    
    
    text(-0.045,1.28*Y,txt,cex=0.7, 
         adj=c(0,1), col="grey35" )
    
    text(p.U,0.65*HH,
         "p --- P ('p is an under-estimate'):
         
         p landed at the 2.5%-ile of this
         sampling distribution (Distrn):
         
         p = qDistrn(0.025,
         prob = P.Upper)
         
         --> solve for P.Upper",
         cex=0.6, adj=c(1,1),col="red" )
    
    text(p.L,(0.55-(J==2)/20)*HH,
         "P---p ('p is an over-estimate'):
         
         p landed at the 97.5%-ile of this
         sampling distribution (Distrn):
         
         p = qDistrn(0.975,
         prob = P.Lower)
         
         --> solve for P.Lower",
         cex=0.6, adj=c(1,1),col="blue" )
    
    text(-0.045,-0.03*HH,
         "Wilson used 2 Gaussian
         sampling distributions",
         cex=0.75, adj=c(0,1))
    
    text(-0.045,-0.3*HH,
         "Clopper-Pearson (1934)
         used 2 Binomial distributions",
         cex=0.75, adj=c(0,1))
    
    yo=-1.07*Y; dy=0.7*Y ; dx=0.003
    
    binom.test(16,20)
    if(J==1) {P.L=0.2835821 ; P.U=0.9949492}
    if(J==2) {P.L=0.563386  ; P.U=0.942666}
    
    segments(0,yo,1,yo)
    
    text(p.O,yo-0.10*Y,"p",adj=c(0.5,1))
    arrows(P.L,yo-0.05*Y,P.L,yo,
           col="blue", length=0.07,angle=25)
    text(P.L,yo-0.10*Y,expression(P[L]),
         adj=c(0.5,1),col="blue")
    h= dy*dbinom(0:n,n,P.L)
    segments((0:n)/n +dx, yo,
             (0:n)/n +dx, yo+h,
             col="blue",lwd=2)
    txt=
      "dbinom(0:5, size=5,
    prob=0.283)"
    if(J==2) txt=
      "dbinom(0:20, size=20,
    prob=0.563)"
    
    Yy = yo+0.4*Y
    
    text(P.L-ifelse(J==2, 0.1,0),Yy,txt,
         col="blue",adj=c(1,1),cex=0.65,family="mono")
    
    txt=expression(paste(Sigma,"[4:5]"))
    if(J==2)txt=expression(paste(Sigma,"[16:20]"))
    
    Yy = yo+0.25*Y
    
    text(p.O*1.02,Yy,txt,
         col="blue",adj=c(0,1),cex=0.6,family="mono")
    
    
    arrows(P.U,yo-0.05*Y,P.U,yo,
           col="red", length=0.07,angle=25)
    text(P.U,yo-0.10*Y,expression(P[U]),
         adj=c(0.5,1),col="red")
    
    h= dy*dbinom(0:n,n,P.U)
    segments((0:n)/n -dx , yo,
             (0:n)/n -dx,  yo+h,
             col="red",lwd=2)
    
    txt=
      expression(paste(Sigma,"[0:4]"))
    if(J==2) txt=
      expression(paste(Sigma,"[0:16]"))
    
    Yy = yo+0.25*Y
    
    text(0.98*p.O,Yy,txt,
         col="red",adj=c(1,1),family="mono",cex=0.6)
    
    txt=
      "dbinom(0:5, size=5,
prob=0.995)"
    if(J==2) txt=
      "dbinom(0:20, size=20,
prob=0.943)"
    
    Yy = yo+0.4*Y
    
    text(0.99*P.U+ifelse(J==2,0.1,0),Yy,txt,
         col="red",adj=c(1,1),family="mono",cex=0.65)
    
    
    
    points(p.O,yo-0.05*Y,cex=0.75,pch=19)
    
    # text( sum(dbinom(4:5,5,0.283))
    
    text(0.98*p.O,yo+0.18*Y,"2.5%",col="red",
         cex=0.8,adj=c(1,1))
    text(1.02*p.O,yo+0.18*Y,"2.5%",col="blue",
         cex=0.8,adj=c(0,1))
    
    
  } # end J
  
} # end wilsonCP
