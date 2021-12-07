
<!-- ======================================================= -->
<!-- ======================================================= -->
<!-- ======================================================= -->
# Transition to R from Excel, Stata, SAS { }  

::: {.rmdnote}
This entire section is reproduced from The Epidemiologist R Handbook [@epir]
:::

Below, we provide some advice and resources if you are transitioning to R.  

R was introduced in the late 1990s and has since grown dramatically in scope. Its capabilities are so extensive that commercial alternatives have reacted to R developments in order to stay competitive! ([read this article comparing R, SPSS, SAS, STATA, and Python](https://www.inwt-statistics.com/read-blog/comparison-of-r-python-sas-spss-and-stata.html)).  

Moreover, R is much easier to learn than it was 10 years ago. Previously, R had a reputation of being difficult for beginners. It is now much easier with friendly user-interfaces like RStudio, intuitive code like the **tidyverse**, and many tutorial resources.  

<span style="color: darkgreen;">**Do not be intimidated - come discover the world of R!**</span>  

  

<img src="/Users/runner/work/EPIB607/EPIB607/inst/figures/transition_door.png" width="75%" height="75%" style="display: block; margin: auto;" />




## From Excel  

Transitioning from Excel directly to R is a very achievable goal. It may seem daunting, but you can do it!  

It is true that someone with strong Excel skills can do very advanced activities in Excel alone - even using scripting tools like VBA. Excel is used across the world and is an essential tool for an epidemiologist. However, complementing it with R can dramatically improve and expand your work flows.  

### Benefits {.unnumbered}  

You will find that using R offers immense benefits in time saved, more consistent and accurate analysis, reproducibility, shareability, and faster error-correction. Like any new software there is a learning "curve" of time you must invest to become familiar. The dividends will be significant and immense scope of new possibilities will open to you with R.  

Excel is a well-known software that can be easy for a beginner to use to produce simple analysis and visualizations with "point-and-click". In comparison, it can take a couple weeks to become comfortable with R functions and interface. However, R has evolved in recent years to become much more friendly to beginners.  

Many Excel workflows rely on memory and on repetition - thus, there is much opportunity for error. Furthermore, generally the data cleaning, analysis methodology, and equations used are hidden from view. It can require substantial time for a new colleague to learn what an Excel workbook is doing and how to troubleshoot it. With R, all the steps are explicitly written in the script and can be easily viewed, edited, corrected, and applied to other datasets.   


**To begin your transition from Excel to R you must adjust your mindset in a few important ways:**  


### Tidy data {.unnumbered}  

Use machine-readable "tidy" data instead of messy "human-readable" data. These are the three main requirements for "tidy" data, as explained in this tutorial on ["tidy" data in R](https://r4ds.had.co.nz/tidy-data.html):  

* Each variable must have its own column  
* Each observation must have its own row  
* Each value must have its own cell  

To Excel users - think of the role that [Excel "tables"](https://exceljet.net/excel-tables) play in standardizing data and making the format more predictable.  

An example of "tidy" data would be the case linelist used throughout this handbook - each variable is contained within one column, each observation (one case) has it's own row, and every value is in just one cell. Below you can view the first 50 rows of the linelist:  




```{=html}
<div id="htmlwidget-81dd923bcece71909323" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-81dd923bcece71909323">{"x":{"filter":"top","vertical":false,"filterHTML":"<tr>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"number\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n    <div style=\"display: none;position: absolute;width: 200px;opacity: 1\">\n      <div data-min=\"2\" data-max=\"13\"><\/div>\n      <span style=\"float: left;\"><\/span>\n      <span style=\"float: right;\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"date\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n    <div style=\"display: none;position: absolute;width: 200px;opacity: 1\">\n      <div data-min=\"1399075200000\" data-max=\"1406419200000\"><\/div>\n      <span style=\"float: left;\"><\/span>\n      <span style=\"float: right;\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"date\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n    <div style=\"display: none;position: absolute;width: 200px;opacity: 1\">\n      <div data-min=\"1399939200000\" data-max=\"1.407024e+12\"><\/div>\n      <span style=\"float: left;\"><\/span>\n      <span style=\"float: right;\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"date\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n    <div style=\"display: none;position: absolute;width: 200px;opacity: 1\">\n      <div data-min=\"1400025600000\" data-max=\"1407110400000\"><\/div>\n      <span style=\"float: left;\"><\/span>\n      <span style=\"float: right;\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"date\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n    <div style=\"display: none;position: absolute;width: 200px;opacity: 1\">\n      <div data-min=\"1400371200000\" data-max=\"1410566400000\"><\/div>\n      <span style=\"float: left;\"><\/span>\n      <span style=\"float: right;\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"number\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n    <div style=\"display: none;position: absolute;width: 200px;opacity: 1\">\n      <div data-min=\"0\" data-max=\"67\"><\/div>\n      <span style=\"float: left;\"><\/span>\n      <span style=\"float: right;\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"disabled\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"number\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n    <div style=\"display: none;position: absolute;width: 200px;opacity: 1\">\n      <div data-min=\"0\" data-max=\"67\"><\/div>\n      <span style=\"float: left;\"><\/span>\n      <span style=\"float: right;\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"factor\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n    <div style=\"width: 100%; display: none;\">\n      <select multiple=\"multiple\" style=\"width: 100%;\" data-options=\"[&quot;0-4&quot;,&quot;5-9&quot;,&quot;10-14&quot;,&quot;15-19&quot;,&quot;20-29&quot;,&quot;30-49&quot;,&quot;50-69&quot;,&quot;70+&quot;]\"><\/select>\n    <\/div>\n  <\/td>\n  <td data-type=\"factor\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n    <div style=\"width: 100%; display: none;\">\n      <select multiple=\"multiple\" style=\"width: 100%;\" data-options=\"[&quot;0-4&quot;,&quot;5-9&quot;,&quot;10-14&quot;,&quot;15-19&quot;,&quot;20-24&quot;,&quot;25-29&quot;,&quot;30-34&quot;,&quot;35-39&quot;,&quot;40-44&quot;,&quot;45-49&quot;,&quot;50-54&quot;,&quot;55-59&quot;,&quot;60-64&quot;,&quot;65-69&quot;,&quot;70-74&quot;,&quot;75-79&quot;,&quot;80-84&quot;,&quot;85+&quot;]\"><\/select>\n    <\/div>\n  <\/td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"number\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n    <div style=\"display: none;position: absolute;width: 200px;opacity: 1\">\n      <div data-min=\"-13.2697246824573\" data-max=\"-13.209391925612\" data-scale=\"13\"><\/div>\n      <span style=\"float: left;\"><\/span>\n      <span style=\"float: right;\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"number\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n    <div style=\"display: none;position: absolute;width: 200px;opacity: 1\">\n      <div data-min=\"8.45171855856465\" data-max=\"8.48802917129884\" data-scale=\"14\"><\/div>\n      <span style=\"float: left;\"><\/span>\n      <span style=\"float: right;\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"number\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n    <div style=\"display: none;position: absolute;width: 200px;opacity: 1\">\n      <div data-min=\"0\" data-max=\"100\"><\/div>\n      <span style=\"float: left;\"><\/span>\n      <span style=\"float: right;\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"number\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n    <div style=\"display: none;position: absolute;width: 200px;opacity: 1\">\n      <div data-min=\"11\" data-max=\"241\"><\/div>\n      <span style=\"float: left;\"><\/span>\n      <span style=\"float: right;\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"number\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n    <div style=\"display: none;position: absolute;width: 200px;opacity: 1\">\n      <div data-min=\"20\" data-max=\"24\"><\/div>\n      <span style=\"float: left;\"><\/span>\n      <span style=\"float: right;\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"number\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n    <div style=\"display: none;position: absolute;width: 200px;opacity: 1\">\n      <div data-min=\"35.9\" data-max=\"38\" data-scale=\"1\"><\/div>\n      <span style=\"float: left;\"><\/span>\n      <span style=\"float: right;\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"number\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n    <div style=\"display: none;position: absolute;width: 200px;opacity: 1\">\n      <div data-min=\"0\" data-max=\"428.994082840237\" data-scale=\"14\"><\/div>\n      <span style=\"float: left;\"><\/span>\n      <span style=\"float: right;\"><\/span>\n    <\/div>\n  <\/td>\n  <td data-type=\"number\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"><\/span>\n    <\/div>\n    <div style=\"display: none;position: absolute;width: 200px;opacity: 1\">\n      <div data-min=\"0\" data-max=\"2\"><\/div>\n      <span style=\"float: left;\"><\/span>\n      <span style=\"float: right;\"><\/span>\n    <\/div>\n  <\/td>\n<\/tr>","data":[["5fe599","8689b7","11f8ea","b8812a","893f25","be99c8","07e3e8","369449","f393b4","1389ca","2978ac","57a565","fc15ef","2eaa9a","bbfa93","c97dd9","f50e8a","3a7673","7f5a01","ddddee","99e8fa","567136","9371a9","bc2adf","403057","8bd1e8","f327be","42e1a9","90e5fe","959170","8ebf6e","e56412","6d788e","a47529","67be4e","da8ecb","148f18","2cb9a5","f5c142","70a9fe","3ad520","062638","c76676","baacc1","497372","23e499","38cc4a","3789ee","c71dcd","6b70f0"],[4,4,2,3,3,3,4,4,4,4,4,4,6,5,6,9,10,8,7,6,7,6,8,6,10,8,6,12,5,8,7,9,11,5,8,5,6,11,7,9,7,8,9,12,13,9,8,10,8,7],["2014-05-08",null,null,"2014-05-04","2014-05-18","2014-05-03","2014-05-22","2014-05-28",null,null,"2014-05-30","2014-05-28","2014-06-14","2014-06-07","2014-06-09",null,null,null,"2014-06-23","2014-06-18","2014-06-24",null,null,"2014-07-03",null,"2014-07-10","2014-06-14",null,"2014-06-18","2014-06-29","2014-07-02","2014-07-12","2014-07-12","2014-06-13","2014-07-15","2014-06-20",null,null,"2014-07-20",null,"2014-07-12","2014-07-19","2014-07-18","2014-07-18","2014-07-27",null,"2014-07-19","2014-07-26","2014-07-24",null],["2014-05-13","2014-05-13","2014-05-16","2014-05-18","2014-05-21","2014-05-22","2014-05-27","2014-06-02","2014-06-05","2014-06-05","2014-06-06","2014-06-13","2014-06-16","2014-06-17","2014-06-18","2014-06-19","2014-06-22","2014-06-23","2014-06-25","2014-06-26","2014-06-28","2014-07-02","2014-07-08","2014-07-09","2014-07-09","2014-07-10","2014-07-12","2014-07-12","2014-07-13","2014-07-13","2014-07-14","2014-07-15","2014-07-16","2014-07-17","2014-07-17","2014-07-18","2014-07-19","2014-07-22","2014-07-22","2014-07-24","2014-07-24","2014-07-25","2014-07-25","2014-07-27","2014-07-29","2014-07-30",null,"2014-08-01","2014-08-02","2014-08-03"],["2014-05-15","2014-05-14","2014-05-18","2014-05-20","2014-05-22","2014-05-23","2014-05-29","2014-06-03","2014-06-06","2014-06-07","2014-06-08","2014-06-15","2014-06-17","2014-06-17","2014-06-20","2014-06-19","2014-06-23","2014-06-24","2014-06-27","2014-06-28","2014-06-29","2014-07-03","2014-07-09","2014-07-09","2014-07-11","2014-07-11","2014-07-13","2014-07-14","2014-07-14","2014-07-13","2014-07-14","2014-07-17","2014-07-17","2014-07-18","2014-07-19","2014-07-20","2014-07-20","2014-07-22","2014-07-24","2014-07-26","2014-07-24","2014-07-27","2014-07-25","2014-07-27","2014-07-31","2014-08-01","2014-08-03","2014-08-02","2014-08-02","2014-08-04"],[null,"2014-05-18","2014-05-30",null,"2014-05-29","2014-05-24","2014-06-01","2014-06-07","2014-06-18","2014-06-09","2014-06-15",null,"2014-07-09",null,"2014-06-30","2014-07-11","2014-07-01","2014-06-25","2014-07-06","2014-07-02","2014-07-09","2014-07-07","2014-07-20",null,"2014-07-22","2014-07-16","2014-07-14","2014-07-20","2014-07-16","2014-07-19","2014-07-27","2014-07-19",null,"2014-07-26","2014-08-14","2014-08-01","2014-07-23","2014-08-28","2014-07-28","2014-07-19",null,"2014-08-03",null,null,null,"2014-08-06","2014-08-21","2014-09-13","2014-08-04",null],[null,"Recover","Recover",null,"Recover","Recover","Recover","Death","Recover","Death","Death","Death","Recover","Recover",null,"Recover",null,null,"Death","Death","Recover",null,null,null,"Death",null,"Death","Death",null,"Death","Recover","Death","Recover","Death","Recover",null,"Death","Recover","Recover","Death",null,null,"Death","Death","Death","Death","Recover",null,"Death","Death"],["m","f","m","f","m","f","f","f","m","f","m","m","m","f","f","m","f","f","f","f","m","m","f","m","f","m","m","f","m","f","f","f","m","m","f","m","f","f","f","m","f","m","f","m","m","f","m","f","m","m"],[2,3,56,18,3,16,16,0,61,27,12,42,19,7,7,13,35,17,11,11,19,54,14,28,6,3,31,6,67,14,10,21,20,45,1,12,3,15,20,36,7,13,14,3,10,1,0,20,26,14],["years","years","years","years","years","years","years","years","years","years","years","years","years","years","years","years","years","years","years","years","years","years","years","years","years","years","years","years","years","years","years","years","years","years","years","years","years","years","years","years","years","years","years","years","years","years","years","years","years","years"],[2,3,56,18,3,16,16,0,61,27,12,42,19,7,7,13,35,17,11,11,19,54,14,28,6,3,31,6,67,14,10,21,20,45,1,12,3,15,20,36,7,13,14,3,10,1,0,20,26,14],["0-4","0-4","50-69","15-19","0-4","15-19","15-19","0-4","50-69","20-29","10-14","30-49","15-19","5-9","5-9","10-14","30-49","15-19","10-14","10-14","15-19","50-69","10-14","20-29","5-9","0-4","30-49","5-9","50-69","10-14","10-14","20-29","20-29","30-49","0-4","10-14","0-4","15-19","20-29","30-49","5-9","10-14","10-14","0-4","10-14","0-4","0-4","20-29","20-29","10-14"],["0-4","0-4","55-59","15-19","0-4","15-19","15-19","0-4","60-64","25-29","10-14","40-44","15-19","5-9","5-9","10-14","35-39","15-19","10-14","10-14","15-19","50-54","10-14","25-29","5-9","0-4","30-34","5-9","65-69","10-14","10-14","20-24","20-24","45-49","0-4","10-14","0-4","15-19","20-24","35-39","5-9","10-14","10-14","0-4","10-14","0-4","0-4","20-24","25-29","10-14"],["Other","Missing","St. Mark's Maternity Hospital (SMMH)","Port Hospital","Military Hospital","Port Hospital","Missing","Missing","Missing","Missing","Port Hospital","Military Hospital","Missing","Missing","Other","Port Hospital","Port Hospital","Port Hospital","Missing","Other","Port Hospital","Port Hospital","St. Mark's Maternity Hospital (SMMH)","Missing","Other","Missing","St. Mark's Maternity Hospital (SMMH)","Military Hospital","Port Hospital","Central Hospital","Military Hospital","Central Hospital","Missing","Military Hospital","Other","Missing","Missing","Port Hospital","Port Hospital","Port Hospital","Missing","Central Hospital","Military Hospital","Other","Other","Other","Missing","St. Mark's Maternity Hospital (SMMH)","St. Mark's Maternity Hospital (SMMH)","Missing"],[-13.2157351064963,-13.2152339775486,-13.212910703914,-13.2363711169728,-13.2228638912441,-13.222625321098,-13.2331547837254,-13.2320975453153,-13.2225511595637,-13.2572163655863,-13.2206286746001,-13.253989309478,-13.2385127873491,-13.209391925612,-13.2157278814899,-13.2243437095992,-13.2336087079551,-13.21422143145,-13.2339681355349,-13.2535640411465,-13.2250089377786,-13.2160657166043,-13.2680671272333,-13.2266742923612,-13.2160179088168,-13.2482584611565,-13.2156319199566,-13.2142410663192,-13.2614879104088,-13.2452992638476,-13.2630592726116,-13.2343341712241,-13.2199077448676,-13.2227293309912,-13.2343062806506,-13.218781651651,-13.2483677722899,-13.2097478342339,-13.2680867723786,-13.2587535457526,-13.262635786914,-13.2697246824573,-13.2209026809759,-13.2330734719715,-13.2680923666905,-13.2547212675054,-13.2573683214693,-13.2137356012883,-13.2175973322257,-13.2486407324245],[8.46897295100924,8.45171855856465,8.46481700596819,8.4754761613651,8.46082377490923,8.46183062600728,8.46272931462646,8.46144367534271,8.46191259217774,8.47292327643506,8.48401630165138,8.45837125340844,8.47761705512509,8.47570184950483,8.47779946878972,8.47145134147474,8.47804840685363,8.48528034195779,8.46957530395867,8.45957352078114,8.47404889511544,8.48802917129884,8.473437335922,8.48408263734462,8.46242233645879,8.47026822126572,8.46398447480533,8.4641347894342,8.45623094629607,8.48334624336805,8.47493999153642,8.47832062438022,8.4693933891765,8.48480589906514,8.47121232619015,8.48438437371817,8.48466158574339,8.47714159984428,8.46238127010609,8.45568597813113,8.4632880274758,8.47940722413856,8.46353857052336,8.46178968158864,8.47508713872833,8.45825808128071,8.4532568143863,8.4732571907655,8.47911586641933,8.48480340615605],["f547d6",null,null,"f90f5f","11f8ea","aec8ec","893f25","133ee7",null,null,"996f3a","133ee7","37a6f6","9f6884","4802b1",null,null,null,"a75c7f","8e104d","ab634e",null,null,"b799eb",null,"5d9e4d","a15e13",null,"ea3740","beb26e","567136","894024","36e2e7","a2086d","7baf73","eb2277",null,null,"d6584f",null,"312ecf","52ea64","cfd79c","d145b7","174288",null,"53608c","3b096b","f5c142",null],["other",null,null,"other","other","other","other","other",null,null,"other","other","other","other","other",null,null,null,"other","other","other",null,null,"other",null,"other","other",null,"other","funeral","other","funeral","other","other","other","funeral",null,null,"other",null,"other","other","other","other","other",null,"funeral","other","other",null],[27,25,91,41,36,56,47,0,86,69,67,84,68,44,34,66,78,47,53,47,71,86,53,69,38,46,68,37,100,56,50,57,65,72,29,69,37,48,54,71,47,61,47,35,53,16,13,59,69,67],[48,59,238,135,71,116,87,11,226,174,112,186,174,90,91,152,214,137,117,131,150,241,131,161,80,69,188,66,233,142,110,182,164,214,26,157,39,154,133,168,100,125,123,67,134,31,36,125,183,169],[22,22,21,23,23,21,21,22,22,22,22,22,22,21,23,22,23,21,22,23,21,23,21,24,23,22,24,23,20,24,24,20,24,21,22,21,23,22,23,23,23,22,23,22,22,22,23,22,22,22],["no",null,null,"no","no","no",null,"no","no","no","no","no","no","no","no","no","no","no",null,"no","no","no","no","no",null,"no","no","no",null,null,"no","no",null,"no","no",null,null,"no","no",null,"no","no",null,"no","no","no","no","no","no",null],["no",null,null,"no","no","no",null,"no","no","no","no","no","no","no","no","no","yes","no",null,"no","no","no","yes","no",null,"no","no","yes",null,null,"no","no",null,"no","no",null,null,"no","no",null,"no","no",null,"no","yes","no","no","no","no",null],["yes",null,null,"no","yes","yes",null,"yes","yes","yes","yes","yes","yes","yes","yes","yes","yes","yes",null,"yes","yes","yes","yes","yes",null,"yes","yes","yes",null,null,"yes","yes",null,"yes","yes",null,null,"yes","yes",null,"yes","yes",null,"yes","yes","yes","yes","yes","no",null],["no",null,null,"no","no","no",null,"no","no","no","no","no","no","no","no","yes","no","no",null,"no","no","no","no","no",null,"no","no","no",null,null,"no","no",null,"no","no",null,null,"yes","yes",null,"no","no",null,"no","no","no","no","no","no",null],["yes",null,null,"no","yes","yes",null,"yes","yes","no","yes","no","no","no","yes","no","no","no",null,"no","yes","no","no","no",null,"no","no","no",null,null,"no","yes",null,"yes","yes",null,null,"yes","yes",null,"yes","yes",null,"yes","yes","no","yes","yes","yes",null],[36.8,36.9,36.9,36.8,36.9,37.6,37.3,37,36.4,35.9,36.5,36.9,36.5,37.1,36.5,37.3,37,38,38,36,37,36.7,36.9,36.5,37,36.5,37.6,36.6,36.6,36.2,36.4,37.1,37.5,37.5,37.4,36.9,36.4,37.3,37,37.8,36.5,37.5,36.7,37,37.3,36.6,36.5,36.6,37.6,36.8],[null,"09:36","16:48","11:22","12:60","14:13","14:33","09:25","11:16","10:55","16:03","11:14","12:42","11:06","09:10","08:45",null,"15:41","13:34","18:58","12:43","16:33","14:29","07:18","08:11","16:32","16:17","07:32","17:45",null,"13:24","14:43","02:33","11:36","17:28","16:27",null,"20:49",null,"11:38","14:25","13:42","21:22","13:33","19:06","17:14","20:09",null,"10:23","09:09"],[117.1875,71.8184429761563,16.0652496292635,22.4965706447188,71.4144019043841,41.6171224732461,62.0953890870657,0,16.8376536925366,22.7903289734443,53.4119897959184,24.2802636142907,22.4600343506408,54.320987654321,41.0578432556455,28.5664819944598,17.0320552013276,25.0412914912888,38.7172182043977,27.3876813705495,31.5555555555556,14.8069075945662,30.8839811199813,26.6193433895297,59.375,96.6183574879227,19.2394748755093,84.9403122130395,18.4199377406104,27.7722674072605,41.3223140495868,17.2080666586161,24.1671624033314,15.7218971089178,428.994082840237,27.9930220292912,243.261012491782,20.2395007589813,30.527446435638,25.15589569161,47,39.04,31.0661643201798,77.9683671196257,29.5165961238583,166.493236212279,100.308641975309,37.76,20.6037803457852,23.458562375267],[2,1,2,2,1,1,2,1,1,2,2,2,1,0,2,0,1,1,2,2,1,1,1,0,2,1,1,2,1,0,0,2,1,1,2,2,1,0,2,2,0,2,0,0,2,2,null,1,0,1]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th>case_id<\/th>\n      <th>generation<\/th>\n      <th>date_infection<\/th>\n      <th>date_onset<\/th>\n      <th>date_hospitalisation<\/th>\n      <th>date_outcome<\/th>\n      <th>outcome<\/th>\n      <th>gender<\/th>\n      <th>age<\/th>\n      <th>age_unit<\/th>\n      <th>age_years<\/th>\n      <th>age_cat<\/th>\n      <th>age_cat5<\/th>\n      <th>hospital<\/th>\n      <th>lon<\/th>\n      <th>lat<\/th>\n      <th>infector<\/th>\n      <th>source<\/th>\n      <th>wt_kg<\/th>\n      <th>ht_cm<\/th>\n      <th>ct_blood<\/th>\n      <th>fever<\/th>\n      <th>chills<\/th>\n      <th>cough<\/th>\n      <th>aches<\/th>\n      <th>vomit<\/th>\n      <th>temp<\/th>\n      <th>time_admission<\/th>\n      <th>bmi<\/th>\n      <th>days_onset_hosp<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":5,"scrollX":true,"columnDefs":[{"className":"dt-right","targets":[1,8,10,14,15,18,19,20,26,28,29]}],"order":[],"autoWidth":false,"orderClasses":false,"orderCellsTop":true,"lengthMenu":[5,10,25,50,100]}},"evals":[],"jsHooks":[]}</script>
```

*The main reason one encounters non-tidy data is because many Excel spreadsheets are designed to prioritize easy reading by humans, not easy reading by machines/software.*  

To help you see the difference, below are some fictional examples of **non-tidy data** that prioritize *human*-readability over *machine*-readability:  

<img src="/Users/runner/work/EPIB607/EPIB607/inst/figures/Excel_nonTidy_1.png" width="100%" height="75%" style="display: block; margin: auto;" />


*Problems:* In the spreadsheet above, there are *merged cells* which are not easily digested by R. Which row should be considered the "header" is not clear. A color-based dictionary is to the right side and cell values are represented by colors - which is also not easily interpreted by R (nor by humans with color-blindness!). Furthermore, different pieces of information are combined into one cell (multiple partner organizations working in one area, or the status "TBC" in the same cell as "Partner D").  


<img src="/Users/runner/work/EPIB607/EPIB607/inst/figures/Excel_nonTidy_2.png" width="100%" height="100%" style="display: block; margin: auto;" />


*Problems:* In the spreadsheet above, there are numerous extra empty rows and columns within the dataset - this will cause cleaning headaches in R. Furthermore, the GPS coordinates are spread across two rows for a given treatment center. As a side note - the GPS coordinates are in two different formats!  

"Tidy" datasets may not be as readable to a human eye, but they make data cleaning and analysis much easier! Tidy data can be stored in various formats, for example "long" or "wide", but the principles above are still observed.


### Functions {.unnumbered}  

The R word "function" might be new, but the concept exists in Excel too as *formulas*. Formulas in Excel also require precise syntax (e.g. placement of semicolons and parentheses). All you need to do is learn a few new functions and how they work together in R.  



### Scripts {.unnumbered}  

Instead of clicking buttons and dragging cells you will be writing *every* step and procedure into a "script". 
Excel users may be familiar with "VBA macros" which also employ a scripting approach.  

*The R script consists of step-by-step instructions.* This allows any colleague to read the script and easily see the steps you took. This also helps de-bug errors or inaccurate calculations.  

Here is an example of an R script:  

<img src="/Users/runner/work/EPIB607/EPIB607/inst/figures/example_script.png" width="75%" height="75%" style="display: block; margin: auto;" />







### Excel-to-R resources {.unnumbered}

Here are some links to tutorials to help you transition to R from Excel:  

* [R vs. Excel](https://www.northeastern.edu/graduate/blog/r-vs-excel/)  
* [RStudio course in R for Excel users](https://rstudio-conf-2020.github.io/r-for-excel/)  


### R-Excel interaction {.unnumbered}  

R has robust ways to import Excel workbooks, work with the data, export/save Excel files, and work with the nuances of Excel sheets.  

It is true that some of the more aesthetic Excel formatting can get lost in translation (e.g. italics, sideways text, etc.). If your work flow requires passing documents back-and-forth between R and Excel while retaining the original Excel formatting, try packages such as **openxlsx**.  







## From Stata  
<!-- ======================================================= -->

**Coming to R from Stata**  

Many epidemiologists are first taught how to use Stata, and it can seem daunting to move into R. However, if you are a comfortable Stata user then the jump into R is certainly more manageable than you might think. While there are some key differences between Stata and R in how data can be created and modified, as well as how analysis functions are implemented – after learning these key differences you will be able to translate your skills.

Below are some key translations between Stata and R, which may be handy as your review this guide.


**General notes**

**STATA**                    | **R**  
---------------------------- | ---------------------------------------------    
You can only view and manipulate one dataset at a time | You can view and manipulate multiple datasets at the same time, therefore you will frequently have to specify your dataset within the code
Online community available through [https://www.statalist.org/](https://www.statalist.org/) | Online community available through [RStudio](https://community.rstudio.com/), [StackOverFlow](https://stackoverflow.com/questions/tagged/r), and [R-bloggers](https://www.r-bloggers.com/)
Point and click functionality as an option | Minimal point and click functionality
Help for commands available by `help [command]` | Help available by `?[function]` or search in the Help pane
Comment code using * or /// or  /* TEXT */ | Comment code using #
Almost all commands are built-in to Stata. New/user-written functions can be installed as **ado** files using **ssc install** [package] | R installs with **base** functions, but typical use involves installing other packages from CRAN 
Analysis is usually written in a **do** file | Analysis written in an R script in the RStudio source pane. R markdown scripts are an alternative.


**Working directory**  

**STATA**                        | **R**  
-------------------------------- | ---------------------------------------------
Working directories involve absolute filepaths (e.g. "C:/usename/documents/projects/data/")| Working directories can be either absolute, or relative to a project root folder by using the **here** package  
See current working directory with **pwd** | Use `getwd()` or `here::here()` (if using the **here** package), with empty parentheses 
Set working directory with **cd** “folder location” | Use `setwd(“folder location”)`, or `set_here("folder location)` (if using **here** package)

**Importing and viewing data**  

**STATA**                    | **R**  
-------------------------------- | ---------------------------------------------
Specific commands per file type | Use `import()` from **rio** package for almost all filetypes. Specific functions exist as alternatives 
Reading in csv files is done by **import delimited** “filename.csv” | Use `import("filename.csv")`
Reading in xslx files is done by **import excel** “filename.xlsx” | Use `import("filename.xlsx")`
Browse your data in a new window using the command **browse** | View a dataset in the RStudio source pane using `View(dataset)`. *You need to specify your dataset name to the function in R because multiple datasets can be held at the same time. Note capital "V" in this function*
Get a high-level overview of your dataset using **summarize**, which provides the variable names and basic information | Get a high-level overview of your dataset using `summary(dataset)`

**Basic data manipulation**  

**STATA**                    | **R**  
-------------------------------- | ---------------------------------------------
Dataset columns are often referred to as "variables" | More often referred to as "columns" or sometimes as "vectors" or "variables"
No need to specify the dataset | In each of the below commands, you need to specify the dataset
New variables are created using the command **generate** *varname* =  | Generate new variables using the function `dplyr::mutate(varname = )`. 
Variables are renamed using **rename** *old_name new_name* | Columns can be renamed using the function `rename(new_name = old_name)`
Variables are dropped using **drop** *varname* | Columns can be removed using the function `dplyr::select()` with the column name in the parentheses following a minus sign
Factor variables can be labeled using a series of commands such as **label define** | Labeling values can done by converting the column to Factor class and specifying levels. Column names are not typically labeled as they are in Stata.

**Descriptive analysis**  

**STATA**                    | **R**  
-------------------------------- | ---------------------------------------------
Tabulate counts of a variable using **tab** *varname* | Provide the dataset and column name to `table()` such as `table(dataset$colname)`. Alternatively, use `count(varname)` from the **dplyr** package, as explained in [Grouping data]
Cross-tabulaton of two variables in a 2x2 table is done with **tab** *varname1 varname2* | Use `table(dataset$varname1, dataset$varname2` or `count(varname1, varname2)`


While this list gives an overview of the basics in translating Stata commands into R, it is not exhaustive. There are many other great resources for Stata users transitioning to R that could be of interest:  

* https://dss.princeton.edu/training/RStata.pdf  
* https://clanfear.github.io/Stata_R_Equivalency/docs/r_stata_commands.html  
* http://r4stats.com/books/r4stata/  




## From SAS  
<!-- ======================================================= -->

**Coming from SAS to R**  

SAS is commonly used at public health agencies and academic research fields. Although transitioning to a new language is rarely a simple process, understanding key differences between SAS and R may help you start to navigate the new language using your native language. 
Below outlines the key translations in data management and descriptive analysis between SAS and R.   

**General notes**  

**SAS**                          | **R**  
-------------------------------- | ---------------------------------------------
Online community available through [SAS Customer Support](https://support.sas.com/en/support-home.html)|Online community available through RStudio, StackOverFlow, and R-bloggers
Help for commands available by `help [command]`|Help available by [function]? or search in the Help pane
Comment code using `* TEXT ;` or `/* TEXT */`|Comment code using #
Almost all commands are built-in.  Users can write new functions using SAS macro, SAS/IML, SAS Component Language (SCL), and most recently, procedures `Proc Fcmp` and `Proc Proto`|R installs with **base** functions, but typical use involves installing other packages from CRAN
Analysis is usually conducted by writing a SAS program in the Editor window.|Analysis written in an R script in the RStudio source pane. R markdown scripts are an alternative.

**Working directory**  

**SAS**                          | **R**  
-------------------------------- | ---------------------------------------------
Working directories can be either absolute, or relative to a project root folder by defining the root folder using `%let rootdir=/root path; %include “&rootdir/subfoldername/filename”`|Working directories can be either absolute, or relative to a project root folder by using the **here** package
See current working directory with `%put %sysfunc(getoption(work));`|Use `getwd()` or `here()` (if using the **here** package), with empty parentheses
Set working directory with `libname “folder location”`|Use `setwd(“folder location”)`, or `set_here("folder location)` if using **here** package


**Importing and viewing data**  

**SAS**                          | **R**  
-------------------------------- | ---------------------------------------------
Use `Proc Import` procedure or using `Data Step Infile` statement.|Use `import()` from **rio** package for almost all filetypes. Specific functions exist as alternatives.
Reading in csv files is done by using `Proc Import datafile=”filename.csv” out=work.filename dbms=CSV; run;` OR using [Data Step Infile statement](http://support.sas.com/techsup/technote/ts673.pdf)|Use `import("filename.csv")`
Reading in xslx files is done by using `Proc Import datafile=”filename.xlsx” out=work.filename dbms=xlsx; run;` OR using [Data Step Infile statement](http://support.sas.com/techsup/technote/ts673.pdf)|Use import("filename.xlsx")
Browse your data in a new window by opening the Explorer window and select desired library and the dataset|View a dataset in the RStudio source pane using View(dataset). You need to specify your dataset name to the function in R because multiple datasets can be held at the same time. Note capital “V” in this function

**Basic data manipulation**  

**SAS**                          | **R**  
-------------------------------- | ---------------------------------------------
Dataset columns are often referred to as “variables”|More often referred to as “columns” or sometimes as “vectors” or “variables”
No special procedures are needed to create a variable. New variables are created simply by typing the new variable name, followed by an equal sign, and then an expression for the value|Generate new variables using the function `dplyr::mutate()`. 
Variables are renamed using `rename *old_name=new_name*`|Columns can be renamed using the function `dplyr::rename(new_name = old_name)`
Variables are kept using `**keep**=varname`|Columns can be selected using the function `dplyr::select()` with the column name in the parentheses
Variables are dropped using `**drop**=varname`|Columns can be removed using the function `dplyr::select()` with the column name in the parentheses following a minus sign
Factor variables can be labeled in the Data Step using `Label` statement|Labeling values can done by converting the column to Factor class and specifying levels. Column names are not typically labeled.
Records are selected using `Where` or `If` statement in the Data Step. Multiple selection conditions are separated using “and” command.|Records are selected using the function `dplyr::filter()` with multiple selection conditions separated either by an AND operator (&) or a comma  
Datasets are combined using `Merge` statement in the Data Step. The datasets to be merged need to be sorted first using `Proc Sort` procedure.|**dplyr** package offers a few functions for merging datasets. 

**Descriptive analysis**  

**SAS**                          | **R**  
-------------------------------- | ---------------------------------------------
Get a high-level overview of your dataset using `Proc Summary` procedure, which provides the variable names and descriptive statistics|Get a high-level overview of your dataset using `summary(dataset)` or `skim(dataset)` from the **skimr** package
Tabulate counts of a variable using `proc freq data=Dataset; Tables varname; Run;`| Options include `table()` from **base** R, and `janitor::tabyl()` from **janitor** package, among others. Note you will need to specify the dataset and column name as R holds multiple datasets.
Cross-tabulation of two variables in a 2x2 table is done with `proc freq data=Dataset; Tables rowvar*colvar; Run;`|Again, you can use `table()`, `tabyl()`.  




