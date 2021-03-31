#!/bin/bash

#SBATCH --job-name="Filter_Alignment"
#SBACTH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=50G
#SBATCH --time=14-00:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=END,FAIL
#SBATCH -e Filter_Alignment.err-%N
#SBATCH -o Filter_Alignment.out-%N


module unload miniconda2
module load qiime

# Paths to Files
INPUT=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/uclust/SeqAlignment/NPRB_Run3_Clustered99_Sans_Singletons_ChimericSeq_aligned.fasta
OUTPUT=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/uclust/FilterAlignment

# Script
filter_alignment.py \
    -i $INPUT \
    -o $OUTPUT \
    --suppress_lane_mask_filter
