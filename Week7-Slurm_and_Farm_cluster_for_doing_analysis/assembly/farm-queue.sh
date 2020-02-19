#!/bin/bash -login
#SBATCH -p bmh                 # partition, or queue, to assign to
#SBATCH -J ggg298-assembly     # name for job
#SBATCH -N 1                   # one "node", or computer
#SBATCH -n 1                   # one task for this node
#SBATCH -c 8                   # eight cores per task
#SBATCH -t 0:30:00             # ask for no more than 30 minutes
#SBATCH --mem=10gb             # ask for no more than 10 GB of memory

# initialize conda
. ~/miniconda3/etc/profile.d/conda.sh

# activate your desired conda environment
conda activate assembly

# go to the directory you ran 'sbatch' in, OR just hardcode it...
#cd $SLURM_SUBMIT_DIR
cd ~/Week7-Slurm_and_Farm_cluster_for_doing_analysis/assembly

# fail on weird errors
set -o nounset
set -o errexit
set -x

# run the snakemake!
snakemake -p -j 8 --use-conda -n

# print out various information about the job
env | grep SLURM            # Print out values of the current jobs SLURM environment variables

scontrol show job ${SLURM_JOB_ID}     # Print out final statistics about resource uses before job exits

sstat --format 'JobID,MaxRSS,AveCPU' -P ${SLURM_JOB_ID}.batch
