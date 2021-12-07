---
output: html_document
editor_options: 
  chunk_output_type: console
---
# (PART) Computing {-}


# Installing R and RStudio {#install}

::: {.rmdnote}
This section is adapted from the books Data Science in Education Using R [@dataedu] and The Epidemiologist R Handbook [@epir]
:::


## Why use R?

As stated on the [R project website](https://www.r-project.org/about.html), R is a programming language and environment for statistical computing and graphics. It is highly versatile, extendable, and community-driven.  

**Cost**

R is free to use! There is a strong ethic in the community of free and open-source material.  

**Reproducibility**  

Conducting your data management and analysis through a programming language (compared to Excel or another primarily point-click/manual tool) enhances **reproducibility**, makes **error-detection** easier, and eases your workload.  

**Community**  

The R community of users is enormous and collaborative. New packages and tools to address real-life problems are developed daily, and vetted by the community of users. As one example, [R-Ladies](https://rladies.org/) is a worldwide organization whose mission is to promote gender diversity in the R community, and is one of the largest organizations of R users. It likely has a chapter near you!  



## Downloading R, RStudio and LaTeX

First, you will need to download the latest versions of R [@rcoreteam] and RStudio [@rstudio]. 
R is a free environment for statistical computing and graphics using the programming language R. 
RStudio is a set of integrated tools that allows for a more user-friendly experience for using R.

Although you will likely use RStudio as your main console and editor, _you must first install R_ as RStudio uses R behind the scenes. Both R and RStudio are freely available, cross-platform, and open-source.

::: {.rmdcaution}
**Permissions**  
Note that you should install R and RStudio to a drive where you have read and write permissions. Otherwise, your ability to install R packages (a frequent occurrence) will be impacted. If you encounter problems, try opening RStudio by right-clicking the icon and selecting "Run as administrator". Other tips can be found in the page [R on network drives]. 
:::

### To Download R:

- Visit [CRAN](https://cran.r-project.org/) (https:[]()//cran.r-project.org/) to download R 
- Find your operating system (Mac, Windows, or Linux)
- Select the "latest release" on the page for your operating system
- Download and install the application

Don't worry; you will not mess anything up if you download (or even install!) the wrong file. Once you've installed R, you can get started.

### To Download RStudio:

- Visit [RStudio's website](https://www.rstudio.com/products/rstudio/download/) (https[]()://www.rstudio.com/products/rstudio/download/) to download RStudio
- Under the column called "RStudio Desktop FREE", click "Download"
- Find your operating system (Mac, Windows, or Linux)
- Select the "latest release" on the page for your operating system 
- Download and install the application

If you do have issues, an excellent place to get help is the [RStudio Community forums](https://community.rstudio.com/) (https[]()://community.rstudio.com/).

### To Download LaTeX:  

TinyTex is a custom LaTeX distribution, useful when trying to produce PDFs from R.  
See [https://yihui.org/tinytex/](https://yihui.org/tinytex/) for more informaton.  

To install TinyTex from R:  


```r
install.packages('tinytex')
tinytex::install_tinytex()
# to uninstall TinyTeX, run tinytex::uninstall_tinytex()
```


