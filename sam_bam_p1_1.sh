#!/bin/bash

#SBATCH --mail-type=fail,begin,end
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --job-name=sam_bam_P1_1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --time=2:00:00
#SBATCH --mem=20G
#SBATCH --output=/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/results/slurm_output/output_%j.o
#SBATCH --error=/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/errors/error_%j.e
#SBATCH --partition=pall

#import module to run samtools
module add UHTS/Analysis/samtools/1.10

#set working directory to a new bam directory
cd /data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/results/hisat2/bam

#shortcut sam index and sam file
sam_index=/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/results/hisat2/sam_ref_index/sam_ref_index.fai
sam_p1=/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/results/hisat2/sam/P1_L3.sam

#convert sam to bam
samtools view -b -t $sam_index $sam_p1 > bam_p1_unsorted.bam

#sort bam file
samtools sort -o bam_p1_sorted.bam bam_p1_unsorted.bam

#index sorted bam file
samtools index bam_p1_sorted.bam



