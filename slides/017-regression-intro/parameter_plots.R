# ```{r,eval=T, echo=F, fig.align="center", fig.height=7, fig.width=9, warning=FALSE, message=F}
plot3 = function(row){
  par(mfrow=c(1,3),mar = c(0,0,0,0.5) )
  TOP="Mean Ocean\ndepth (Km)"
  x=c(0.225,0.775);; dx=0.025
  mu = c(3.6,4.5)

  LABEL=c("North\n(South=0)", "South")
  delta.mu = mu[2]-mu[1]

  PARA = t(matrix( c( toString(mu[1]),
                      toString(mu[2]),
                      toString(mu[1]),
                      paste( toString(mu[1]), " + ",
                             toString(delta.mu),sep=""),
                      rep(paste(toString(mu[1]),
                                " + ",toString(delta.mu),
                                " if South",sep=""),2)
  ),2,3) )

  PARA.S = c( expression(mu[North]),
              expression(mu[South]),
              expression(mu[North]),
              expression(mu[North] + Delta * mu),
              expression(mu[S] == paste(mu[0] + Delta * mu ,
                                        " ",textstyle(x)," S")),
              expression(mu[S] == paste(mu[0] + Delta * mu ,
                                        " ",textstyle(x)," S")),

              expression(mu[North]),
              expression(mu[South]),
              expression(mu[North]),
              expression(mu[North] %*% Delta * mu),

              expression(mu[S] == paste(mu[0] %*% Delta * mu ,
                                        " ",textstyle(x)," S")),
              expression(mu[S] == paste(mu[0] %*% Delta * mu ,
                                        " ",textstyle(x)," S"))

  )

  PARA.R = c( toString(mu[1]),
              toString(mu[2]),
              toString(mu[1]),
              expression(3.6 %*% frac(4.5, 3.6) ),
              rep(expression(
                paste(3.6 %*% frac(4.5, 3.6)," if South")
              ), 2)
  )

  PARA.RS = c(  expression(mu[North]),
                expression(mu[South]),
                expression(mu[North]),
                expression(mu[North] %*% frac(mu[South], mu[North]) ),
                rep(expression(mu[S] == mu[0]
                               %*% Ratio^s), 2)
  )

  SRT=38

  dy= 1
  for(co in 1:3){
    plot(x,mu,yaxt="n",xlim=c(0,1),
         ylim=c(-0.2,ceiling(mu[2])))
    text(0, ceiling(mu[2]),
         c("(a)","(b)","(c)")[co],
         adj=c(0,0), cex=2)

    rect(x-dx,0,x+dx,mu,
         col="lightblue",border=NA)
    if(co>=2){
      points(x[2],mu[1],cex=1)
      polygon( c(x,x[2]), c(mu[1],mu),
               col=NA,border="grey50",lwd=0.75)
    }

    if(co==1){
      arrows(x[1]-0.1,0,
             x[1]-0.1,ceiling(mu[2]),
             length=0.07,angle=30)
      text(x[1]-0.15, mean(mu),
           "Mean Depth of Oceans (Km)",
           adj=c(1.25,0), srt=90, cex=2.0)
    }
    for( y in seq(0,ceiling(mu[2]),dy)){
      segments(x[1], y, x[2],y, col="grey50",lty="dotted")
      if (co == 1 & y %in% c(0,1,2,3,5) ) text(x[1]-dx, y,toString(y),
                                               adj=c(1,0.5),cex=1.5)
      if(co == 3 & y %in% c(0,1,2,3,4)  ) text(x[2]+dx, y,toString(y),
                                               adj=c(0,0.5), cex=1.5)

    }
    text(0.5,1.05*ceiling(mu[2]),TOP,adj=c(0.5,0),cex=1.2,font=2)
    points(x,mu,pch=19,cex=0.75)
    for(j in 1:2){
      txt = PARA[co,j]
      if(row==2) txt = PARA.S[(co-1)*2+j]
      if(row==3) txt = PARA.R[(co-1)*2+j]
      if(row==4) txt = PARA.RS[(co-1)*2+j]

      xx = x[j]  - 0.00*(j==1) + 0.00*(j==2)
      if(co==3) xx = mean(x)

      yy = mu[j] + 0.15 + 0.05*(row >= 3)
      if(co==3) yy =  mean(mu) +  0.15 +
        0.15*(row >= 3)

      text(xx, yy, txt,  adj=c(0.6, 0.5),
           cex=1.75,srt=SRT)

      if(row==4 & co==3 & j==1) text(
        mean(x), 2.5,
        expression(Ratio == frac(mu[South], mu[North] ) ),
        cex=1.75)

      LAB = LABEL[j]
      if(row %in% c(2,4) & co == 3 ) LAB=c("0","1")[j]
      text(x[j],-0.15,LAB, adj=c(0.5,1),
           cex=1.5)
      if(row %in% c(2,4) & co == 3 & j==1 ) text(
        mean(x),-0.25,"S", adj=c(0.5,1),cex=1.5)

    }
  }
}
plot3(1)
# ```


