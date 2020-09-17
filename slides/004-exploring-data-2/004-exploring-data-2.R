library(oibiostat)
data("famuss")
?COL


cor(famuss$height, famuss$weight)
plot(famuss$height, famuss$weight)

(1/(nrow(famuss)-1)) * sum(scale(famuss$height)*scale(famuss$weight))

zx <- scale(famuss$height)
zy <- scale(famuss$weight)

xlims <- c(-ceiling(abs(max(zx))),ceiling(abs(max(zx))))
ylims <- c(-ceiling(abs(max(zy))),ceiling(abs(max(zy))))

plot(zx,
     zy,
     pch = 19,
     cex = 1.3,
     col = COL[1, 3],
     xlim = xlims,
     ylim = ylims,
     type = "n",
     bty = "n",
     xlab = "height Z-scores",
     ylab = "weight Z-scores")
polygon(x = c(0,max(xlims), max(xlims), 0)*1.1, y = c(0,0, max(ylims), max(ylims))*1.1, col = "#56B4E9")
polygon(x = c(0,min(xlims), min(xlims), 0)*1.1, y = c(0,0, min(ylims), min(ylims))*1.2, col = "#56B4E9")
polygon(x = c(0,min(xlims), min(xlims), 0)*1.1, y = c(0,0, max(ylims), max(ylims))*1.1, col = "#D55E00")
polygon(x = c(0,max(xlims), max(xlims), 0)*1.1, y = c(0,0, min(ylims), min(ylims))*1.2, col = "#D55E00")
text(-2.7, 4.4, "(-,+)", cex = 1.5)
text(2.7, 4.4, "(+,+)", cex = 1.5)
text(2.7, -4.4, "(+,-)", cex = 1.5)
text(-2.7, -4.4, "(-,-)", cex = 1.5)
points(zx,
       zy,
       pch = 19,
       cex = 1.3,
       col = COL[5,3])
points(zx,
       zy,
       cex = 1.3,
       col = COL[5])

tt <- rnorm(10)
ttt <- -tt

sd(tt)
sd(ttt)
mean(tt)
mean(ttt)




tt <- famuss[-(1:20),]
cor(tt$height, tt$weight)
pacman::p_load(boot)

famuss_corr <- function(data) cor(data$weight, data$height)

cor(famuss$height, famuss$weight)
fit <- lm(height ~ weight, data = famuss)

coef(fit)[2] * sd(famuss$weight)/sd(famuss$height)

pacman::p_load(ggplot2)

p2 <- ggplot(data = famuss, mapping = aes(x = actn3.r577x, fill = race)) +
  theme_minimal() + colorspace::scale_fill_discrete_qualitative() + theme(legend.position = "bottom")
p2 + geom_bar(position = "stack")
p2 + geom_bar(position = "dodge")

# devtools::install_github("haleyjeppson/ggmosaic")
pacman::p_load(ggmosaic)
ggplot(data = famuss) +
  geom_mosaic(aes(x = product(race, actn3.r577x),
                  fill = race))


str(famuss)


ggplot(data = famuss) +
  geom_mosaic(aes(x = product(race, actn3.r577x),
                  fill = race, conds=product(sex))) #+
  # labs(x = "Is it rude recline? ", title='f(DoYouRecline, RudeToRecline| Gender)')


library(ggmosaic)
#> Loading required package: ggplot2
data("fly")
ggplot(data = fly) +
  geom_mosaic(aes(x = product(rude_to_recline), fill=do_you_recline))

head(fly)
colnames(fly)
# install.packages("devtools")
devtools::install_github("haleyjeppson/ggmosaic")

library(ggmosaic)

dev.off()
mosaicplot(actn3.r577x~race*sex, famuss)

tab1 <- table(famuss$race, famuss$actn3.r577x)
tab1
addmargins(tab1)
addmargins(prop.table(tab1, margin = 1))
library(sjPlot)
sjplot(famuss,race,actn3.r577x)

