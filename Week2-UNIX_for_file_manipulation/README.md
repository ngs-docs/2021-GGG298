# UNIX for File Manipulation

Launch binder:

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/ngs-docs/2020-GGG298/shannonekj-week-2)

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
The **shell** is a computer program that uses a command line interface (CLI) to give commmands made by your keyboard to your operating system. Most people are used to interacting with a graphic user interface (GUI), where you can use a combination of your mouse and keyboard to carry out commands on your computer. We can use the shell through a **terminal** program. 

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

We can see the following directories:

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
> > ..		README.md	gvng.jpg	hidden		nano2.png
> > ~~~

Three new items pop up `.`, `..` and `hidden`. 

Using options with our commands allows us to do a lot! But how did we know to add `-a` after ls? The `man` command allows us to look at what options any shell command has. Let's look at the available options that `ls` has:

```
man ls
```

Here we see a long list of options. Each option will allow us to do something different. Type `q` to quit looking at the manual page.

**CHALLENGE** Try to find the option that allows you to differentiate between directories and executable files when using `ls`.

```
ls -F
```

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

Navigate into the `tmp1` directory located in the `hidden` directory.

```
cd hidden/tmp1
```

Here we see two files `notit.txt` and `thisinnotit.txt`. We can see what is in the directories using the `cat` command which concatenates and prints the content of the file we list. 

```
cat thisinnotit.txt
```

> > ~~~
> > This is not the text file you're looking for
> > ~~~

Let's see what else is in the other tmp directories:

```
ls ../tmp2
```

and we can see the contents of tmp3

```
ls ../tmp3
```

So, even though we are in the `tmp1/` directory, we can see what is in other directories by using the relative path to the directory of interest. Note we can also use absolute paths too. You may have noticed the `../` this is how to get to the directory above the one you are currently located in. 

**CHALLENGE:** Use the absolute path to list the files in the tmp2 directory.

Wouldn't it be nice to see the contents of all the tmp directories at once? We can use a regular expression to capture a sequence of characters (like the numbers 1, 2 and 3 at the end of the tmp directories). We can use the wild card character `*`, which expands to match any amount of characters.

```
ls tmp*
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
cp thisinnotit.txt ../tmp2/.
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

**CHALLENGE:** Navigate to the data directoy and use the `rm` command to remove the `how` directory and all its contents. 

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

Starting from the `shell/data/` directory,

```
cd ../
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

**CHALLENGE:** What line does `CATTAG` occur on in `F3D141_S207_L001_R1_001.fastq`? (HINT: Use `man` to search for `grep` options related to line number)





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

***Question:*** why did I use `echo` here?

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

Now let's also get rid of the annoying '\_001' that's at the end of the all files.  `basename` is all fine and good with the end of files, but what do we do about things in the middle? Now we get to use another one of my favorite commands -- `cut`.

What `cut` does is slice and dice strings.  So, for example, :

```
echo hello, world | cut -c5-
```

will print out `o, world`.

But this is kind of a strange construction! What's going on?

Well, `cut` expects to take a bunch of lines of input from a file. By default it is happy to take them in from stdin ("standard input"), so you can specify '-' and give it some input via a pipe, which is what we're doing with echo:

We're taking the output of 'echo hello, world' and sending it to the input of cut with the `|` command ('pipe').

You may have already seen this with head or tail, but many UNIX commands take stdin and stdout.

Let's construct the `cut` command we want to use.  If we look at the names of the files, and we want to remove '001' only, we can see that each filename has a bunch of fields separated by '\_'.  So we can ask 'cut' to pay attention to the first four fields, and omit the fifth, around the separator (or delimiter) '\_':

```
echo F3D141_S207_L001_R1_001.fq | cut -d_ -f1-4
```

That looks about right -- let's put it into a for loop:

```
for i in *.fq
do
   echo $i | cut -d_ -f1-4
done
```

Looking good - now assign it to a variable and append an ending:

```
for i in *.fq
do
   newname=$(echo $i | cut -d_ -f1-4).fq
   echo $newname
done
```
  
and now construct the `mv` command:

