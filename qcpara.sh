#!/bin/bash

#SBATCH --mail-type=fail,begin,end
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --job-name="qc_para"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=6
#SBATCH --time=2:00:00
#SBATCH --mem=25G
#SBATCH --output=/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/scripts/output_%j.o
#SBATCH --error=/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/errors/error_%j.e
#SBATCH --partition=pall

# Set "type" variable i.e. 'parent' 'holo' etc.
type="para"

# Load FastQC module
# Theres a more efficient way to do this but I can't work it 
# out, so for now I'm using the module script from the
# Bioinformatics Course 

source /data/users/lfalquet/SBC07107_22/scripts/module.sh

# go to the data directory 
cd /data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/data/${type}

# make the output dir

mkdir /data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/results/qc/${type}

for k in `ls -1 *.fastq.gz`;
do fastqc -t 6 ${k} -o /data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/results/qc/${type};
done
