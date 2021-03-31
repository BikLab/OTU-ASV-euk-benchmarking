#!/bin/bash

#SBATCH --job-name="Quality_Filter"
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=50G
#SBATCH --time=14-00:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH -e QualFilter.err-%N
#SBATCH -o QualFilter.out-%N

#Path Variables
INPUT=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/NPRB_DemulSeq_Run3Merged_FASTQ.qza
REPSEQ=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/Deblur/NPRB_Demultiplexed_MergedQualityFiltered.qza
STATS=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/Deblur/NPRB_Merged_QualityFiltered_Stats.qza


#Activate QIIME2
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
source activate qiime2-2019.4

#Script
qiime quality-filter q-score-joined \
  --i-demux $INPUT \
  --o-filter-stats $STATS \
  --o-filtered-sequences $REPSEQ \
  --verbose
