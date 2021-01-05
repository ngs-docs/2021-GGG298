---
tags: ggg, ggg2021, ggg298
---
# GGG298 -- Week 10 - Rmarkdown for reports, documentation and beyond 

[toc]

## Objectives

* understand what an Rmarkdown document is
* gain insight into how Rmarkdown documents can help your research
* acquire basic Rmarkdown syntax

## What is Rmarkdown?

Rmarkdown is a type of [literate programming](https://en.wikipedia.org/wiki/Literate_programming) where you find source code (to carry out analyses) and documentation. It produces a dynamic document that contains code to carry out analyses, produce output from the code (figures, tables, etc) and provide narrative text where the creator of the document can describe results or anything else related to the analysis at hand.

When an Rmarkdown document is run, it goes through the following steps:

![literate programming workflow](https://raw.github.com/ngs-docs/2021-GGG298/master/Week10-Rmarkdown_for_reports_documentation_and_beyond/Literate_Programming_workflow.png)

1. **Parse** the source document and separate code from narratives.
2. **Execute** source code and return results.
3. **Mix** results from the source code with the original narratives to get a pretty document!


## Anatomy of Rmarkdown documents

1. YAML header

> \-\-\-
>
>title:  "Iris Plot" 
>Author:  "Shannon E.K. Joslin"  
>date: "February 26, 2020"  
>output:  html_document
>
>\-\-\-


2. text in Rmarkdown language

> I am going to plot Sepal.length by Sepal.width for the iris dataset.


3. code chunks

>\```{r chunk_of_code}
>
>print(iris$Sepal.Width)
>
>\```


## Example .Rmd RNAseq experiment
Launch binder, open up an Rstudio window and let's look at an example Rmarkdown script from the ANGUS course we teach during the summers. 


## Creating Rmarkdown documents using Rstudio
We will create an Rmarkdown document through Rstudio. Note: you can create an Rmarkdown script in _any_ text editor, the document will need to be rendered in R/Rstudio.

### 1. Open file

![open Rmd](https://raw.github.com/ngs-docs/2021-GGG298/master/Week10-Rmarkdown_for_reports_documentation_and_beyond/Open_Rmarkdown_doc.png)

Fill in a title for the project you will be working on. Select 
- [x] HTML
Then click <kbd>OK</kbd>

### 2. Use Rmarkdown syntax to write narrative blocks of text

Narrative blocks of text show up like regular text. Sometimes with particular emphases (see table below). 

Navigate to this [sample hackMD](https://hackmd.io/v7dO5-Y3S0uVeXFe74wwKA) play around with a markdown language that renders instantaneously.

Note: HackMD is a slightly different language than Rmarkdown but most syntax carry over.

#### A bit of markdown:

| emphasis | how to |
|--|--|
|**bold** | \*\*bold**|
|_italics_ | \_italics_ |
|~~strikeout~~ | \~\~strikeout~~ |
|***bold italics*** | \*\*\*bold italics*** |
Here's an a [Rmarkdown cheatsheet](https://rstudio.com/wp-content/uploads/2015/02/rmarkdown-cheatsheet.pdf)

### 3. Insert code chunks

Write code to carry out your analysis. This can be any code that you would use in R.

#### Code Chunks

| option | description of effect | options (default given first) |
|--|--|--|
|eval| evaluate the code & include results | TRUE, FALSE | 
|echo| displays code and results | TRUE, FALSE |
|warning| displays warnings | TRUE, FALSE |
|error| displays errors | FALSE, TRUE |
|collapse| collapse output of code  | TRUE, FALSE |
|message| display messages | TRUE, FALSE |
|tidy| reformat code in a tidy way | FALSE, TRUE |
|results| outputs results in specific format | "markup", "asis", "hold", "hide" |
|fig.width| width of figures (default is in inches)| 7 |
|fig.height| height of figures (default is in inches)| 7 |
|fig.align| axis to align figures| "center", "right", "left" |
|fig.path| path to the directory where graphics are to be stored | "." |

Here are more [knit chunk options](http://yihui.name/knitr/options/#chunk_options).

#### Setting global options
You can set global options for your Rmarkdown document with the following line of code (and using any of options listed above). This is a good place to add something like the path where you would like to save all of your figures or results.
`knitr::opts_chunk$set(options)`

For example:
```
knitr::opts_chunk$set(echo = TRUE, # display code and results 
                      warning = FALSE, # do not display warnings
                      message = FALSE, # do not print messages
                      engine = "R", # Chunks will always have R code, unless noted
                      error = TRUE, # display error messages 
                      fig.path="Figures/",  # Set the figure options
                      fig.align = "center")
```

### 4. Repeat steps 2 & 3 until project is complete!


**Challenge** Pick two graphs from this [Data Visualization with ggplot2](https://www.mailman.columbia.edu/sites/default/files/media/fdawg_ggplot2.html) and create an Rmarkdown document explaining which two plots you picked and your interpretation of what is happening in the plot. Don't forget to insert a bit of markdown magic in your narrative text! Render the file and send the `.html` file to sejoslin@ucdavis.edu a subject line titled "GGG298-Rmarkdown Iris Plots"

## Rendering from the command line

It is all good and well when we would can run RStudio from our computer but we can't launch RStudio from the farm. So how do we deal with memory intensive analyses? We can run & render our Rmarkdown script from the command line! 

To render a markdown script from the command line, first open up a new terminal, then navigate to the directory with the `Rmd` file.

```
cd ~/Week10-Rmarkdown_for_reports_documentation_and_beyond/RNAseq_report/
ls -l
```

Here we can see that we have the `markdown-angus-rnaseq-viz.Rmd` script that we will be using. SO let's render it from the command line!

```
echo "rmarkdown::render('markdown-angus-rnaseq-viz.Rmd', clean=TRUE)" | R --slave
```

Note you can also use:
```
Rscript -e "rmarkdown::render('markdown-angus-rnaseq-viz.Rmd', clean=TRUE)"
```


## Resources, resources, resources
* [ANGUS 2017: Rmarkdown RNAseq](https://angus.readthedocs.io/en/2017/rmarkdown_rnaseq.html)
* [Software Carpentry Rmarkdown Lesson](https://swcarpentry.github.io/r-novice-gapminder/15-knitr-markdown/)
* [HackMD features](https://hackmd.io/features?both) a lot of the syntax used in HackMD is shared for Rmarkdown
* [Rmarkdown website](http://rmarkdown.rstudio.com/index.html)
* [RStudio Cheatsheet](https://www.rstudio.com/resources/cheatsheets/)
* [In-depth Rmarkdown tutorial](https://rpubs.com/marschmi/RMarkdown)
