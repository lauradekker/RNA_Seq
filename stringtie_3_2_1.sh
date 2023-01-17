#!/bin/bash

#SBATCH --mail-type=fail,begin,end
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --job-name=stringtie_3_2_1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=6
#SBATCH --time=2:00:00
#SBATCH --mem=40G
#SBATCH --output=/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/results/slurm_output/output_%j.o
#SBATCH --error=/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/errors/error_%j.e
#SBATCH --partition=pall

#load stringtie module
module load UHTS/Aligner/stringtie/1.3.3b

#shortcut to reference annotation
ref_ann="/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/data/gencode.v21.chr_patch_hapl_scaff.annotation.gtf"

#shortcut to sorted bam file directory
sorted_bam="/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/results/hisat2/bam/bam_sorted/bam_3_2_sorted.bam"

#set working directory
cd /data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/results/stringtie/

#perform stringtie function to create .gtf transcriptome assembly files
# -o defines the name of output file ; --rf indicates first-strand library caused by sequencing type
# -G defines the reference annotation file ; after ref_ann define location of bam file to process
stringtie -o transcriptome_assembly_3_2.gtf --rf -G $ref_ann $sorted_bam