```
for i in *.fq
do
   newname=$(echo $i | cut -d_ -f1-4).fq
   echo mv $i $newname
done
```

and if that looks right, run it:

```
for i in *.fq
do
   newname=$(echo $i | cut -d_ -f1-4).fq
   mv $i $newname
done
```

Ta-da! You've renamed all your files.

----

### Subsetting

Let's do something quite useful - subset a bunch of FASTQ files.

If you look at one of the FASTQ files with head, 

```
head F3D0_S188_L001_R1.fq
```

you'll see that it's full of FASTQ sequencing records.  Often I want to run a bioinformatices pipeline on some small set of records first, before running it on the full set, just to make sure all the syntax for all the commands works. So I'd like to subset all of these files without modifying the originals.

First, let's make sure the originals are read-only

```
chmod u-w *.fq
```

Now, let's make a 'subset' directory

```
mkdir subset
```

Now, to subset each file, we want to run a 'head' with an argument that is the total number of lines we want to take.  In this case, it should be a multiple of 4, because FASTQ records have 4 lines each. Let's take the first 100 records of each file by using `head -400`.

The for loop will now look something like:

```
for i in *.fq
do
   echo "head -400 $i > subset/$i"
done
```

If that command looks right, run it for realz:

```
for i in *.fq
do
   head -400 $i > subset/$i
done
```

and voila, you have your subsets!

(This is incredibly useful. You have no idea :)

----

**CHALLENGE:** Can you rename all of your files in subset/ to have 'subset.fq' at the end?

(Work in small groups; start from working code; there are several ways to do it; all that matters is getting there!)

A little backtracking...
------------------------

Variables:

You can use either $varname or ${varname}.  The latter is useful when you want to construct a new filename, e.g.

```
   MY${varname}SUBSET
```

would expand ${varname} and then put MY .. SUBSET on either end, while 

```
MY$varnameSUBSET
```

would try to put MY in front of $varnameSUBSET which won't work.

(Unknown/uncreated variables are empty.)

NOTE: `${varname}` is quite different from `$(expression)`! The former is replaced by the value assigned to `varname`; the latter is replaced by the result of running `expression`. So, both _replace_ but they do different things. Think of `$` here as meaning, "replace me with something".

---

We used "$varname" above - what happens if we use single quotes -
e.g. '$varname'?

(Variables are interpreted inside of "", and not inside of ''.)

----

### Pipes and redirection

To redirect stdin and stdout, you can use:

```
> - send stdout to a file
< - take stdin from a file
| - take stdout from first command and make it stdin for second command
>> - appends stdout to a previously-existing file
```

stderr (errors) can be redirected:

```
2> - send stderr to a file
```

and you can also say::

```
>& - to send all output to a file
```

### Editing on the command line:

Most prompts support 'readline'-style editing.  This uses emacs control
keys.

Type something out; then type CTRL-a.  Now type CTRL-e.  Beginning and end!

Up arrows to recall previous command, left/right arrows, etc.

CTRL-r will search backwards for recent commands, too! If you find the exact
command you are looking for, you can hit ENTER to run it again. If you
want to edit it, use CTRL-a or CTRL-e to move to editing mode.

----

CHALLENGE: Another useful command along with 'basename' is 'dirname'. Any idea what
it does?

-----

Working with collections of files; conditionals
-----------------------------------------------

Let's go back to the 'data' directory and play around with loops some more. 

```
  cd ..
```

`if` acts on things conditionally:

```
for i in *
do
   if [ -f $i ]; then
      echo $i is a file
   elif [ -d $i ]; then
      echo $i is a directory
   fi
done
```

but what the heck is this `[ ]` notation?  That's actually running the 'test' command; try `help test | less` to see the docs.  This is a weird syntax that lets you do all sorts of useful things with files -- I usually use it to get rid of empty files.

```
touch emptyfile.txt
```

to create an empty file, and then::

```
for i in *
do
   if [ \! -s $i ]; then
      echo rm $i
   fi
done
```

...and as you can see here, I'm using '!' to say 'not'. (Why do I need to put a backslash in front of it, though??)

Executing things conditionally based on exit status
---------------------------------------------------

