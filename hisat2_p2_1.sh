#!/bin/bash

#SBATCH --mail-type=fail,begin,end
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --job-name=hisat2_1_P2
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --time=2:00:00
#SBATCH --mem=20G
#SBATCH --output=/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/results/slurm_output/output_%j.o
#SBATCH --error=/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/errors/error_%j.e
#SBATCH --partition=pall

#load modules
module add UHTS/Aligner/hisat/2.2.1

#set working directory
cd /data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/results/hisat2/sam

#make shortcut to the indexed reference genome
ref_idx=/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/results/hisat2/hisat2_ref_index

#make shortcut to the fastq files
p2_fwd=/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/data/parent/P2_L3_R1_001_R82RphLQ2938.fastq.gz
p2_rev=/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/data/parent/P2_L3_R2_001_06FRMIIGwpH6.fastq.gz

#runs hisat2 on para strand P1
hisat2 -p 8 --dta -x $ref_idx -1 $p2_fwd -2 $p2_rev -S P2_L3.sam



