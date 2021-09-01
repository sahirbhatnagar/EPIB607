## ----setup, include=FALSE, message = FALSE, tidy = FALSE, warning = FALSE-----
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
if (!requireNamespace("pacman")) install.packages("pacman")
pacman::p_load(tidyverse)
library(NCStats)

#knitr::opts_chunk$set(background = '#FFFF00')
library(tools) #needed for include_graphics2 function
pacman::p_load(here)
source(here::here("inst","slides","bin","include_graphics2.R"))
knitr::knit_hooks$set(purl = hook_purl)

## ----named-chunk, eval=TRUE, out.width = "75%"--------------------------------
include_graphics2("http://www.biostat.mcgill.ca/hanley/statbook/OxfordCovidVaccine.png")

## ----oxforrr, echo = TRUE, size = 'tiny'--------------------------------------
path <- 
  "http://www.biostat.mcgill.ca/hanley/statbook/immunogenicityChAdOx1.nCoV-19vaccine.txt"
ds <- read.table(path)
ds$RefIndexCategory <- factor(ds$RefIndexCategory)
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
base::by(ds$IgGResponse.log10.ElisaUnits,ds$RefIndexCategory,summary)

## ----echo=TRUE----------------------------------------------------------------
stats::t.test(IgGResponse.log10.ElisaUnits ~ RefIndexCategory, data = ds)

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
                dplyr::group_by(county) %>%
                dplyr::filter(date >= "2020-03-15") %>%
                dplyr::filter(date <= "2020-09-01")

pop_state <- pop_county %>% 
             dplyr::group_by(state) %>% 
             dplyr::summarise(population = sum(population, na.rm = TRUE))
             
state_level <- county_level %>%
               dplyr::group_by(state, date) %>%
               dplyr::filter(date >= "2020-03-15") %>% 
               dplyr::filter(date <= "2020-09-01") %>%
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
pacman::p_load(ggeffects)
ggeffects::ggpredict(fit3, terms = "state") %>% 
  plot()

## ----echo=FALSE, comment = NA, size = 'tiny'----------------------------------
print(sessionInfo(), locale = FALSE)

