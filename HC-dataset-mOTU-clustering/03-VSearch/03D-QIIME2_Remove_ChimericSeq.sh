#!/bin/bash

#SBATCH --job-name="RemoveChimericSeq"
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=25G
#SBATCH --time=7-00:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH -e Remove_ChimericSeq.err-%N
#SBATCH -o Remove_ChimericSeq.out-%N

#Path Variables
FEATURETABLE=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/VSearch/FeatureTable/NPRB_Run3_Clustered_99_FeatureTable_Filtered_Singletons.qza
FEATURESEQ=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/VSearch/FeatureSeq/NPRB_Run3_Clustered_99_FeatureSeq_Filtered_Singletons.qza
METADATA=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/VSearch/ChimericSeq/nonchimeras.qza
OUTPUTTABLE=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/VSearch/FeatureTable/NPRB_Run3_Clustered_99_FeatureTable_Filtered_Singletons_and_ChimericSeq.qza
OUTPUTSEQ=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/VSearch/FeatureSeq/NPRB_Run3_Clustered_99_FeatureSeq_Filtered_Singletons_and_ChimericSeq.qza

#Activate QIIME2
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
source activate qiime2-2019.4

#Script
qiime feature-table filter-features \
  --i-table $FEATURETABLE \
  --m-metadata-file $METADATA \
  --o-filtered-table $OUTPUTTABLE &&
qiime feature-table filter-seqs \
  --i-data $FEATURESEQ \
  --m-metadata-file $METADATA \
  --o-filtered-data $OUTPUTSEQ