plot3(2)



plot_mu = function(row){
  #c(bottom, left, top, right)
  par(mfrow=c(1,1),mar = c(0,0,0,0.5) )
  TOP="Mean Ocean\ndepth (Km)"
  x=c(0.225,0.775); dx=0.025
  mu = c(3.6,4.5)

  # LABEL=c("North", "South")
  LABEL=c("North (X=0)", "South (X=1)")

  delta.mu = mu[2]-mu[1]

  PARA = t(matrix( c( toString(mu[1]),
                      toString(mu[2]),
                      toString(mu[1]),
                      paste( toString(mu[1]), " + ",
                             toString(delta.mu),sep=""),
                      rep(paste(toString(mu[1]),
                                " + ",toString(delta.mu),
                                " if South",sep=""),2)
  ),2,3) )

  PARA.S = c( expression(mu[0]),
              expression(mu[1]),
              expression(mu[0]),
              expression(mu[0] + Delta * mu),
              expression(mu[S] == paste(mu[0] + Delta * mu ,
                                        " ",textstyle(x)," S")),
              expression(mu[S] == paste(mu[0] + Delta * mu ,
                                        " ",textstyle(x)," S")),

              expression(mu[0]),
              expression(mu[1]),
              expression(mu[0]),
              expression(mu[0] %*% Delta * mu),

              expression(mu[S] == paste(mu[0] %*% Delta * mu ,
                                        " ",textstyle(x)," S")),
              expression(mu[S] == paste(mu[0] %*% Delta * mu ,
                                        " ",textstyle(x)," S"))

  )

  PARA.R = c( toString(mu[1]),
              toString(mu[2]),
              toString(mu[1]),
              expression(3.6 %*% frac(4.5, 3.6) ),
              rep(expression(
                paste(3.6 %*% frac(4.5, 3.6)," if South")
              ), 2)
  )

  PARA.RS = c(  expression(mu[North]),
                expression(mu[South]),
                expression(mu[North]),
                expression(mu[North] %*% frac(mu[South], mu[North]) ),
                rep(expression(mu[S] == mu[0]
                               %*% Ratio^s), 2)
  )

  SRT=38

  dy= 1
  for(co in 1:1){
    plot(x,mu,yaxt="n",xlim=c(0,1),
         ylim=c(-0.2,ceiling(mu[2])))
    text(0, ceiling(mu[2]),
         # c("","(b)","(c)")[co],
         expression(mu[X]),
         adj=c(0,0), cex=2)

    rect(x-dx,0,x+dx,mu,
         col="lightblue",border=NA)
    if(co>=2){
      points(x[2],mu[1],cex=1)
      polygon( c(x,x[2]), c(mu[1],mu),
               col=NA,border="grey50",lwd=0.75)
    }

    if(co==1){
      arrows(x[1]-0.1,0,
             x[1]-0.1,ceiling(mu[2]),
             length=0.07,angle=30)
      text(x[1]-0.15, mean(mu),
           "Mean Depth of Oceans (Km)",
           adj=c(1.25,0), srt=90, cex=2.0)
    }
    for( y in seq(0,ceiling(mu[2]),dy)){
      segments(x[1], y, x[2],y, col="grey50",lty="dotted")
      if (co == 1 & y %in% c(0,1,2,3,5) ) text(x[1]-dx, y,toString(y),
                                               adj=c(1,0.5),cex=1.5)
      if(co == 3 & y %in% c(0,1,2,3,4)  ) text(x[2]+dx, y,toString(y),
                                               adj=c(0,0.5), cex=1.5)

    }
    text(0.5,1.05*ceiling(mu[2]),TOP,adj=c(0.5,0),cex=1.2,font=2)
    points(x,mu,pch=19,cex=0.75)
    for(j in 1:2){
      txt = PARA[co,j]
      if(row==2) txt = PARA.S[(co-1)*2+j]
      if(row==3) txt = PARA.R[(co-1)*2+j]
      if(row==4) txt = PARA.RS[(co-1)*2+j]

      xx = x[j]  - 0.00*(j==1) + 0.00*(j==2)
      if(co==3) xx = mean(x)

      yy = mu[j] + 0.15 + 0.05*(row >= 3)
      if(co==3) yy =  mean(mu) +  0.15 +
        0.15*(row >= 3)

      text(xx, yy, txt,  adj=c(0.6, 0.5),
           cex=1.75,srt=SRT)

      if(row==4 & co==3 & j==1) text(
        mean(x), 2.5,
        expression(Ratio == frac(mu[South], mu[North] ) ),
        cex=1.75)

      LAB = LABEL[j]
      if(row %in% c(2,4) & co == 3 ) LAB=c("0","1")[j]
      text(x[j],-0.15,LAB, adj=c(0.5,1),
           cex=1.5)
      if(row %in% c(2,4) & co == 3 & j==1 ) text(
        mean(x),-0.25,"S", adj=c(0.5,1),cex=1.5)

    }
  }
}

dev.off()
plot_mu(2)
