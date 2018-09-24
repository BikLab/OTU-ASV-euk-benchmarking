#!/bin/bash

#SBATCH --job-name="QIIME2_DADA2"
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=250G
#SBATCH --time=14-00:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH -e QIIME2_DADA2.err-%N
#SBATCH -o QIIME2_DADA2.out-%N

#Path Variables
INPUT=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/NPRB_DemulSeq_Run3Raw_FASTQ.qza
OUTPUT_TABLE=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/DADA2/NPRB_Run3_ASV_RepTable_DADA2.qza
OUTPUT_REPSEQ=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/QC_DADA2/NPRB_Run3_ASV_RepSeq_DADA2.qza
OUTPUT_STATS=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/QC_DADA2/NPRB_Run3_ASV_QCStats_DADA2.qza

#Activate QIIME2v2018.8
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
source activate qiime2-2018.8

#Script
qiime dada2 denoise-paired \
--i-demultiplexed-seqs $INPUT \
--p-trim-left-f 0 \
--p-trunc-len-f 220 \
--p-trim-left-r 0 \
--p-trunc-len-r 236 \
--o-table $OUTPUT_TABLE \
--o-representative-sequences $OUTPUT_REPSEQ \
--o-denoising-stats $OUTPUT_STATS \
--verbose
