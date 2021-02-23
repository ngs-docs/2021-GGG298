# UNIX for File Manipulation

Launch binder:

[![Binder](https://mybinder.org/badge_logo.svg)](https://binder.pangeo.io/v2/gh/ngs-docs/2020-ggg-201b-rnaseq/stable?urlpath=rstudio)

This lesson is a combination of Data Carpentry's [Introduction to the Command Line for Genomics](https://datacarpentry.org/shell-genomics/) lesson and the Lab for Data Intensive Biology's [Advanced Beginner/Intermediate Shell](https://dib-training.readthedocs.io/en/pub/2016-01-13-adv-beg-shell.html) workshop.

----

## Section 1: Introduction to UNIX
----------------------------------

### Learning Goals
* visualize file/directory structures
* understand basic shell vocabulary
* gain exposure to the syntax of shell & shell scripting
* look at the contents of a directory 
* find features of commands with `man`
* commands: `pwd`, `ls`, `cd`, `man`
------------------------------------

#### What is the shell and what is the terminal?
The **shell** is a computer program that uses a command line interface (CLI) to give commands made by your keyboard to your operating system. Most people are used to interacting with a graphic user interface (GUI), where you can use a combination of your mouse and keyboard to carry out commands on your computer. We can use the shell through a **terminal** program. 

Everything we can do using our computer GUI, we can do in the shell. We can open programs, run analyses, create documents, delete files and create folders. We should note that _folders_ are called **directories** at the command line. For all intents and purposes they can be used interchangeably but if you'd like more information please see "The folder metaphor" section of [Wikipedia](https://en.wikipedia.org/wiki/Directory_%28computing%29#Folder_metaphor).

The ease of getting things done via the shell will increase with your exposure to the program.  
Go ahead and open a new terminal window in binder.

When we open up terminal in binder we will see a a line of text. This is a **prompt statement**. It can tell us useful things such as the name of the directory we are currently in, our username, or what computer we are currently running terminal on. However, the prompt statement that pops up in binder is quite long and distracting. Let's customize it to read `$ ` it by running:

```
PS1='$ '
```

Then hit <kbd>Enter</kbd>. Better, right?

Let's take a look around. First, we can use the **print working directory** command see what directory we are currently located in.

```
pwd
```

This gives us the **absolute path** to the directory where we are located. An absolute path shows the complete series of directories you need to locate either a directory or a file starting from the root directory of your computer.

What is the root?
A useful way to start thinking about directories and files is through levels. At the highest level of your computer, you have the **root directory**. Everything that is contained in your computer is located in directories below your root directory. 
![CLIvsGUI](https://github.com/ngs-docs/2020-GGG298/blob/shannonekj-week-2/Week2-UNIX_for_file_manipulation/CLIvsGUI.png)


We can also look at the contents of the directory by using the `ls` command:

```
ls
```

This command prints out a list of files and directories that are located in our current working directory. We don't currently have data in our directory for the lesson, so let's get some!

```
wget https://s3-us-west-1.amazonaws.com/dib-training.ucdavis.edu/shell-data.zip
unzip shell-data.zip
```

Now, if we look at the contents of our current directory we have added a a file called `shell-data.zip` and a directory called `data`.

To switch the directory we are located in, we need to change directories using the `cd` command. Let's move into the data directory. 

```
cd data
```

Let's have a look around.

```
ls
```

We can see the following files:

> > ~~~
> > MiSeq		Slide1.jpg	hello.sh	nano1.png
> > README.md	gvng.jpg		nano2.png
> > ~~~

However, this directory contains more than the eye can see! To show hidden files we can use the `-a` option.

```
ls -a
```

We will see the following:

> > ~~~
> > .		MiSeq		Slide1.jpg	hello.sh	nano1.png
> > ..		README.md	gvng.jpg	.hidden		nano2.png
> > ~~~

Three new items pop up `.`, `..` and `.hidden`. 

Using options with our commands allows us to do a lot! But how did we know to add `-a` after ls? Most commands offer a `--help`. Let's look at the available options that `ls` has:

```
ls --help
```

Here we see a long list of options. Each option will allow us to do something different.

**CHALLENGE** Try to find the option that allows you to differentiate between directories and executable files when using `ls`. Hint: look for the word classify.


We can also combine commands:

```
ls -aFl
```

This combination of options will _list_ _all_ the contents of the directory and _differentiate_ between files types. 

----

## Section 2: Navigation
------------------------

### Learning Goals
* paths
* look at the contents of files
* perform functions outside of the directory you are in
* intro to the wildcard expression: `*`
* copy, move and remove files
* create and remove directories
* understand the structure of commands
* commands: `cat`, `cp`, `mv`, `rm`, `mkdir`
--------------------------------------------

Now we have a fairly good concept of navigating around our computers and seeing what is located in the directory we are. But some of the beauty of the shell is that we can execute activities in locations that we are not currently in. To do this we can either use an absolute path or a relative path. A **relative path** is the path to another directory from the the one you are currently in. 

Navigate into the `tmp1` directory located in the `.hidden` directory.

```
cd .hidden/tmp1
```

Here we see two files `notit.txt` and `thisinnotit.txt`. We can see what is in the directories using the `cat` command which concatenates and prints the content of the file we list. 

```
cat thisinnotit.txt
```

> > ~~~
> > This is not the text file you're looking for
> > ~~~

NOTE - you can use TAB to do filename completion, so if you type `cat this` and then press your Tab key once, it will autocomplete if there is a unique match. If there is more than one match, the first Tab will do nothing, and the second will show all the possible matches.

Let's see what else is in the other tmp directories:

```
ls ../tmp2
```

and we can see the contents of tmp3

```
ls ../tmp3
```

So, even though we are in the `tmp1/` directory, we can see what is in other directories by using the relative path to the directory of interest. Note we can also use absolute paths too. You may have noticed the `../` this is how to get to the directory above the one you are currently located in. 

Note: in this case, we have access to the RStudio file browser, too, which is really nice. But in the future we won't. So we can use the file browser today, but on Farm we'll have to get by with just the command line interface and no other interface!

**CHALLENGE:** Use the absolute path to list the files in the tmp2 directory.

Wouldn't it be nice to see the contents of all the tmp directories at once? We can use a regular expression to capture a sequence of characters (like the numbers 1, 2 and 3 at the end of the tmp directories). We can use the wild card character `*`, which expands to match any amount of characters.

```
ls ../tmp*
```

> > ~~~
> > ../tmp1:
> > notit.txt	thisinnotit.txt
> > 
> > ../tmp2:
> > anotherfile.txt
> > 
> > ../tmp3:
> > closebutnotit.txt	youfoundit.txt
> > ~~~

So, even though we are in the `tmp1` directory we can use a relative path.

We are quite used to moving, copying and deleting files using a GUI. All of these functions can be carried out at the command line with the following commands: 

Copy files with the `cp` command by specifying a file to copy and the location of the copied file. Here we will copy the `thisinnotit.txt` into the file `thisisacopy.txt`. 

```
cp thisinnotit.txt thisisacopy.txt
```

The syntax for the copy command is `cp <source_file> <destination_file>`. Using this syntax we can copy files to other directories as well:

```
cp thisinnotit.txt ../tmp2
```

If we navigate to the tmp2 directory and list the files that are in it we will see the `thisinnotit.txt` file has been copied to the tmp2 directory.

```
cd ../tmp2
ls -l
```

**CHALLENGE:** Use the `mv` command to move the `thisinnotit.txt` file from tmp2 to tmp3.

Once we know how to copy and move files, we can also copy and move directories. We can create new directories with the command `mkdir`. Let's make a new directory called `tmp4`

```
cd ../
mkdir tmp4
ls -l
```

The shell is quite powerful and can create multiple directories at once. It can create multiple in the current working directory:

```
mkdir tmp5 tmp6
ls -l
```

or it can create a series of directories on top of one another:

```
mkdir -p how/deep/does/the/rabbit/hole/go
```

We can use tab complete to get to the `go` directory. Type `cd h` then hit <kbd>tab</kbd>. If you hit tab enough times your command will eventually read:

```
cd how/deep/does/the/rabbit/hole/go/
```

You can see that we've created a bit of a monster directory structure...

**CHALLENGE:** Navigate to the data directory and use the `rm` command to remove the `how` directory and all its contents. 

----

This nicely hints at the power of the shell - you can do certain things (in this case, create a nested hierarchy of directories) much more easily in the shell. But that power cuts both ways - you can also mess things up more easily in the shell!


----

## Section 3: Viewing & Searching
---------------------------------

### Learning Goals
* looking inside files
* search for keywords within files
* commands: `less`, `head`, `tail`, `grep`
------------------------------------------

A big part of bioinformatics is making sure what you _expect_ in a particular file is what you _have_ in that file. There are a few ways to look at the contents of a file. We've already seen how to print the entirety of a file to the stdout of our `cat` command. We can also look at files using the `less` command. Less is a safe way of looking at the contents of a file without the ability to change it. This is an important note since our raw sequence data should never be altered.

Starting from the `data/` directory in our home directory

```
cd ~/data/
```

let's look at some sequence data in a [fastq file](https://en.wikipedia.org/wiki/FASTQ_format) format.

```
cd MiSeq
less F3D0_S188_L001_R1_001.fastq
```

We can see a bunch of sequence data! Use the up, down, left and right arrows to look through the folder a bit. Then press `q` to quit less. 

A lot of the time we want to know if a file contains what we expect. Many of the sequence files in this directory have the file ending `.fastq`. We expect these files to contain information in a particular format throughout the file with four  lines of information for each sequence string. Looking through a million line file using less will take a long time. Rather than manually looking through the file we can print only a portion of the files contents to the terminal:

```
head F3D0_S188_L001_R1_001.fastq
```

> > ~~~
> > @M00967:43:000000000-A3JHG:1:1101:18327:1699 1:N:0:188
> > NACGGAGGATGCGAGCGTTATCCGGATTTATTGGGTTTAAAGGGTGCGTAGGCGGCCTGCCAAGTCAGCGGTAAAATTGCGGGGCTCAACCCCGTACAGCCGTTGAAACTGCCGGGCTCGAGTGGGCGAGAAGTATGCGGAATGCGTGGTGTAGCGGTGAAATGCATAGATATCACGCAGAACCCCGATTGCGAAGGCAGCATACCGGCGCCCTACTGACGCTGAGGCACGAAAGTGCGGGGATCAAACAG
> > +
> > #>>AABABBFFFGGGGGGGGGGGGGGGGHHHHHHHGGGHHHHHGHGGGGGGGHGGGGGGHHHHHHHHHHGGGGGHHHHGHGGGGGGHHBGHGDGGGGGHHHGGGGHHHHHHHHGGGGGHG@DHHGHEGGGGGGBFGGEGGGGGGGG.DFEFFFFFFFDCFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFFFEFFCFF?FDFFFFFFFFAFFFFFFFFFFFBDDFFFFFEFADFFFFFBAFFFA?EFFFBFF
> > @M00967:43:000000000-A3JHG:1:1101:14069:1827 1:N:0:188
> > TACGGAGGATGCGAGCGTTATCCGGATTTATTGGGTTTAAAGGGTGCGTAGGCGGCCTGCCAAGTCAGCGGTAAAATTGCGGGGCTCAACCCCGTACAGCCGTTGAAACTGCCGGGCTCGAGTGGGCGAGAAGTATGCGGAATGCGTGGTGTAGCGGTGAAATGCATAGATATCACGCAGAACCCCGATTGCGAAGGCAGCATACCGGCGCCCTACTGACGCTGAGGCACGAAAGTGCGGGGATCAAACAG
> > +
> > 3AA?ABBDBFFBEGGEGGGGAFFGGGGGHHHCGGGGGGHFGHGGCFDEFGGGHGGGEGF1GGFGHHHHHGGEGGHHHHHFGGGGGGHHHHHGGGGCDDGHHGGGFHHHHHHHHCD@CCHGGGGHEHGGG@GFGGGGGGG@BGGGEGCEBFFFBFFB;9@EFFFEFFFFFFFFFFFFAFBBBFFFFFBBBFFFFBBBFFFFFFFFFFFBBBBBBBFFFFFFFFFDDFAFFFFF.AF9/FBBBBB.EAFFE?F
> > @M00967:43:000000000-A3JHG:1:1101:18044:1900 1:N:0:188
> > TACGGAGGATGCGAGCGTTGTCCGGAATCACTGGGCGTAAAGGGCGCGTAGGCGGTTTAATAAGTCAGTGGTGAAAACTGAGGGCTCAACCCTCAGCCTGCCACTGATACTGTTAGACTTGAGTATGGAAGAGGAGAATGGAATTCCTAGTGTAGCGGTGAAATGCGTAGATATTAGGAGGAACACCAGTGGCGAAGGCGATTCTCTGGGCCAAGACTGACGCTGAGGCGCGAAAGCGTGGGGAGCAAACA
> > ~~~

`head` prints the first ten lines of a file out onto your screen.

We can look at the last ten lines of a file using the `tail` command:

```
tail F3D0_S188_L001_R1_001.fastq
```

We can see that our **fastq** files look a lot different than the **fasta** files:

```
head HMP_MOCK.v35.fasta
```

> > ~~~
> > >A.baumannii.1
> > TGGGGAATATTGGACAATGGGGGGAACCCTGATCCAGCCATGCCGCGTGTGTGAAGAAGGCCTTATGGTTGTAAAGCACTTTAAGCGAGGAGGAGGCTACTTTAGTTAATACCTAGAGATAGTGGACGTTACTCGCAGAATAAGCACCGGCTAACTCTGTGCCAGCAGCCGCGGTAATACAGAGGGTGCGAGCGTTAATCGGATTTACTGGGCGTAAAGCGTGCGTAGGCGGCTTATTAAGTCGGATGTGAAATCCCCGAGCTTAACTTGGGAATTGCATTCGATACTGGTGAGCTAGAGTATGGGAGAGGATGGTAGAATTCCAGGTGTAGCGGTGAAATGCGTAGAGATCTGGAGGAATACCGATGGCGAAGGCAGCCATCTGGCCTAATACTGACGCTGAGGTACGAAAGCATGGGGAGCAAACAGGATTAGATACCCTGGTAGTCCATGCCGTAAACGATGTCTACTAGCCGTTGGGGCCTTTGAGGCTTTAGTGGCGCAGCTAACGCGATAAGTAGACCGCCTGGGGAGTACGGTC
> > >A.odontolyticus.1
> > TGGGGAATATTGCACAATGGGCGAAAGCCTGATGCAGCGACGCCGCGTGAGGGATGGAGGCCTTCGGGTTGTAAACCTCTTTCGCTCATGGTCAAGCCGCAACTCAAGGTTGTGGTGAGGGTAGTGGGTAAAGAAGCGCCGGCTAACTACGTGCCAGCAGCCGCGGTAATACGTAGGGCGCGAGCGTTGTCCGGAATTATTGGGCGTAAAGGGCTTGTAGGCGGTTGGTCGCGTCTGCCGTGAAATCCTCTGGCTTAACTGGGGGCGTGCGGTGGGTACGGGCTGACTTGAGTGCGGTAGGGGAGACTGGAACTCCTGGTGTAGCGGTGGAATGCGCAGATATCAGGAAGAACACCGGTGGCGAAGGCGGGTCTCTGGGCCGTTACTGACGCTGAGGAGCGAAAGCGTGGGGAGCGAACAGGATTAGATACCCTGGTAGTCCACGCTGTAAACGTTGGGCACTAGGTGTGGGGGCCACCCGTGGTTTCTGCGCCGTAGCTAACGCTTTAAGTGCCCCGCCTGGGGAGTACGGCC
> > >B.cereus.1
> > TAGGGAATCTTCCGCAATGGACGAAAGTCTGACGGAGCAACGCCGCGTGAGTGATGAAGGCTTTCGGGTCGTAAAACTCTGTTGTTAGGGAAGAACAAGTGCTAGTTGAATAAGCTGGCACCTTGACGGTACCTAACCAGAAAGCCACGGCTAACTACGTGCCAGCAGCCGCGGTAATACGTAGGTGGCAAGCGTTATCCGGAATTATTGGGCGTAAAGCGCGCGCAGGTGGTTTCTTAAGTCTGATGTGAAAGCCCACGGCTCAACCGTGGAGGGTCATTGGAAACTGGGAGACTTGAGTGCAGAAGAGGAAAGTGGAATTCCATGTGTAGCGGTGAAATGCGTAGAGATATGGAGGAACACCAGTGGCGAAGGCGACTTTCTGGTCTGTAACTGACACTGAGGCGCGAAAGCGTGGGGAGCAAACAGGATTAGATACCCTGGTAGTCCACGCCGTAAACGATGAGTGCTAAGTGTTAGAGGGTTTCCGCCCTTTAGTGCTGAAGTTAACGCATTAAGCACTCCGCCTGGGGAGTACGGCC
> > >B.vulgatus.1
> > TGAGGAATATTGGTCAATGGGCGCAGGCCTGAACCAGCCAAGTAGCGTGAAGGATGACTGCCCTATGGGTTGTAAACTTCTTTTATAAAGGAATAAAGTCGGGTATGGATACCCGTTTGCATGTACTTTATGAATAAGGATCGGCTAACTCCGTGCCAGCAGCCGCGGTAATACGGAGGATCCGAGCGTTATCCGGATTTATTGGGTTTAAAGGGAGCGTAGATGGATGTTTAAGTCAGTTGTGAAAGTTTGCGGCTCAACCGTAAAATTGCAGTTGATACTGGATATCTTGAGTGCAGTTGAGGCAGGCGGAATTCGTGGTGTAGCGGTGAAATGCTTAGATATCACGAAGAACTCCGATTGCGAAGGCAGCCTGCTAAGCTGCAACTGACATTGAGGCTCGAAAGTGTGGGTATCAAACAGGATTAGATACCCTGGTAGTCCACACGGTAAACGATGAATACTCGCTGTTTGCGATATACGGCAAGCGGCCAAGCGAAAGCGTTAAGTATTCCACCTGGGGAGTACGCCG
> > >B.vulgatus.2
> > TGAGGAATATTGGTCAATGGGCGAGAGCCTGAACCAGCCAAGTAGCGTGAAGGATGACTGCCCTATGGGTTGTAAACTTCTTTTATAAAGGAATAAAGTCGGGTATGGATACCCGTTTGCATGTACTTTATGAATAAGGATCGGCTAACTCCGTGCCAGCAGCCGCGGTAATACGGAGGATCCGAGCGTTATCCGGATTTATTGGGTTTAAAGGGAGCGTAGATGGATGTTTAAGTCAGTTGTGAAAGTTTGCGGCTCAACCGTAAAATTGCAGTTGATACTGGATATCTTGAGTGCAGTTGAGGCAGGCGGAATTCGTGGTGTAGCGGTGAAATGCTTAGATATCACGAAGAACTCCGATTGCGAAGGCAGCCTGCTAAGCTGCAACTGACATTGAGGCTCGAAAGTGTGGGTATCAAACAGGATTAGATACCCTGGTAGTCCACACGGTAAACGATGAATACTCGCTGTTTGCGATATACGGCAAGCGGCCAAGCGAAAGCGTTAAGTATTCCACCTGGGGAGTACGCCG
> > ~~~

Each sequence entry for a [fasta](https://en.wikipedia.org/wiki/FASTA_format) formatted file contains only two lines of information for each sequence string.

Another useful thing to do is to be able to **search the contents of files** for a particular string of characters you would like to find. Let's say you'd like to find the sequence `CATTAG` in your files. We can use the file pattern searcher `grep` to look for our favorite sequence:

```
grep CATTAG F3D0_S188_L001_R2_001.fastq
```

We can also use the **wildcard** regular expression to search `CATTAG` in all of the fastq files located in our current working directory:

```
grep CATTAG *.fastq
```

**CHALLENGE:** What line does `CATTAG` occur on in `F3D141_S207_L001_R1_001.fastq`? (HINT: Use `grep --help` to search for `grep` options related to line number)





----

## Section 4: File Manipulation
-------------------------------

### Learning Goals
* combine commands to carry out a sequence of steps with `|`
* redirect output of commands to files with `>`
* increase exposure to regular expressions
* commands `for`, `basename`, `echo`
------------------------------------------

### Renaming a bunch of files

For our first task, let's pretend that we want to rename all of the fastq files to be `.fq` files instead (this is a surprisingly useful specific skill, even if you can't immediately think of why you would want to do that!).  Here, we get to use two of my favorite commands - 'for' and 'basename'.

`for` lets you do something to every file in a list.  To see it in action:

```
for i in *.fastq
do
   echo $i
done
```

This is running the command `echo` for every value of the variable 'i', which is set (one by one) to all the values in the expression `*.fastq`.

If we want to get rid of the extension '.fastq', we can use the `basename` command:

```
for i in *.fastq
do
   basename $i .fastq
done
```

Now, this doesn't actually rename the files - it just prints out the name, with the suffix '.fastq' removed.  To rename the files, we need to capture the new name in a variable::

```
for i in *.fastq
do
   newname=$(basename $i .fastq).fq
   echo $newname
done
```

What `$( ... )` does is run the command in the middle, and then replace the `$( )` with the output of running the command.

Now we have the old name ($i) and the new name ($newname) and we're ready to write the rename command -- ::

```
for i in *.fastq
do
   newname=$(basename $i .fastq).fq
   echo mv $i $newname
done
```

***Question:*** why did I put `echo` here?

Now that we're pretty sure it all looks good, let's run it for realz:

```
for i in *.fastq
do
   newname=$(basename $i .fastq).fq
   mv $i $newname
done
```

and voila, we have renamed all the files!

_Side note:_ you may see backquotes used instead of `$(...)`. It does the same thing but is trickier to get right, so we teach `$(...)` instead of ``...``.

----

For more UNIX commands (and a continuation of this lesson head to the [UNIX Shell File Manipulation section](https://github.com/ngs-docs/2021-GGG298/tree/latest/Week8-project_organization_and_UNIX_shell#file-manipulation) of the lesson for Week 8.


Other notes
-----------

Google (and especially stackoverflow) is your friend.
