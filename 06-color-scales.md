---
output: html_document
editor_options: 
  chunk_output_type: console
---

# Color scales {#color-basics}

::: {.rmdnote}
This section is reproduced from the book Fundamentals of Data Visualization [@wilke]
:::


**Packages used in this Section**


```r
pacman::p_load(
  cowplot,
  colorspace,
  colorblindr, # devtools::install_github("clauswilke/colorblindr")
  dviz.supp, # devtools::install_github("clauswilke/dviz.supp")
  forcats,
  patchwork,
  lubridate,
  tidyr, 
  ggplot2,
  sf
)
```




There are three fundamental use cases for color in data visualizations: (i) we can use color to distinguish groups of data from each other; (ii) we can use color to represent data values; and (iii) we can use color to highlight. The types of colors we use and the way in which we use them are quite different for these three cases.


## Color as a tool to distinguish

We frequently use color as a means to distinguish discrete items or groups that do not have an intrinsic order, such as different countries on a map or different manufacturers of a certain product. In this case, we use a *qualitative* color scale. Such a scale contains a finite set of specific colors that are chosen to look clearly distinct from each other while also being equivalent to each other. The second condition requires that no one color should stand out relative to the others. And, the colors should not create the impression of an order, as would be the case with a sequence of colors that get successively lighter. Such colors would create an apparent order among the items being colored, which by definition have no order. 

Many appropriate qualitative color scales are readily available. Figure \@ref(fig:qualitative-scales) shows three representative examples. In particular, the ColorBrewer project provides a nice selection of qualitative color scales, including both fairly light and fairly dark colors [@ColorBrewer]. 

(ref:qualitative-scales) Example qualitative color scales. The Okabe Ito scale is the default scale used throughout this book [@Okabe-Ito-CUD]. The ColorBrewer Dark2 scale is provided by the ColorBrewer project [@ColorBrewer]. The ggplot2 hue scale is the default qualitative scale in the widely used plotting software ggplot2.

