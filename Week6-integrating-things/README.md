---
tags: ggg, ggg2021,ggg298
---
[toc]

# GGG 298, March 2021 - Week 6, integrating all the things

Feb 10, 2021
Titus Brown and Shannon Joslin

Learning goals:
* review the previous four lessons by building something that puts them all together!

## Links!

scratchpads for breakout rooms -

[solutions etc](https://hackmd.io/grcnwriGQVyMxqc-qrCHIw)

## Rough schedule thoughts

9:30 install software, get basic commands running, 
(end 10:05)
10:10  download data; sourmash sketch on each file
(end 10:35)
10:45 sourmash compare, sourmash plot
(end 11:10)
11:15 default rule; conda environment file
(end 11:40)

## Where we will run things

start up a binder,

[![Binder](https://binder.pangeo.io/badge_logo.svg)](https://binder.pangeo.io/v2/gh/binder-examples/r-conda/master?urlpath=rstudio)

This should bring up the usual RStudio window.

Next, go to the Terminal window and run:

```
conda init
echo "PS1='\w $ '" >> .bashrc
```

which will (1) initialize conda and (2) modify your shell settings to a cleaner prompt.

Now close & reopen your terminal, by typing 'exit' and then going to Tools... New Terminal.

## Today's plan!

Today we're going to try to integrate across some of the things you've seen this quarter so far.

What we're going to do is try to start a _new_ project from scratch, knowing just the commands to run. And then we're going to install stuff with conda and develop a snakemake workflow.

What we'll do is take ~20-25 minutes for each chunk of work, in breakout rooms. After each chunk, I'll walk through a solution, post it for you all, and then move on to the next chunk.

Importantly, you absolutely don't have to complete each chunk! I'd like you to try, but having a set of questions and thoughts is perfectly fine!

## The workflow!

**Scenario:**

> Sandra has received a collection of bacterial genomes and wants to see how similar they are at a nucleotide level. To do this, she decides to use the [sourmash tool](http://sourmash.rtfd.io/) to compare them and create a figure showing their similarity.

Briefly, sourmash is a tool that compares genomes at a k-mer level. First, it breaks genomes down into k-mers, then it calculates the Jaccard similarity between the genomes, and then it plots the similarities in various ways.

### A. Computing signatures

We'll download five genome files like so --

```
wget https://osf.io/t5bu6/download -O 1.fa.gz
wget https://osf.io/ztqx3/download -O 2.fa.gz
wget https://osf.io/w4ber/download -O 3.fa.gz
wget https://osf.io/dnyzp/download -O 4.fa.gz
wget https://osf.io/ajvqk/download -O 5.fa.gz
```

Then we compute genome signatures for each of them, using a k-mer size of 31. Each of these commands takes as input a `.fa.gz` file, and outputs a `.fa.gz.sig` file.

```
sourmash compute -k 31 1.fa.gz
sourmash compute -k 31 2.fa.gz
sourmash compute -k 31 3.fa.gz
sourmash compute -k 31 4.fa.gz
sourmash compute -k 31 5.fa.gz
```

### B. Comparing the signatures

Next we want to compare all five of these signature files.
The following command takes as input multiple `.sig` files and outputs a comparison results file named `all.cmp`. We can optionally produce a CSV matrix file using `--csv all.csv`.
```
sourmash compare *.sig -o all.cmp
```

### C. Plotting the comparison

Finally, we want to plot the comparison.
This final command takes as input the files `all.cmp` and `all.cmp.labels.txt`, and outputs three files,`all.cmp.hist.png`, `all.cmp.dendro.png`, and `all.cmp.matrix.png`. Use the `--labels` option to put labels on the matrix figure.

```
sourmash plot --labels all.cmp
```

This produces the following figure showing that genomes 1 and 5 are similar, genomes 3 and 4 are similar, and genome 2 is not similar to either of the other sets.

![figure](https://github.com/ngs-docs/2020-GGG298/raw/master/Week9-Sourmash_project/all.cmp.matrix.png)

## The tasks!

### 1. Conda for software installation

#### 1.1 First, use conda to install sourmash and snakemake.

We'll need to have both `sourmash` and `snakemake-minimal` installed. Let's use conda to do it!

**Task:** Create a conda environment containing the latest version of sourmash and snakemake-minimal, installed from bioconda.

:::info
[Pointer to the relevant section from the conda lesson in week 3](https://github.com/ngs-docs/2021-GGG298/tree/master/Week3-conda_for_software_installation#installation)
:::

**Check**: `conda env list` should show that your new environment exists.

#### 1.2 Second, activate your conda environment

**Task:** Activate your conda environment.

**Check:** Running `sourmash` should show something other than "command not found".

**Questions:**

Q: If I already have snakemake in an environment and I want to add sourmash, how would I do that?
A: Activate the environment, and run `conda install -y sourmash` to install sourmash in the current environment. You can also run `conda install -n smash -y snakemake` to install snakemake in a non-active environment.

#### Stretch: Create a conda environment.yml that you can use with `conda env create -f environment.yml`

:::info
[See link to section in conda tutorial](https://github.com/ngs-docs/2021-GGG298/tree/master/Week3-conda_for_software_installation#making-and-using-environment-files)
:::

### 2. Create an automated workflow!

Let's automate this set of commands using snakemake!

**Reminder:** rules look like this,

```python=
rule rulename:
    input: "input_file1", "input_file2"
    output: "output_file1", "output_file2"
    shell: "shell_command goes here"
```

And you can (and should :) use `{input}` and `{output}` in the shell command.

#### 2.1 Create snakemake rules to download the genome files.

**Task:** Create a rule to run the following commands to download the data files [from this OSF](https://osf.io/ke2tu/files/)

```
wget https://osf.io/t5bu6/download -O 1.fa.gz
wget https://osf.io/ztqx3/download -O 2.fa.gz
wget https://osf.io/w4ber/download -O 3.fa.gz
wget https://osf.io/dnyzp/download -O 4.fa.gz
wget https://osf.io/ajvqk/download -O 5.fa.gz
```

:::info
[Link to relevant snakemake tutorial section](https://github.com/ngs-docs/2021-GGG298/tree/master/Week4-snakemake-for-workflows#add-a-variable-substitution)
:::

**Check:** `snakemake 1.fa.gz` should run the appropriate `wget` command and produce the right file.

**Hint:** you can run multiple shell commands by doing this:
```
shell: """
   command1
   command2
   command3
"""
```

#### 2.2 Create snakemake rules to run `sourmash compute` on each of the files.

**Task:** Create a snakemake rule to run sourmash compute on each genome.

**Check:** `snakemake 1.fa.gz.sig` should run `sourmash compute`  on `1.fa.gz` to produce `1.fa.gz.sig`.

**Stretch goal:** build a generic rule using wildcards 
:::info
[link to relevant lesson section](https://github.com/ngs-docs/2021-GGG298/tree/master/Week4-snakemake-for-workflows#add-wildcards).
:::

#### 2.3 Create a snakemake rule to run `sourmash compare`

**Note:** you can have multiple input files by separating them with commas, i.e. using ``"file1", "file2", "file3"``.

**Task:** Create a snakemake rule that runs `sourmash compute` on all of the signature files.

**Check:** `snakemake <cmp file>` should run `sourmash compare`.

A few notes:
* if you don't list the inputs explicitly then snakemake won't make sure they're there before running this
* you want to change `*.sig` to `{input}` so that you avoid comparing all of the signatures in the directory, and just use those five. (This doesn't matter in this situation, but computers like precision.)
* if you don't like typing in lots of input: filenames, you can use expand like so: `input: expand("{sample}.fa.gz.sig", sample=[1,2,3,4,5])` - here, expand makes 5 concrete targets (filenames not containing wildcards) out of one wildcard expression with five values to fill in.
* more on that vein - you can't have `input: "{sample}.fa.gz.sig"` because snakemake won't know how to fill in {sample} for input based on the output: block, which just contains `all.cmp`.

#### 2.4 Create a snakemake rule to run `sourmash plot.`

**Task:** Create a snakemake rule that runs `sourmash plot` to produce PNG files.

**Check:** `snakemake <cmp file>.matrix.png` should run `sourmash plot`.

**One solution:**

```
rule sourmash_plot:
    input: "all.cmp", "all.cmp.labels.txt"
    output: "all.cmp.hist.png", "all.cmp.dendro.png", "all.cmp.matrix.png"
    shell: "sourmash plot --labels all.cmp"

rule sourmash_compare:
    input: expand("{sample}.fa.gz.sig", sample=range(1, 6))
    #input: expand("{sample}.fa.gz.sig", sample=[1,2,3,4,5])
    #input: "1.fa.gz.sig", "2.fa.gz.sig", "3.fa.gz.sig", "4.fa.gz.sig",
    #    "5.fa.gz.sig"
    output: "all.cmp", "all.cmp.labels.txt"
    shell: "sourmash compare {input} -o all.cmp"
```

**note** that you have to change the output: block of sourmash_compare to include `all.cmp.labels.txt`.

Stretch goal: build a generic rule using wildcards, so that any `.cmp` file can be turned into a set of plots. 

#### 2.5 Create a default rule that runs the entire workflow

:::info
[Link to tutorial section on default rules](https://github.com/ngs-docs/2020-GGG201b-lab/blob/master/lab-3.md#create-a-good-default-rule)
:::

**Task:** Create a default rule that asks for the plots to be created.

**Check:**  Running just `snakemake` produces the plots.


#### 2.6 Stretch Goal: use a conda environment file for those commands that run sourmash

:::info
[Relevant section in snakemake tutorial](https://github.com/ngs-docs/2021-GGG298/tree/master/Week4-snakemake-for-workflows#rule-specific-conda-environments-with-conda-and---use-conda)
:::

**Task:** Create an environment file and name it in a `conda:` block for each snakemake rule that uses sourmash.

**Check:** `snakemake --use-conda` should create a new environment and run the commands in that environment.

**One solution:**

(TBA)

### Voila, done!

Questions?
