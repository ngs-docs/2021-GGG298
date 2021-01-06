---
tags: ggg, ggg2021, ggg298
---
# GGG 298, jan 2021 - class 1 - NOTES

Titus Brown, ctbrown@ucdavis.edu
Shannon Joslin, sejoslin@ucdavis.edu

# Section 1: Binder & R

We're going to quickly walk through a first analysis of the data we'll be manipulating this quarter. It's a fairly standard RNAseq analysis, and we won't actually be talking about anything but the commands.

Here's a diagram of what we're going to do:

![workflow](https://raw.githubusercontent.com/ngs-docs/2020-ggg-298-first-day-rnaseq/master/txome%20workflow.png)

## Getting started in binder!

Go [here](https://github.com/ngs-docs/2020-ggg-201b-rnaseq/blob/latest/README.md) and click on the "launch binder" link at the bottom of the page. This runs RStudio in a ["binder"](https://binder.readthedocs.io/en/latest/user-manual/overview/intro.html), which means you don't need to install anything on your local computer! Here, everything is running in the [Google Cloud](https://cloud.google.com/compute/).

Wait ~10-15 seconds. You should see an RStudio Server window ...sooner or later!

When RStudio has launched, open a Terminal by clicking on the Terminal tab in the top lefthand corner, and copy and paste the following commands.

To shorten the prompt:
```
PS1='$ '
```

To run the automated workflow:
```
snakemake -j 4 --use-conda
```
