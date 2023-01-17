#!/bin/bash

#SBATCH --mail-type=fail,begin,end
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --job-name="hisat2_5_3_2"
#SBATCH --nodes=2
#SBATCH --cpus-per-task=6
#SBATCH --time=2:00:00
#SBATCH --mem=40G
#SBATCH --output=/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/results/slurm_output/output_%j.o
#SBATCH --error=/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/errors/error_%j.e
#SBATCH --partition=pall

#load modules
module add UHTS/Aligner/hisat/2.2.1

#set working directory
cd /data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/results/hisat2/sam

#make shortcut to the indexed reference genome
ref_idx=/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/results/hisat2/hisat2_ref_index/

#runs hisat2 on para strand 3_2
hisat2 -p 8 --dta -x $ref_idx -1 /data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/data/para/3_2_L3_R1_001_DID218YBevN6.fastq.gz -2 /data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/data/para/3_2_L3_R2_001_UPhWv8AgN1X1.fastq.gz -S 3_2_L3.sam