table(famuss$race) / nrow(famuss)
sjPlot::plot_frq(famuss$race)


addmargins(table(famuss$race), margin = 1)
margin.table(famuss[["race"]])

old <- theme_set(theme_minimal(base_size = 16L))
theme_set(old)
theme_update(legend.position = "bottom")

sjPlot::set_theme(legend.pos = "bottom", base = theme_minimal_hgrid(font_size = 12))

sjPlot::plot_xtab(famuss$race, famuss$actn3.r577x)
sjPlot::plot_xtab(famuss$race, famuss$actn3.r577x, margin = "col", show.total = F)
addmargins(
  prop.table(tab1, margin = 2)
)
# quartet -----------------------------------------------------------------


library(datasets)
data("anscombe")

mydata=with(anscombe,data.frame(xVal=c(x1,x2,x3,x4), yVal=c(y1,y2,y3,y4), group=gl(4,nrow(anscombe))))
aggregate(.~mygroup,data=mydata,mean)
aggregate(.~mygroup,data=mydata,sd)
library(ggplot2)
ggplot(mydata,aes(x=xVal, y=yVal)) + geom_point() + facet_wrap(~mygroup)

dev.off()

##-- now some "magic" to do the 4 regressions in a loop:
ff <- y ~ x
mods <- setNames(as.list(1:4), paste0("lm", 1:4))
for(i in 1:4) {
  ff[2:3] <- lapply(paste0(c("y","x"), i), as.name)
  ## or   ff[[2]] <- as.name(paste0("y", i))
  ##      ff[[3]] <- as.name(paste0("x", i))
  mods[[i]] <- lmi <- lm(ff, data = anscombe)
  print(anova(lmi))
}

## See how close they are (numerically!)
sapply(mods, coef)
lapply(mods, function(fm) coef(summary(fm)))

library(magrittr)
summary(mods[[1]]) %>% names

lapply(mods, function(fm) summary(fm)$r.squared^0.5)

cor(anscombe$x1, anscombe$y1)

## Now, do what you should have done in the first place: PLOTS
op <- par(mfrow = c(2, 2), mar = 0.1+c(4,4,1,1), oma =  c(0, 0, 2, 0))
for(i in 1:4) {
  ff[2:3] <- lapply(paste0(c("y","x"), i), as.name)
  plot(ff, data = anscombe, col = "red", pch = 21, bg = "orange", cex = 1.2,
       xlim = c(3, 19), ylim = c(3, 13))
  abline(mods[[i]], col = "blue")
  text(15,4,sprintf("r = %0.2f",summary(mods[[i]])$r.squared^0.5))
}
mtext("Anscombe's 4 Regression data sets", outer = TRUE, cex = 1.5)
par(op)





# NHANES ------------------------------------------------------------------

library(openintro)
data(COL)
library(oibiostat)
data(nhanes.samp.adult.500)

dev.off()


library(openintro)
data(COL)
library(oibiostat)
data(nhanes.samp.adult.500)

plot(nhanes.samp.adult.500$Height,
     nhanes.samp.adult.500$Weight,
     pch = 19,
     cex = 1.3,
     col = COL[1, 3],
     xlab = "",
     ylab = "Weight (kg)")
points(nhanes.samp.adult.500$Height,
       nhanes.samp.adult.500$Weight,
       cex = 1.3,
       col = COL[1])
mtext("Height (cm)", 1, 1.9)

t1 <- nhanes.samp.adult.500$Height[480]
t2 <- nhanes.samp.adult.500$Weight[480]
lines(c(t1, t1), c(-10, t2),
      lty = 2,
      col = COL[4])
lines(c(-10, t1), c(t2, t2),
      lty = 2,
      col = COL[4])
points(t1, t2,
       pch = 19,
       cex = 1.3,
       col = COL[4, 3],)

