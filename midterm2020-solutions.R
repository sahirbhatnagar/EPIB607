# Question 1 --------------------------------------------------------------
dbinom(20, 50, 0.371)
dbinom(30, 50, 1 - 0.371)
pbinom(10, 20, 0.579)
pbinom(10, 20, 0.579, lower.tail = FALSE)
# alternatively
1 - pbinom(10, 20, 0.579)

# Question 3 --------------------------------------------------------------

yrbss <- readr::read_csv(file = "~/git_repositories/EPIB607/midterm/datasets/yrbss.csv")
mu <- mean(yrbss$weight)
# population sd should be divided by n
sigma <- sqrt(mean((yrbss$weight - mu)^2))

set.seed(123) # for reproducibility
sample.size <- 16
yrbss.sample <- sample_n(yrbss, size = sample.size, replace = FALSE)
sample.mean <- mean(yrbss.sample$weight)

# using t-dist with canned function
t.test(yrbss.sample$weight, conf.level = 0.95)$conf.int


# Question 4 --------------------------------------------------------------
anemia <- readr::read_csv(file = "~/git_repositories/EPIB607/midterm/datasets/anemia.csv")

#age
par(mfrow = c(1, 2))
hist(anemia$age, main = "Age", xlab = "Age (months)", col = "lightblue")
boxplot(anemia$age, main = "Age", ylab = "Age (months)", col = "lightblue")
summary(anemia$age)

# create anemic binary indicator variable
anemia$anemic <- anemia$hb < 10.5
table(anemia$anemic)
pi.hat <- sum(anemia$anemic == TRUE)/nrow(anemia)

# age vs. anemic
boxplot(age ~ anemic , data = anemia,
        xlab = "Presence of anemia", ylab = "Age (months)",
        main = "Age distribution between presence\nand absence of anemia")


# two-sided test (Clopper-Pearson confidence interval)
binom.test(x = sum(anemia$anemic), n = nrow(anemia),
           p = 0.50, alternative = "two.sided")
