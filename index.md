--- 
title: "EPIB607"
author: "Sahir Bhatnagar and James A Hanley"
date: "2021-12-07"
site: bookdown::bookdown_site
documentclass: book
bibliography: [book.bib, packages.bib]
url: https://sahirbhatnagar.com/EPIB607
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







```
#> 
#>   There is a binary version available but the source
#>   version is later:
#>        binary source needs_compilation
#> dtplyr  1.1.0  1.2.0             FALSE
#> 
#> 
#> The downloaded binary packages are in
#> 	/var/folders/24/8k48jl6d249_n_qfxwsl6xvm0000gn/T//Rtmp3YbLcs/downloaded_packages
#> 
#> The downloaded binary packages are in
#> 	/var/folders/24/8k48jl6d249_n_qfxwsl6xvm0000gn/T//Rtmp3YbLcs/downloaded_packages
```


# Preface {-}

Welcome to the course website for [EPIB 607 FALL 2021: Inferential Statistics](https://www.mcgill.ca/study/2021-2022/courses/epib-607) at McGill University. 


## Objectives {-}

The aim of this course is to provide students with basic principles of statistical inference so that they can:

1. Visualize/Analyze/Interpret data using statistical methods with the `R` statistical software program.
2. Understand the statistical results in a scientific paper.
3. Learn the tools for creating reproducible analyses
4. Apply statistical methods in their own research.
5. Use the methods learned in this course as a foundation for more advanced biostatistics courses.


## Audience  {-}

The principal audience is researchers in the natural and social sciences who haven't had an introductory course in statistics (or did have one a long time ago). This audience accepts that statistics has penetrated the life sciences pervasively and is required knowledge for both doing research and understanding scientific papers. 

This course is tailored to graduate students in population health sciences in their first year. Concurrently, they take their first courses on epidemiologic methods. The department is known for its emphasis on quantitative methods, and students' ability to carry out their own quantitative work. Since most of the data they will deal with are non-experimental, there is a strong emphasis on multivariable regression. While some students will have had some statistical courses as undergraduates, the courses start at the beginning, and are pitched at the Master's level.

In the last decade, the incoming classes have become more diverse, both in their backgrounds, and in their career plans. Some of those in the recently begun MScPH program plan to be consumers rather than producers of research; previously, the majority of students pursued a thesis-based Masters that involved considerable statistical analyses to produce new statistical evidence.


## About these notes  {-}

These notes are a collection of useful links, videos, online resources and papers for an introductory course in statistics. The instructors have found that no single book sufficiently teaches all the topics covered in this course. Part of this is due to advancements in computing which have far outpaced the publication of modern textbooks. Indeed, the computer has replaced many of the calculations that were traditionally taught to be done by hand. We direct the readers to what we think is a good learning resource for a given topic (following the **Flipped Classroom** strategy). We also provide our own commentary and notes when we think its useful.  


## Topics/textbooks {-}

For the **first term** course 607, recent choices have been _The Practice of Statistics in the Life Sciences_ by Baldi and Moore, and _Stats_ by de Veaux, Velleman and Bock. Others that have been recommended are the older texts by Pagano and Gauvreau, and by Rosner. Some of us have also drawn on material in _Statistics_ by Freedman, Pisani, Purves and Adkikari, and
_Statistical Methods in Medical Research_, 4th Edition_ by
Armitage,Berry, and Matthews.

The newer books have tried to teach the topic more engagingly, by starting with where data come from, and (descriptively) displaying single distributions, or relationships between variables. They and the many others then typically move on to Probability; Random Variables; Sampling Distributions; Confidence intervals and Tests of Hypotheses; Inference about/for a single Mean/Proportion/Rate and a difference of two Means/Proportions/Rates; Chi-square Tests for 2 way frequency tables; Simple Correlation and Regression. Most include a (or point to an online) chapter on Non-Parametric Tests. They typically end with  tables of probability tail areas, and critical values. 

Bradford Hill's  _Principles of Medical Statistics_ followed the same sequence 80 years ago, but in black type in a book that measured 6 inches by 9 inches by 1 inch, and weighed less than a pound. Today's multi-colour texts are 50% longer, 50% wider, and twice as thick, and weigh 5 pounds or more.

The topics to be covered in the **second term** course include multiple regression involving 
Gaussian, Binomial, and Poisson variation, as well
as (possibly censored) time-durations -- or their reciprocals, event rates. Here is is more difficult to point to one modern comprehensive textbook.
There is pressure to add even more topics, such as correlated data, missing data, measurement error etc. top the second statistics course.

## Regression from the outset {-}

It is important to balance the desire to cover more of these regression-based topics with having a good grounding, from the first term, in the basic concepts that underlie all statistical analyses.

The first term _epidemiology_ course deals with proportions and rates (risks and hazards) and -- at the core of epidemiology -- comparisons involving these. Control for confounding is typically via  odds/risk/rate differences/ratios obtained by standardization or Mantel-Haenszel-type summary measures. Teachers are reluctant to spend the time to teach the classical confidence intervals for these, as they are not that intuitive and -- once students have covered multiple regression -- superceded by model-based intervals.    


One way to synchronize with epidemiology, is to teach the six separate topics Mean/Proportion/Rate and differences of two Means/Proportions/Rates in a more unified way by embedding all 6 in a regression format right from the outset, to use generalized linear models, and to focus on  all-or-none contrasts, represented by binary 'X' values.  

This would have other benefits. As of now, a lot of time in 607 is spent on 1-sample and 2-sample methods (and chi-square tests) that don't lead anywhere (generalize). Ironically, the first-term concerns with equal and unequal variance tests  are no longer raised, or obsessed about, in the multiple regression framework in second term. 

The teaching/learning of statistical concepts/techiques is greatly enriched by  real-world applications from published reports of  public health and epidemiology research. In 1980, a first course in statistics provided access to 80% of the articles in NEJM articles. This large dividend is no longer the case -- and even less so for journals that report on non-experimental research. The 1-sample and 2-sample methods, and chi-square tests that have been the core of first statistics courses are no longer the techniques that underlie the reported summaries in the abstracts and in the full text. The statistical analysis sections of 
many of these articles do still start off with descriptive statistics and a perfunctory list of parametric and non-parametric 1 and 2 sample tests, but most then describe the multivariable techniques used to produce the reported summaries. [Laboratory sciences can still get by with t-tests and 'anova's -- and the occasional ancova'; studies involving  intact human  beings in free-living populations can not.]   Thus, if the first statistical course is to to get the same 'understanding' dividend from research articles as the introductory epidemiology course does, that first statistical course needs to teach the techniques that produce the results in the abstracts. Even if it can only go so far, such an approach can promote a regression approach right from week one, and build on it each week, rather than introduce it for the first time at week 9 or 10, when the course is already beginning to wind down, and assignments from other courses are piling up. 

## Parameters first, data later {-}

When many teachers and students think of regression, they imagine  a cloud of points in x-y space, and the least squares fitting of a regression line. They start with thinking about the data. 

A few teachers, when they introduce regression, do so by describing/teaching it as **an equation that connects parameters**,   constructed in such a way that the parameter-constrast of interest is easily and directly visible. Three such teachers are Clayton and Hills 1995, Miettinen1985, and Rothman 2012. In each case, their first chapter on regression is limited to the parameters and to undersatnding what they mean; data only appear in the next chapter.

There is a lot to commend this approach. It reminds epidemiologists -- and even statisticians -- that statistical inference is about parameters. Before addressing  data and data-summaries, we need to specify what the estimands are -- i.e, what parameter(s) is(are) we pursuing.

Fisher, when introducing Likelihood in 1922, was one of the earliest statisticians to distinguish parameters from statistics. he decried 'the obscurity which envelops the theoretical bases of statistical methods' and  ascribed it to two considerations. (**emphasis ours**)

> In the first place, it appears to be widely thought, or rather felt, that in a subject in which all results are liable to greater or smaller errors, precise definition of ideas or concepts is, if not impossible, at least not a practical necessity.  

> In the second place, it has happened that in statistics a purely verbal confusion has hindered the distinct formulation of statistical problems; for **it is customary to apply the same name, mean, standard deviation, correlation coefficient, etc., both to the true value which we should like to know, but can only estimate, and to the particular value at which we happen to arrive by our methods of estimation.** [R. A. Fisher. On the Mathematical Foundations of Theoretical Statistics. Philosophical Transactions of the Royal Society of London. Series A, Containing Papers of a Mathematical or Physical Character, Vol. 222 (1922), pp. 309-368]

It is  easy and tempting to start with data, since the form of the summary statistic is usually easy to write down directly. It can also be used to motivate a definition: for example, we could define an odds ratio by its empirical computational form ad/bc. However, this 'give me the answer first, and the question later' approach comes up short as soon as one asks how statistically stable this estimate is. To derive a standard error or confidence interval, one has to appeal to a sampling distribution. To do this, one needs to identify the random variables involvced, and the parameters that determine/modulate their statistical distributions.

Once students master the big picture (the parameter(s) being pursued), the task of estimating them by fitting these equations to data is considerably simplified, and becomes more generic. In this approach more upfront thinking is devoted to the parameters -- to what Miettinen calls the design of the study object -- with the focus on a pre-specified 'deliverable.'

 

## Let's switch to "y-bar", and drop  "x-bar" {-}

The prevailing practice, when introducing descriptive statistics, and even  to 1 and two sample procedures, is to use the term x-bar ($\bar{x}$) for an arithmetic mean (one notable execption is de Veaux at al.) This misses the chance to prepare students for regression, where E[Y|X] is the object of interest, and the X-conditional Y's are the random variables. Technically speaking, the X's are not even considered random variables. Elevating the status of the Y's and explaining the  role of the X's, and the impact of the X distributions on precision might also cut down on the practice of checking the normality of the X's, even though the X's are not random variables. They are merely the X locations/profiles at which Y was measured/recorded. When possible, the X distribution should be determined by the investigators, so as to give more precise and less correlated estimates of the  parameters being pursued. Switching from $\bar{x}$ to $\bar{y}$ is a simple yet meaningful step in this direction. JH made this switch about 10 years ago.

## Computing from the outset {-}

In 1980, most calculations in the first part of 607 were by hand calculator.  Computing summary statistics by hand was seen as a way to help students understand the concepts involved, and the absence of automated rapid computation was not considered a drawback. However, 
doing so did not always help students understand the concept of a standard deviation or a regression slope, since these formulae were designed to minimize the number of keystrokes, rather than to illuminate the construct involved. For example, it was common to rescale and relocate data to cut down on the numbers of digits entered, to group values into bins, and use midpoints and frequencies. It was also common to use the computationally-economical 1-pass-through-the-data formula for the sample variance 
$$s^2 =   \frac{ \sum y^2 - \frac{(\sum y)^2}{n}}{n-1},$$  
even though the definitional formula is

$$s^2 = \frac{\sum(y - \bar{y})^2}{n-1}.$$

The latter (definitional) one was considered too long, even though having to first have to compute $\bar{y}$ and then go back and compute (and square) each $y - \bar{y}$ would have helped students to internalize what a sample variance is.  

When spreadsheets arrived in the early 1980s, students could use the built-in mean formula  to  compute and display $\bar{y}$, another formula to compute and display a new column of the deviations from $\bar{y}$, another to compute and display a new column of the squares of these deviations, another to count the number of deviations, and a final formula to arrives at $s^2.$ The understanding comes from coding the definitional formula, and the spreadsheet simply and speedily carries them out, allowing to user to see all of the relevant components, and from noticing if each one looks reasonable.  Ultimately, once students master the concept, they could move on to built-in formulae that hide (or themselves avoid) the intermediate quantities. 

Few teachers actually encouraged the use of spreadsheets, and instead promoted commercial statistical packages such as SAS, SPSS and Stata. Thus, the opportunity to learn to `walk first, run later' afforded by spreadsheets was not fully exploited. 

RStudio is an integrated environment for R, a free software environment for statistical computing and graphics that runs on a wide variety of platforms. Just like spreadsheet software, one can use R not just as a calculator, but as a _programmable_  calculator, and by programming them, learn the concepts before moving on to the built-in functions. There is a large user-community and a tradition of sharing information and ways of doing things. The graphics language contains primitive functions that allow customization, as well as higher-level functions, and is tightly integrated with the statistical routines and data frame functions. R Markdown helps to foster reproducible research. Shiny apps allow interactivity and visualization, a bit like 'what-ifs' with a spreadsheet.


## The link between EPIB607 and EPIB613 {-}

It takes practice to become comfortable with R. For those less mathematical, it is somewhat more cryptic than, and not quite as intuitive as, other packages. For the last several years, the department has offered a 13 hour course introduction to R in first term. Initially the aim was to prepare students for using it in course 621 in second term, but in the Fall 2018, 2019 and 2020 offerings of EPIB607, computing with R and use of R Studio became mandatory. Just as the epidemiology material in the Fall is shared between 2 courses (601 and 602), the aim will be to also spread the statistics material over 607 and 613, and to integrate the two more tightly. As an example, the material on 'descriptive' (i.e., not model-based) statistics and graphical displays will be covered in 613, while 607 will begin with parameters and models. Rather than treat computing as a separate activity, exercises based on 607 material will be carried out as part of 613 classes/tutorials. The statistical material will be used to motivate the computer tasks.

Classic introductory statistics textbooks were written during a time when computers were still in their infancy. As such, even the newer editions heavily rely on _by-hand_ computations such as looking up tables for tail probabilities. We take a modern approach and introduce computational methods in statistics with the statistical software program `R`.



## Teaching strategy {-}

This course will follow the **Flipped Classroom** model. Here, students are expected to have engaged with the material before coming to class. This allows the instructor to delegate the delivery of basic content and definitions to textbooks and videos, and enforces the idea that students cannot be simply passive recipients of information. This approach then allows the professor to focus valuable class time on nurturing efficient discussions surrounding the ideas within the content, guiding interactive
exploration of typical misconceptions, and promoting collaborative problem solving with peers. 

<br>  

<center>
<iframe width="800" height="450" src="https://www.youtube.com/embed/qdKzSq_t8k8" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
</center>





## DataCamp {-}

This class is supported by [DataCamp](https://www.datacamp.com/), the most intuitive learning platform for data science and analytics. Learn any time, anywhere and become an expert in R, Python, SQL, and more. DataCamp’s learn-by-doing methodology combines short expert videos and hands-on-the-keyboard exercises to help learners retain knowledge. DataCamp offers 350+ courses by expert instructors on topics such as importing data, data visualization, and machine learning. They’re constantly expanding their curriculum to keep up with the latest technology trends and to provide the best learning experience for all skill levels. Join over 6 million learners around the world and close your skills gap.



![](inst/figures/datacampt.png)

<br>  

You will be asked to complete some of the courses in DataCamp for background reading or for assignments. You can sign up for a free account at [this link](https://www.datacamp.com/groups/shared_links/a10245cf1485dc55a1ee21a23d6dfe6ae703fd60). Note: you are required to sign up with a `@mail.mcgill.ca` or `@mcgill.ca` email address. 

## R Code Conventions {-}

We use [`R`](https://cran.r-project.org/) code throughout these notes. When `R` code is displayed[^1] it will be typeset using a `monospace` font with syntax highlighting enabled to ensure the differentiation of functions, variables, and so on. For example, the following adds 1 to 1

[^1]: https://raw.githubusercontent.com/coatless/spm/master/index.Rmd


```r
a = 1L + 1L
a
```

Each code segment may contain actual output from `R`. Such output will appear in grey font prefixed by `#>`. For example, the output of the above code segment would look like so:


```
#> [1] 2
```





## Development {-}

This book is built with [**bookdown**](https://github.com/rstudio/bookdown) and is open source and freely available. This approach encourages contributions, ensures reproducibility and provides access to the material worldwide. The online version of the book is hosted at [sahirbhatnagar.com/EPIB607](https://sahirbhatnagar.com/EPIB607). The entire source code is available at [https://github.com/sahirbhatnagar/EPIB607](https://github.com/sahirbhatnagar/EPIB607).  

If you notice any errors, we would be grateful if you would let us know by filing an issue [here](https://github.com/sahirbhatnagar/EPIB607/issues)
or making a pull request by clicking the `Edit this page` link on the right hand side of this page.



<br>

## About the authors {-}

Sahir Bhatnagar           |  James Hanley
:-------------------------:|:-------------------------:
<img src="inst/figures/sahir.png" alt="Drawing" style="height: 200px;"/>  |  <img src="inst/figures/jim.png" alt="Drawing" style="height: 200px;"/>

* Sahir R. Bhatnagar: Assistant Professor of Biostatistics - McGill University, Montreal, Canada.  
    + Website: <https://sahirbhatnagar.com/>  
    + GitHub: <https://github.com/sahirbhatnagar>  
* James A. Hanley: Professor of Biostatistics - McGill University, Montreal, Canada.  
    + Website: <http://www.medicine.mcgill.ca/epidemiology/hanley/>  




## License {-}

<p xmlns:cc="http://creativecommons.org/ns#" xmlns:dct="http://purl.org/dc/terms/"><a property="dct:title" rel="cc:attributionURL" href="https://sahirbhatnagar.com/EPIB607">EPIB607: Inferential Statistics</a> by <a rel="cc:attributionURL dct:creator" property="cc:attributionName" href="https://sahirbhatnagar.com/">Sahir Bhatnagar and James A Hanley</a> is licensed under <a href="http://creativecommons.org/licenses/by-nc/4.0/?ref=chooser-v1" target="_blank" rel="license noopener noreferrer" style="display:inline-block;">Attribution-NonCommercial 4.0 International<img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/cc.svg?ref=chooser-v1"><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/by.svg?ref=chooser-v1"><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/nc.svg?ref=chooser-v1"></a></p>












# Schedule {-}




<table class="table table-hover" style="margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Week </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Date </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Topic </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Readings </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Slides </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Lab </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Assignment </th>
  </tr>
 </thead>
<tbody>
  <tr grouplength="4"><td colspan="7" style="border-bottom: 1px solid;"><strong>Descriptive Statistics</strong></td></tr>
<tr>
   <td style="text-align:left;background-color: #EAEAEA !important;padding-left: 2em;" indentlevel="1"> 1 </td>
   <td style="text-align:left;background-color: #EAEAEA !important;"> Sep 02 </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 10em; "> Introduction to statistical inference and motivating examples </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 10em; "> [AA0 Unit 1](https://www.learner.org/series/against-all-odds-inside-statistics/what-is-statistics/) </td>
   <td style="text-align:left;background-color: #EAEAEA !important;"> [001](https://github.com/sahirbhatnagar/EPIB607/blob/master/inst/slides/001-introduction/001-introduction_handout.pdf), [002](https://github.com/sahirbhatnagar/EPIB607/blob/master/inst/slides/002-motivating-examples/002-motivating-examples_handout.pdf) </td>
   <td style="text-align:left;background-color: #EAEAEA !important;"> 001-getting-started </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 12em; ">  </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> 2 </td>
   <td style="text-align:left;"> Sep 07 </td>
   <td style="text-align:left;width: 10em; "> Exploring data </td>
   <td style="text-align:left;width: 10em; "> [AA0 Unit 3](https://www.learner.org/series/against-all-odds-inside-statistics/histograms/), [AAO Unit 4](https://www.learner.org/series/against-all-odds-inside-statistics/measures-of-center/), [AAO Unit 5](https://www.learner.org/series/against-all-odds-inside-statistics/boxplots/), [AAO Unit 6](https://www.learner.org/series/against-all-odds-inside-statistics/standard-deviation/), [Section 1.1 – 1.5](https://sahirbhatnagar.com/EPIB607/introdata.html) </td>
   <td style="text-align:left;"> [003](https://github.com/sahirbhatnagar/EPIB607/blob/master/inst/slides/003-exploring-data-1/003-exploring-data-1_handout.pdf), [004](https://github.com/sahirbhatnagar/EPIB607/blob/master/inst/slides/004-exploring-data-2/004-exploring-data-2_handout.pdf) </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;width: 12em; "> <span style=" font-weight: bold;    border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: ABE35A !important;">[A1 due Sep 6](https://github.com/sahirbhatnagar/EPIB607/raw/master/inst/assignments/a1/a1-setup.pdf)</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1">  </td>
   <td style="text-align:left;"> Sep 09 </td>
   <td style="text-align:left;width: 10em; "> Data visualization </td>
   <td style="text-align:left;width: 10em; "> [ggplot2 grammar guide](https://evamaerey.github.io/ggplot2_grammar_guide/about), [Section 1.6](https://sahirbhatnagar.com/EPIB607/introdata.html#relationships-between-two-variables) </td>
   <td style="text-align:left;"> [005](https://github.com/sahirbhatnagar/EPIB607/blob/master/inst/slides/005-data-graphics/005-data-graphics_handout.pdf) </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;width: 12em; ">  </td>
  </tr>
  <tr>
   <td style="text-align:left;background-color: #EAEAEA !important;padding-left: 2em;" indentlevel="1"> 3 </td>
   <td style="text-align:left;background-color: #EAEAEA !important;"> Sep 14 </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 10em; "> Grammar of graphics </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 10em; "> [Section 2](https://sahirbhatnagar.com/EPIB607/aesthetic-mapping.html), [Section 3](https://sahirbhatnagar.com/EPIB607/coordinate-systems-axes.html), [Section 4](https://sahirbhatnagar.com/EPIB607/ggplot2-package-for-plots.html), [Section 5](https://sahirbhatnagar.com/EPIB607/color-basics.html) </td>
   <td style="text-align:left;background-color: #EAEAEA !important;"> [006](https://github.com/sahirbhatnagar/EPIB607/blob/master/inst/slides/006-ggplot/006-ggplot_handout.pdf) </td>
   <td style="text-align:left;background-color: #EAEAEA !important;"> 002-data-basics </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 12em; "> <span style=" font-weight: bold;    border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: ABE35A !important;">[A2 due Sep 13](https://github.com/sahirbhatnagar/EPIB607/raw/master/inst/assignments/a2/a2-tidyverse.pdf)</span> </td>
  </tr>
  <tr grouplength="1"><td colspan="7" style="border-bottom: 1px solid;"><strong></strong></td></tr>
<tr grouplength="6"><td colspan="7" style="border-bottom: 1px solid;"><strong>Sampling Distributions</strong></td></tr>
<tr>
   <td style="text-align:left;background-color: #EAEAEA !important;padding-left: 4em;" indentlevel="2">  </td>
   <td style="text-align:left;background-color: #EAEAEA !important;"> Sep 16 </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 10em; "> Statistical parameters </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 10em; "> [Section 6](https://sahirbhatnagar.com/EPIB607/paras.html) </td>
   <td style="text-align:left;background-color: #EAEAEA !important;"> [007](https://github.com/sahirbhatnagar/EPIB607/blob/master/inst/slides/007-statistical-parameters/007-statistical-parameters_handout.pdf) </td>
   <td style="text-align:left;background-color: #EAEAEA !important;">  </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 12em; ">  </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> 4 </td>
   <td style="text-align:left;"> Sep 21 </td>
   <td style="text-align:left;width: 10em; "> Probability </td>
   <td style="text-align:left;width: 10em; "> [Section 7](https://sahirbhatnagar.com/EPIB607/ChapProbability.html), [AAO Unit 18](https://www.learner.org/series/against-all-odds-inside-statistics/introduction-to-probability/), [AAO Unit 19](https://www.learner.org/series/against-all-odds-inside-statistics/probability-models/) </td>
   <td style="text-align:left;"> [008](https://github.com/sahirbhatnagar/EPIB607/blob/master/inst/slides/008-probability/008-probability_handout.pdf) </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;width: 12em; "> <span style=" font-weight: bold;    border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: ABE35A !important;">A3 due Oct 3</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1">  </td>
   <td style="text-align:left;"> Sep 23 </td>
   <td style="text-align:left;width: 10em; "> Random Variables </td>
   <td style="text-align:left;width: 10em; "> [Section 8](https://sahirbhatnagar.com/EPIB607/randomVariables.html), [AAO Unit 20](https://www.learner.org/series/against-all-odds-inside-statistics/random-variables/) </td>
   <td style="text-align:left;"> [009](https://github.com/sahirbhatnagar/EPIB607/blob/master/inst/slides/009-random-variables/009-random-variables_handout.pdf) </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;width: 12em; ">  </td>
  </tr>
  <tr>
   <td style="text-align:left;background-color: #EAEAEA !important;padding-left: 2em;" indentlevel="1"> 5 </td>
   <td style="text-align:left;background-color: #EAEAEA !important;"> Sep 28 </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 10em; "> Sampling Distributions, Normal Curves, CLT </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 10em; "> [Section 9](https://sahirbhatnagar.com/EPIB607/ChapNormal.html), [Section 10](https://sahirbhatnagar.com/EPIB607/ChapSampDist.html), [AAO Unit 7](https://www.learner.org/series/against-all-odds-inside-statistics/normal-curves/), [AAO Unit 8](https://www.learner.org/series/against-all-odds-inside-statistics/normal-calculations/), [AAO Unit 22](https://www.learner.org/series/against-all-odds-inside-statistics/sampling-distributions/) </td>
   <td style="text-align:left;background-color: #EAEAEA !important;"> [010](https://github.com/sahirbhatnagar/EPIB607/blob/master/inst/slides/010-sampling-distributions/010-sampling-distributions_handout.pdf), [011](https://github.com/sahirbhatnagar/EPIB607/blob/master/inst/slides/011-normal-curves/011-normal-curves_handout.pdf), [012](https://github.com/sahirbhatnagar/EPIB607/blob/master/inst/slides/012-clt/012-clt_handout.pdf) </td>
   <td style="text-align:left;background-color: #EAEAEA !important;"> 003-ocean-depths, 004-pnorm-qnorm </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 12em; ">  </td>
  </tr>
  <tr>
   <td style="text-align:left;background-color: #EAEAEA !important;padding-left: 2em;" indentlevel="1">  </td>
   <td style="text-align:left;background-color: #EAEAEA !important;"> Sep 30 </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 10em; "> Confidence Intervals </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 10em; "> [Section 11](https://sahirbhatnagar.com/EPIB607/CI.html), [AAO Unit 24](https://www.learner.org/series/against-all-odds-inside-statistics/confidence-intervals/) </td>
   <td style="text-align:left;background-color: #EAEAEA !important;"> [013](https://github.com/sahirbhatnagar/EPIB607/blob/master/inst/slides/013-confidence-intervals/013-confidence-intervals_handout.pdf) </td>
   <td style="text-align:left;background-color: #EAEAEA !important;">  </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 12em; ">  </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> 6 </td>
   <td style="text-align:left;"> Oct 05 </td>
   <td style="text-align:left;width: 10em; "> Bootstrap </td>
   <td style="text-align:left;width: 10em; "> [Scientific American Article](https://www.dropbox.com/s/igp61c24l2o2qti/EfronDiaconisBootstrap.pdf?dl=0), [Section 12](https://sahirbhatnagar.com/EPIB607/foundations-bootstrapping.html) </td>
   <td style="text-align:left;"> [014](https://github.com/sahirbhatnagar/EPIB607/blob/master/inst/slides/014-bootstrap/014-bootstrap_handout.pdf) </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;width: 12em; ">  </td>
  </tr>
  <tr grouplength="1"><td colspan="7" style="border-bottom: 1px solid;"><strong></strong></td></tr>
<tr grouplength="7"><td colspan="7" style="border-bottom: 1px solid;"><strong>One Sample Inference</strong></td></tr>
<tr>
   <td style="text-align:left;padding-left: 4em;" indentlevel="2">  </td>
   <td style="text-align:left;"> Oct 07 </td>
   <td style="text-align:left;width: 10em; "> One sample mean </td>
   <td style="text-align:left;width: 10em; "> [Section 13](https://sahirbhatnagar.com/EPIB607/inference-one-mean.html), [AAO Unit 26](https://www.learner.org/series/against-all-odds-inside-statistics/small-sample-inference-for-one-mean/) </td>
   <td style="text-align:left;"> [015](https://github.com/sahirbhatnagar/EPIB607/blob/master/inst/slides/015-one-sample-mean/015-one-sample-mean_handout.pdf) </td>
   <td style="text-align:left;"> 005-one-sample-mean </td>
   <td style="text-align:left;width: 12em; ">  </td>
  </tr>
  <tr>
   <td style="text-align:left;background-color: #EAEAEA !important;padding-left: 2em;" indentlevel="1"> 7 </td>
   <td style="text-align:left;background-color: #EAEAEA !important;"> Oct 12 </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 10em; "> READING BREAK – NO LECTURE </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 10em; ">  </td>
   <td style="text-align:left;background-color: #EAEAEA !important;">  </td>
   <td style="text-align:left;background-color: #EAEAEA !important;">  </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 12em; ">  </td>
  </tr>
  <tr>
   <td style="text-align:left;background-color: #EAEAEA !important;padding-left: 2em;" indentlevel="1">  </td>
   <td style="text-align:left;background-color: #EAEAEA !important;"> Oct 14 </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 10em; "> MONDAY SCHEDULE – NO LECTURE </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 10em; ">  </td>
   <td style="text-align:left;background-color: #EAEAEA !important;">  </td>
   <td style="text-align:left;background-color: #EAEAEA !important;">  </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 12em; ">  </td>
  </tr>
  <tr>
   <td style="text-align:left;background-color: #EAEAEA !important;padding-left: 2em;" indentlevel="1">  </td>
   <td style="text-align:left;background-color: #EAEAEA !important;"> Oct 15 </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 10em; "> p-values (make-up lecture for Tuesday) </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 10em; "> [AAO Unit 25](https://www.learner.org/series/against-all-odds-inside-statistics/tests-of-significance/) </td>
   <td style="text-align:left;background-color: #EAEAEA !important;"> [016](https://github.com/sahirbhatnagar/EPIB607/blob/master/inst/slides/016-pvalues/016-pvalues_handout.pdf) </td>
   <td style="text-align:left;background-color: #EAEAEA !important;">  </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 12em; "> <span style=" font-weight: bold;    border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: ABE35A !important;">A4 due Oct 15</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> 8 </td>
   <td style="text-align:left;"> Oct 19 </td>
   <td style="text-align:left;width: 10em; "> Midterm review </td>
   <td style="text-align:left;width: 10em; ">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;width: 12em; "> <span style=" font-weight: bold;    border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: ABE35A !important;">A5 due Oct 18</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1">  </td>
   <td style="text-align:left;"> Oct 21 </td>
   <td style="text-align:left;width: 10em; "> Midterm </td>
   <td style="text-align:left;width: 10em; ">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;width: 12em; ">  </td>
  </tr>
  <tr>
   <td style="text-align:left;background-color: #EAEAEA !important;padding-left: 2em;" indentlevel="1"> 9 </td>
   <td style="text-align:left;background-color: #EAEAEA !important;"> Oct 26 </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 10em; "> Power </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 10em; ">  </td>
   <td style="text-align:left;background-color: #EAEAEA !important;"> [017](https://github.com/sahirbhatnagar/EPIB607/blob/master/inst/slides/017-power/017-power_handout.pdf) </td>
   <td style="text-align:left;background-color: #EAEAEA !important;"> 006-power </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 12em; ">  </td>
  </tr>
  <tr grouplength="1"><td colspan="7" style="border-bottom: 1px solid;"><strong></strong></td></tr>
<tr grouplength="8"><td colspan="7" style="border-bottom: 1px solid;"><strong>Regression</strong></td></tr>
<tr>
   <td style="text-align:left;background-color: #EAEAEA !important;padding-left: 4em;" indentlevel="2">  </td>
   <td style="text-align:left;background-color: #EAEAEA !important;"> Oct 28 </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 10em; "> One sample proportion </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 10em; "> [Section 14](https://sahirbhatnagar.com/EPIB607/ChapBinom.html), [Section 15](https://sahirbhatnagar.com/EPIB607/inference-one-prop.html),  [AAO Unit 21](https://www.learner.org/series/against-all-odds-inside-statistics/binomial-distributions/), [AAO Unit 28](https://www.learner.org/series/against-all-odds-inside-statistics/inference-for-proportions/) </td>
   <td style="text-align:left;background-color: #EAEAEA !important;"> [019](https://github.com/sahirbhatnagar/EPIB607/blob/master/inst/slides/019-one-sample-prop/019-one-sample-prop_handout.pdf) </td>
   <td style="text-align:left;background-color: #EAEAEA !important;"> 007-one-sample-prop </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 12em; ">  </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> 10 </td>
   <td style="text-align:left;"> Nov 02 </td>
   <td style="text-align:left;width: 10em; "> One sample rate </td>
   <td style="text-align:left;width: 10em; ">  </td>
   <td style="text-align:left;"> [020](https://github.com/sahirbhatnagar/EPIB607/blob/master/inst/slides/020-one-sample-rate/020-one-sample-rate_handout.pdf) </td>
   <td style="text-align:left;"> 008-one-sample-rate </td>
   <td style="text-align:left;width: 12em; "> <span style=" font-weight: bold;    border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: ABE35A !important;">A6 due Nov 4</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1">  </td>
   <td style="text-align:left;"> Nov 04 </td>
   <td style="text-align:left;width: 10em; "> Linear regression 1 </td>
   <td style="text-align:left;width: 10em; "> [AAO Unit 30](https://www.learner.org/series/against-all-odds-inside-statistics/inference-for-regression/), [AAO Unit 27](https://www.learner.org/series/against-all-odds-inside-statistics/comparing-two-means/) </td>
   <td style="text-align:left;"> [021](https://github.com/sahirbhatnagar/EPIB607/blob/master/inst/slides/021-regression-intro/021-regression-intro_handout.pdf) </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;width: 12em; ">  </td>
  </tr>
  <tr>
   <td style="text-align:left;background-color: #EAEAEA !important;padding-left: 2em;" indentlevel="1"> 11 </td>
   <td style="text-align:left;background-color: #EAEAEA !important;"> Nov 09 </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 10em; "> Linear regression 2 </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 10em; ">  </td>
   <td style="text-align:left;background-color: #EAEAEA !important;"> [022](https://github.com/sahirbhatnagar/EPIB607/blob/master/inst/slides/022-linear-reg/022-linear-reg_handout.pdf) </td>
   <td style="text-align:left;background-color: #EAEAEA !important;">  </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 12em; ">  </td>
  </tr>
  <tr>
   <td style="text-align:left;background-color: #EAEAEA !important;padding-left: 2em;" indentlevel="1">  </td>
   <td style="text-align:left;background-color: #EAEAEA !important;"> Nov 11 </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 10em; "> Poisson regression 1 </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 10em; ">  </td>
   <td style="text-align:left;background-color: #EAEAEA !important;"> [023](https://github.com/sahirbhatnagar/EPIB607/blob/master/inst/slides/023-poisson-reg/023-poisson-reg_handout.pdf) </td>
   <td style="text-align:left;background-color: #EAEAEA !important;">  </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 12em; ">  </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> 12 </td>
   <td style="text-align:left;"> Nov 16 </td>
   <td style="text-align:left;width: 10em; "> Poisson regression 2 </td>
   <td style="text-align:left;width: 10em; ">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;width: 12em; ">  </td>
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1">  </td>
   <td style="text-align:left;"> Nov 18 </td>
   <td style="text-align:left;width: 10em; "> Logistic regression 1 </td>
   <td style="text-align:left;width: 10em; ">  </td>
   <td style="text-align:left;"> [024](https://github.com/sahirbhatnagar/EPIB607/blob/master/inst/slides/024-logistic-reg-1/024-logistic-reg-1_handout.pdf) </td>
   <td style="text-align:left;"> 009-logistic-reg </td>
   <td style="text-align:left;width: 12em; "> <span style=" font-weight: bold;    border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: ABE35A !important;">A7 due Nov 19</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;background-color: #EAEAEA !important;padding-left: 2em;" indentlevel="1"> 13 </td>
   <td style="text-align:left;background-color: #EAEAEA !important;"> Nov 23 </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 10em; "> Logistic regression 1 </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 10em; ">  </td>
   <td style="text-align:left;background-color: #EAEAEA !important;"> [025](https://github.com/sahirbhatnagar/EPIB607/blob/master/inst/slides/025-logistic-reg-2/025-logistic-reg-2.pdf) </td>
   <td style="text-align:left;background-color: #EAEAEA !important;">  </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 12em; ">  </td>
  </tr>
  <tr>
   <td style="text-align:left;background-color: #EAEAEA !important;">  </td>
   <td style="text-align:left;background-color: #EAEAEA !important;"> Nov 25 </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 10em; "> Logistic regression 2 </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 10em; ">  </td>
   <td style="text-align:left;background-color: #EAEAEA !important;">  </td>
   <td style="text-align:left;background-color: #EAEAEA !important;">  </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 12em; ">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:left;"> Nov 30 </td>
   <td style="text-align:left;width: 10em; "> ROC curves </td>
   <td style="text-align:left;width: 10em; ">  </td>
   <td style="text-align:left;"> [026](https://github.com/sahirbhatnagar/EPIB607/blob/master/inst/slides/026-ROC-curves/ROC_curves.pdf) </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;width: 12em; "> <span style=" font-weight: bold;    border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: ABE35A !important;">A8 due Dec 1</span> </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> Dec 02 </td>
   <td style="text-align:left;width: 10em; "> Final review </td>
   <td style="text-align:left;width: 10em; ">  </td>
   <td style="text-align:left;"> [027](https://github.com/sahirbhatnagar/EPIB607/blob/master/inst/slides/027-final-review_handout.pdf) </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;width: 12em; ">  </td>
  </tr>
  <tr>
   <td style="text-align:left;background-color: #EAEAEA !important;">  </td>
   <td style="text-align:left;background-color: #EAEAEA !important;"> Dec 09 </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 10em; "> Final </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 10em; ">  </td>
   <td style="text-align:left;background-color: #EAEAEA !important;">  </td>
   <td style="text-align:left;background-color: #EAEAEA !important;">  </td>
   <td style="text-align:left;background-color: #EAEAEA !important;width: 12em; ">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> Dec 22 </td>
   <td style="text-align:left;width: 10em; "> Group project </td>
   <td style="text-align:left;width: 10em; ">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;width: 12em; "> <span style=" font-weight: bold;    border-radius: 4px; padding-right: 4px; padding-left: 4px; background-color: ABE35A !important;">[Group project due](https://github.com/sahirbhatnagar/EPIB607/blob/master/inst/project/EPIB607_project.pdf)</span> </td>
  </tr>
</tbody>
</table>


