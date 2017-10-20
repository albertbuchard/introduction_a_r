# R Introduction
Introductory course to R and Data analysis

Main file is [scripts/markdown/introduction.pdf](https://github.com/albertbuchard/introduction_a_r/blob/master/scripts/markdown/introduction.pdf)

# How to keep your code clean
## Coding convention
* Pick a naming convention and stick to it
  + snake_case = "this is a nice too"
  + camelCase = "this is ok too"

* Comment your code
* Look at the google style book to make sure your code is easilly readable by anyone
  + [Google style guide](https://google.github.io/styleguide/Rguide.xml)
  + they advice to use only "<-" and not "=" but I personally think it is pointless

## Storage
Keep a README.md file at the root of your folder explaining where everything is,
helping someone that knows nothing about your data to navigate your work.
Keeping your work in the cloud, through services like dropbox, icloud, or google drive.
The best would be github but it is not easy in the beginning.

## Folders
Keep your folder clean, with clear names in minuscules separated by "\_" :

* data
    + raw
    + preprocessed
    + analysis
        + analysis_one ...

* scripts
    + preprocessing: scripts that transforms the raw data in processed data
    + analysis: scripts that use preprocessed data and performs analysis on it
    + markdown: your markdown files
    + r_files: other R files, like utility functions

* media: here should go any ressources, presentations, images you produced or needed etc...
    + presentations
    + graphics
    + text
    + notes

* backups: you might need a backup folder when in doubt
    + data
    + script
    + media


# Cheat sheet
## Install R


- [Installing R on Windows](http://youtu.be/mfGFv-iB724)
- [Installing R on Mac](http://youtu.be/Icawuhf0Yqo)

## Get RStudio
- [Here](http://www.rstudio.com/products/rstudio/download/) +++


## SWIRL
For a good interactive tutorial directly built in R try [SWIRL](http://swirlstats.com/ )

To start a swirl session enter in the console : +++

```R
install.packages("swirl")
library("swirl")
swirl()
```

## Style Guides - Good to read before programming
- [Google Style Guide](https://google.github.io/styleguide/Rguide.xml) ++
- [Advanced R - Functions](http://adv-r.had.co.nz/Functions.html)
- [R packages](http://r-pkgs.had.co.nz/r.html)
- [HipsterR](http://kbroman.org/hipsteR/)

## Books
- [Advanced R](http://adv-r.had.co.nz/)
- [R companion](https://rcompanion.org/rcompanion/a_02.html)
- [R for data science](http://r4ds.had.co.nz/)

## Data Exploration
![Data analysis pipeline](http://r4ds.had.co.nz/diagrams/data-science-explore.png)

### Ressources
- [The Tidyverse](https://www.tidyverse.org/)
- [Psych package Guide for the impatient](https://cran.r-project.org/web/packages/psych/vignettes/overview.pdf) ++
- https://www.youtube.com/watch?v=40tyOFMZUSM
- https://www.youtube.com/watch?v=mAOvzjqQcO0

### Import
- [readr](https://cran.r-project.org/web/packages/readr/README.html)
-

### Tidy
- [TidyR](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)
- [Reshape2](http://seananderson.ca/2013/10/19/reshape.html)
- [Broom](https://cran.r-project.org/web/packages/broom/vignettes/broom.html)


### Transformation
- [dplyr](https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html)
- [Data.tables](https://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.html)
- [Pipe operators](http://r4ds.had.co.nz/pipes.html)
- [Purr](https://cran.r-project.org/web/packages/purrr/purrr.pdf)
- [Tibbles](https://cran.r-project.org/web/packages/tibble/vignettes/tibble.html)
- [Glue](https://github.com/tidyverse/glue)

### Visualization
- [GGPlot2](http://ggplot2.tidyverse.org/reference/)
- [GGVis](http://ggvis.rstudio.com/) - vs [ggplot2](http://ggvis.rstudio.com/ggplot2.html)
- [Cookbook for R](http://www.cookbook-r.com/Graphs/)
- [Shiny](https://shiny.rstudio.com/)

## Statistics
- [Ben Meuleman Bayes Factor presentation](https://github.com/albertbuchard/introduction_a_r/blob/master/media/presentation/CISA_peers_bayes_Ben_Meuleman.pptx)
- [Structural Equation Modeling](https://github.com/albertbuchard/introduction_a_r/blob/master/media/presentation/structural_equation_modeling.pptx)
- packages
    + pastecs: stat.desc
    + fBasics: basicStats

## Modeling
### Videos
- https://www.youtube.com/watch?v=rz3_FDVt9eg

### Packages
- Zelig
- Caret

### Interpolation and Fitting
- https://stat.ethz.ch/R-manual/R-patched/library/stats/html/approxfun.html
- https://stat.ethz.ch/R-manual/R-devel/library/stats/html/splinefun.html
- https://stat.ethz.ch/R-manual/R-devel/library/stats/html/predict.smooth.spline.html

### Diffusion model
- https://journal.r-project.org/archive/2014-1/vandekerckhove-wabersich.pdf

## Markdown
### Intro
- http://rmarkdown.rstudio.com/
- Two main library for formatting
    * [Knitr](http://kbroman.org/knitr_knutshell/pages/Rmarkdown.html)
    * [printr](http://yihui.name/printr/)

### Examples
- [dynamic calling to markdown templates](http://stackoverflow.com/questions/12095113/r-knitr-possible-to-programmatically-modify-chunk-labels)

## R packages
### Creating it
- [Video](https://www.youtube.com/watch?v=9PyQlbAEujY)
- http://r-pkgs.had.co.nz/vignettes.html
- [Video](https://www.youtube.com/watch?v=RT9OPxbUUmI)
- https://cran.r-project.org/doc/manuals/r-release/R-exts.html

### Documentation/Comments
- http://r-pkgs.had.co.nz/man.html
- http://kbroman.org/pkg_primer/pages/docs.html
- http://stackoverflow.com/questions/12038160/how-to-not-run-an-example-using-roxygen2
    * For example code you do not want to run use : ``\dontrun{}``

### Import/Depend
- http://blog.obeautifulcode.com/R/How-R-Searches-And-Finds-Stuff/
- http://kbroman.org/pkg_primer/pages/build.html

### Putting it on github
- http://kbroman.org/pkg_primer/pages/github.html

### Putting it on cran
- http://kbroman.org/pkg_primer/pages/cran.html

### Install a package from source file
- http://stackoverflow.com/questions/1474081/how-do-i-install-an-r-package-from-source

## Object Oriented programming
- https://stat.ethz.ch/R-manual/R-devel/library/methods/html/refClass.html
- https://cran.r-project.org/web/packages/R6/vignettes/Introduction.html

### Choosing between object type
- http://stackoverflow.com/questions/27219132/creating-classes-in-r-s3-s4-r5-rc-or-r6
- http://stackoverflow.com/questions/11653127/what-does-the-function-invisible-do

## Multicore
- [multidplyr]()
- [parallel](http://stat.ethz.ch/R-manual/R-devel/library/parallel/doc/parallel.pdf)
- [Parallel R Book](http://www.amazon.com/exec/obidos/ASIN/1449309925/7210-20)

## Debugging
- https://cran.r-project.org/doc/manuals/r-patched/R-exts.html#Debugging-R-code
- options(error = dump.frames); debugger()
- stringAsFactor options causes frequent error

[messy google doc](https://docs.google.com/document/d/1_OEpDCsDbtU6mublqju59G5sg8_J3RVhEULveSviklo/edit?usp=sharing)

---

Work in progress - help welcome !

---

Bavelier Lab 2016

(MIT License)
