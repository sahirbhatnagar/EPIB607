# # # examples
# # # less than alternative  ----
n <- 5 # sample size
s <- 0.0080 # standard deviation
mu0 <- -0.540 # mean undder the null
mha <- 1.01 * mu0 # mean under the alternative
cutoff <- mu0 + qnorm(0.05) * s / sqrt(n)

dev.off()
par(mfrow = c(1,2))
power_plot(n = n*5,
           s = s,
           mu0 = mu0,
           mha = mha,
           cutoff = cutoff,
           alternative = "less",
           xlab = "")

ylims <- par("usr")[3:4]

power_plot(n = n,
           s = s,
           mu0 = mu0,
           mha = mha,
           cutoff = cutoff,
           alternative = "less",
           xlab = "",
           ylimit = ylims)
#
#
#
# # greater than alternative  ----
n <- 5*5 # sample size
s <- 0.0080 # standard deviation
mu0 <- -0.540 # mean undder the null
mha <- 0.99 * mu0 # mean under the alternative
cutoff <- mu0 + qnorm(0.95) * s / sqrt(n)
dev.off()
par(mfrow=c(1,2))
power_plot(n = n,
           s = s,
           mu0 = mu0,
           mha = mha,
           cutoff = cutoff,
           alternative = "greater",
           xlab = "")
ylims <- par("usr")[3:4]

n <- 5 # sample size
s <- 0.0080 # standard deviation
mu0 <- -0.540 # mean undder the null
mha <- 0.99 * mu0 # mean under the alternative
cutoff <- mu0 + qnorm(0.95) * s / sqrt(n)
power_plot(n = n,
           s = s,
           mu0 = mu0,
           mha = mha,
           cutoff = cutoff,
           alternative = "greater",
           xlab = "",
           ylimit = ylims)
#
# dev.off()
#
#
#
#
# # two-sided alternative ----
n <- 3 # sample size
s <- 0.088 # standard deviation
mu0 <- .86 # mean undder the null
mha <- .88 # mean under the alternative
cutoff <- mu0 + qnorm(c(0.025, 0.975)) * s / sqrt(n)
power_plot(n = n,
           s = s,
           mu0 = mu0,
           mha = mha,
           cutoff = cutoff,
           alternative = "equal",
           xlab = "")
#
# manipulate: poor man's shiny ----
pacman::p_load(manipulate) # or library(manipulate)
mu0 <- -0.540 # mean under the null
mha <- 0.99*-0.540 # mean under the alternative
s <- 0.0080
n <- 5
cutoff <- mu0 + qnorm(0.95) * s / sqrt(n)
manipulate::manipulate(
  power_plot(n = sample_size, s = sample_sd,
             mu0 = mu0, mha = mha,
             cutoff = cutoff,
             alternative = "greater",
             xlab = "Freezing point (degrees C)"),
  sample_size = manipulate::slider(5, 100),
  sample_sd = manipulate::slider(0.001, 0.01, initial = 0.008))



n=15
mha <- 0.99*-0.540
cutoff <- mu0 + qnorm(0.95) * s / sqrt(n)

p1 <- power_plot(n = n, s = s,
           mu0 = mu0, mha = mha,
           cutoff = cutoff,
           alternative = "greater",
           xlab = "Freezing point (degrees C)")