data("nhanes.samp.adult.500")
nhanes.dat <- nhanes.samp.adult.500[,c("Height","Weight","BMI")]
nhanes.dat <- na.omit(nhanes.dat)
fit <- lm(Weight~Height, data = nhanes.dat)
lines(nhanes.dat$Height,
      fit$fitted.values,col="red")
text(190,50, sprintf("r = %0.2f",summary(fit)$r.squared^0.5))



plot(nhanes.samp.adult.500$Height,
     nhanes.samp.adult.500$BMI,
     pch = 19,
     cex = 1.3,
     col = COL[1, 3],
     xlab = "",
     ylab = "BMI")
points(nhanes.samp.adult.500$Height,
       nhanes.samp.adult.500$BMI,
       cex = 1.3,
       col = COL[1])
mtext("Height (cm)", 1, 1.9)

t1 <- nhanes.samp.adult.500$Height[480]
t2 <- nhanes.samp.adult.500$BMI[480]
lines(c(t1, t1), c(-10, t2),
      lty = 2,
      col = COL[4])
lines(c(-10, t1), c(t2, t2),
      lty = 2,
      col = COL[4])
points(t1, t2,
       pch = 19,
       cex = 1.3,
       col = COL[4, 3],)
fit <- lm(BMI~Height, data = nhanes.dat)
lines(nhanes.dat$Height,
      fit$fitted.values,col="red")
text(190,50, sprintf("r = %0.2f",summary(fit)$r.squared^0.5))

?nhanes.samp.adult.500

DataExplorer::create_report(nhanes.samp.adult.500, y = "AlcoholDay")

colnames(nhanes.samp.adult.500)

library(openintro)
library(oibiostat)
data("wdi.2011")
data(COL)

par(mfrow = c(1,2))
plot(wdi.2011$life.expect,
     wdi.2011$gdp.per.capita,
     pch = 19,
     cex = 1.3,
     col = COL[1, 3],
     xlab = "Life Expectancy (years)",
     ylab = "Per Capita Income (USD)",
     axes = FALSE)
fit1 <- lm(gdp.per.capita~life.expect, data = wdi.2011)
lines(wdi.2011$life.expect,
      fit1$fitted.values,col="red")
points(wdi.2011$life.expect,
       wdi.2011$gdp.per.capita,
       cex = 1.3,
       col = COL[1])
AxisInDollars(2, pretty(wdi.2011$gdp.per.capita))
axis(1)
text(55,1e5, sprintf("r = %0.2f",summary(fit1)$r.squared^0.5))


plot(wdi.2011$life.expect,
     log(wdi.2011$gdp.per.capita),
     pch = 19,
     cex = 1.3,
     col = COL[1, 3],
     xlab = "Life Expectancy (years)",
     ylab = "log(Per Capita Income (USD))",
     axes = FALSE)
fit2 <- lm(log(gdp.per.capita)~life.expect, data = wdi.2011)
lines(wdi.2011$life.expect,
      fit2$fitted.values,col="red")
AxisInDollars(2, pretty(log(wdi.2011$gdp.per.capita)))
axis(1)
text(55,11, sprintf("r = %0.2f",summary(fit2)$r.squared^0.5))

# nyt cases log scale -----------------------------------------------------


library(covdata) # remotes::install_github("kjhealy/covdata")
library(dplyr); library(tidyr); library(ggplot2); library(readr)

# get population data from https://covid19.census.gov/datasets/
pop_county <- read_csv("https://opendata.arcgis.com/datasets/21843f238cbb46b08615fc53e19e0daf_1.csv") %>%
  dplyr::rename(fips = GEOID, population = B01001_001E, state = State) %>%
  dplyr::select(state, fips, population)

county_level <- nytcovcounty %>%
  dplyr::left_join(pop_county, by = c("state","fips")) %>%
  dplyr::mutate(cases.per.10k = cases/population * 1e4) %>%
  dplyr::filter(state %in% c("Iowa","Illinois")) %>%
  dplyr::group_by(county)

