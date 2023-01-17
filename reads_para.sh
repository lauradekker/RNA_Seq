#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=2G
#SBATCH --time=02:00:00
#SBATCH --job-name=readspara1
#SBATCH --output=/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/scripts/reads/ReadParental1.o
#SBATCH --error=/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/errors/error_%j.e
#SBATCH --partition=pall

type=para

#according to Quinn this is to make a file where output is deposited
#if an error here try to make the para.txt file before executing script
echo "${type} reads:" > /data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/results/reads/${type}.txt

#move into the data directory with the links to the raw data
cd /data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/data/${type}

#the files are zipped, so need to be partially unzipped to be counted
for i in *.fastq.gz;
do echo $(zcat $i|wc -l)/4|bc >> /data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/results/reads/${type}.txt
done





