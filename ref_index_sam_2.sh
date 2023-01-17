#!/bin/bash

#SBATCH --mail-type=fail,begin,end
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --job-name="ref_index_sam_2"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=6
#SBATCH --time=2:00:00
#SBATCH --mem=25G
#SBATCH --output=/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/results/slurm_output/output_%j.o
#SBATCH --error=/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/errors/error_%j.e
#SBATCH --partition=pall

#load module samtools
module add UHTS/Analysis/samtools/1.10

#set working directory
cd /data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/results/hisat2/sam_ref_index

#necessary step to prepare the reference genome to be read by samtools
samtools faidx /data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/data/GRCh38.genome.fa > GRCh38_genome_samtools_idx.fai


