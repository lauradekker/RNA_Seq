

  #setup
  
#install sleuth

#BiocManager::install("devtools")
#BiocManager::install("pachterlab/sleuth")
#BiocManager::install("rtracklayer")


#```{r message=FALSE, include=FALSE}
#knitr::opts_chunk$set(echo=TRUE)

#Set wd to analysis results directory on local computer
setwd("C:/Users/laura/OneDrive/Documenten/Bern/Universiteit/RNA Sequencing/Analysis-results/differential_expression/")

#load Sleuth, tidyverse & rtracklayer
library(tidyverse)
library(rtracklayer)
library(sleuth)

  #arrange the merged .gtf file in order to use Sleuth

#Load the merged .gtf file and convert it into a data frame
gtf_merged <- rtracklayer::import("all_gtfs_merged.gtf")
gtf_merged_df <- as.data.frame(gtf_merged)

#Filter the necessary columns and then arrange to get NAs at the end
gtf_filt_col <- gtf_merged_df %>% filter(type == "transcript") %>% select(gene_id, transcript_id, gene_name, ref_gene_id)
gtf_arr_NA <- gtf_filt_col %>% arrange(gene_name)

#Find rows with an without NAs
get_NA <- is.na(gtf_arr_NA$gene_name)
get_NA_nr <- which(is_NA == TRUE)
get_not_NA_nr <- which(is_NA == FALSE)

#for NA get gene_id and transcript_id if gene name is NA
get_NA_nr_df <- gtf_arr_NA[get_NA_nr, c(1,2)]
#for not NA get same
get_not_NA_nr_df <- gtf_arr_NA[get_not_NA_nr, c(3,2)]
colnames(get_not_NA_nr_df) <- c("gene_id", "transcript_id")

#put everything in one data frame and sort the same as gtf_arranged
gene_transcript_file <- as.data.frame(rbind(get_NA_nr_df, get_not_NA_nr_df))
gene_transcript_file <- gene_transcript_file[order(match(gene_transcript_file[,2],gtf_filt_col[,2])),]
colnames(gene_transcript_file) <- c("gene_id", "target_id")

#write.csv(gene_transcript_file, file = "gene_transcript_file.csv", row.names = FALSE)
gene_transcript_file <- read.csv(file = "gene_transcript_file.csv")

  #Sleuth & differential expression of transcripts

#assign information on sample abundance files and their locations to a variable
#sample_locations <- read.csv("sample_paths2.csv", header = T, sep = ",") #.txt file maybe?
sample_locations <- read.table("sample_paths4.txt", header = T, sep = ",")
#My .csv is separated by ; not , look if it works now

#1. Assign to a variable the sample locations, and experiment details
#kallisto data assigned to an object so sleuth can use it.
so_transcript <- sleuth_prep(sample_locations, read_bootstrap_tpm = TRUE, extra_bootstrap_summary = TRUE, transformation_function = function(x) log2(x + 0.5))
#76701 objects passed the filter
#read_bootstrap_tpm = summary statistics
#extra_bootstrap_summary = extra summary statistics
#transformation_function = assigns different logarithmic function to make output better interpretable
#

#2. Estimate parameters for sleith response error measurement
so_transcript <- sleuth_fit(so_transcript, ~condition, "full")

#3. estimate parameters for sleuth reduced model
so_transcript <- sleuth_fit(so_transcript, ~1, "reduced")

#4. differential analysis test with likelihood ratio
so_transcript <- sleuth_lrt(so_transcript, "reduced", "full")

#5. differential analysis with Wald test
so_transcript <- sleuth_wt(so_transcript, "conditionparental",)

#Examine results of test transcript level
transcript_likelihood <- sleuth_results(so_transcript, "reduced:full", "lrt", show_all = F)
transcript_likelihood_sig <- filter(transcript_likelihood, qval <= 0.05)
transcript_wald <- sleuth_results(so_transcript, "conditionparental", show_all = T)
transcript_wald_sig <- filter(transcript_wald, qval <= 0.05)

#write transcript results to files (only once)
#write.csv(transcript_likelihood, file = "sleuth_trpt_like.csv", row.names = F)
#write.csv(transcript_likelihood_sig, file = "sleuth_trpt_like_sig.csv", row.names = F)
#write.csv(transcript_wald, file = "sleuth_trpt_wald.csv", row.names = F)
#write.csv(transcript_wald_sig, file = "sleuth_trpt_wald_sig.csv", row.names = F)
#sleuth_save(so_transcript, file = "so_transcript")

  #Sleuth & differential expression of genes

#1. assign kallisto data to an object for sleuth to process
so_genes <- sleuth_prep(sample_locations, target_mapping = gene_transcript_file, aggregation_column = "gene_id", gene_mode = T, read_bootstrap_tpm = T, extra_bootstrap_summary = T, transformation_function = function(x) log2(x + 0.5))
#76701 objects passed filter
#22694 genes passed filter
#took really long?

#2. estimate parameters for sleuth response error measurement
so_genes <- sleuth_fit(so_genes, ~condition, "full")

#3. estimate parameters for sleuth reduced model
so_genes <- sleuth_fit(so_genes, ~1, "reduced")

#4. differential analysis with likelihood ratio
so_genes <- sleuth_lrt(so_genes, "reduced", "full")

#5. perform differential analysis with Wald
so_genes <- sleuth_wt(so_genes, "conditionparental")

#examine results gene level
gene_likelihood <- sleuth_results(so_genes, "reduced:full", "lrt", show_all = F)
gene_likelihood_sig <- filter(gene_likelihood, qval <= 0.05)
gene_wald <- sleuth_results(so_genes, "conditionparental", show_all = T)
gene_wald_sig <- filter(gene_wald, qval <= 0.05)

#write gene results to file (only once)
#write.csv(gene_likelihood, file = "sleuth_gene_like.csv", row.names = F)
#write.csv(gene_likelihood_sig, file = "sleuth_gene_like_sig.csv", row.names = F)
#write.csv(gene_wald, file = "sleuth_gene_wald.csv", row.names = F)
#write.csv(gene_wald_sig, file = "sleuth_gene_wald_sig.csv", row.names = F)
#sleuth_save(so_genes, file = "so_genes")

  #Volcano plot transcript-level

sleuth_live(so_transcript)

  #volcano plot gene level

sleuth_live(so_genes)




