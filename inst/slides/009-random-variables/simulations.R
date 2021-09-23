B <- 1000; N <- 1000
var_diff <- replicate(B, {
  RV1 <- rnorm(N, mean = 2, sd = 3)
  RV2 <- rnorm(N, mean = 4, sd = 4)
  var(RV1 - RV2)
})

hist(R, col = "lightblue", xlab = "Var(RV1 - RV2)",
     main = sprintf("Average of Var(RV1-RV2) over 1000 replications is %0.2f",mean(R)))
abline(v = mean(R), col = "red", lty = 2, lwd = 3)


g.y <- function(y) {
  (pi / 6) * y^3
}

set.seed(12)
B <- 1000; N <- 2000
E_g.y <- replicate(B, {
  diameter <- runif(N, min = 0, max = 10)
  mean(g.y(diameter)) # E(g(y))
})

g_E.y <- replicate(B, {
  diameter <- runif(N, min = 0, max = 10)
  g.y(mean(diameter)) # g(E(y))
})


par(mfrow = c(1,2))
hist(E_g.y, col = "lightblue", xlab = "mean(g(y))",
     main = sprintf("Average of E(g(Y)) over 1000\n replications is %0.2f",mean(E_g.y)))
abline(v = mean(E_g.y), col = "red", lty = 2, lwd = 3)

hist(g_E.y, col = "lightblue", xlab = "g(mean(y))",
     main = sprintf("Average of g(E(Y)) over 1000\n replications is %0.2f",mean(g_E.y)))
abline(v = mean(g_E.y), col = "red", lty = 2, lwd = 3)


