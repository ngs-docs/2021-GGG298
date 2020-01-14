# UNIX for File Manipulation

Launch binder:

This lesson is a combination of Data Carpentry's [Introduction to the Command Line for Genomics](https://datacarpentry.org/shell-genomics/) lesson and the Lab for Data Intensive Biology's [Advanced Beginner/Intermediate Shell](https://dib-training.readthedocs.io/en/pub/2016-01-13-adv-beg-shell.html) workshop.


## Section 1: Introduction to UNIX

### Learning Goals
* visualize file structure
* understand basic shell vocabulary
* understand the structure of commands
* gain exposure to the syntax of shell & scripting
* look at the contents of a directory with `ls`
* find features of commands with `man`

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

This gives us **absolute path** to the directory where we are located. An absolute path shows a complete series of directories you need to locate either a directory or a file starting from the root of your computer.

What is the root?
![CLIvsGUI](https://github.com/ngs-docs/2020-GGG298/blob/shannonekj-week-2/Week2-UNIX_for_file_manipulation/CLIvsGUI.png)

We can also look at the contents of the directory by using the 




----

## Section 2: Navigation

### Learning Goals
* paths
* navigate around directories with `cd`
* move and copy files and directories 
* perform functions outside of the directory you are in

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
