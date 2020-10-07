# count the number of students who provided a mean and proportion
N.r <- 60
p0 <- 2
p1 <- 1
p2 <- 13
p3 <- 19
p4 <- 24
p5 <- 1

water_res <- c(rep(0, p0), 
               rep(0.2, p1),
               rep(0.4, p2),
               rep(0.6, p3),
               rep(0.8, p4),
               rep(1, p5))
  
  
# par(mfrow=c(2,1), mai = c(0.45,0.45,0.45,0.1))
plot(table(water_res), 
       xlim = c(0,1),
       xlab = "Students' Estimates of Proportion Covered by Water",
       main = "n = 5", 
       ylim = c(0, N.r/1.5), 
       ylab = "Frequency", cex.lab = 3, cex.main = 3, cex.axis = 3)
abline(v=0.71, col = "#009E73", lty = 2)
text(0.72, 30, expression(mu), cex = 3)
text(0.76, 31, "=0.71", cex = 3)


pacman::p_load(magrittr)
pacman::p_load(ggformula)
ggformula::gf_col()


