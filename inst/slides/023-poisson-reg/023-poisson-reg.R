## ----setup-slides, echo=FALSE, warning=FALSE, message=FALSE, eval=TRUE--------
knitr::opts_chunk$set(cache=FALSE, message = FALSE, tidy = FALSE, warning = FALSE,
                      echo = FALSE,
                      #fig.width = 8,
                      #fig.asp = 0.8,
                      fig.align = 'center',
                      #out.width = "0.50\\linewidth",
                      size = 'tiny')

# the kframe environment does not work with allowframebreaks, so remove it
#knit_hooks$set(document = function(x) {
#gsub('\\\\(begin|end)\\{kframe\\}', '', x)
#})

library(tidyverse)
library(NCStats)
#options(digits = )


#knitr::opts_chunk$set(background = '#FFFF00')
library(tools) #needed for include_graphics2 function

pacman::p_load(here)

source(here::here("inst","slides","bin","include_graphics2.R"))

knitr::knit_hooks$set(purl = hook_purl)

pacman::p_load(
  gapminder,
  here,
  socviz,
  tidyverse,
  kableExtra,
  mosaic,
  DT
)

theme_set(cowplot::theme_cowplot())

## ----eval=TRUE, echo=4:5------------------------------------------------------
cases <- c(514230, 140312)
PT <- c(151690, 37922)
not_breastfed <- c(0, 1)
fit <- glm(cases ~ -1 + PT + PT:not_breastfed, family = poisson(link = identity))
print(summary(fit), signif.stars = F)

## ----eval=TRUE----------------------------------------------------------------
fit <- glm(cases ~ not_breastfed + offset(log(PT)), family = poisson(link = log))
print(summary(fit), signif.stars = F)

## ----eval=TRUE, echo=FALSE----------------------------------------------------
df <- data.frame(month = rep(c(paste0(c("june","july","august","september","october",
"november","december"),"2014"),
paste0(c("may"),"2015"),
paste0(c("june","july","august","september","october",
"november","december"),"2015")
), 
each = 2),
exposure = rep(c(0,1), 15),
years = c(79,0,123,0,103,23,79,39,81,63,78,81,80,84,
89,82,
59,77,54,99,29,123,0,139,0,166,0,185,0,189),
cases = c(33,0,454,0,244,43,177,66,212,155,193,170,111,92,
15,14,42,50,146,223,64,266,0,271,0,337,0,304,0,56)
)

df <- df[-which(df$years==0),]

## ----echo=FALSE, eval=TRUE----------------------------------------------------
fit <- glm(cases ~ exposure + offset(log(years)), 
data = df, family = poisson(link = log))
print(summary(fit), signif.stars = F, show.call=TRUE)

## -----------------------------------------------------------------------------
library(dplyr)
library(tidyr)

pt <- read.table("~/git_repositories/epib607/inst/slides/023-poisson-reg/denmark_person_time.txt", skip = 1, 
header = TRUE)
pt$type <- "PT"
deaths <- read.table("~/git_repositories/epib607/inst/slides/023-poisson-reg/denmark_deaths.txt", skip = 1, 
header = TRUE)
deaths$type <- "deaths"
df <- rbind(pt, deaths)

tt <- df %>% 
gather(key = "group", value = "value", -Year, -Age, -type) %>% 
spread(type, value) %>% 
mutate(rate = deaths / PT) %>% 
gather(key = "measure", value = "value", -Year, -Age, -group) %>% 
unite(col = "measure", group, measure) %>% 
spread(measure, value) 


# head(tt)
# str(tt)
# levels(tt$Year)
# levels(tt$Age)
knitr::kable(tt[which(tt$Year %in% c("1980-1984","2000-2004", "2005-2009") & 
tt$Age %in% c("70-74", "75-79", "80-84", "85-89")),c("Year", "Age", "Female_deaths", "Female_PT", "Female_rate", 
"Male_deaths", "Male_PT", "Male_rate")], row.names = FALSE)

## ----echo=FALSE, comment = NA, size = 'tiny'----------------------------------
print(sessionInfo(), locale = FALSE)

