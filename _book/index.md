--- 
title: "A Minimal Book Example"
author: "John Doe"
date: "2021-08-19"
site: bookdown::bookdown_site
documentclass: book
bibliography: [book.bib, packages.bib]
# url: your book url like https://bookdown.org/yihui/bookdown
# cover-image: path to the social sharing image like images/cover.jpg
description: |
  This is a minimal example of using the bookdown package to write a book.
  set in the _output.yml file.
  The HTML output format for this example is bookdown::bs4_book,
biblio-style: apalike
csl: chicago-fullnote-bibliography.csl
editor_options: 
  chunk_output_type: console
---

# About

why isnt this working 
\begin{tabular}{ |p{0.2cm}|p{0.9cm}|p{3cm}|p{3cm}|p{3cm}|  }
\hline
\multicolumn{5}{|c|}{Part I} \\
\hline
Week & Date & Topic &  References & Slides  \\
\hline
1 & Sept 2 & Introduction to inferential statistics and motivating examples & \href{http://www.stat.cmu.edu/~ryantibs/papers/sparsitynn.pdf}{Chapter 1}, Rosner Chapter 1, DVB Chapter 3    & 001-parameters.pdf  \\
\hline
\rowcolor{grayBackground}
2 & Sept 7 &  &  &   \\
\rowcolor{grayBackground}
 & Sept 9 &  &  &   \\
\hline 
3 & Sept 14 &  simpson's paradox unravelled (hernan IJE 2011)&  &   \\
 & Sept 16 &  &  &   \\
\hline
\rowcolor{grayBackground}
4 & Sept 21 &  &  &   \\
\rowcolor{grayBackground}
 & Sept 23 &  &  &   \\
\hline
5 & Sept 28 &  &  &   \\
  & Sept 30 &  &  &   \\
\hline
\rowcolor{grayBackground}
6 & Oct 5 &  &  &   \\
\rowcolor{grayBackground}
 & Oct 7 &  &  &   \\
\hline
7 & Oct 12 &  &  &   \\
 & Oct 14 &  &  &   \\
\hline
\rowcolor{grayBackground}
8 & Oct 19 &  &  &   \\
\rowcolor{grayBackground}
 & Oct 21 &  &  &   \\
\hline
9 & Oct 26 &  &  &   \\
 & Oct 28 &  &  &   \\
\hline
\rowcolor{grayBackground}
10 & Nov 2 &  &  &   \\
\rowcolor{grayBackground}
 & Nov 4 &  &  &   \\
\hline
11 & Nov 9 &  &  &   \\
 & Nov 11 &  &  &   \\
\hline
\rowcolor{grayBackground}
12 & Nov 16 &  &  &   \\
\rowcolor{grayBackground}
 & Nov 18 &  &  &   \\
\hline
13 & Nov 23 &  &  &   \\
 & Nov 25 &  &  &   \\
\hline
\rowcolor{grayBackground}
14 & Nov 30 &  &  &   \\
\rowcolor{grayBackground}
 & Dec 2 &  &  &   \\
\hline
\end{tabular}

This is a _sample_ book written in **Markdown**. You can use anything that Pandoc's Markdown supports; for example, a math equation $a^2 + b^2 = c^2$.

::: {.rmdnote}
The `bs4_book` style also includes an `.rmdnote` callout block
like this one.


```r
head(beaver1, n = 5)
#>   day time  temp activ
#> 1 346  840 36.33     0
#> 2 346  850 36.34     0
#> 3 346  900 36.35     0
#> 4 346  910 36.42     0
#> 5 346  920 36.55     0
```

:::


::: {.rmdcaution}
The `bs4_book` style also includes an `.rmdnote` callout block
like this one.


```r
library(glmnet)
#> Loading required package: Matrix
#> Loaded glmnet 4.1-1
set.seed(1010)
n = 1000
p = 100
nzc = trunc(p/10)
x = matrix(rnorm(n * p), n, p)
beta = rnorm(nzc)
fx = x[, seq(nzc)] %*% beta
eps = rnorm(n) * 5
y = drop(fx + eps)
px = exp(fx)
px = px/(1 + px)
ly = rbinom(n = length(px), prob = px, size = 1)
set.seed(1011)
cvob1 = cv.glmnet(x, y)
plot(cvob1)
coef(cvob1)
#> 101 x 1 sparse Matrix of class "dgCMatrix"
#>                      1
#> (Intercept) -0.1162737
#> V1          -0.2171531
#> V2           0.3237422
#> V3           .        
#> V4          -0.2190339
#> V5          -0.1856601
#> V6           0.2530652
#> V7           0.1874832
#> V8          -1.3574323
#> V9           1.0162046
#> V10          0.1558299
#> V11          .        
#> V12          .        
#> V13          .        
#> V14          .        
#> V15          .        
#> V16          .        
#> V17          .        
#> V18          .        
#> V19          .        
#> V20          .        
#> V21          .        
#> V22          .        
#> V23          .        
#> V24          .        
#> V25          .        
#> V26          .        
#> V27          .        
#> V28          .        
#> V29          .        
#> V30          .        
#> V31          .        
#> V32          .        
#> V33          .        
#> V34          .        
#> V35          .        
#> V36          .        
#> V37          .        
#> V38          .        
#> V39          .        
#> V40          .        
#> V41          .        
#> V42          .        
#> V43          .        
#> V44          .        
#> V45          .        
#> V46          .        
#> V47          .        
#> V48          .        
#> V49          .        
#> V50          .        
#> V51          .        
#> V52          .        
#> V53          .        
#> V54          .        
#> V55          .        
#> V56          .        
#> V57          .        
#> V58          .        
#> V59          .        
#> V60          .        
#> V61          .        
#> V62          .        
#> V63          .        
#> V64          .        
#> V65          .        
#> V66          .        
#> V67          .        
#> V68          .        
#> V69          .        
#> V70          .        
#> V71          .        
#> V72          .        
#> V73          .        
#> V74          .        
#> V75         -0.1420966
#> V76          .        
#> V77          .        
#> V78          .        
#> V79          .        
#> V80          .        
#> V81          .        
#> V82          .        
#> V83          .        
#> V84          .        
#> V85          .        
#> V86          .        
#> V87          .        
#> V88          .        
#> V89          .        
#> V90          .        
#> V91          .        
#> V92          .        
#> V93          .        
#> V94          .        
#> V95          .        
#> V96          .        
#> V97          .        
#> V98          .        
#> V99          .        
#> V100         .
predict(cvob1, newx = x[1:5, ], s = "lambda.min")
#>               1
#> [1,] -1.3447658
#> [2,]  0.9443441
#> [3,]  0.6989746
#> [4,]  1.8698290
#> [5,] -4.7372693
title("Gaussian Family", line = 2.5)
```

<img src="index_files/figure-html/unnamed-chunk-2-1.png" width="672" />

:::


## Usage 

Each **bookdown** chapter is an .Rmd file, and each .Rmd file can contain one (and only one) chapter. A chapter *must* start with a first-level heading: `# A good chapter`, and can contain one (and only one) first-level heading.

Use second-level and higher headings within chapters like: `## A short section` or `### An even shorter section`.

The `index.Rmd` file is required, and is also your first book chapter. It will be the homepage when you render the book.

## Render book

You can render the HTML version of this example book without changing anything:

1. Find the **Build** pane in the RStudio IDE, and

1. Click on **Build Book**, then select your output format, or select "All formats" if you'd like to use multiple formats from the same book source files.

Or build the book from the R console:


```r
bookdown::render_book()
```

To render this example to PDF as a `bookdown::pdf_book`, you'll need to install XeLaTeX. You are recommended to install TinyTeX (which includes XeLaTeX): <https://yihui.org/tinytex/>.

## Preview book

As you work, you may start a local server to live preview this HTML book. This preview will update as you edit the book when you save individual .Rmd files. You can start the server in a work session by using the RStudio add-in "Preview book", or from the R console:


```r
bookdown::serve_book()
```



