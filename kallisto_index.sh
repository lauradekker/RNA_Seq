#!/bin/bash

#SBATCH --mail-type=fail,begin,end
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --job-name="kallisto_index"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --time=2:00:00
#SBATCH --mem=40G
#SBATCH --output=/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/results/slurm_output/output_%j.o
#SBATCH --error=/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/errors/error_%j.e
#SBATCH --partition=pall

#load module for kallisto to make the kallisto index
module load UHTS/Analysis/kallisto/0.46.0

#load cufflinks to make the fasta from the reference file and stringtie merged gtf
module load UHTS/Assembler/cufflinks/2.2.1

#shortcut to reference genome
ref_gen="/data/courses/rnaseq_course/lncRNAs/Project2/references/GRCh38.genome.fa"

#shortcut to merged .gtf file
gtf_merged="/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/results/stringtie/all_gtfs_merged.gtf"

#set working directory to deposit index file in
cd /data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/results/kallisto

#cufflinks gffread generates the fasta file based on the gff transcripts
# -w defines the  .fa file for spliced exons
# -g defines path to reference genome
gffread -w exon_trcr.fa -g $ref_gen $gtf_merged

#use the generated fasta file and kallisto to make an index for quantification in kallisto
# -i defines the name for the index file
kallisto index -i kallisto_ref_index.idx exon_trcr.fa
