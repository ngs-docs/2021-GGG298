---
tags: ggg, ggg2020, ggg298
---
# GGG298 -- Week 8 - R/Rmarkdown for Reports, Documentation and beyond 

[toc]

## Objectives

* understand what an Rmarkdown document is
* gain insight into how Rmarkdown documents can help your research
* acquire basic Rmarkdown syntax

## What is Rmarkdown?

Rmarkdown is a type of [literate programming](https://en.wikipedia.org/wiki/Literate_programming) where you find source code (to carry out analyses) and documentation. It produces a dynamic document that contains code to carry out analyses, produce output from the code (figures, tables, etc) and provide narrative text where the creator of the document can describe results or anything else related to the analysis at hand.

When an Rmarkdown document is run it goes through the following steps:
1. **Parse** the source document and separate code from narratives.
2. **Execute** source code and return results.
3. **Mix** results from the source code with the original narratives.


### variants of Rmarkdown

### Uses of dynamic documents



## How to build an Rmarkdown workflow

1. **open** .Rmd
2. **write** in Rmarkdown syntax
3. **code**
4. **render** document


## Creating Rmarkdown documents

### Open file
insert image of open box

### anatomy of Rmarkdown document

make following 3 lines into a diagram:
* YAML header
```YAML
---
title:  "R/Rmarkdown Workflow" 
Author:  "Shannon E.K. Joslin"  
date: "February 26, 2020"  
output:  html_document
---
```
* text in Rmarkdown language
* code chunks

## Example .Rmd
Launch binder and let's look at an example Rmarkdown script: 

```bash
wget https://github.com/ngs-docs/angus/raw/2017/_static/markdown_tutorial.tar.gz
tar xvf markdown_tutorial.tar.gz
```

## Code Chunks

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
|fig.width| width of figures (default is in inches)| 
|fig.height| height of figures (default is in inches)|
|fig.align| axis to align figures|
|fig.path| path to the directory where graphics are to be stored | 

Here are more [knit chunk options](http://yihui.name/knitr/options/#chunk_options).

#### Setting global options
`knitr::opts_chunk$set(options)`

## Rmd Syntax

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



## More resources 
* [ANGUS 2017: Rmarkdown RNAseq](https://angus.readthedocs.io/en/2017/rmarkdown_rnaseq.html)
* [Software Carpentry Rmarkdown Lesson](https://swcarpentry.github.io/r-novice-gapminder/15-knitr-markdown/)
* [HackMD features](https://hackmd.io/features?both) a lot of the syntax used in HackMD is shared for Rmarkdown
* [Rmarkdown website](http://rmarkdown.rstudio.com/index.html)
* [RStudio Cheatsheet](https://www.rstudio.com/resources/cheatsheets/)
