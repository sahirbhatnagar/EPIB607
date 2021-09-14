## ----setup, include=FALSE-----------------------------------------------------
library(knitr)
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
options(digits = 2)


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
DT
)

theme_set(cowplot::theme_cowplot())

## ----echo=TRUE, size = 'tiny'-------------------------------------------------
library(gapminder)
gapminder::gapminder %>% 
  dplyr::select(country, year, lifeExp) %>% 
  tidyr::pivot_wider(names_from = "year", values_from = "lifeExp") %>% 
  dplyr::slice_head(n = 10) %>% 
  knitr::kable(caption = "Life Expectancy data from gapminder dataset for 
  the first 10 countries.", digits = 0, booktabs=TRUE)

## ----echo=TRUE, size = 'tiny'-------------------------------------------------
gapminder::gapminder %>% 
  	dplyr::select(country, year, lifeExp) %>% 
	dplyr::filter(country %in% c("Afghanistan","Albania")) %>%
	knitr::kable(caption = "gapminder dataset for Afghanistan and Albania", digits = 0, booktabs=TRUE)

## ----echo=TRUE, size = 'normalsize'-------------------------------------------
library(ggplot2)
library(cowplot) 
ggplot2::theme_set(cowplot::theme_cowplot())
p <- ggplot(data = gapminder)

## ----echo=TRUE, size = 'normalsize'-------------------------------------------
p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
			  y = lifeExp))

## ----echo=TRUE,  fig.asp=0.681------------------------------------------------
p

## ----echo=TRUE, fig.asp=0.681-------------------------------------------------
p + geom_point()

## ----echo=TRUE, fig.asp=0.681, message=TRUE-----------------------------------
p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y=lifeExp))
p + geom_smooth()

## ----echo=TRUE, fig.asp=0.681, message=TRUE-----------------------------------
p <- ggplot(data = gapminder,
mapping = aes(x = gdpPercap,
y=lifeExp))
p + geom_point() + geom_smooth(method = "lm") 

## ----echo=TRUE, fig.asp=0.681, message=TRUE-----------------------------------
p <- ggplot(data = gapminder,
	mapping = aes(x = gdpPercap,
		y=lifeExp))
p + geom_point() +
	geom_smooth(method = "gam") +
	scale_x_log10()

## ----echo=TRUE, fig.asp=0.651-------------------------------------------------
library(scales)
p <- ggplot(data = gapminder, mapping = aes(x = gdpPercap, y=lifeExp))
p + geom_point() +
	geom_smooth(method = "gam") +
	scale_x_log10(labels = scales::dollar)

## ----echo=TRUE, fig.asp=0.651, size='normalsize'------------------------------
p <-  ggplot(data = gapminder,
		mapping = aes(x = gdpPercap,
				y = lifeExp,
				color = continent))

## ----echo=TRUE, fig.asp=0.621-------------------------------------------------
p <- ggplot(data = gapminder,
			mapping = aes(x = gdpPercap,
			y = lifeExp,
			color = "purple"))
p + geom_point() +
	geom_smooth(method = "loess") +
	scale_x_log10()

## ----echo=TRUE, fig.asp=0.621-------------------------------------------------
p <- ggplot(data = gapminder,
			mapping = aes(x = gdpPercap,
					y = lifeExp))
p + geom_point(color = "purple") +
	geom_smooth(method = "loess") +
	scale_x_log10()

## ----echo=TRUE, fig.asp=0.601-------------------------------------------------
p <- ggplot(data = gapminder,
		mapping = aes(x = gdpPercap,
					y = lifeExp)) 
p + geom_point(alpha = 0.3) +
geom_smooth(color = "orange", se = FALSE, size = 8, method = "lm") +
scale_x_log10()

## ----echo=TRUE, fig.asp=0.501-------------------------------------------------
p <- ggplot(data = gapminder, mapping = aes(x = gdpPercap, y=lifeExp))
p + geom_point(alpha = 0.3) + geom_smooth(method = "gam") +
    scale_x_log10(labels = scales::dollar) +
    ggthemes::theme_stata() + 
    labs(x = "GDP Per Capita", y = "Life Expectancy in Years",
	title = "Economic Growth and Life Expectancy",
	subtitle = "Data points are country-years",
	caption = "Source: Gapminder.")

## ----echo=TRUE, fig.asp=0.621-------------------------------------------------
p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
            y = lifeExp,
            color = continent))
p + geom_point() +
	geom_smooth(method = "loess") +
	scale_x_log10()

## ----echo=TRUE, fig.asp=0.501-------------------------------------------------
p <- ggplot(data = gapminder,
		mapping = aes(x = gdpPercap,
		y = lifeExp,
		color = continent,
		fill = continent))
p + geom_point() +
geom_smooth(method = "loess") +
scale_x_log10()

## ----echo=TRUE, fig.asp=0.521-------------------------------------------------
p <- ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp))
p + geom_point(mapping = aes(color = continent)) +
	geom_smooth(method = "loess") +
	scale_x_log10()

## ----echo=TRUE, fig.asp=0.651-------------------------------------------------
p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y = lifeExp))
p + geom_point(mapping = aes(color = log(pop))) +
                 scale_x_log10()    

## ----echo=FALSE, comment = NA, size = 'tiny'----------------------------------
print(sessionInfo(), locale = FALSE)

