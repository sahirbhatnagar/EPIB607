# data taken from human mortality database
# user: james.hanley@mcgill.ca
# pw: c634
library(dplyr)
library(tidyr)

pt <- read.table("~/git_repositories/epib607/slides/regression/handouts/denmark_person_time.txt", skip = 1, 
                 header = TRUE)
pt$type <- "PT"
str(pt)
head(pt)
deaths <- read.table("~/git_repositories/epib607/slides/regression/handouts/denmark_deaths.txt", skip = 1, 
                     header = TRUE)
deaths$type <- "deaths"
head(deaths)
str(deaths)
df <- rbind(pt, deaths)
head(df)

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

dput(colnames(tt))

head(df)
df[which(df$Year=="1980-1984" & df$group == "Female" & df$Age == "70-74"),]
df[which(df$Year=="1980-1984" & df$group == "Male" & df$Age == "70-74"),]
tail(df)

df[which(df$Year %in% c("1980-1984","2000-2004", "2005-2009") & df$group %in% c("Female","Male") & 
           df$Age %in% c("70-74","75-79","80-84","85-89")),] %>% 
  spread(group, deaths)

