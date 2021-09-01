## ----setup, include=FALSE-----------------------------------------------------
library(knitr)
knitr::opts_chunk$set(cache=FALSE, message = FALSE, tidy = FALSE, warning = FALSE,
echo = FALSE, 
#fig.width = 8, 
#fig.asp = 0.8, 
fig.align = 'center', 
#out.width = "100%", 
size = 'tiny')

# the kframe environment does not work with allowframebreaks, so remove it
#knit_hooks$set(document = function(x) {
#gsub('\\\\(begin|end)\\{kframe\\}', '', x)
#})

library(tidyverse)
library(NCStats)

library(oibiostat)
data(famuss) 

#knitr::opts_chunk$set(background = '#FFFF00')
library(tools) #needed for include_graphics2 function
pacman::p_load(here)
source(here::here("inst","slides","bin","include_graphics2.R"))
knitr::knit_hooks$set(purl = hook_purl)

## ----echo=TRUE, size = 'scriptsize'-------------------------------------------
# devtools::install_github("OI-Biostat/oi_biostat_data")
library(oibiostat)
data(famuss)
famuss %>% 
  dplyr::glimpse()	

## ----mean-famus, echo = TRUE, size = 'scriptsize'-----------------------------
mean(famuss$weight)

## ----median-famus, echo = TRUE, size = 'scriptsize'---------------------------
median(famuss$weight)
quantile(famuss$weight, probs = 0.50) 

## ----sd-famus, echo = TRUE, size = 'scriptsize'-------------------------------
sd(famuss$weight)

## ----iqr-famus, echo = TRUE, size = 'scriptsize'------------------------------
IQR(famuss$weight)
diff(quantile(famuss$weight, probs = c(0.25, 0.75)))

## ----hist_weight-1, echo=TRUE, size = 'scriptsize', out.width = "0.6\\linewidth"----
hist(famuss$weight, breaks = 30, col = 'lightblue')
abline(v = mean(famuss$weight), lwd = 3, col = "red")
abline(v = median(famuss$weight), lwd = 3, col = "blue")
legend("topright", legend = c("mean","median"), col = c("red","blue"), lwd = 3)

## ----hist_weight-2, echo=TRUE, size = 'scriptsize', out.width = "0.6\\linewidth"----
hist(famuss$weight, breaks = 5, col = 'lightblue')
abline(v = mean(famuss$weight), lwd = 3, col = "red")
abline(v = median(famuss$weight), lwd = 3, col = "blue")
legend("topright", legend = c("mean","median"), col = c("red","blue"), lwd = 3)

## ----hist_weight-3, echo=TRUE, size = 'scriptsize', out.width = "0.6\\linewidth"----
hist(famuss$weight, breaks = 30, col = 'lightblue', probability = TRUE)
openintro::densityPlot(famuss$weight, add = TRUE, lwd = 5)
abline(v = mean(famuss$weight), lwd = 3, col = "red")
abline(v = median(famuss$weight), lwd = 3, col = "blue")
legend("topright", legend = c("mean","median","density"), 
       col = c("red","blue","black"), lwd = 3)

## ----boxplot, echo = FALSE, out.width = "0.85\\linewidth"---------------------
pacman::p_load(openintro)
d <- famuss$weight

# myPDF("frogBoxPlot.pdf", 6.1, 4,
#       mar = c(0, 4, 0, 1),
#       mgp = c(2.8, 0.7, 0))
boxPlot(d,
ylab = 'weight (pounds)',
xlim = c(0.3, 3),
axes = FALSE,
ylim = range(d))
axis(2)

df <- boxplot(d, plot = FALSE)

arrows(2, df$stats[1], 1.4, df$stats[1], length = 0.08)
text(2, df$stats[1], 'lower whisker', pos = 4)


arrows(2, df$stats[2], 1.4, df$stats[2], length = 0.08)
text(2, df$stats[2],
expression(Q[1]~~'(first quartile)'), pos = 4)

arrows(2, df$stats[3], 1.4, df$stats[3], length = 0.08)
text(2, df$stats[3], 'median', pos = 4)

arrows(2, df$stats[4], 1.4, df$stats[4], length = 0.08)
text(2, df$stats[4],
expression(Q[3]~~'(third quartile)'), pos = 4)

