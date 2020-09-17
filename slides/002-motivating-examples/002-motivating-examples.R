library(covdata)
library(dplyr)
library(tidyr)
library(ggplot2)
library(readr)

pop_county <- read_csv("https://opendata.arcgis.com/datasets/21843f238cbb46b08615fc53e19e0daf_1.csv") %>%
  dplyr::rename(fips = GEOID, population = B01001_001E, state = State) %>%
  dplyr::select(state, fips, population)

county_level <- nytcovcounty %>%
  dplyr::left_join(pop_county, by = c("state","fips")) %>%
  dplyr::mutate(cases.per.10k = cases / population * 1e4) %>%
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

ggplot(data = state_level, mapping = aes(x = date, y = cases.per.10k, color = state)) +
  geom_line(size = 1) +
  scale_x_date(date_breaks = "1 month", date_labels = "%b")+
  scale_y_continuous(labels = scales::label_number_si()) +
  labs(title = "COVID-19 Cases in Iowa and Illinois",
       x = "Date", y = "No. of cases per 10 000", caption = "Data: The New York Times") + theme_minimal()


fit3 <- glm(cases.per.10k ~ state*time, data = state_level)
summary(fit3)

library(sjPlot)
sjPlot::plot_model(fit3)
library(visreg)
visreg(fit3,
       xvar = "time",
       by = "state")

library(ggeffects)

ggeffects::ggpredict(fit3, terms = "state") %>%
  plot()

ggeffects:::plot.ggeffects()

ggplot(data = county_level, mapping = aes(x = date, y = cases, group = county)) +
  geom_line(size = 0.25, color = "gray20") +
  scale_x_date(date_breaks = "1 month", date_labels = "%b")+
  scale_y_log10(labels = scales::label_number_si()) +
  guides(color = FALSE) +
  facet_wrap(~ state, ncol = 2) +
  labs(title = "COVID-19 Cases in Iowa and Illinois by counties",
       x = "Date", y = "No. of cases (log10 scale)",
       caption = "Data: The New York Times") +
  theme_minimal()



ggplot(data = county_level, mapping = aes(x = date, y = cases.per.10k, group = county)) +
  geom_line(size = 0.25, color = "gray20") +
  scale_x_date(date_breaks = "1 month", date_labels = "%b")+
  scale_y_log10(labels = scales::label_number_si()) +
  guides(color = FALSE) +
  facet_wrap(~ state, ncol = 2) +
  labs(title = "COVID-19 Cases per 10 000 Residents in Iowa and Illinois by counties",
       x = "Date", y = "No. of cases per 10 000",
       caption = "Data: The New York Times") +
  theme_minimal()


















nytcovcounty %>%
  left_join(pop, by = "fips") %>%
  mutate(cases.per.10k = cases/population * 1e4) %>%
  dplyr::filter(state %in% c("Iowa","Illinois")) %>%
  dplyr::group_by(county) %>%
  ggplot(aes(x = date, y = cases.per.10k, group = county)) +
  geom_line(size = 0.25, color = "gray20") +
  scale_x_date(date_breaks = "1 month", date_labels = "%b")+
  scale_y_log10(labels = scales::label_number_si()) +
  guides(color = FALSE) +
  facet_wrap(~ state, ncol = 2) +
  labs(title = "COVID-19 Cases per 10 000 Residents in Iowa and Illinois by counties",
       x = "Date", y = "No. of cases per 10 000",
       caption = "Data: The New York Times") +
  theme_minimal()