<div class="figure">
<img src="06-color-scales_files/figure-html/qualitative-scales-1.png" alt="(ref:qualitative-scales)" width="685.714285714286" />
<p class="caption">(\#fig:qualitative-scales)(ref:qualitative-scales)</p>
</div>

As an example of how we use qualitative color scales, consider Figure \@ref(fig:popgrowth-US). It shows the percent population growth from 2000 to 2010 in U.S. states. I have arranged the states in order of their population growth, and I have colored them by geographic region. This coloring highlights that states in the same regions have experienced similar population growth. In particular, states in the West and the South have seen the largest population increases whereas states in the Midwest and the Northeast have grown much less.

(ref:popgrowth-US) Population growth in the U.S. from 2000 to 2010. States in the West and South have seen the largest increases, whereas states in the Midwest and Northeast have seen much smaller increases or even, in the case of Michigan, a decrease. Data source: U.S. Census Bureau


```r

data("US_census") # from dviz.supp package
data("US_regions") # from dviz.supp package

popgrowth_df <- left_join(US_census, US_regions) %>%
    group_by(region, division, state) %>%
    summarize(pop2000 = sum(pop2000, na.rm = TRUE),
              pop2010 = sum(pop2010, na.rm = TRUE),
              popgrowth = (pop2010-pop2000)/pop2000,
              area = sum(area)) %>%
    arrange(popgrowth) %>%
    ungroup() %>%
    mutate(state = factor(state, levels = state),
           region = factor(region, levels = c("West", "South", "Midwest", "Northeast")))

# make color vector in order of the state
region_colors <- c("#E69F00", "#56B4E9", "#009E73", "#F0E442")
region_colors_dark <- darken(region_colors, 0.4)
state_colors <- region_colors_dark[as.numeric(popgrowth_df$region[order(popgrowth_df$state)])]

ggplot(popgrowth_df, aes(x = state, y = 100*popgrowth, fill = region)) + 
  geom_col() + 
  scale_y_continuous(
    limits = c(-.6, 37.5), expand = c(0, 0),
    labels = scales::percent_format(accuracy = 1, scale = 1),
    name = "population growth, 2000 to 2010"
  ) +
  scale_fill_manual(values = region_colors) +
  coord_flip() + 
  theme_dviz_vgrid_2(12, rel_small = 1) +
  theme(axis.title.y = element_blank(),
        axis.line.y = element_blank(),
        axis.ticks.length = unit(0, "pt"),
        axis.text.y = element_text(size = 10, color = state_colors),
        legend.position = c(.56, .68),
        legend.background = element_rect(fill = "#ffffffb0"))
```

<div class="figure">
<img src="06-color-scales_files/figure-html/popgrowth-US-1.png" alt="(ref:popgrowth-US)" width="576" />
<p class="caption">(\#fig:popgrowth-US)(ref:popgrowth-US)</p>
</div>



## Color to represent data values

Color can also be used to represent data values, such as income, temperature, or speed. In this case, we use a *sequential* color scale. Such a scale contains a sequence of colors that clearly indicate (i) which values are larger or smaller than which other ones and (ii) how distant two specific values are from each other. The second point implies that the color scale needs to be perceived to vary uniformly across its entire range.

Sequential scales can be based on a single hue (e.g., from dark blue to light blue) or on multiple hues (e.g., from dark red to light yellow) (Figure \@ref(fig:sequential-scales)). Multi-hue scales tend to follow color gradients that can be seen in the natural world, such as dark red, green, or blue to light yellow, or dark purple to light green. The reverse, e.g. dark yellow to light blue, looks unnatural and doesn't make a useful sequential scale.

(ref:sequential-scales) Example sequential color scales. The ColorBrewer Blues scale is a monochromatic scale that varies from dark to light blue. The Heat and Viridis scales are multi-hue scales that vary from dark red to light yellow and from dark blue via green to light yellow, respectively. 

<div class="figure">
<img src="06-color-scales_files/figure-html/sequential-scales-1.png" alt="(ref:sequential-scales)" width="685.714285714286" />
<p class="caption">(\#fig:sequential-scales)(ref:sequential-scales)</p>
</div>

Representing data values as colors is particularly useful when we want to show how the data values vary across geographic regions. In this case, we can draw a map of the geographic regions and color them by the data values. Such maps are called *choropleths*. Figure \@ref(fig:map-Texas-income) shows an example where I have mapped annual median income within each county in Texas onto a map of those counties. 

(ref:map-Texas-income) Median annual income in Texas counties. The highest median incomes are seen in major Texas metropolitan areas, in particular near Houston and Dallas. No median income estimate is available for Loving County in West Texas and therefore that county is shown in gray. Data source: 2015 Five-Year American Community Survey



```r
# B19013_001: Median household income in the past 12 months (in 2015 Inflation-adjusted dollars)

# EPSG:3083
# NAD83 / Texas Centric Albers Equal Area
# http://spatialreference.org/ref/epsg/3083/
texas_crs <- "+proj=aea +lat_1=27.5 +lat_2=35 +lat_0=18 +lon_0=-100 +x_0=1500000 +y_0=6000000 +ellps=GRS80 +datum=NAD83 +units=m +no_defs"

# -110, -93.5 transformed using texas_crs
texas_xlim <- c(558298.7, 2112587)

data("texas_income") # from dviz.supp package

texas_income %>% st_transform(crs = texas_crs) %>%
  ggplot(aes(fill = estimate)) + 
  geom_sf(color = "white") + 
  coord_sf(xlim = texas_xlim, datum = NA) +
  theme_dviz_map_2() + 
  scale_fill_distiller(
    palette = "Blues", type = 'seq', na.value = "grey60", direction = 1,
    name = "annual median income (USD)",
    limits = c(18000, 90000),
    breaks = 20000*c(1:4),
    labels = c("$20,000", "$40,000", "$60,000", "$80,000"),
    guide = guide_colorbar(
      direction = "horizontal",
      label.position = "bottom",
      title.position = "top",
      ticks = FALSE,
      barwidth = grid::unit(3.0, "in"),
      barheight = grid::unit(0.2, "in")
    )
  ) +
  theme(
    legend.title.align = 0.5,
    legend.text.align = 0.5,
    legend.justification = c(0, 0),
    legend.position = c(0.02, 0.1)
  )
```

<div class="figure">
<img src="06-color-scales_files/figure-html/map-Texas-income-1.png" alt="(ref:map-Texas-income)" width="576" />
<p class="caption">(\#fig:map-Texas-income)(ref:map-Texas-income)</p>
</div>

In some cases, we need to visualize the deviation of data values in one of two directions relative to a neutral midpoint. One straightforward example is a dataset containing both positive and negative numbers. We may want to show those with different colors, so that it is immediately obvious whether a value is positive or negative as well as how far in either direction it deviates from zero. The appropriate color scale in this situation is a *diverging* color scale. We can think of a diverging scale as two sequential scales stitched together at a common midpoint, which usually is represented by a light color (Figure \@ref(fig:diverging-scales)). Diverging scales need to be balanced, so that the progression from light colors in the center to dark colors on the outside is approximately the same in either direction. Otherwise, the perceived magnitude of a data value would depend on whether it fell above or below the midpoint value.

(ref:diverging-scales) Example diverging color scales. Diverging scales can be thought of as two sequential scales stitched together at a common midpoint color. Common color choices for diverging scales include brown to greenish blue, pink to yellow-green, and blue to red.

<div class="figure">
<img src="06-color-scales_files/figure-html/diverging-scales-1.png" alt="(ref:diverging-scales)" width="685.714285714286" />
<p class="caption">(\#fig:diverging-scales)(ref:diverging-scales)</p>
</div>

As an example application of a diverging color scale, consider Figure \@ref(fig:map-Texas-race), which shows the percentage of people identifying as white in Texas counties. Even though percentage is always a positive number, a diverging scale is justified here, because 50% is a meaningful midpoint value. Numbers above 50% indicate that whites are in the majority and numbers below 50% indicate the opposite. The visualization clearly shows in which counties whites are in the majority, in which they are in the minority, and in which whites and non-whites occur in approximately equal proportions.

(ref:map-Texas-race) Percentage of people identifying as white in Texas counties. Whites are in the majority in North and East Texas but not in South or West Texas. Data source: 2010 Decennial U.S. Census


```r
data("texas_race") # from dviz.supp package

texas_race %>% st_sf() %>%
  st_transform(crs = texas_crs) %>%
  filter(variable == "White") %>%
  ggplot(aes(fill = pct)) +
  geom_sf(color = "white") +
  coord_sf(xlim = texas_xlim, datum = NA) + 
  theme_dviz_map_2() + 
  scale_fill_continuous_divergingx(
    palette = "Earth",
    mid = 50,
    limits = c(0, 100),
    breaks = 25*(0:4),
    labels = c("0% ", "25%", "50%", "75%", " 100%"),
    name = "percent identifying as white",
    guide = guide_colorbar(
      direction = "horizontal",
      label.position = "bottom",
      title.position = "top",
      ticks = FALSE,
      barwidth = grid::unit(3.0, "in"),
      barheight = grid::unit(0.2, "in"))) +
  theme(
    legend.title.align = 0.5,
    legend.text.align = 0.5,
    legend.justification = c(0, 0),
    legend.position = c(0.02, 0.1)
  )
```

<div class="figure">
<img src="06-color-scales_files/figure-html/map-Texas-race-1.png" alt="(ref:map-Texas-race)" width="576" />
<p class="caption">(\#fig:map-Texas-race)(ref:map-Texas-race)</p>
</div>



## Color as a tool to highlight

Color can also be an effective tool to highlight specific elements in the data. There may be specific categories or values in the dataset that carry key information about the story we want to tell, and we can strengthen the story by emphasizing the relevant figure elements to the reader. An easy way to achieve this emphasis is to color these figure elements in a color or set of colors that vividly stand out against the rest of the figure. This effect can be achieved with *accent* color scales, which are color scales that contain both a set of subdued colors and a matching set of stronger, darker, and/or more saturated colors (Figure \@ref(fig:accent-scales)).

(ref:accent-scales) Example accent color scales, each with four base colors and three accent colors. Accent color scales can be derived in several different ways: (top) we can take an existing color scale (e.g., the Okabe Ito scale, Fig \@ref(fig:qualitative-scales)) and lighten and/or partially desaturate some colors while darkening others; (middle) we can take gray values and pair them with colors; (bottom) we can use an existing accent color scale, e.g. the one from the ColorBrewer project.

<div class="figure">
<img src="06-color-scales_files/figure-html/accent-scales-1.png" alt="(ref:accent-scales)" width="685.714285714286" />
<p class="caption">(\#fig:accent-scales)(ref:accent-scales)</p>
</div>

As an example of how the same data can support differing stories with different coloring approaches, I have created a variant of Figure \@ref(fig:popgrowth-US) where now I highlight two specific states, Texas and Louisiana (Figure \@ref(fig:popgrowth-US-highlight)). Both states are in the South, they are immediate neighbors, and yet one state (Texas) was the fifth-fastest growing state within the U.S. whereas the other was the third slowest growing from 2000 to 2010.

(ref:popgrowth-US-highlight) From 2000 to 2010, the two neighboring southern states Texas and Louisiana have experienced among the highest and lowest population growth across the U.S. Data source: U.S. Census Bureau


```r
popgrowth_hilight <- left_join(US_census, US_regions) %>%
    group_by(region, division, state) %>%
    summarize(pop2000 = sum(pop2000, na.rm = TRUE),
              pop2010 = sum(pop2010, na.rm = TRUE),
              popgrowth = (pop2010-pop2000)/pop2000,
              area = sum(area)) %>%
    arrange(popgrowth) %>%
    ungroup() %>%
    mutate(region = ifelse(state %in% c("Texas", "Louisiana"), "highlight", region)) %>%
    mutate(state = factor(state, levels = state),
           region = factor(region, levels = c("West", "South", "Midwest", "Northeast", "highlight")))

# make color and fontface vector in order of the states
region_colors_bars <- c(desaturate(lighten(c("#E69F00", "#56B4E9", "#009E73", "#F0E442"), .4), .8), darken("#56B4E9", .3))
region_colors_axis <- c(rep("gray30", 4), darken("#56B4E9", .4))
region_fontface <- c(rep("plain", 4), "bold")
state_colors <- region_colors_axis[as.numeric(popgrowth_hilight$region[order(popgrowth_hilight$state)])]
state_fontface <- region_fontface[as.numeric(popgrowth_hilight$region[order(popgrowth_hilight$state)])]

ggplot(popgrowth_hilight, aes(x = state, y = 100*popgrowth, fill = region)) + 
  geom_col() + 
  scale_y_continuous(
    limits = c(-.6, 37.5), expand = c(0, 0),
    labels = scales::percent_format(accuracy = 1, scale = 1),
    name = "population growth, 2000 to 2010"
  ) +
  scale_fill_manual(
    values = region_colors_bars,
    breaks = c("West", "South", "Midwest", "Northeast")
  ) +
  coord_flip() + 
  theme_dviz_vgrid_2(12, rel_small = 1) +
  theme(
    text = element_text(color = "gray30"),
    axis.text.x = element_text(color = "gray30"),
    axis.title.y = element_blank(),
    axis.line.y = element_blank(),
    axis.ticks.length = unit(0, "pt"),
    axis.text.y = element_text(
      size = 10, color = state_colors,
      face = state_fontface
    ),
    legend.position = c(.56, .68),
    legend.background = element_rect(fill = "#ffffffb0")
  )
```

<div class="figure">
<img src="06-color-scales_files/figure-html/popgrowth-US-highlight-1.png" alt="(ref:popgrowth-US-highlight)" width="576" />
<p class="caption">(\#fig:popgrowth-US-highlight)(ref:popgrowth-US-highlight)</p>
</div>

When working with accent colors, it is critical that the baseline colors do not compete for attention. Notice how drab the baseline colors are in (Figure \@ref(fig:popgrowth-US-highlight)). Yet they work well to support the accent color. It is easy to make the mistake of using baseline colors that are too colorful, so that they end up competing for the reader's attention against the accent colors. There is an easy remedy, however. Just remove all color from all elements in the figure except the highlighted data categories or points. An example of this strategy is provided in Figure \@ref(fig:Aus-athletes-track).


(ref:Aus-athletes-track) Track athletes are among the shortest and leanest of male professional athletes participating in popular sports. Data source: @Telford-Cunningham-1991


```r
data("Aus_athletes") # from dviz.supp package
male_Aus <- filter(Aus_athletes, sex=="m") %>%
  filter(sport %in% c("basketball", "field", "swimming", "track (400m)",
                      "track (sprint)", "water polo")) %>%
  mutate(sport = case_when(sport == "track (400m)" ~ "track",
                           sport == "track (sprint)" ~ "track",
                           TRUE ~ sport))

male_Aus$sport <- factor(male_Aus$sport,
                         levels = c("track", "field", "water polo", "basketball", "swimming"))

colors <- c("#BD3828", rep("#808080", 4))
fills <- c("#BD3828D0", rep("#80808080", 4))

ggplot(male_Aus, aes(x=height, y=pcBfat, shape=sport, color = sport, fill = sport)) +
  geom_point(size = 3) +
  scale_shape_manual(values = 21:25) +
  scale_color_manual(values = colors) +
  scale_fill_manual(values = fills) +
  xlab("height (cm)") +
  ylab("% body fat") +
  theme_dviz_grid_2()
```

<div class="figure">
<img src="06-color-scales_files/figure-html/Aus-athletes-track-1.png" alt="(ref:Aus-athletes-track)" width="576" />
<p class="caption">(\#fig:Aus-athletes-track)(ref:Aus-athletes-track)</p>
</div>


## Using color scales with ggplot2


All [HCL-based color palettes](https://colorspace.r-forge.r-project.org/articles/hcl_palettes.html) in the `colorspace` package [@colorspace] are also provided as discrete, continuous, and binned color scales for the use with the ggplot2 package [@ggplot2]. 

The scales are called via the scheme


```r
scale_<aesthetic>_<datatype>_<colorscale>()
```

where

- `<aesthetic>` is the name of the aesthetic (`fill`, `color`, `colour`).  
- `<datatype>` is the type of the variable plotted (`discrete`, `continuous`, `binned`).  
- `<colorscale>` sets the type of the color scale used (qualitative, sequential, diverging).  

The color palettes can be listed and visualized as follows:



```r
# get list of palettes
hcl_palettes()
#> HCL palettes
#> 
#> Type:  Qualitative 
#> Names: Pastel 1, Dark 2, Dark 3, Set 2, Set 3, Warm, Cold,
#>        Harmonic, Dynamic
#> 
#> Type:  Sequential (single-hue) 
#> Names: Grays, Light Grays, Blues 2, Blues 3, Purples 2,
#>        Purples 3, Reds 2, Reds 3, Greens 2, Greens 3,
#>        Oslo
#> 
#> Type:  Sequential (multi-hue) 
#> Names: Purple-Blue, Red-Purple, Red-Blue, Purple-Orange,
#>        Purple-Yellow, Blue-Yellow, Green-Yellow,
#>        Red-Yellow, Heat, Heat 2, Terrain, Terrain 2,
#>        Viridis, Plasma, Inferno, Rocket, Mako, Dark
#>        Mint, Mint, BluGrn, Teal, TealGrn, Emrld,
#>        BluYl, ag_GrnYl, Peach, PinkYl, Burg, BurgYl,
#>        RedOr, OrYel, Purp, PurpOr, Sunset, Magenta,
#>        SunsetDark, ag_Sunset, BrwnYl, YlOrRd, YlOrBr,
#>        OrRd, Oranges, YlGn, YlGnBu, Reds, RdPu, PuRd,
#>        Purples, PuBuGn, PuBu, Greens, BuGn, GnBu,
#>        BuPu, Blues, Lajolla, Turku, Hawaii, Batlow
#> 
#> Type:  Diverging 
#> Names: Blue-Red, Blue-Red 2, Blue-Red 3, Red-Green,
#>        Purple-Green, Purple-Brown, Green-Brown,
#>        Blue-Yellow 2, Blue-Yellow 3, Green-Orange,
#>        Cyan-Magenta, Tropic, Broc, Cork, Vik, Berlin,
#>        Lisbon, Tofino

# plot the qualitative palette
hcl_palettes(type = "qualitative") %>% 
  plot
```

<img src="06-color-scales_files/figure-html/unnamed-chunk-3-1.png" width="672" />


A few examples of these scales are illustrated in the following sections.

### Examples

A discrete qualitative scale applied to a fill aesthetic corresponds to the function `colorspace::scale_fill_discrete_qualitative()`:


```r
ggplot(iris, aes(x = Sepal.Length, fill = Species)) + 
  geom_density(alpha = 0.6) +
  colorspace::scale_fill_discrete_qualitative() + 
  cowplot::theme_minimal_hgrid()
```

<img src="06-color-scales_files/figure-html/unnamed-chunk-4-1.png" width="672" />

Similarly, a color aesthetic for a discrete qualitative scale corresponds to the function `colorspace::scale_color_discrete_qualitative()`:



```r
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) + 
  geom_point() +
  colorspace::scale_color_discrete_qualitative(palette = "Set 2") + 
  cowplot::theme_minimal_grid()
```

<img src="06-color-scales_files/figure-html/unnamed-chunk-5-1.png" width="672" />


A continuous sequential scale applied to a color aesthetic corresponds to the function `colorspace::scale_color_continuous_sequential()`:



```r
ggplot(iris, aes(x = Species, y = Sepal.Width, color = Sepal.Length)) + 
  geom_jitter(width = 0.2) +
  colorspace::scale_color_continuous_sequential(palette = "Heat") + 
  cowplot::theme_minimal_hgrid()
```

<img src="06-color-scales_files/figure-html/unnamed-chunk-6-1.png" width="672" />


A continuous sequential scale applied to a fill aesthetic corresponds to the function `colorspace::scale_fill_continuous_sequential()`:




```r
df <- data.frame(height = c(volcano), 
                 x = c(row(volcano)), 
                 y = c(col(volcano)))
p <- ggplot(df, aes(x, y, fill = height)) + 
  geom_raster() + 
  coord_fixed(expand = FALSE)

p + colorspace::scale_fill_continuous_sequential(palette = "Blues")
```

<img src="06-color-scales_files/figure-html/unnamed-chunk-7-1.png" width="672" />

A binned version of the same sequential scale can be obtained with the function `colorspace::scale_fill_binned_sequential()`:



```r
p + colorspace::scale_fill_binned_sequential(palette = "Blues")
```

<img src="06-color-scales_files/figure-html/unnamed-chunk-8-1.png" width="672" />


A continuous diverging scale applied to a fill aesthetic corresponds to the function `colorspace::scale_fill_continuous_diverging()`:



```r
cm <- cor(mtcars)
df <- data.frame(cor = c(cm), var1 = factor(col(cm)), var2 = factor(row(cm)))
levels(df$var1) <- levels(df$var2) <- names(mtcars)
ggplot(df, aes(var1, var2, fill = cor)) + 
  geom_tile() + 
  coord_fixed() +
  ylab("variable") +
  scale_x_discrete(position = "top", name = "variable") +
  colorspace::scale_fill_continuous_diverging("Blue-Red 3")
```

<img src="06-color-scales_files/figure-html/unnamed-chunk-9-1.png" width="672" />

