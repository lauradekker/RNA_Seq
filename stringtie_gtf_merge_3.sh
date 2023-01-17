#!/bin/bash

#SBATCH --mail-type=fail,begin,end
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --job-name=stringtie_gtf_merge_3
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --time=2:00:00
#SBATCH --mem=40G
#SBATCH --output=/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/results/slurm_output/output_%j.o
#SBATCH --error=/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/errors/error_%j.e
#SBATCH --partition=pall

#Load stringtie module
module load UHTS/Aligner/stringtie/1.3.3b

#set working directory to deposit the merged file in
cd /data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/results/stringtie

#define location of .gtf files
#gtf_files="/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/results/stringtie"

#define location reference annotation
ref_ann="/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/data/gencode.v21.chr_patch_hapl_scaff.annotation.gtf"

#put the 6 previously made .gtf files in a list
ls -1 *.gtf > all_gtf_files.txt

#merge the 6 .gtf files using the .txt file generated above
# --merge indicates the merging of the files ; -G points to reference
# -o defines name of the output file 
stringtie --merge -o all_gtfs_merged.gtf -G $ref_ann all_gtf_files.txt

