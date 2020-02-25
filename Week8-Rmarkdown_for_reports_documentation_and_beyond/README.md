---
tags: ggg, ggg2020, ggg298
---
# GGG298 -- Week 8 - Rmarkdown for reports, documentation and beyond 

[toc]

## Objectives

* understand what an Rmarkdown document is
* gain insight into how Rmarkdown documents can help your research
* acquire basic Rmarkdown syntax

## What is Rmarkdown?

Rmarkdown is a type of [literate programming](https://en.wikipedia.org/wiki/Literate_programming) where you find source code (to carry out analyses) and documentation. It produces a dynamic document that contains code to carry out analyses, produce output from the code (figures, tables, etc) and provide narrative text where the creator of the document can describe results or anything else related to the analysis at hand.

When an Rmarkdown document is run, it goes through the following steps:

![literate programming workflow](https://raw.github.com/ngs-docs/2020-GGG298/master/Week8-Rmarkdown_for_reports_documentation_and_beyond/Literate_Programming_workflow.png)

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
>\-\-\-

2. text in Rmarkdown language

> I am going to plot Sepal.length by Sepal.width the iris dataset.

4. code chunks


>\```{r chunk_of_code}
 print(iris$Sepal.Width)
\```



## Creating Rmarkdown documents using Rstudio
We will create an Rmarkdown document through Rstudio. Note you can create an Rmarkdown script in _any_ text editor, the document just has to render in R/Rstudio.

### 1. Open file

![open Rmd](https://raw.github.com/ngs-docs/2020-GGG298/master/Week8-Rmarkdown_for_reports_documentation_and_beyond/Open_Rmarkdown_doc.png)

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
|++Inserted text++ | \+\+Inserted text++ |
|==highlighted text== | \=\=highlighted text== |
|super^script^ | super\^script^ |
|sub~script~ | sub\~script~ |
|{text|stacked} | \{text|stacked} |
Here's a long list of just about all the [features in HackMD](https://hackmd.io/features) you could hope for and a [Rmarkdown cheatsheet](https://rstudio.com/wp-content/uploads/2015/02/rmarkdown-cheatsheet.pdf)

### 3. Insert code chunks


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
|fig.path| path to the directory where graphics are to be stored | "."

Here are more [knit chunk options](http://yihui.name/knitr/options/#chunk_options).

#### Setting global options
`knitr::opts_chunk$set(options)`

### 4. Repeat steps 2 & 3 until project is complete!


## Example .Rmd RNAseq experiment
Launch binder and let's look at an example Rmarkdown script: 

```bash
wget https://github.com/ngs-docs/angus/raw/2017/_static/markdown_tutorial.tar.gz
tar xvf markdown_tutorial.tar.gz
```


@@put in notes about using on the farm...harder


## Resources, resources, resources
* [ANGUS 2017: Rmarkdown RNAseq](https://angus.readthedocs.io/en/2017/rmarkdown_rnaseq.html)
* [Software Carpentry Rmarkdown Lesson](https://swcarpentry.github.io/r-novice-gapminder/15-knitr-markdown/)
* [HackMD features](https://hackmd.io/features?both) a lot of the syntax used in HackMD is shared for Rmarkdown
* [Rmarkdown website](http://rmarkdown.rstudio.com/index.html)
* [RStudio Cheatsheet](https://www.rstudio.com/resources/cheatsheets/)
* [In-depth Rmarkdown tutorial](https://rpubs.com/marschmi/RMarkdown)