arrows(2, df$stats[5],
1.4, df$stats[5], length = 0.08)
text(2, df$stats[5],
'upper whisker', pos = 4)

# outliers midpoint
midpoint <- median(df$out)
for(i in df$out) {
arrows(2, midpoint, 1.1, i - 0.2, length = 0.08)
}

text(2, midpoint, 'outliers', pos = 4)

points(rep(0.4, length(d[d<=df$stats[3]])), d[d<=df$stats[3]],
cex = 1.3,
col = COL[1, 3],
pch = 1)
points(rep(0.4, length(d[d>df$stats[3]])), d[d>df$stats[3]],
cex = 1,
col = COL[4,3],
pch = "-")

## ----echo = TRUE, size = 'scriptsize', out.width = "0.45\\linewidth", fig.subcap = c('Boxplot for weight', 'Violin plot for weight')----
p1 <- ggplot(data = famuss, mapping = aes(x = "all", y = weight)) + theme_minimal()
p1 + geom_boxplot()
p1 + geom_violin()

## ----table-1, echo=TRUE, size = 'scriptsize', out.width="0.5\\linewidth"------
table(famuss$actn3.r577x)

## ----table-2, echo=TRUE, size = 'scriptsize', out.width="0.45\\linewidth", fig.subcap=c('base \\texttt{graphics} package', '\\texttt{sjPlot} package')----
graphics::barplot(table(famuss$actn3.r577x))
sjPlot::plot_frq(famuss$actn3.r577x)

## ----numerical, echo=TRUE, size = 'scriptsize', out.width="0.45\\linewidth", fig.subcap=c('base \\texttt{graphics} package', '\\texttt{ggplot2} package')----
plot(famuss$height, famuss$weight,
     xlab = "Height (in)", ylab = "Weight (lb)", cex = 0.8)

ggplot(data = famuss, mapping = aes(x = height, y = weight)) + 
   geom_point(size = 0.8, pch = 21)


## ----cor, echo=TRUE, size = 'tiny'--------------------------------------------
cor(famuss$height, famuss$weight)
summary(lm(height ~ weight, data = famuss))

## ----contt, echo=TRUE, size = 'scriptsize'------------------------------------
addmargins(table(famuss$race, famuss$actn3.r577x))

## ----cont1, echo=TRUE, size = 'scriptsize'------------------------------------
#row proportions
addmargins(prop.table(table(famuss$race, famuss$actn3.r577x), 1))

## ----cont2, echo=TRUE, size = 'scriptsize'------------------------------------
#column proportions
addmargins(prop.table(table(famuss$race, famuss$actn3.r577x), 2))

## ----box-1, echo=TRUE, size = 'scriptsize'------------------------------------
boxplot(famuss$ndrm.ch ~ famuss$actn3.r577x)

## ----oxforrr, echo = TRUE, size = 'tiny'--------------------------------------
path <- 
  "http://www.biostat.mcgill.ca/hanley/statbook/immunogenicityChAdOx1.nCoV-19vaccine.txt"
ds <- read.table(path)
head(ds)
str(ds)
levels(ds$RefIndexCategory)

## ----echo=TRUE, out.width="0.6\\linewidth"------------------------------------
natural <- ds[ds$RefIndexCategory=="Convalescent",]
hist(natural$IgGResponse.log10.ElisaUnits,
     breaks = 20, col = "lightblue")

## ----echo=TRUE, out.width="99%", size = "tiny"--------------------------------
summary(natural$IgGResponse.log10.ElisaUnits)
boxplot(natural$IgGResponse.log10.ElisaUnits,
        col = "lightblue",
        ylab = "Immunoglobulin G (IgG) response")
grid(lty = "dashed")

## ----echo=c(1,2,3,5), eval = c(1,2,3,5), size = "tiny"------------------------
t.test(natural$IgGResponse.log10.ElisaUnits)
fit1 <- glm(IgGResponse.log10.ElisaUnits ~ 1, data = natural)
summary(fit1)
print(summary(fit1), signif.stars = F)
confint(fit1)