pop_state <- pop_county %>%
  dplyr::group_by(state) %>%
  dplyr::summarise(population = sum(population, na.rm = TRUE))

state_level <- county_level %>%
  dplyr::group_by(state, date) %>%
  dplyr::filter(date >= "2020-03-15") %>%
  dplyr::summarise(cases = sum(cases)) %>%
  dplyr::left_join(pop_state, by = "state") %>%
  dplyr::mutate(cases.per.10k = cases / population * 1e4, state = factor(state),
                time = as.numeric(date - min(date)) + 1)


library(cowplot)
library(lubridate)
ggplot(data = state_level, mapping = aes(x = date, y = cases, color = state)) +
  geom_line(size = 1) +
  geom_smooth(method = "lm") +
  scale_x_date(date_breaks = "1 month", date_labels = "%b")+
  scale_y_continuous(labels = scales::label_number_si()) +
  labs(title = "COVID-19 Cases in Iowa and Illinois",
       subtitle = "Cases since March 15, 2020",
       x = "Date", y = "No. of cases") +
  theme_minimal() + coord_cartesian(xlim = c(ymd("2020-03-01"), ymd("2020-05-01")),
                                    ylim = c(0,100000))

state_level %>%
  filter(date <= ymd("2020-05-01")) %>%
ggplot(data = ., mapping = aes(x = date, y = cases, color = state)) +
  geom_line(size = 1) +
  geom_smooth(method = "lm") +
  scale_x_date(date_breaks = "1 month", date_labels = "%b")+
  scale_y_log10(labels = scales::label_number_si()) +
  labs(title = "COVID-19 Cases in Iowa and Illinois",
       subtitle = "Cases since March 15, 2020",
       x = "Date", y = "log(No. of cases)", caption = "Data: The New York Times") +
  theme_minimal() #+ coord_cartesian(xlim = c(ymd("2020-03-01"), ymd("2020-04-01")))

legend_b <- get_legend(
  p1 +
    guides(color = guide_legend(nrow = 1)) +
    theme(legend.position = "bottom")
)

prow <- plot_grid(
  p1 + theme(legend.position="none"),
  p2 + theme(legend.position="none"),
  align = 'vh',
  labels = c("A", "B"),
  hjust = -1,
  nrow = 1
)

plot_grid(prow, legend_b, ncol = 1, rel_heights = c(1, .1))





## Libraries for the graphs
library(ggrepel)

## Convenince "Not in" operator
"%nin%" <- function(x, y) {
  return( !(x %in% y) )
}


## Countries to highlight
focus_cn <- c("CHN", "DEU", "GBR", "CAN", "IRN", "JPN",
              "KOR", "ITA", "FRA", "ESP", "CHE", "TUR")

## Colors
cgroup_cols <- c("#195F90FF", "#D76500FF", "#238023FF", "#AB1F20FF", "#7747A3FF",
                 "#70453CFF", "#D73EA8FF", "#666666FF", "#96971BFF", "#1298A6FF", "#6F9BD6FF",
                 "#FF952DFF", "gray70")

