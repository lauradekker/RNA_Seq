#!/bin/bash

#SBATCH --mail-type=fail,begin,end
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --job-name=hisat2_1_P3
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
ref_idx=/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/results/hisat2/hisat2_ref_index/ref_index

#make shortcut to the fastq files
p3_fwd=/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/data/parent/P3_L3_R1_001_fjv6hlbFgCST.fastq.gz
p3_rev=/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/data/parent/P3_L3_R2_001_xo7RBLLYYqeu.fastq.gz

#runs hisat2 on para strand P1
hisat2 -p 8 --dta -x $ref_idx -1 $p3_fwd -2 $p3_rev -S P3_L3.sam



