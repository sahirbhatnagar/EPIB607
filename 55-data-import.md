# Data Import and Export {#import}

::: {.rmdnote}
This section is adapted from The Epidemiologist R Handbook [@epir]
:::

In this page we describe ways to locate, import, and export files:  

* Use of the **rio** package to flexibly `import()` and `export()` many types of files  
* Use of the **here** package to locate files relative to an R project root - to prevent complications from file paths that are specific to one computer  
* Specific import scenarios, such as:  
  * Specific Excel sheets  
  * Messy headers and skipping rows  
  * From Google sheets  
  * From data posted to websites  
  * With APIs  
  * Importing the *most recent* file  
* Manual data entry  
* R-specific file types such as RDS and RData  
* Exporting/saving files and plots  


<!-- ======================================================= -->
## Overview

When you import a "dataset" into R, you are generally creating a new *data frame* object in your R environment and defining it as an imported file (e.g. Excel, CSV, TSV, RDS) that is located in your folder directories at a certain file path/address.  

You can import/export many types of files, including those created by other statistical programs (SAS, STATA, SPSS). You can also connect to relational databases.  

R even has its own data formats:  

* An RDS file (.rds) stores a single R object such as a data frame. These are useful to store cleaned data, as they maintain R column classes. Read more in [this section](#import_rds).    
* An RData file (.Rdata) can be used to store multiple objects, or even a complete R workspace. Read more in [this section](#import_rdata).  


<!-- ======================================================= -->
## The **rio** package {}  

The R package we recommend is: **rio**. The name "rio" is an abbreviation of "R I/O" (input/output).  

Its functions `import()` and `export()` can handle many different file types (e.g. .xlsx, .csv, .rds, .tsv). When you provide a file path to either of these functions (including the file extension like ".csv"), **rio** will read the extension and use the correct tool to import or export the file.  

The alternative to using **rio** is to use functions from many other packages, each of which is specific to a type of file. For example, `read.csv()` (**base** R), `read.xlsx()` (**openxlsx** package), and `write_csv()` (**readr** pacakge), etc. These alternatives can be difficult to remember, whereas using `import()` and `export()` from **rio** is easy.  

**rio**'s functions `import()` and `export()` use the appropriate package and function for a given file, based on its file extension. See the end of this page for a complete table of which packages/functions **rio** uses in the background. It can also be used to import STATA, SAS, and SPSS files, among dozens of other file types.  



## The **here** package {#here}

The package **here** and its function `here()` make it easy to tell R where to find and to save your files - in essence, it builds file paths.  

Used in conjunction with an [R Project][projects], **here** allows you to describe the location of files in your R Project in relation to the R Project's *root directory* (the top-level folder). This is useful when the R project may be shared or accessed by multiple people/computers. It prevents complications due to the unique file paths on different computers (e.g. `"C:/Users/Laura/Documents..."` by "starting" the file path in a place common to all users (the R Project root). See Chapter \@ref(projects) for a reminder about R Projects.

This is how `here()` works within an R Project:  

* When the **here** package is first loaded within the R Project, it places a small file called ".here" in the root folder of your R project as a "benchmark" or "anchor"  
* In your scripts, to reference a file in the R project's sub-folders, you use the function `here()` to build the file path *in relation to that anchor*
* To build the file path, write the names of folders beyond the root, within quotes, separated by commas, finally ending with the file name and file extension as shown below  
* `here()` file paths can be used for both importing and exporting  

For example, below, the function `import()` is being provided a file path constructed with `here()`.  


```r
linelist <- rio::import(here::here("data", "linelists", "ebola_linelist.xlsx"))
```

The command `here::here("data", "linelists", "ebola_linelist.xlsx")` is actually providing the full file path that is *unique to the user's computer*:  

```
"C:/Users/Laura/Documents/my_R_project/data/linelists/ebola_linelist.xlsx"
```

The beauty is that the R command using `here()` can be successfully run on any computer accessing the R project.   


::: {.rmdtip}
If you are unsure where the “.here” root is set to, run the function `here()` with empty parentheses. Read more about the **here** package [at this link](https://here.r-lib.org/).
:::



<!-- ======================================================= -->
## File paths  

When importing or exporting data, you must provide a file path. You can do this one of three ways:  

1) *Recommended:* provide a "relative" file path with the **here** package  
2) Provide the "full" / "absolute" file path  
3) Manual file selection  



### "Relative" file paths 

