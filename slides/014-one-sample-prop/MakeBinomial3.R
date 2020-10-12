
par(mfrow=c(2,1),mar = rep(0.001,4) )


s =c(-1,1)
COL=c("red","blue")
p=0.4

plot(c(0,8.5),c(-1,40),col="white",xaxt="n")

y5=1:32
y4=apply(matrix(y5,2,16),2,mean)
arrows(4,rep(y4,each=2), 5, y5,
 col=rep(COL,16),
  length=0.06, angle=25)
text(4.5,0,"5th")

y3=apply(matrix(y4,2,8),2,mean)
arrows(3,rep(y3,each=2), 4, y4,
 col=rep(COL,16),
  length=0.06, angle=25)
text(3.5,0,"4th")
 
y2=apply(matrix(y3,2,4),2,mean)
arrows(2,rep(y2,each=2), 3, y3,
 col=rep(COL,8),
  length=0.06, angle=25)
text(2.5,0,"3rd")

y1=apply(matrix(y2,2,2),2,mean)
arrows(1,rep(y1,each=2), 2, y2,
 col=rep(COL,4),
  length=0.06, angle=25)
text(1.5,0,"2nd")

arrows(0,mean(y5), 1, y1,
 col=COL,
  length=0.06, angle=25)
text(0.5,0,"1st")


C=c("red","blue")
for(i in 31:0){
	r = as.integer(intToBits(y5[i])[5:1] ) 
	points(5+(1:5)/10,rep(i+1,5),col=C[r+1],
	pch=19,cex=0.5)	
}

