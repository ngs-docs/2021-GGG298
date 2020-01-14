# UNIX for File Manipulation

Launch binder:

This lesson is a combination of Data Carpentry's [Introduction to the Command Line for Genomics](https://datacarpentry.org/shell-genomics/) lesson and the Lab for Data Intensive Biology's [Advanced Beginner/Intermediate Shell](https://dib-training.readthedocs.io/en/pub/2016-01-13-adv-beg-shell.html) workshop.


## Section 1: Introduction to UNIX

### Learning Goals
* visualize file structure
* understand basic shell vocabulary
* understand the structure of commands
* gain exposure to the syntax of shell & scripting
* look at the contents of a directory 
* find features of commands with `man`
* commands: `pwd`, `ls`, `cd`, `man`

### Lesson
#### What is the shell and what is the terminal?
The **shell** is a computer program that uses a command line interface (CLI) to gives commmands made by your keyboard to your operating system. Most people are used to interacting with a graphic user interface (GUI), where you can use a combination of your mouse and keyboard to carry out commands on your computer. We can use the shell through a **terminal** program. 

Everything we can do using our computer GUI, we can do in the shell. We can open programs, run analyses, create documents, delete files and create folders. We should note that _folders_ are called **directories** at the command line. For all intensive purposes they can be used interchangeably but if you'd like more information please see "The folder metaphor" section of [Wikipedia](https://en.wikipedia.org/wiki/Directory_%28computing%29#Folder_metaphor).

The ease of getting things done via the shell will increase with your exposure to the program.  
Go ahead and open a new terminal window in binder.

When we open up terminal in binder we will see a a line of text. This is a **prompt statement**. It can tell us useful things such as the name of the directory we are currently in, our username, or what computer we are currently running terminal on. However, the prompt statement that pops up in binder is quite long and distracting. Let's customize it to read `$ ` it by running:

```
PS1='$ '
```

Then hit <kbd>Enter</kbd>. Better right?

Let's take a look around. First, we can use the **print working directory** command see what directory we are currently located in.

```
pwd
```

This gives us **absolute path** to the directory where we are located. An absolute path shows the complete series of directories you need to locate either a directory or a file starting from the root directory of your computer.

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

~~~
MiSeq		Slide1.jpg	hello.sh	nano1.png
README.md	gvng.jpg		nano2.png
~~~

However, this directory contains more than the eye can see! To show hidden files we can use the `-a` option.

```
ls -a
```

We will see the following:

~~~
.		MiSeq		Slide1.jpg	hello.sh	nano1.png
..		README.md	gvng.jpg	hidden		nano2.png
~~~

Three new items pop up `.`, `..` and `hidden`. 

Using options with our commands allows us to do a lot! But how did we know to add `-a` after ls? The `man` command allows us to look at what options any shell command has. Let's look at the available options that `ls` has:

```
man ls
```

Here we see a long list of options. Each option will allow us to do something different.
Try to find the option that allows you to differentiate between directories and executable files (**HINT** to search type `/` before the word you are looking for.)

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

### Learning Goals
* paths
* look at the contents of files
* move and copy files and directories 
* perform functions outside of the directory you are in
* commands: `cat`, `cp`, `mv`

Now we have a fairly good concept of navigating around our computers and seeing what is located in the directory we are. But some of the beauty of the shell is that we can execute activities in locations that we are not currently in. To do this we can either use an absolute path or a relative path. A **relative path** is the path to another directory from the the one you are currently in. 

Navigate into the tmp1 directory located in the hidden directory.

```
cd hidden/tmp1
```

Here we see two files `notit.txt` and `thisinnotit.txt`. We can see what is in the directories using the `cat` command. 

```
cat thisinnotit.txt
```

~~~
This is not the text file you're looking for
~~~

----

## Section 3: Searching

### Learning Goals
* looking inside files
* search for keywords within files with `grep`
* gain exposure to regular expressions

----

## Section 4: File Manipulation

### Learning Goals
* combine commands to carry out a sequence of steps with `|`
* redirect output of commands to files with `>`
* increase exposure to regular expressions

----

## Section 5: Automating Scripts

### Learning Goals
* establish repeatability by automating a series of commands