In R, "relative" file paths consist of the file path *relative to* the root of an R project. They allow for more simple file paths that can work on different computers (e.g. if the R project is on a shared drive or is sent by email). As described [above](#here), relative file paths are facilitated by use of the **here** package.  

An example of a relative file path constructed with `here()` is below. In Figure \@ref(fig:proj1) I show an example of a directory on my computer, with the `epib607.Rproj` file. This is referred to as the **root directory** of your project. All file paths will be relative to this directory. In this example the root directory is `/home/sahir/git_repositories/epib607`.


```r
knitr::include_graphics(here::here("inst","figures","proj1.png"))
```

<div class="figure">
<img src="/Users/runner/work/EPIB607/EPIB607/inst/figures/proj1.png" alt="The files in my epib607 R project. (1) The R project file - this indicates that I have indeed created an R project called epib607. The .Rporj file is always found in the root directory. (2) The path of the directory as would be seen in a file management application such as Finder (on a mac) or Windows Explorer. (3) A directory that contains data." width="352" />
<p class="caption">(\#fig:proj1)The files in my epib607 R project. (1) The R project file - this indicates that I have indeed created an R project called epib607. The .Rporj file is always found in the root directory. (2) The path of the directory as would be seen in a file management application such as Finder (on a mac) or Windows Explorer. (3) A directory that contains data.</p>
</div>

The data I want to load is in a sub-folder called "inst" and within that, a subfolder "data", in which there is the `.rds` file of interest as shown in Figure \@ref(fig:proj2)


```r
knitr::include_graphics(here::here("inst","figures","proj2.png"))
```

<div class="figure">
<img src="/Users/runner/work/EPIB607/EPIB607/inst/figures/proj2.png" alt="The sub-folder containing the data I want to load. (1) linelist_cleaned.rds is the data file. (2) The path of the directory as would be seen in a file management application such as Finder (on a mac) or Windows Explorer. (3) Indicator that I am indeed in the RStudio project called epib607." width="392" />
<p class="caption">(\#fig:proj2)The sub-folder containing the data I want to load. (1) linelist_cleaned.rds is the data file. (2) The path of the directory as would be seen in a file management application such as Finder (on a mac) or Windows Explorer. (3) Indicator that I am indeed in the RStudio project called epib607.</p>
</div>

To load the data, I simply call the `rio::import()` function. This function requires the location of the data file. I use the `here::here()` to locate the datafile:



```r
linelist <- rio::import(here::here("inst","data", "linelist_cleaned.rds"))
```



### "Absolute" file paths  

Absolute or "full" file paths can be provided to functions like `import()` but they are "fragile" as they are unique to the user's specific computer and therefore *not recommended*. 

Below is an example of an absolute file path, where in Laura's computer there is a folder "analysis", a sub-folder "data" and within that a sub-folder "linelists", in which there is the .xlsx file of interest.  


```r
linelist <- rio::import("/home/sahir/git_repositories/epib607/inst/data/linelist_cleaned.rds")
```

A few things to note about absolute file paths:  

* **Avoid using absolute file paths** as they will break if the script is run on a different computer
* Use *forward* slashes (`/`), as in the example above (note: this is *NOT* the default for Windows file paths)  
* File paths that begin with double slashes (e.g. "//...") will likely **not be recognized by R** and will produce an error. Consider moving your work to a "named" or "lettered" drive that begins with a letter (e.g. "J:" or "C:").  

One scenario where absolute file paths may be appropriate is when you want to import a file from a shared drive that has the same full file path for all users.  

<span style="color: darkgreen;">**_TIP:_** To quickly convert all `\` to `/`, highlight the code of interest, use Ctrl+f (in Windows), check the option box for "In selection", and then use the replace functionality to convert them.</span>  




## Import data from Excel

By default, if you provide an Excel workbook (.xlsx) to `rio::import()`, the workbook's first sheet will be imported. If you want to import a specific **sheet**, include the sheet name to the `which = ` argument. For example:  


```r
my_data <- rio::import("my_excel_file.xlsx", which = "Sheetname")
```

If using the `here()` method to provide a relative pathway to `import()`, you can still indicate a specific sheet by adding the `which = ` argument after the closing parentheses of the `here()` function.  


```r
# Demonstration: importing a specific Excel sheet when using relative pathways with the 'here' package
linelist_raw <- rio::import(here::here("data", "linelist.xlsx"), which = "Sheet1")  
```



<!-- ======================================================= -->
## Missing values {#import_missing } 

You may want to designate which value(s) in your dataset should be considered as missing. The value in R for missing data is `NA`, but perhaps the dataset you want to import uses 99, "Missing", or just empty character space "" instead.  

Use the `na = ` argument for `rio::import()` and provide the value(s) within quotes (even if they are numbers). You can specify multiple values by including them within a vector, using `c()` as shown below.  

Here, the value "99" in the imported dataset is considered missing and converted to `NA` in R.  


```r
linelist <- rio::import(here::here("data", "my_linelist.xlsx"), na = "99")
```

Here, any of the values "Missing", "" (empty cell), or " " (single space) in the imported dataset are converted to `NA` in R.  


```r
linelist <- rio::import(here::here("data", "my_linelist.csv"), na = c("Missing", "", " "))
```


<!-- ======================================================= -->
## Skip rows

Sometimes, you may want to avoid importing a row of data. You can do this with the argument `skip = ` if using `import()` from **rio** on a .xlsx or .csv file. Provide the number of rows you want to skip. 



```r
linelist_raw <- rio::import("linelist_raw.xlsx", skip = 1)  # does not import header row
```

Unfortunately `skip = ` only accepts one integer value, *not* a range (e.g. "2:10" does not work). 






<!-- ======================================================= -->
## Import from Google sheets

You can import data from an online Google spreadsheet with the **googlesheet4** package and by authenticating your access to the spreadsheet.  


```r
pacman::p_load("googlesheets4")
```

Below, a demo Google sheet is imported and saved. This command may prompt confirmation of authentification of your Google account. Follow prompts and pop-ups in your internet browser to grant Tidyverse API packages permissions to edit, create, and delete your spreadsheets in Google Drive.  


The sheet below is "viewable for anyone with the link" and you can try to import it.  


```r
Gsheets_demo <- read_sheet("https://docs.google.com/spreadsheets/d/1scgtzkVLLHAe5a6_eFQEwkZcc14yFUx1KgOMZ4AKUfY/edit#gid=0")
```

The sheet can also be imported using only the sheet ID, a shorter part of the URL:  


```r
Gsheets_demo <- read_sheet("1scgtzkVLLHAe5a6_eFQEwkZcc14yFUx1KgOMZ4AKUfY")
```


Another package, **googledrive** offers useful functions for writing, editing, and deleting Google sheets. For example, using the  `gs4_create()` and `sheet_write()` functions found in this package. 

Here are some other helpful online tutorials:  
[basic Google sheets importing tutorial](https://arbor-analytics.com/post/getting-your-data-into-r-from-google-sheets/)  
[more detailed tutorial](https://googlesheets4.tidyverse.org/articles/googlesheets4.html)  
[interaction between the googlesheets4 and tidyverse](https://googlesheets4.tidyverse.org/articles/articles/drive-and-sheets.html)  




<!-- ======================================================= -->
## Import from Github {#import_github}

Importing data directly from Github into R can be very easy or can require a few steps - depending on the file type. Below are some approaches:  

### CSV files 

It can be easy to import a .csv file directly from Github into R with an R command.  

1) Go to the Github repo https://github.com/sahirbhatnagar/knitr-tutorial, locate the file `001-motivating-example/fat-data.csv`, and click on it  
3) Click on the "Raw" button (you will then see the "raw" csv data, as shown below)  
4) Copy the URL (web address)  
5) Place the URL in quotes within the `import()` R command  

<div class="figure" style="text-align: left">
<img src="/Users/runner/work/EPIB607/EPIB607/inst/gifs/git_data.gif" alt="Getting the link to data in .csv format from a GitHub repository." width="100%" />
<p class="caption">(\#fig:unnamed-chunk-11)Getting the link to data in .csv format from a GitHub repository.</p>
</div>

Once you've copied the URL address of the file, you can use the `rio::import` function as follows:


```r
df <- rio::import("https://raw.githubusercontent.com/sahirbhatnagar/knitr-tutorial/master/001-motivating-example/fat-data.csv")
```

```{=html}
<div id="htmlwidget-bf4cd0dfb6b9dff3f587" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-bf4cd0dfb6b9dff3f587">{"x":{"filter":"none","vertical":false,"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148","149","150","151","152","153","154","155","156","157","158","159","160","161","162","163","164","165","166","167","168","169","170","171","172","173","174","175","176","177","178","179","180","181","182","183","184","185","186","187","188","189","190","191","192","193","194","195","196","197","198","199","200","201","202","203","204","205","206","207","208","209","210","211","212","213","214","215","216","217","218","219","220","221","222","223","224","225","226","227","228","229","230","231","232","233","234","235","236","237","238","239","240","241","242","243","244","245","246","247","248","249","250","251"],[12.6,6.9,24.6,10.9,27.8,20.6,19,12.8,5.1,12,7.5,8.5,20.5,20.8,21.7,20.5,28.1,22.4,16.1,16.5,19,15.3,15.7,17.6,14.2,4.6,8.5,22.4,4.7,9.4,12.3,6.5,13.4,20.9,31.1,38.2,23.6,27.5,33.8,31.3,33.1,31.7,30.4,30.8,8.4,14.1,11.2,6.4,13.4,5,10.7,7.4,8.7,7.1,4.9,22.2,20.1,27.1,30.4,24,25.4,28.8,29.6,25.1,31,28.9,21.1,14,7.1,13.2,23.7,9.4,9.1,13.7,12,18.3,9.2,21.7,21.1,18.6,30.2,26,18.2,26.2,26.1,25.8,15,22.6,8.8,14.3,20.2,18.1,9.2,24.2,9.6,17.3,10.1,11.1,17.7,21.7,20.8,20.1,19.8,21.9,24.7,17.8,19.1,18.2,17.2,21,19.5,27.1,21.6,20.9,25.9,16.7,19.8,14.1,25.1,17.9,27,24.6,14.8,16,14,17.4,26.4,17.4,20.4,15,18,22.2,23.1,25.3,23.8,26.3,21.4,28.4,21.8,20.1,24.3,18.1,22.7,9.9,10.8,14.4,19,28.6,6.1,24.5,9.9,19.1,10.6,16.5,20.5,17.2,30.1,10.5,12.8,22,9.9,14.8,13.3,15.2,26.5,19,21.4,20,34.7,16.5,4.1,1.9,20.2,16.8,24.6,10.4,13.4,28.8,22,16.8,25.8,11.9,12.4,17.4,9.2,23,20.1,20.2,23.8,11.8,36.5,16,24,22.3,24.8,21.5,17.6,7.3,22.6,12.5,21.7,27.7,6.8,33.4,16.6,31.7,31.5,10.1,11.3,7.8,26.4,19.3,18.5,19.3,45.1,13.8,8.2,23.9,15.1,12.7,25.3,11.9,6.1,11.3,12.8,14.9,24.5,15,16.9,11.1,16.1,15.5,25.9,25.5,18.4,24,26.4,12.7,28.8,17,33.6,29.3,31.4,28.1,15.3,29.1,11.5,32.3,28.3,25.3,30.7],[23,22,22,26,24,24,26,25,25,23,26,27,32,30,35,35,34,32,28,33,28,28,31,32,28,27,34,31,27,29,32,29,27,41,41,49,40,50,46,50,45,44,48,41,39,43,40,39,45,47,47,40,51,49,42,54,58,62,54,61,62,56,54,61,57,55,54,55,54,55,62,55,56,55,61,61,57,69,81,66,67,64,64,70,72,67,72,64,46,48,46,44,47,46,47,53,38,50,46,47,49,48,41,49,43,43,43,52,43,40,43,43,47,42,48,40,48,51,40,44,52,44,40,47,50,46,42,43,40,42,49,40,47,50,41,44,39,43,40,49,40,40,52,23,23,24,24,25,25,26,26,26,27,27,27,28,28,28,30,31,31,33,33,34,34,35,35,35,35,35,35,35,35,36,36,37,37,37,38,39,39,40,40,40,40,41,41,41,41,41,42,42,42,42,42,42,42,42,43,43,43,43,44,44,44,44,47,47,47,49,49,49,50,50,51,51,51,52,53,54,54,54,55,55,55,55,55,56,56,57,57,58,58,60,62,62,63,64,65,65,65,66,67,67,68,69,70,72,72,72,74],[154.25,173.25,154,184.75,184.25,210.25,181,176,191,198.25,186.25,216,180.5,205.25,187.75,162.75,195.75,209.25,183.75,211.75,179,200.5,140.25,148.75,151.25,159.25,131.5,148,133.25,160.75,182,160.25,168,218.5,247.25,191.75,202.25,196.75,363.15,203,262.75,205,217,212,125.25,164.25,133.5,148.5,135.75,127.5,158.25,139.25,137.25,152.75,136.25,198,181.5,201.25,202.5,179.75,216,178.75,193.25,178,205.5,183.5,151.5,154.75,155.25,156.75,167.5,146.75,160.75,125,143,148.25,162.5,177.75,161.25,171.25,163.75,150.25,190.25,170.75,168,167,157.75,160,176.75,176,177,179.75,165.25,192.5,184.25,224.5,188.75,162.5,156.5,197,198.5,173.75,172.75,196.75,177,165.5,200.25,203.25,194,168.5,170.75,183.25,178.25,163,175.25,158,177.25,179,191,187.5,206.5,185.25,160.25,151.5,161,167,177.5,152.25,192.25,165.25,171.75,171.25,197,157,168.25,186,166.75,187.75,168.25,212.75,176.75,173.25,167,159.75,188.15,156,208.5,206.5,143.75,223,152.25,241.75,146,156.75,200.25,171.5,205.75,182.5,136.5,177.25,151.25,196,184.25,140,218.75,217,166.25,224.75,228.25,172.75,152.25,125.75,177.25,176.25,226.75,145.25,151,241.25,187.25,234.75,219.25,145.75,159.25,170.5,167.5,232.75,210.5,202.25,185,153,244.25,193.5,224.75,162.75,180,156.25,168,167.25,170.75,178.25,150,200.5,184,223,208.75,166,195,160.5,159.75,140.5,216.25,168.25,194.75,172.75,219,149.25,154.5,199.25,154.5,153.25,230,161.75,142.25,179.75,126.5,169.5,198.5,174.5,167.75,147.75,182.25,175.5,161.75,157.75,168.75,191.5,219.15,155.25,189.75,127.5,224.5,234.25,227.75,199.5,155.5,215.5,134.25,201,186.75,190.75,207.5],[67.75,72.25,66.25,72.25,71.25,74.75,69.75,72.5,74,73.5,74.5,76,69.5,71.25,69.5,66,71,71,67.75,73.5,68,69.75,68.25,70,67.75,71.5,67.5,67.5,64.75,69,73.75,71.25,71.25,71,73.5,65,70,68.25,72.25,67,68.75,29.5,70,71.5,68,73.25,67.5,71.25,68.5,66.75,72.25,69,67.75,73.5,67.5,72,68,69.5,70.75,65.75,73.25,68.5,70.25,67,70,67.5,70.75,71.5,69.25,71.5,71.5,68.75,73.75,64,65.75,67.5,69.5,68.5,70.25,69.25,67.75,67.25,72.75,70,69.25,67.5,67.25,65.75,72.5,73,70,69.5,70.5,71.75,74.5,77.75,73.25,66.5,68.25,72,73.5,72,71.25,73.75,69.25,68.5,73.5,74.25,75.5,69.25,68.5,70,70,70.25,71.75,69.25,72.75,72,74,72.25,74.5,71.5,68.75,66.75,66.5,67,68.75,67.75,73.25,69.75,71.5,70.5,73.25,66.75,69.5,69.75,70.75,74,71.25,75,71,69.5,67.75,72.25,77.5,70.75,72.75,69.75,72.5,70.25,69,74.5,72.25,67.25,73.5,75.25,69,72.25,68.75,71.5,72.25,73,68.75,70.5,72,73.75,68,72.25,69.5,69.5,67.75,65.5,71,71.5,71.75,69.25,67,71.5,69.25,74.5,74.25,67.25,69.75,74.25,71.5,74.25,72,72.5,68.25,69.25,76,70.5,74.75,72.75,68.25,69,71.5,72.75,67.5,70.25,69.25,71.5,74,69.75,73,65.5,72.5,70.25,70.75,68,74.5,71.75,70.75,73,64,69.75,70,71.75,69.25,70.5,72.25,67.5,67.25,68.75,66.75,68.25,74.25,69.5,68.5,65.75,71.75,71.5,67.25,67.5,67.5,72.25,69.5,69.5,65.75,65.75,68.25,72,72.75,68.5,69.25,70.5,67,69.75,66,70.5,70],[36.2,38.5,34,37.4,34.4,39,36.4,37.8,38.1,42.1,38.5,39.4,38.4,39.4,40.5,36.4,38.9,42.1,38,40,39.1,41.3,33.9,35.5,34.5,35.7,36.2,38.8,36.4,36.7,38.7,37.3,38.1,39.8,42.1,38.4,38.5,42.1,51.2,40.2,43.2,36.6,37.3,41.5,31.5,35.7,33.6,34.6,32.8,34,34.9,34.3,36.5,35.1,37.8,39.9,39.1,40.5,40.5,38.4,41.4,35.6,38,37.4,40.1,40.9,35.6,36.9,37.5,36.3,35.5,38.7,36.4,33.2,36.5,36,38.7,38.7,37.8,37.4,38.4,38.1,39.3,38.7,38.5,36.5,37.7,36.5,38,36.7,37.2,39.2,37.5,38,37.3,41.1,37.5,38.7,35.9,40,40.1,37,36.3,40.7,39.6,31.1,38.6,42,38.5,34.2,37.2,37.1,40.2,35.3,38,36.3,36.8,41,38.3,38,40.8,39.5,36.9,36.9,37.7,36.6,38.9,37.5,39.8,38.3,35.5,36.3,37.8,37.8,36.5,37.8,37,37.7,34.3,40.8,37.4,36.5,37.5,35.5,38,35.7,39.2,40.9,35.2,40.6,35.4,41.8,34.1,37.9,38.2,35.6,38.5,37,35.9,36.2,35,38.5,40.7,36,39.5,40.5,38.5,43.9,40.4,37.6,37,34,38.4,38.7,41.5,36,35.3,42.1,38,42.8,40,35.5,35.3,37.7,39.4,41.9,38.5,40.8,38,36.4,41.8,40.7,38.5,35.4,38.5,35.5,36.5,37.6,37.4,37.8,35.2,37.9,37.9,40.9,41.9,39.1,40.2,36,34.5,35.8,40.2,38.3,39,37.4,41.2,34.8,36.9,39.4,37.6,38.5,42.5,37.4,35.2,41.1,33.4,37.2,38.3,38.1,37.4,35.2,39.4,38,35.1,40.4,38.3,40.6,40.2,37.9,40.8,34.7,38.8,41.4,41.3,40.7,36.3,40.8,34.9,40.9,38.9,38.9,40.8],[93.1,93.6,95.8,101.8,97.3,104.5,105.1,99.6,100.9,99.6,101.5,103.6,102,104.1,101.3,99.1,101.9,107.6,106.8,106.2,103.3,111.4,86,86.7,90.2,89.6,88.6,97.4,93.5,97.4,100.5,93.5,93,111.7,117,118.5,106.5,105.6,136.2,114.8,128.3,106,113.3,106.6,85.1,96.6,88.2,89.8,92.3,83.4,90.2,89.2,89.7,93.3,87.6,107.6,100,111.5,115.4,104.8,112.3,102.9,107.6,105.3,105.3,103,90,95.4,89.3,94.4,97.6,88.5,93.6,87.7,93.4,91.6,91.6,102,96.4,102.7,97.7,97.1,103.1,101.8,101.4,98.9,97.5,104.3,97.3,96.7,99.7,101.9,97.2,106.6,99.6,113.2,99.1,99.4,95.1,107.5,106.5,99.1,96.7,103.5,104,93.1,105.2,110,110.1,97.8,96.3,108,99.7,93.5,100.7,97,96,99.2,95.4,101.8,104.3,99.2,99.3,94,98.9,101,98.7,95.9,103.9,96.2,97.8,94.6,103.6,100.4,98.4,104.6,92.9,97.8,98.3,104.7,98.6,99.5,102.7,92.1,96.6,92.7,102,110.9,92.3,114.1,92.9,108.3,88.5,94,101.1,92.1,105.6,98.5,88.7,101.1,94,103.8,98.9,89.2,111.4,107.5,99.1,108.2,114.9,99.1,92.2,90.8,100.5,98.2,115.3,96.8,92.6,119.2,102.7,109.5,108.5,95.5,92.3,98.9,89.5,117.5,107.4,109.2,103.4,91.4,115.2,104.9,106.7,92.2,101.6,97.8,92,94,103.7,102.7,91.1,107.2,100.8,121.6,105.6,100.6,102.7,99.8,92.9,91.2,115.6,98.3,103.7,98.7,119.8,92.8,93.3,106.8,93.9,99,119.9,94.2,92.7,106.9,88.8,101.7,105.3,104,98.6,99.6,103.4,100.2,94.9,97.2,104.7,104,117.6,95.8,106.4,93,119.6,119.7,115.8,118.3,97.4,113.7,89.2,108.5,111.1,108.3,112.4],[85.2,83,87.9,86.4,100,94.4,90.7,88.5,82.5,88.6,83.6,90.9,91.6,101.8,96.4,92.8,96.4,97.5,89.6,100.5,95.9,98.8,76.4,80,76.3,79.7,74.6,88.7,73.9,83.5,88.7,84.5,79.1,100.5,115.6,113.1,100.9,98.8,148.1,108.1,126.2,104.3,111.2,104.3,76,81.5,73.7,79.5,83.4,70.4,86.7,77.9,82,79.6,77.6,100,99.8,104.2,105.3,98.3,104.8,94.7,102.4,99.7,105.5,100.3,83.9,86.6,78.4,84.6,91.5,82.8,82.9,76,83.3,81.8,78.8,95,95.4,98.6,95.8,89,97.8,94.9,99.8,89.7,88.1,90.9,86,86.5,95.6,93.2,83.1,97.5,88.8,99.2,91.6,86.7,88.2,94,95,92,89.2,95.5,98.6,87.3,102.8,101.6,88.7,92.3,90.6,105,95,89.6,92.4,86.6,90,90,92.4,87.5,99.2,98.1,83.3,86.1,84.1,89.9,92.1,78,93.5,87,90.1,90.3,99.8,89.4,87.2,101.1,86.1,98.6,88.5,106.6,93.1,93,91,77.1,85.3,81.9,99.1,100.5,76.5,106.8,77.6,102.9,72.8,88.2,100.1,83.5,105,90.8,76.6,92.4,81.2,95.6,92.1,83.4,106,95.1,90.4,100.4,115.9,90.8,81.9,75,90.3,90.3,108.8,79.4,83.2,110.3,92.7,104.5,104.6,83.6,86.8,90.4,83.7,109.3,98.9,98,101.2,80.6,113.7,94.1,105.7,85.6,96.6,86,89.7,78,89.7,89.2,85.7,103.1,89.1,113.9,96.3,93.9,101.3,83.9,84.4,79.4,104,89.7,97.6,87.6,122.1,81.1,81.5,100,88.7,91.8,110.4,87.6,82.8,95.3,78.2,91.1,96.7,89.4,93,86.4,96.7,88.1,94.9,93.3,95.6,98.2,113.8,82.8,100.5,79.7,118,109,113.4,106.1,84.3,107.6,83.6,105,111.5,101.3,108.5],[94.5,98.7,99.2,101.2,101.9,107.8,100.3,97.1,99.9,104.1,98.2,107.7,103.9,108.6,100.1,99.2,105.2,107,102.4,109,104.9,104.8,94.6,93.4,95.8,96.5,85.3,94.7,88.5,98.7,99.8,100.6,94.5,108.3,116.1,113.8,106.2,104.8,147.7,102.5,125.6,115.5,114.1,106,88.2,97.2,88.5,92.7,90.4,87.2,98.3,91,89.1,91.6,88.6,99.6,102.5,105.8,97,99.6,103.1,100.8,99.4,99.7,108.3,104.2,93.9,91.8,96.1,94.3,98.5,95.5,96.3,88.6,93,94.8,94.3,98.3,99.3,100.2,97.1,96.9,99.6,95,96.2,96.2,96.9,93.8,99.3,98.3,102.2,100.6,95.4,100.6,101.4,107.5,102.4,96.2,92.8,103.7,101.7,98.3,98.3,101.6,99.5,96.6,103.6,100.7,102.1,100.6,99.3,103,98.6,99.8,97.5,92.6,99.7,96.4,104.3,101,104.1,101.4,97.5,95.2,94,100,98.5,93.2,99.5,97.8,95.8,99.1,103.2,92.3,98.4,102.1,95.6,100.6,98.3,107.7,101.6,99.3,98.9,93.9,102.5,95.3,110.1,106.2,92.1,113.9,93.5,114.4,91.1,95.2,105,98.3,106.4,102.5,89.8,99.3,91.5,105.1,103.5,89.6,108.8,104.5,95.6,106.8,111.9,98.1,92.8,89.2,98.7,99.9,114.4,89.2,96.4,113.9,101.9,109.9,109.8,91.6,96.1,95.5,98.1,108.8,104.1,101.8,103.1,92.3,112.4,102.7,111.8,96.5,100.6,96.2,101,99,94.2,99.2,96.9,105.5,102.6,107.1,102,100.1,101.7,91.8,94,89,109,99.1,104.2,96.1,112.8,96.3,94.4,105,94.5,96.2,105.5,95.6,91.9,98.2,87.5,97.1,106.6,98.4,97,90.1,100.7,97.8,100.2,94,93.7,101.1,111.8,94.5,100.5,87.6,114.3,109.1,109.8,101.6,94.4,110,88.8,104.5,101.7,97.8,107.1],[59,58.7,59.6,60.1,63.2,66,58.4,60,62.9,63.1,59.7,66.2,63.4,66,69,63.1,64.8,66.9,64.2,65.8,63.5,63.4,57.4,54.9,58.4,55,51.7,57.5,50.1,58.9,57.5,58.5,57.3,67.1,71.2,61.9,63.5,66,87.3,61.3,72.5,70.6,67.7,65,50,58.4,53.3,52.7,52,50.6,52.6,51.4,49.3,52.6,51.9,57.2,62.1,61.8,59.1,60.6,61.6,60.9,61,60.8,65,64.8,55,54.3,56,51.2,56.6,58.9,52.9,50.9,55.5,54.5,56.7,55,53.5,56.5,54.8,54.8,58.9,56,56.3,54.7,57.2,57.8,61,60.4,58.3,58.9,56.9,58.9,57.4,61.7,60.6,62.1,54.7,62.7,59,59.3,60,59.1,59.5,54.7,61.2,55.8,57.5,57.5,61.9,63.7,62.3,61.5,59.3,55.9,58.8,56.8,64.6,58.5,58.5,57.1,60.5,58.1,58.5,60.7,60.7,53.5,61.7,57.4,57,60.3,61.2,56.1,56,58.9,58.8,63.6,58.1,66.5,59.1,60.4,57.1,56.1,59.1,56.4,71.2,68.4,51.9,67.6,56.9,72.9,53.6,56.8,62.1,57.3,68.6,60.8,50.1,59.4,52.5,61.4,64,52.4,63.8,64.8,55.5,63.3,74.4,60.1,54.7,50,57.8,59.2,69.2,50.3,60,69.8,64.7,69.5,68.1,54.1,58,55.4,57.3,67.7,63.5,62.8,61.5,54.3,68.5,60.6,65.3,60.2,61.1,57.7,62.3,57.5,58.5,60.2,55.5,68.8,60.6,63.5,63.3,58.9,60.7,53,56,51.1,63.7,56.3,60,57.1,62.5,53.8,54.7,63.9,53.7,57.7,64.2,59.7,54.4,57.4,50.8,56.6,64,58.4,55.4,53,59.3,57.1,56.8,54.3,54.4,59.3,63.4,61.2,59.2,50.7,61.3,63.7,65.6,58.2,54.3,63.3,49.6,59.6,60.3,56,59.3],[37.3,37.3,38.9,37.3,42.2,42,38.3,39.4,38.3,41.7,39.7,39.2,38.3,41.5,39,38.7,40.8,40,38.7,40.6,38,40.6,35.3,36.2,35.5,36.7,34.7,36,34.5,35.3,38.7,38.8,36.2,44.2,43.3,38.3,39.9,41.5,49.1,41.1,39.6,42.5,40.9,40.2,34.7,38.2,34.5,37.5,35.8,34.4,37.2,34.9,33.7,37.6,34.9,38,39.6,39.8,38,37.7,40.9,38,39.4,40.1,41.2,40.2,36.1,35.4,37.4,37.4,38.6,37.6,37.5,35.4,35.2,37,39.7,38.3,37.5,39.3,38.2,38,39,36.5,36.6,37.8,37.7,39.5,38.4,39.9,38.2,39.7,38.3,40.5,39.6,42.3,39.4,39.3,37.3,39,39.4,38.4,38.4,39.8,36.1,39,39.3,38.7,40,36.8,38,40,38.1,37.8,38.1,36.3,38.4,38.8,41.1,39.2,39.3,40.5,38.7,36.5,36.6,36,36.8,35.8,39,36.9,38.7,38.5,38.1,35.6,36.9,37.9,36.1,39.2,38.4,42.5,39.6,38.2,36.7,36.1,37.6,36.5,43.5,40.8,35.7,42.7,35.9,43.5,36.8,37.4,40,37.8,40,38.5,34.8,39,36.6,40.6,37.3,35.6,42,41.3,34.2,41.7,40.6,39.1,36.2,34.8,37.3,37.7,42.4,34.8,38.1,42.6,39.5,43.1,42.8,36.2,39.4,38.9,39.7,41.3,39.8,41.3,40.4,36.3,45,38.6,43.3,38.9,38.4,38.6,38,40,39,39.2,35.7,38.3,39,40.3,39.8,37.6,39.4,36.2,38.2,35,40.3,38.8,40.9,38.1,36.9,36.5,39,39.2,36.2,38.1,42.7,40.2,35.2,37.1,33,38.5,42.6,37.4,38.8,35,38.6,38.9,35.9,35.7,37.1,40.3,41.1,39.1,38.1,33.4,42.1,42.4,46,38.8,37.5,44,34.8,40.8,37.3,41.6,42.2],[21.9,23.4,24,22.8,24,25.6,22.9,23.2,23.8,25,25.2,25.9,21.5,23.7,23.1,21.7,23.1,24.4,22.9,24,22.1,24.6,22.2,22.1,22.9,22.5,21.4,21,21.3,22.6,33.9,21.5,24.5,25.2,26.3,21.9,22.6,24.7,29.6,24.7,26.6,23.7,25,23,21,23.4,22.5,21.9,20.6,21.9,22.4,21,21.4,22.6,22.5,22,22.5,22.7,22.5,22.9,23.1,22.1,23.6,22.7,24.7,22.7,21.7,21.5,22.4,21.6,22.4,21.6,23.1,19.1,20.9,21.4,24.2,21.8,21.5,22.7,23.7,22,23,24.1,22,33.7,21.8,23.3,23.8,24.4,22.5,23.1,22.1,24.5,24.6,23.2,22.9,23.3,21.9,22.3,22.3,22.4,23.2,25.4,22,24.8,23.5,23.4,24.8,22.8,22.3,23.6,23.9,21.9,21.8,22.1,22.8,23.3,24.8,24.5,24.6,23.2,22.6,22.1,23.5,21.9,22.2,20.8,21.8,22.2,23.2,23,22.6,20.5,23,22.7,22.4,23.8,22.5,24.5,21.6,22,22.3,22.7,23.2,22,25.2,24.6,22,24.7,20.4,25.1,23.8,22.8,24.9,21.7,25.2,25,21.8,24.6,21,25,23.5,20.4,23.4,25.6,21.9,24.6,24,23.4,22.1,22,22.4,21.5,24,22.2,22,24.8,24.7,25.8,24.1,21.8,22.7,22.4,22.6,24.7,23.5,24.8,22.9,21.8,25.5,24.7,26,22.4,24.1,24,22.3,22.5,24.1,23.8,22,23.7,24,21.8,24.1,21.4,23.3,22.5,22.6,21.7,23.2,23,25.5,21.8,23.6,21.5,22.6,22.9,22,23.9,27,23.4,22.5,21.8,19.7,22.6,23.4,22.5,23.2,21.3,22.8,23.6,21,21,22.7,23,22.3,22.3,24,20.1,23.4,24.6,25.4,24.1,22.6,22.6,21.5,23.2,21.5,22.7,24.6],[32,30.5,28.8,32.4,32.2,35.7,31.9,30.5,35.9,35.6,32.8,37.2,32.5,36.9,36.1,31.1,36.2,38.2,37.2,37.1,32.5,33,27.9,29.8,31.1,29.9,28.7,29.2,30.5,30.1,32.5,30.1,29,37.5,37.3,32,35.1,33.2,45,34.1,36.4,33.6,36.7,35.8,26.1,29.7,27.9,28.8,28.8,26.8,26,26.7,29.6,38.5,27.7,35.9,33.1,37.7,31.6,34.5,36.2,32.5,32.7,33.6,35.3,34.8,29.6,32.8,32.6,27.3,31.5,30.3,29.7,29.3,29.4,29.3,30.2,30.8,31.4,30.3,29.4,29.9,34.3,31.2,29.7,32.4,32.6,29.2,30.2,28.8,29.1,31.4,30.1,33.3,30.3,32.9,31.6,30.6,31.6,35.3,32.2,27.9,31,31,30.1,31,30.5,35.1,35.1,32.1,33.3,33.5,35.3,30.7,31.8,29.8,29.9,33.4,33.6,32.1,33.9,33,34.4,30.6,34.4,35.6,33.8,33.9,33.3,31.6,27.5,31.2,33.5,33.6,34,30.9,32.7,34.3,31.7,35.5,30.8,32,31.6,30.5,31.8,33.5,36.1,33.3,25.8,36,31.6,38.5,27.8,30.6,33.7,32.2,35.2,31.6,27,30.1,27,31.3,33.5,28.3,34,36.4,30.2,37.2,36.1,32.5,30.4,24.8,31,32.4,35.4,31,31.5,34.4,34.8,39.1,35.6,31.4,30,30.5,32.9,37.2,36.4,36.6,33.4,29.6,37.1,34,33.7,31.7,32.9,31.2,30.8,30.6,33.8,31.7,29.4,32.1,32.9,34.8,37.3,33.1,36.7,31.4,29,30.9,36.8,29.5,32.7,28.6,34.7,31.3,27.5,35.7,28.5,31.4,38.4,27.9,29.4,34.1,25.3,33.4,33.2,34.6,32.4,31.7,31.8,30.9,27.8,31.3,30.3,32.6,35.1,29.8,35.9,28.5,34.9,35.6,35.3,32.1,29.2,37.5,25.6,35.2,31.3,30.5,33.7],[27.4,28.9,25.2,29.4,27.7,30.6,27.8,29,31.1,30,29.4,30.2,28.6,31.6,30.5,26.4,30.8,31.6,30.5,30.1,30.3,32.8,25.9,26.7,28,28.2,27,26.6,27.9,26.7,27.7,26.4,30,31.5,31.7,29.8,30.6,30.5,29,31,32.7,28.7,29.8,31.5,23.1,27.4,26.2,26.8,25.5,25.8,25.8,26.1,26,27.4,27.5,30.2,28.3,30.9,28.8,29.6,31.8,29.8,29.9,29,31.1,30.1,27.4,27.4,28.1,27.1,27.3,27.3,27.3,25.7,27,27,29.2,25.7,26.8,28.7,27.2,25.2,29.6,27.3,26.3,27.7,28,28.4,29.3,29.6,27.7,28.4,28.2,29.6,27.9,30.8,30.1,27.8,27.5,30.9,31,26.2,29.2,30.3,27.2,29.4,28.5,29.6,30.7,26,28.2,27.8,31.1,27.6,27.3,26.3,28,29.8,29.5,28.6,31.2,29.6,28,27.5,29.2,30.2,30.3,28.2,29.6,27.8,26.5,28.4,28.6,29.3,29.8,28.8,28.3,28.4,27.4,29.8,27.9,28.5,27.5,27.2,29.7,28.3,30.3,29.7,25.2,30.4,29,33.8,26.3,28.3,29.2,27.7,30.7,28,34.9,28.2,26.3,29.2,30.6,26.2,31.2,33.7,28.7,33.1,31.8,29.8,27.4,25.9,28.7,28.4,21,26.9,26.6,29.5,30.3,32.5,29,28.3,26.4,28.9,29.3,31.8,30.4,32.4,29.2,27.3,31.2,30.1,29.9,27.1,29.8,27.3,27.8,30,28.8,28.4,26.6,28.9,29.2,30.7,23.1,29.5,31.6,27.5,26.2,28.8,31,27.9,30,26.7,29.1,26.3,25.9,30.4,25.7,29.9,32,27,26.8,31.1,22,29.3,30,30.1,29.7,27.3,29.1,29.6,26.1,28.7,26.3,28.5,29.6,28.9,30.5,24.8,30.1,30.7,29.8,29.3,27.3,32.6,25.7,28.6,27.2,29.4,30],[17.1,18.2,16.6,18.2,17.7,18.8,17.7,18.8,18.2,19.2,18.5,19,17.7,18.8,18.2,16.9,17.3,19.3,18.5,18.2,18.4,19.9,16.7,17.1,17.6,17.7,16.5,17,17.2,17.6,18.4,17.9,18.8,18.7,19.7,17,19,19.4,21.4,18.3,21.4,17.4,18.4,18.8,16.1,18.3,17.3,17.9,16.3,16.8,17.3,17.2,16.9,18.5,18.5,18.9,18.5,19.2,18.2,18.5,20.2,18.3,19.1,18.8,18.4,18.7,17.4,18.7,18.1,17.3,18.6,18.3,18.2,16.9,16.8,18.3,18.1,18.8,18.3,19,19,17.7,19,19.2,18,18.2,18.8,18.1,18.8,18.7,17.7,18.8,18.4,19.1,17.8,20.4,18.5,18.2,18.2,18.3,18.6,17,18.4,19.7,17.7,18.8,18.1,19.1,19.2,17.3,18.1,17.4,19.8,17.4,17.5,17.3,18.1,19.5,18.5,18,19.5,18.4,17.6,17.6,18,17.6,17.2,17.4,18.1,17.7,17.6,17.1,17.9,17.3,18.1,17.6,17.1,17.7,17.6,18.7,16.6,17.8,17.9,18.2,18.3,17.3,18.7,18.4,16.9,18.4,17.8,19.6,17.4,17.9,19.4,17.7,19.1,18.6,16.9,18.2,16.5,19.1,19.7,16.5,18.5,19.4,17.7,19.8,18.8,17.4,17.7,16.9,17.7,17.8,20.1,16.9,16.7,18.4,18.1,19.9,19,17.2,17.4,17.7,18.2,20,19.1,18.8,18.5,17.9,19.9,18.7,18.5,17.1,18.8,17.4,16.9,18.5,18.8,18.6,17.4,18.7,18.4,17.4,19.4,17.3,18.4,17.7,17.6,17.4,18.9,18.6,19,18,18.4,17.8,18.6,19.2,17.1,18.9,19.6,17.8,17,19.2,15.8,18.8,18.4,18.8,19,16.9,19,18,17.6,18.3,18.3,19,18.5,18.3,19.1,16.5,19.4,19.5,19.5,18.5,18.5,18.8,18.5,20.1,18,19.8,20.9]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>pbf1<\/th>\n      <th>age<\/th>\n      <th>weight<\/th>\n      <th>height<\/th>\n      <th>neck<\/th>\n      <th>chest<\/th>\n      <th>abdomen<\/th>\n      <th>hip<\/th>\n      <th>thigh<\/th>\n      <th>knee<\/th>\n      <th>ankle<\/th>\n      <th>bicep<\/th>\n      <th>forearm<\/th>\n      <th>wrist<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"className":"dt-right","targets":[1,2,3,4,5,6,7,8,9,10,11,12,13,14]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>
```


### XLSX files 

You may not be able to view the "Raw" data for some files (e.g. .xlsx, .rds, .nwk, .shp)  

1) Go to the Github repo, locate the file of interest, and click on it  
2) Click the "Download" button, as shown below  
3) Save the file on your computer, and import it into R  


<img src="/Users/runner/work/EPIB607/EPIB607/inst/figures/download_xlsx.png" width="100%" style="display: block; margin: auto auto auto 0;" />



<!-- ======================================================= -->
## Manual data entry 

### Entry by rows 

Use the `tribble` function from the **tibble** package from the tidyverse ([online tibble reference](https://tibble.tidyverse.org/reference/tribble.html)).  
  
Note how column headers start with a *tilde* (`~`).  Also note that each column must contain only one class of data (character, numeric, etc.). You can use tabs, spacing, and new rows to make the data entry more intuitive and readable. Spaces do not matter between values, but each row is represented by a new line of code. For example:  


```r
# create the dataset manually by row
manual_entry_rows <- tibble::tribble(
  ~colA, ~colB,
  "a",   1,
  "b",   2,
  "c",   3
  )
```

And now we display the new dataset:  


```{=html}
<div id="htmlwidget-e32a60ff0a0fece1cfa4" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-e32a60ff0a0fece1cfa4">{"x":{"filter":"none","vertical":false,"data":[["1","2","3"],["a","b","c"],[1,2,3]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>colA<\/th>\n      <th>colB<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"className":"dt-right","targets":2},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>
```


### Entry by columns 

Since a data frame consists of vectors (vertical columns), the **base** approach to manual dataframe creation in R expects you to define each column and then bind them together. This can be counter-intuitive in epidemiology, as we usually think about our data in rows (as above). 


```r
# define each vector (vertical column) separately, each with its own name
PatientID <- c(235, 452, 778, 111)
Treatment <- c("Yes", "No", "Yes", "Yes")
Death     <- c(1, 0, 1, 0)
```

<span style="color: orange;">**_CAUTION:_** All vectors must be the same length (same number of values).</span>

The vectors can then be bound together using the function `data.frame()`:  


```r
# combine the columns into a data frame, by referencing the vector names
manual_entry_cols <- data.frame(PatientID, Treatment, Death)
```

And now we display the new dataset:  


```{=html}
<div id="htmlwidget-bb96f095e84a1c9b5f4b" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-bb96f095e84a1c9b5f4b">{"x":{"filter":"none","vertical":false,"data":[["1","2","3","4"],[235,452,778,111],["Yes","No","Yes","Yes"],[1,0,1,0]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>PatientID<\/th>\n      <th>Treatment<\/th>\n      <th>Death<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"className":"dt-right","targets":[1,3]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>
```




### Pasting from clipboard 

If you copy data from elsewhere and have it on your clipboard, you can try using the [datapasta](https://www.r-pkg.org/pkg/datapasta) R package which allows you to import as a data frame as shown in Figure \@ref(fig:datapasta):  

<div class="figure" style="text-align: left">
<img src="/Users/runner/work/EPIB607/EPIB607/inst/gifs/tribble_paste.gif" alt="Copying data to your clipboard and pasting as a data frame in R." width="100%" />
<p class="caption">(\#fig:datapasta)Copying data to your clipboard and pasting as a data frame in R.</p>
</div>

 






<!-- ======================================================= -->
## Export {}  

### With **rio** package 
With **rio**, you can use the `rio::export()` function in a very similar way to `rio::import()`. First give the name of the R object you want to save (e.g. `linelist`) and then in quotes put the file path where you want to save the file, including the desired file name and file extension. For example:  

This saves the data frame `linelist` as an Excel workbook to the working directory (R Project root folder):  


```r
rio::export(linelist, "my_linelist.xlsx") # will save to working directory
```

You could save the same data frame as a csv file by changing the extension. For example, we also save it to a file path constructed with `here()`:  


```r
rio::export(linelist, here::here("data", "clean", "my_linelist.csv"))
```


## RDS files {#import_rds}

Along with .csv, .xlsx, etc, you can also export/save R data frames as .rds files. This is a file format specific to R, and is very useful if you know you will work with the exported data again in R. 

The classes of columns are stored, so you don't have do to cleaning again when it is imported (with an Excel or even a CSV file this can be a headache!). It is also a smaller file, which is useful for export and import if your dataset is large.  


```r
rio::export(linelist, here::here("data", "clean", "my_linelist.rds"))
```



<!-- ======================================================= -->
## Rdata files and lists {#import_rdata}

`.Rdata` files can store multiple R objects - for example multiple data frames, model results, lists, etc. This can be very useful to consolidate or share a lot of your data for a given project.  

In the below example, multiple R objects are stored within the exported file "my_objects.Rdata":  


```r
rio::export(my_list, my_dataframe, my_vector, "my_objects.Rdata")
```

Note: if you are trying to *import* a list, use `rio::import_list()` to import it with the complete original structure and contents.  


```r
rio::import_list("my_list.Rdata")
```







<!-- ======================================================= -->
## Saving plots {} 

Instructions on how to save plots, such as those created by `ggplot()`, are discussed in depth in the [ggplot basics] page.  

In brief, run `ggsave("my_plot_filepath_and_name.png")` after printing your plot. You can either provide a saved plot object to the `plot = ` argument, or only specify the destination file path (with file extension) to save the most recently-displayed plot. You can also control the `width = `, `height = `, `units = `, and `dpi = `.  

How to save a network graph, such as a transmission tree, is addressed in the page on [Transmission chains]. 


<!-- ======================================================= -->
## Resources {} 

The [R Data Import/Export Manual](https://cran.r-project.org/doc/manuals/r-release/R-data.html)  
[R 4 Data Science chapter on data import](https://r4ds.had.co.nz/data-import.html#data-import)  
[ggsave() documentation](https://ggplot2.tidyverse.org/reference/ggsave.html)  


Below is a table, taken from the **rio** online [vignette](https://cran.r-project.org/web/packages/rio/vignettes/rio.html). For each type of data it shows: the expected file extension, the package **rio** uses to import or export the data, and whether this functionality is included in the default installed version of **rio**.  



Format                     | Typical Extension | Import Package    | Export Package     | Installed by Default
---------------------------|-------------------|-------------------|--------------------|---------------------
Comma-separated data | .csv | data.table `fread()` | data.table |	Yes
Pipe-separated data |	.psv | data.table `fread()` | data.table | Yes
Tab-separated data| .tsv | data.table `fread()` | data.table | Yes
SAS | .sas7bdat | haven | haven | Yes
SPSS | .sav | haven | haven | Yes
Stata | .dta | haven | haven | Yes
SAS | XPORT | .xpt | haven | haven | Yes
SPSS Portable | .por | haven | | Yes
Excel | .xls | readxl | | Yes
Excel | .xlsx | readxl | openxlsx | Yes
R syntax | .R	| base | base | Yes
Saved R objects | .RData, .rda | base | base | Yes
Serialized R objects | .rds | base | base | Yes
Epiinfo | .rec | foreign | | Yes
Minitab | .mtp | foreign | | Yes
Systat | .syd |	foreign | | Yes
“XBASE” | database files | .dbf | foreign | foreign | Yes
Weka Attribute-Relation File Format | .arff | foreign | foreign | Yes
Data Interchange Format | .dif | utils | | Yes
Fortran data | no recognized extension | utils | | Yes
Fixed-width format data | .fwf | utils | utils | Yes
gzip comma-separated data | .csv.gz | utils | utils | Yes
CSVY (CSV + YAML metadata header) | .csvy | csvy | csvy | No
EViews | .wf1 |hexView | | No
Feather R/Python interchange format | .feather | feather | feather | No
Fast Storage | .fst | fst |	fst | No
JSON | .json | jsonlite | jsonlite | No
Matlab | .mat | rmatio | rmatio | No
OpenDocument Spreadsheet | .ods | readODS | readODS | No
HTML Tables | .html | xml2 | xml2 | No
Shallow XML documents | .xml | xml2 | xml2 | No
YAML | .yml | yaml | yaml	| No
Clipboard	default is tsv | |  clipr | clipr | No