Let's create two scripts (you can use 'nano' here if you want) -- in 'success.sh', put:

```
  #! /bin/bash
  echo mesucceed
  exit 0
```

and in 'fail.sh', put:

```
  #! /bin/bash
  echo mefail
  exit 1
```

You can do this with 'heredocs' -- ::

```
  cat > success.sh <<EOF
  #! /bin/bash
  echo mesucceed
  exit 0
  EOF
  cat > fail.sh <<EOF
  #! /bin/bash
  echo mefail
  exit 1
  EOF
 ```

Now make them executable -- 

```
chmod +x success.sh fail.sh
```

(Somewhat counterintuitively, an exit status of 0 means "success" in UNIX land. Any non-zero exit status is an error.)

You can now use this to chain commands with `&&` and `||` -- :

```
./success.sh && echo this succeeded || echo this failed
./fail.sh && echo this succeeded || echo this failed
```

You can do this with R and python scripts too -- in R, you set the exit status of a script with `quit(status=0, save='no')` and in Python with `sys.exit(0)`.  Any failure of the script due to an exception will automatically set the exit status to non-zero.

The exit status of the previous command can be examined with `$?` -- :

```
./success.sh
if [ $? -eq 0 ]; then echo succ; fi
```

```
./success.sh
if [ $? -ne 0 ]; then echo fail; fi
```

Writing shell scripts
---------------------

Always put `set -e` at the top.

Sometimes put `set -x` at the top.

You can take in command line parameters with '$1', '$2', etc. '$\*' gives you all of them at once.

Other things to mention
-----------------------

Scripts exit in a subshell and can't modify your environment variables. If you want to modify your environment, you need to use '.' or 'source'.

Subshells are ways to group commands with ( ... ).

You can use \ to do line continuation in scripts (in R and Python, too!)

History tricks:

```
  !! - run previous command
  !-1 - run command-before-previous command (!-2 etc.)
  !$ - replace with the last word on the previous line
  !n - run the nth command in your 'history'
```


The general approach I use
--------------------------

* break the task down into multiple commands
* put commands things in shell scripts, run in serial
* use intermediate i/o files to figure out what's going on!
* use echo to debug!

(But we'll also teach you another way to do automation with snakemake.)

The weird awesomeness that is 'find'
------------------------------------

The 'find' command is like a whole 'nother world, but it is an awesome one.

Print all files:

```
find . -type f
```

Print all files w/details:

```
find . -type f -ls
```

Find all files not in git directories:

```
find . -name .git -prune -o -type f -print
```

Find all directories in the current directory:

```
find * -prune -type d -print
```

...and get their disk usage:

```
find * -prune -type d -exec du -skh {} \;
```

Here, '-exec' runs the command specified up until the ``\;``, and replaces
the {} with the filename.

Same result, different command:

```
find . -depth 1 -type d -exec du -skh {} \;
```

Find all files larger than 100k:

```
find . -size +100k -print
```

Find all files that were changed within the last 10 minutes:

```
find . -ctime -10m
```

(...and do things to them with -exec ;).

Run 'grep -l' to find all files containing the string 'CGTTATCCGGATTTATTGGGTTTA':

```
find . -type f -exec grep -q CGTTATCCGGATTTATTGGGTTTA {} \; -print
```

(What's the difference between this and `grep -l CGTTATCCGGATTTATTGGGTTTA *`?)

Note, you can use -a (and) and -o (or), along with `\(` and `\)`,
to group conditions::

```
find . \( \( -type f -size +100k \) -o \( -type f -size -1k \) \)  -print
```

...so it's basically all programming...

Note that you can 'exec' a Python, R, or shell script.

Challenge exercise: how would you copy all files containing a specific string
('CGTTATCCGGATTTATTGGGTTTA', say) into a new directory? And what are the
pros (and cons) of your approach?

(Work in small groups; start from working code, say, the 'find'
command above; there are several ways to do it, all that matters is
getting there.)

Things I forgot to talk about
-----------------------------

* sort (and sort -n)
* wc
* special characters and tricky filenames

Other notes
-----------

Google (and especially stackoverflow) is your friend.