covnat %>%
  filter(cu_cases > 99) %>%
  filter(iso3 %in% focus_cn) %>%
  mutate(days_elapsed = date - min(date)) %>%
  filter(days_elapsed <= 50) %>%
  mutate(end_label = ifelse(date == max(date), cname, NA),
         end_label = recode(end_label, `United States` = "USA",
                            `Iran, Islamic Republic of` = "Iran",
                            `Korea, Republic of` = "South Korea",
                            `United Kingdom` = "UK"),
         cname = recode(cname, `United States` = "USA",
                        `Iran, Islamic Republic of` = "Iran",
                        `Korea, Republic of` = "South Korea",
                        `United Kingdom` = "UK"),
         end_label = case_when(iso3 %in% focus_cn ~ end_label,
                               TRUE ~ NA_character_),
         cgroup = case_when(iso3 %in% focus_cn ~ iso3,
                            TRUE ~ "ZZOTHER")) %>%
  ggplot(mapping = aes(x = days_elapsed, y = cu_cases,
                       color = cgroup, label = end_label,
                       group = cname)) +
  geom_line(size = 0.5) +
  geom_text_repel(nudge_x = 0.75,
                  segment.color = NA) +
  guides(color = FALSE) +
  scale_color_manual(values = cgroup_cols) +
  scale_y_log10(labels = scales::label_number_si()) +
  # scale_y_continuous(labels = scales::comma_format(accuracy = 1),
  #                    breaks = 2^seq(4, 20, 1),
  #                    trans = "log2") +
  labs(x = "Days Since 100th Confirmed Case",
       y = "Cumulative Number of Reported Cases (log2 scale)",
       title = "Cumulative Reported Cases of COVID-19, Selected Countries",
       subtitle = paste("ECDC data as of", format(max(covnat$date), "%A, %B %e, %Y")),
       caption = "Kieran Healy @kjhealy / Data: https://www.ecdc.europa.eu/") +
  theme_minimal()


covnat %>%
  filter(cu_cases > 99) %>%
  filter(iso3 %in% focus_cn) %>%
  mutate(days_elapsed = date - min(date)) %>%
  filter(days_elapsed <= 50) %>%
  mutate(end_label = ifelse(date == max(date), cname, NA),
         end_label = recode(end_label, `United States` = "USA",
                            `Iran, Islamic Republic of` = "Iran",
                            `Korea, Republic of` = "South Korea",
                            `United Kingdom` = "UK"),
         cname = recode(cname, `United States` = "USA",
                        `Iran, Islamic Republic of` = "Iran",
                        `Korea, Republic of` = "South Korea",
                        `United Kingdom` = "UK"),
         end_label = case_when(iso3 %in% focus_cn ~ end_label,
                               TRUE ~ NA_character_),
         cgroup = case_when(iso3 %in% focus_cn ~ iso3,
                            TRUE ~ "ZZOTHER")) %>%
  ggplot(mapping = aes(x = days_elapsed, y = cu_cases,
                       color = cgroup, label = end_label,
                       group = cname)) +
  geom_line(size = 0.5) +
  geom_text_repel(nudge_x = 0.75,
                  segment.color = NA) +
  guides(color = FALSE) +
  scale_color_manual(values = cgroup_cols) +
  scale_y_continuous(labels = scales::label_number_si()) +
  # scale_y_continuous(labels = scales::comma_format(accuracy = 1),
  #                    breaks = 2^seq(4, 20, 1),
  #                    trans = "log2") +
  labs(x = "Days Since 100th Confirmed Case",
       y = "Cumulative Number of Reported Cases (log2 scale)",
       title = "Cumulative Reported Cases of COVID-19, Selected Countries",
       subtitle = paste("ECDC data as of", format(max(covnat$date), "%A, %B %e, %Y")),
       caption = "Kieran Healy @kjhealy / Data: https://www.ecdc.europa.eu/") +
  theme_minimal()


cor(famuss$actn3.r577x, famuss$ndrm.ch)
cor(as.numeric(famuss$actn3.r577x), famuss$ndrm.ch, method = "pearson")
cor(as.numeric(famuss$actn3.r577x), famuss$ndrm.ch, method = "kendall")
cor(as.numeric(famuss$actn3.r577x), famuss$ndrm.ch, method = "spearman")
# Golub -------------------------------------------------------------------

library(oibiostat)
data("golub")
golub %>% dim
golub[1:5,1:5]
heatmap(as.matrix(golub[,-(1:6)]))
library(pheatmap)
dat <- as.matrix(golub[,-(1:6)])
pheatmap(dat)


set.seed(12)
x <- runif(100,-1,1)
y <- x^2
plot(x,y, pch = 19)
cor(x,y)
