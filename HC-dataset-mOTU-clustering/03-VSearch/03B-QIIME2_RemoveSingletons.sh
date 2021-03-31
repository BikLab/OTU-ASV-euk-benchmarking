#!/bin/bash

#SBATCH --job-name="RemoveSingletons"
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=75G
#SBATCH --time=7-00:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH -e RemoveSingletons.err-%N
#SBATCH -o RemoveSingletons.out-%N

#Path Variables
INPUT=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/VSearch/FeatureTable/NPRB_Run3_Clustered_99_FeatureTable.qza
OUTPUT=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/VSearch/FeatureTable/NPRB_Run3_Clustered_99_FeatureTable_Filtered_Singletons.qza
SEQS=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/VSearch/FeatureSeq/NPRB_Run3_Clustered_99_FeatureSeq.qza
SEQOUT=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/VSearch/FeatureSeq/NPRB_Run3_Clustered_99_FeatureSeq_Filtered_Singletons.qza

#Activate QIIME2
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
source activate qiime2-2019.4

#Script
qiime feature-table filter-features \
  --i-table $INPUT \
  --p-min-frequency 2 \
  --o-filtered-table $OUTPUT &&
qiime feature-table filter-seqs \
  --i-data $SEQS \
  --i-table $OUTPUT \
  --o-filtered-data $SEQOUT 