text(0.8,38,"",adj=c(0,0))
	
	
	text(0,38,expression(
	      paste(
	      "The ", 2^n,
" possible sequences of n independent Bernoulli observations")),
	      adj=c(0,0))
	
	text(5.7,31,
"With n=5, 32 possible sequences.

Below, sequences leading to the
same positive:negative (RED/blue)
'split' are grouped.

The number of sequences leading
to same split is shown in black.

With n=5,
there are 6 possible splits

The probability of a given split
is the probability of any one 
of the sequences leading to it,
multiplied by the number of such 
sequences.",
cex=0.7,adj=c(0,1))
	
    
     text(0,35,
      expression(paste(
        "Prob[ i-th observation is BLUE, i.e. = 1 ] = ",
         pi)
      ),col="blue",adj=c(0,0.5)
    )
	
 plot(c(0,7.0),c(-6.7,6.5),col="white",xaxt="n")
 for (y1 in s){
	arrows(0, 0, p, p*y1,
	  col=COL[(y1+3)/2],length=0.07,
	  angle=20, lwd = 1+ (y1==1) )
	if(y1>0) text(p/2, y1/2,
		  expression(pi),
		  adj=c(0.5,0.0),col="blue")
	if(y1<0) text(p/2, y1/2,
		  expression(1 - pi),
		  adj=c(0.5,1),col="red")
	
	
	for (y2 in s){
	  
	  	  arrows(1,y1,1+p,y1+y2*p,
	      col=COL[(y2+3)/2],
	      length=0.07,angle=20,
	      lwd = 1+ (y2==1) )
	  for (y3 in s){
	  	arrows(2,y1+y2,2+p,y1+y2+y3*p,
	      col=COL[(y3+3)/2],
	      length=0.07,angle=20,
	      lwd = 1+ (y3==1) )
	    for (y4 in s){
	  	  arrows(3,y1+y2+y3,3+p,y1+y2+y3+y4*p,
	      col=COL[(y4+3)/2],
	      length=0.07,angle=20,
	      lwd = 1+ (y4==1) )
	      for (y5 in s){
	  	   
	  	   arrows(4,y1+y2+y3+y4,4+p,y1+y2+y3+y4+y5*p,
	         col=COL[(y5+3)/2],
	         length=0.07,angle=20,
	         lwd = 1+ (y5==1) )
          } # y5
        } # y4
      } # y3
    } #y2
 } #y1

	    
    N=c(1,2,1)	  
	for(ss in 2:1){
		y = ss*1 - (2-ss)*1
		C = N[ss+1]
		text(1+(p)/2, 
		     y-0.2,expression(pi),
		     col="blue", adj=c(0.5,1))
	}
	
    N=c(1,3,3,1)	  
	for(ss in 3:1){
		y = ss*1 - (3-ss)*1
		C = N[ss+1]
		text(2+(p)/2, 
		     y-0.2,expression(pi),
		     col="blue", adj=c(0.5,1))
	}
	N=c(1,4,6,4,1)	  
	for(ss in 4:1){
		y = ss*1 - (4-ss)*1
		C = N[ss+1]
		text(3+(p)/2, 
		     y-0.2,expression(pi),
		     col="blue", adj=c(0.5,1))
	}
	N=c(1,5,10,10,5,1)	  
	for(ss in 5:1){
		y = ss*1 - (5-ss)*1
		C = N[ss+1]
		text(4+(p)/2, 
		     y-0.2,expression(pi),
		     col="blue", adj=c(0.5,1))
	}
	

	   text(0.0, 5.5,
"1,2,3, ... 10: Number of sequences that yield the
indicated split (can obtain from nCy or Pascal's Triangle).
All sequences leading to the split are equiprobable.",
	 adj=c(0,0.5),cex=0.75)
	 
	 text(6,6,"Binomial Probabilities*")
  text(6.9,-6,"* in R: dbinom(0:5,size=5,prob=0.xx)",
  family="mono", adj=c(1,1))
  
  text(0,0,"1", adj=c(1,0.5))

 	N=c(1,1)	  
	for(ss in 1:0){
		y = ss*1 - (1-ss)*1
		C = N[ss+1]
		text(1-(1-p)/1.2, 
		     y*(p+1)/2,toString(C),adj=c(0,0.5))
	}		
	points( (p+1)/2, (p+1)/2,
		  cex=1,pch=19,col="blue")
    points( (p+1)/2, -(p+1)/2,
		  cex=1,pch=19,col="red")
		  
		  
	N=c(1,2,1)	  
	for(s in 2:0){
		y = s*1 - (2-s)*1
		C = N[s+1]
		text(2-(1-p)/1.5, 
		     y*(p+1)/2,toString(C),adj=c(1,0.5))
	}	
		  
    points( 1+(p+1)/2, 1+(p+1)/2+p/2,
		  cex=1,pch=19,col="blue")
	points( 1+(p+1)/2, 1+(p+1)/2-p/2,
		  cex=1,pch=19,col="blue")
		  
    points( 1+(p+1)/2, p/2,
		  cex=1,pch=19,col="blue")
	points( 1+(p+1)/2, -p/2,
		  cex=1,pch=19,col="red")
		  
	points( 1+(p+1)/2, -1-(p+1)/2+p/2,
		  cex=1,pch=19,col="red")
	points( 1+(p+1)/2, -1-(p+1)/2-p/2,
		  cex=1,pch=19,col="red")
		  
	N=c(1,3,3,1)	  
	for(ss in 3:0){
		if(ss==3) COL=rep("blue",4)
		if(ss==2) COL[3]="red"
		if(ss==1) COL[2]="red"
		if(ss==0) COL[1]="red"
		y = ss*1 - (3-ss)*1
		points( 2+(p+1.1)/2      , y+0.1,
		  cex=1,pch=19,col=COL[1])
		points( 2+(p+1.1)/2 -0.08,  y-0.2,
		  cex=1,pch=19,col=COL[2])
		points( 2+(p+1.1)/2 +0.08,  y-0.2,
		  cex=1,pch=19,col=COL[3])
		
	}
	
	N=c(1,3,3,1)	  
	for(ss in 3:0){
		y = ss*1 - (3-ss)*1
		C = N[ss+1]
		text(3-(1-p)/1.5, 
		     y-0.2,toString(C),adj=c(1,0.5))
	}
	
	N=c(1,4,6,4,1)	  
	for(ss in 4:0){
		if(ss==4) COL=rep("blue",4)
		if(ss==3) COL[4]="red"
		if(ss==2) COL[3]="red"
		if(ss==1) COL[2]="red"
		if(ss==0) COL[1]="red"
		y = ss*1 - (4-ss)*1
		points( 3+(p+1.1)/2 - 0.06, y-0.2,
		  cex=1,pch=19,col=COL[1])
		points( 3+(p+1.1)/2 +0.06,  y-0.2,
		  cex=1,pch=19,col=COL[2])
		points( 3+(p+1.1)/2 -0.06,  y+0.2,
		  cex=1,pch=19,col=COL[3])
		points( 3+(p+1.1)/2 +0.06,  y+0.2,
		  cex=1,pch=19,col=COL[4])
		    
		text(4-(1-p)/1.5, 
		     y-0.2,toString(N[ss+1]),adj=c(1,0.5))
	}
	
		  
	N=c(1,5,10,10,5,1)	  
	for(ss in 5:0){
		if(ss==5) COL=rep("blue",5)
		if(ss==4) COL[5]="red"
		if(ss==3) COL[4]="red"
		if(ss==2) COL[3]="red"
		if(ss==1) COL[2]="red"
		if(ss==0) COL[1]="red"
		y = ss*1 - (5-ss)*1
		
		text(5-(1-p)/1.24, 
		     y,toString(N[ss+1]),adj=c(1,0.5))
		
		points( 4+(p+1.1)/2 - 0.12, y,
		  cex=1,pch=19,col=COL[1])
		points( 4+(p+1.1)/2 +0.12,  y,
		  cex=1,pch=19,col=COL[2])
		points( 4+(p+1.1)/2 ,  y+0.40,
		  cex=1,pch=19,col=COL[3])
		points( 4+(p+1.1)/2 ,  y-0.40,
		  cex=1,pch=19,col=COL[4])
		points( 4+(p+1.1)/2 ,  y,
		  cex=1,pch=19,col=COL[5])

		C = N[ss+1]
		text(4.75+(p+1.6)/2, y,
		  substitute(
		    paste(coef, 
		     phantom(0),
		     scriptstyle(x),
		     phantom(0)),
		    list(coef=C,y=s,rest=3-ss)
		  ),
		  adj=c(1,0.8)
		)
		
		text(4.7+(p+1.6)/2+0.4, y,
		  substitute(
		    paste( pi^y, phantom(0)),
		    list(coef=C,y=ss,rest=5-ss)
		  ),col="blue",
		  adj=c(1,0.5)
		)
		
		text(4.7+(p+1.6)/2+0.4, y,
		  substitute(
		    paste( (1-pi)^rest),
		    list(coef=C,y=ss,rest=5-ss)
		  ),col="red",
		  adj=c(0,0.5)
		)
		
	}
	
 
  
