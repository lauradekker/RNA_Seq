#!/bin/bash

#SBATCH --mail-type=fail,begin,end
#SBATCH --mail-user=laura.dekker@students.unibe.ch
#SBATCH --job-name="kallisto_quantification"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --time=2:00:00
#SBATCH --mem=50G
#SBATCH --output=/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/results/slurm_output/output_%j.o
#SBATCH --error=/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/errors/error_%j.e
#SBATCH --partition=pall

#Load kallisto module
module load UHTS/Analysis/kallisto/0.46.0

#shortcut for each cell type 3_2, 3_4, 3_7 & P1, P2, P3
cell_type="3_7"
#shortcut to kallisto results directory
res_kall="/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/results/kallisto"
#shortcut to data link directory
data_link="/data/courses/rnaseq_course/lncRNAs/Project2/users/ldekker/data/para"

#define directory for quantification results in kallisto results directory
cd ${res_kall}

#make a new directory for the quantification results per cell line
mkdir quant_${cell_type} 

#run kallisto quantification
# -i index file
# -b nr of bootstrap samples
# -o defines results directory
# -t thread number
# --rf-stranded point to original .gz data links, R1 first then R2

#change para in --rf to parent later in shortcut
kallisto quant -i kallisto_ref_index.idx -b 100 -o ${res_kall}/quant_${cell_type} -t 8 --rf-stranded ${data_link}/${cell_type}*R1*.fastq.gz ${data_link}/${cell_type}*R2*.fastq.gz
