#!/bin/bash

#SBATCH --job-name="VisualizeSeq"
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=50G
#SBATCH --time=7-00:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH -e VisualizeSeq.err-%N
#SBATCH -o VisualizeSeq.out-%N

#Path Variables
INPUT=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/NPRB_DemulSeq_Run3Raw_FASTQ.qza
OUTPUT=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/NPRB_DemulSeq_Run3Raw_Vis_FASTQ.qzv

#Activate QIIME2v2018.8
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-
source activate qiime2-2018.8

#Script
qiime demux summarize \
--i-data $INPUT \
--o-visualization $OUTPUT