## ----echo=TRUE, fig.cap = '', fig.subcap=c('Violin plot', 'Boxplot'), out.width="0.5\\linewidth", tidy = TRUE----
p1 <- ggplot(data = ds, 
             mapping = aes(x = RefIndexCategory, y = IgGResponse.log10.ElisaUnits, fill = RefIndexCategory)) + 
             geom_jitter(alpha = 0.3) + 
             theme_minimal() + 
             theme(legend.position = "none")
p1 + geom_violin() 
p1 + geom_boxplot() 

## ----echo=TRUE,size='tiny'----------------------------------------------------
by(ds$IgGResponse.log10.ElisaUnits,ds$RefIndexCategory,summary)

## ----echo=TRUE----------------------------------------------------------------
t.test(IgGResponse.log10.ElisaUnits ~ RefIndexCategory, data = ds)

## ----echo=TRUE,size='tiny'----------------------------------------------------
fit2 <- glm(IgGResponse.log10.ElisaUnits ~ RefIndexCategory, data = ds) 
print(summary(fit2), signif.star = FALSE)
confint(fit2)

## ----echo=TRUE, size = 'tiny', fig.cap = 'The red line is the fitted regression from the previous slide.', out.width = "0.5\\linewidth"----
plot(ds$RefIndexCategory, ds$IgGResponse.log10.ElisaUnits, pch=19, cex=0.5)
abline(h = seq(0,4,0.5),col = "lightblue")
lines(ds$RefIndexCategory, fit2$fitted.values, col = "red", lwd = 3)

## ----masks, eval=TRUE, out.width = "100%"-------------------------------------
include_graphics2("http://www.biostat.mcgill.ca/hanley/statbook/IowaIllinoisBorderFig1.png")

## ----nyt, echo = TRUE, out.width = "100%", echo = TRUE------------------------
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
head(state_level) 

## ----nytcases, echo = TRUE, fig.asp = 0.481-----------------------------------
ggplot(data = county_level, mapping = aes(x = date, y = cases, group = county)) +
  geom_line(size = 0.25, color = "gray20") +
  scale_x_date(date_breaks = "1 month", date_labels = "%b")+
  scale_y_log10(labels = scales::label_number_si()) +
  guides(color = FALSE) + facet_wrap(~ state, ncol = 2) +
  labs(title = "COVID-19 Cases in Iowa and Illinois by County",
       x = "Date", y = "No. of cases (log10 scale)", caption = "Data: The New York Times") + 
  theme_minimal()

## ----nytcapita, echo = TRUE, fig.asp = 0.481----------------------------------
ggplot(data = county_level, mapping = aes(x = date, y = cases.per.10k, group = county)) +
  geom_line(size = 0.25, color = "gray20") +
  scale_x_date(date_breaks = "1 month", date_labels = "%b")+
  scale_y_continuous(labels = scales::label_number_si()) +
  guides(color = FALSE) + facet_wrap(~ state, ncol = 2) +
  labs(title = "COVID-19 Cases in Iowa and Illinois by County",
       x = "Date", y = "No. of cases per 10 000", caption = "Data: The New York Times") + 
  theme_minimal()

## ----nytcapitastate, echo = TRUE, fig.asp = 0.481-----------------------------
ggplot(data = state_level, mapping = aes(x = date, y = cases.per.10k, color = state)) +
  geom_line(size = 1) +
  scale_x_date(date_breaks = "1 month", date_labels = "%b")+
  scale_y_continuous(labels = scales::label_number_si()) +
  labs(title = "COVID-19 Cases in Iowa and Illinois",
       subtitle = "Cases since March 15, 2020",
       x = "Date", y = "No. of cases per 10 000", caption = "Data: The New York Times") + 
  theme_minimal()

## ----nytcapitastatemodel, echo = TRUE, fig.asp = 0.481------------------------
fit3 <- glm(cases.per.10k ~ state*time, data = state_level)
summary(fit3)

## ----nytcapitastatemodel2, echo = TRUE, fig.asp = 0.481-----------------------
library(ggeffects)
ggeffects::ggpredict(fit3, terms = "state") %>% 
  plot()

## ----echo=FALSE, comment = NA, size = 'tiny'----------------------------------
print(sessionInfo(), locale = FALSE)

