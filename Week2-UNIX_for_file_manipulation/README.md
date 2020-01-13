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

The ease of getting things done via the shell will increase with your exposure to the program.  
Go ahead and open a new terminal window in binder.

When we open up terminal in binder we will see a a line of text. This is a **prompt statement**. It can tell us useful things such as the name of the directory we are currently in, our username, or what computer we are currently running terminal on. However, the prompt statement that pops up in binder is quite long and distracting. Let's adjust it by running:

```
PS1='$ '
```

Then hit <kbd>Enter</kbd>. Better right?





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

## Automating Scripts

### Learning Goals
* establish repeatability by automating a series of commands
