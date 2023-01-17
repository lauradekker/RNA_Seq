#!/bin/bash

#SBATCH --mail-type=fail,begin,end
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --job-name=count_exon_transcr_genes
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --time=2:00:00
#SBATCH --mem=20G
#SBATCH --output=/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/results/slurm_output/output_%j.o
#SBATCH --error=/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/errors/error_%j.e
#SBATCH --partition=pall

#shortcut to directory of the merged .gtf directory
mrg_gtf="/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/results/stringtie"

#access the file to prepare to count the necessary data
cat $mrg_gtf/all_gtfs_merged.gtf | awk 'BEGIN{
}!/^#/{

