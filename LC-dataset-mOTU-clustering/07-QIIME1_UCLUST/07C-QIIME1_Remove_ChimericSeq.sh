#!/bin/bash

#SBATCH --job-name="Remove_ChimericSeq"
#SBACTH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=50G
#SBATCH --time=14-00:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=END,FAIL
#SBATCH -e Remove_ChimericSeq.err-%N
#SBATCH -o Remove_ChimericSeq.out-%N


module unload miniconda2
module load qiime
module load usearch

# Paths to Files
INPUT=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/07-QIIME1-UCLUST/otu_table_mc2.biom
OUTPUT=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/07-QIIME1-UCLUST/07C-MEMB_Clustered99_FilteredSingletons_Sans_ChimericSeq.biom
CHIMERAS=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/07-QIIME1-UCLUST/07B-QIIME1_ChimericSeq/chimeras.txt
INSEQ=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/07-QIIME1-UCLUST/rep_set.fna
OUTSEQ=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/07-QIIME1-UCLUST/07C-MEMB_Clustered99_FilteredSingletons_Sans_ChimericSeq.fna

# Script
filter_otus_from_otu_table.py \
    -i $INPUT \
    -o $OUTPUT \
    -e $CHIMERAS && filter_fasta.py \
    -f $INSEQ \
    -o $OUTSEQ \
    -b $OUTPUT
