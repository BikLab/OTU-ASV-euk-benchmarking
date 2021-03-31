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
INPUT=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/uclust/otu_table_mc2.biom
OUTPUT=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/uclust/NPRB_Run3_Clustered99_Sans_Singletons_ChimericSeq.biom
CHIMERAS=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/uclust/ChimericSeq/chimeras.txt
INSEQ=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/uclust/rep_set.fna
OUTSEQ=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/uclust/NPRB_Run3_Clustered99_Sans_Singletons_ChimericSeq.fna

# Script
filter_otus_from_otu_table.py \
    -i $INPUT \
    -o $OUTPUT \
    -e $CHIMERAS && filter_fasta.py \
    -f $INSEQ \
    -o $OUTSEQ \
    -b $OUTPUT
