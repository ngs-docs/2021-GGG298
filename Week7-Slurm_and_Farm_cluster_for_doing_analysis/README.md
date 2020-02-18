# Slurm and the Farm cluster for doing analysis

## What is a cluster?

A cluster can be thought of as a group of computers which work together to allow you to log onto one computer (**head node**) and use resources to perform memory intensive functions from other connected computers.

<center><img src="https://i.imgur.com/2nl5zzP.png" width="80%"></a></center>

Image modified from [vrlab](http://www.vrlab.umu.se/documentation/guides/beginner-guide)

## How do clusters work?

### Job Schedulers

In order to carry out commands that are memory intensive we need to use auxillary computers that will not affect the login/head node. **NOTE:** sometimes merely copying large files is memory intensive enough that we will need to use computers other than the head node! To request resources to run our scripts we use _job schedulers_. Job schedulers handle how to allocate the compute cluster's resources to batch job scripts submitted by users.

There are a number of different flavors of job schedulers. The job scheduler you will be submitting jobs to is specific to the cluster you are using at your institution but they all have the following general structure:

![](https://i.imgur.com/9rSbIxR.png)

The job scheduler evaulates when resources will be dedicated to a job based on the:
* partition & priority (`-p`)
* how much of  the group's resources are already being used
* requested wall time (`-t`)
* requested resources
    * memory (`--mem`)
    * CPUs (`-c`)


**Slurm** [workload manager](https://slurm.schedmd.com/documentation.html)

Slurm is an open source workload manager that is commonly used on compute clusters (both the FARM and barbera use Slurm). It handles allocating resources requested by batch scripts. 

There are **two** main ways you can request resources using Slurm:

#### 1. Run an interactive session with `srun`

Interactive sessions allow you to work on computers that aren't the login/head node. Essentially you can do everything you've done at the command line interface on Jetstream on the compute cluster. This is really powerful for doing memory intensive commands that you may not need to keep track of. However, with this power comes a great danger. 

*Why is it dangerous?*
The commands you run will not be saved in scripts anywhere. So, if you wanted to go back and recreate an analysis, you won't know what you've run, how you've run it or which versions of software you used.

To request and launch a basic interactive session that will last for two hours use the following:
```
srun --time=02:00:00 --pty /bin/bash
```

Pay close attention to the time you give to yourself using `srun`! Slurm will terminate the session immediately at the end of the allotted time. It, sadly, doesn't care if you are 99.99% of the way through your analysis :/

Also, you can request more/different resources by using to following flags:
* `--mem=<number>Gb` = request memory
* `-c <number>` = request a certain number of CPUs
* `--pty R` = request an interactive R session


#### 2. Submit batch scripts with `sbatch`

Batch job scripts (also known as job scripts) are scripts that contain `#!/bin/bash` at the beginning of each script and are submitted to the slurm workload manager by using `sbatch`. When we submit a script to slurm it is considered a _job_ and gets a unique _job ID_ assigned to it.

First, let's create a script called **HelloWorld.sh**.

```
nano HelloWorld.sh
```

Then copy and paste the following:

```
#!/bin/bash

echo Hello World
sleep 1m
date
```

Then exit nano with <kbd>Crtl+Q</kbd>

We can submit this script to **Slurm** with the `sbatch` command.

```
sbatch HelloWorld.sh
```

but we receive an error message...

```
sbatch: error: Batch job submission failed: Requested time limit is invalid (missing or exceeds some limit)
```

In order to handle jobs, Slurm needs to know the maximum amount of **walltime** your job will run. Walltime can be thought of as the amount of time from the start of your code running to when the last command in your script finishes. We can tell Slurm how much time to allow our submitted script by using the `-t` flag. Let's tell Slurm that our job _shouldn't_ take longer than 5 minutes (note: the format is `dd-hh:mm:ss`).

```
sbatch -t 00-00:06:00 HelloWorld.sh
``` 

You will see your job was successfully submitted and will be given an associated Job ID number `Submitted batch job 15219016`

#### Flags to use when submitting jobs

We can use a number of different flags to specify resources we want from Slurm:
* the **partition** we would like to use for our job––this will also entail the _priority_ in which our job is submitted (priorities can be high, medium or low). We can request a partition by using the following flag: `-p <name_of_partition>`. The farm has the following partitions:
    * parallel nodes names: `high`, `med`, `low`
        * 24 nodes with 64 CPUs and 256GB ram
        * 95 nodes with 32 CPUs and 64GB ram
    * bigmem nodes names: `bmh`, `bmm`, `bml`, `bigmemh`, `bigmemm`, `bigmeml`
        * 13 nodes with 96 CPUs and 1TB ram
        * 9 nodes with 64 CPUs and 512GB 
        * 1 node with 96 CPUs and 1024GB 
* the **memory** required to run our job. We can request a specified amount of time with the following flag: `--mem=<number>Gb`
* we can have slurm **mail** us updates about our job, such as when it starts(`BEGIN`), ends(`END`), if it fails(`FAIL`) or all of the above (`ALL`). We can request slurm emails us with the following flags: `--mail-user=<your_email> --mail-type=ALL`
* we can also give jobs specific **names**. To name your job use: `-J <job_name>` Be careful, as there is a limit to the number of characters your job name can be.
* slurm automatically generates **output scripts** where all of the output from commands run from the script are printed to. These will take the form as `slurm12345.out` where 12345 is an identifying number slurm assigns to the file. We can change this to any output file name we want. To specify the name of your output file use `-o <file_name>.out`
* slurm can generate **error files**, where all of the errors from the script are printed to. We can ask slurm to create err files and name them with `-e <file_name>.err`

If we were hard to ourselves we would write these out at the command line each time we submitted a job to slurm with `sbatch`. It would look something like this:
```
sbatch --time=01-02:03:04 -p high --mem=4Gb --mail-user=<your_email> --mail-type=ALL -J <job_name> -o <file_name>.out -e <file_name>.err
```
We will ned to switch out all of the `<text>` with parameters specific to our preference, but hopefully you get the gist. We can make this easier on ourselves: typing all of the parameters out on the command line everytime we want to submit a batch script is annoying and it also doesn't allow us to record what parameters we used easily.

Luckily there is a way to put the parameters for each job in the script we submit to slurm!
   


#### Repeatibility

One of the most important things in science is repeatability. This sentiment holds true in bioinformatics experiments as well. However, it is exceptionally easy to run a series of command on data, leave the data for a few months (or years) and come back to the data and have no clue how you went from point A to point Z. 

Let's say we lost everything except our backed up raw data and we needed to recreate an analysis. In the worst case, where  the commands used to carry out the experiment were not saved, we would have to figure out all of the commands with only a vague memory of the steps we took to get results. It is hard, if not impossible to recreate an analysis with exactly the same string of commands and parameters. So, we should think about documenting things as we go.

In the best case (of this terrible scenario) we would have a script to recreate our analysis! So, we can make this easy for our _future_ forgetful-selves and put all of the flags and commands we submit to Slurm INSIDE our batch scripts!

We can do this by adding **#SBATCH** lines of code after the shebang line (`#!/bin/bash`) in our script.

```
#!/bin/bash
#
#SBATCH --mail-user=<email>@ucdavis.edu        # YOUR EMAIL ADDRESS
#SBATCH --mail-type=ALL                         # NOTIFICATIONS OF SLURM JOB STATUS - ALL, NONE, BEGIN, END, FAIL, REQUEUE
#SBATCH -J HelloWorld                           # JOB ID
#SBATCH -e HelloWorld.j%j.err                   # STANDARD ERROR FILE TO WRITE TO
#SBATCH -o HelloWorld.j%j.out                   # STANDARD OUTPUT FILE TO WRITE TO
#SBATCH -c 1                                    # NUMBER OF PROCESSORS PER TASK
#SBATCH --ntasks=1                              # MINIMUM NUMBER OF NODES TO ALLOCATE TO JOB
#SBATCH --mem=1Gb                               # MEMORY POOL TO ALL CORES
#SBATCH --time=00-00:11:00                      # REQUESTED WALL TIME
#SBATCH -p low                                 # PARTITION TO SUBMIT TO

echo Hello World
sleep 10m
date
```

Make sure to replace your `<email>` with your UC Davis email address.


#### Monitor your jobs with `squeue`

Oftentimes we submit jobs and would like to know certain things about them -- if they've started, how long they've been running, if they are _still_ running, etc, etc... We can look at the status of any job Slurm is handling by using `squeue`

Let's submit the `HelloWorld.sh` to slurm:

```
sbatch HelloWorld.sh
```

If we type

```
squeue
```

then we see _many_ rows of jobs...

```
         JOBID PARTITION     NAME     USER ST        TIME  NODES CPU MIN_ME NODELIST(REASON)
      15218450       bmh this_is_ keyu1996 CG       31:10      1 2   100G   bm3
      15219413       bmh     pigz   aminio CG        0:01      1 8   4G     bm2
15108157_[34-4   bigmemm  mapping gfburgue PD        0:00      1 8   200G   (Resources)
14204771_[1182       med freebaye eoziolor PD        0:00      1 4   2000M  (AssocGrpCpuLimit)
15217722_[7-23       bmm     trim hansvgdu PD        0:00      1 2   10G    (JobArrayTaskLimit)
      15113687   bigmemm AA_ophiu jgillung PD        0:00      1 24  200G   (Priority)
      15144078   bigmemm NT_ophiu jgillung PD        0:00      1 24  200G   (Priority)
      15144205   bigmemm AA_plant jgillung PD        0:00      1 24  200G   (Priority)
      15144210   bigmemm NT_plant jgillung PD        0:00      1 24  200G   (Priority)
```

This is a list of **ALL** the jobs currently submitted to Slurm -- which usually quite a few! And often we won't be able to scroll through the list to find our job(s). So, in order to only see your own job(s) we can specify a **username**:

To find your username you can use the `whoami` command:
```
whoami
```

We can use the output of this to see the status of the jobs associated with a particular username:

```
squeue -u <username>
```

```
         JOBID PARTITION     NAME     USER ST        TIME  NODES CPU MIN_ME NODELIST(REASON)
      15219530       med Hello sejoslin  R        0:28      1 1   2000M  c11-72
```
Much better!! 

Not only can you check on your own job's status but you can also check on the status of your **group**:
```
squeue -A <group_name>
```

If you do not know what group you are a part of, you can check!
```
groups
```

You can also check on the status of particular partitions:
```
squeue -p <partition_name>
```

These will help you figure out what resources are being used so you can figure out which are free.



#### Cancel your jobs with `scancel`

To cancel a single job you can specify the `JOBID`
```
scancel <job_ID>
```

To cancel all of the jobs that belong to you, use the `-u`flag.
```
squeue -u <username>
```




### Space Issues

Each group only has so much space on the cluster. Memory can be bought but it is good practice to always compress and delete files as we run analyses. That way, we won't have an extra terrabyte of unnecessary sequence data files hanging around.  

* space left for group
```
df -h | grep <username>
```
* how much space you are taking up
```
du -d 0 -h
``` 

### Nodes vs CPUs vs tasks

* **Node**: A physical box that connects memory systems with extension cards and CPU cores. (On Barbera you can only request **one** node or else your job will fail)
* **CPU Core**: An independent computing unit that can access a certain number of _CPU threads_ with all the threads having independent input streams but sharing the core's total memory.
* **tasks**: This is 

The `-c` flag will adjust the number of CPUs per process. Alter this if the job is multithreaded and requires more than one CPU per task to perform optimally. If this option is specified without the -n flag, then as many tasks will be allocated to per node as possible.
The `-n` flag will determine the number of tasks to run. The default Slurm setting is one task per node but is adjusted when using -c. 

<center><img src="https://i.imgur.com/4cercJV.png" width="50%"></a></center>

