#!/bin/bash

#SBATCH --job-name="QIIME2_Deblur"
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=30G
#SBATCH --time=14-00:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH -e QIIME2_Deblur.err-%N
#SBATCH -o QIIME2_Deblur.out-%N

#Path Variables
INPUT=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/Deblur/NPRB_Demultiplexed_MergedQualityFiltered_FixedNames.qza
REF=/rhome/adesa002/shared/ref-dbs/SILVA_132_QIIME_release/rep_set/rep_set_18S_only/99/silva_132_99_18S.qza
OUTPUT=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/Deblur/ClusteredASVs

#Activate QIIME2
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
source activate qiime2-2019.4

#Script
qiime deblur denoise-other \
  --i-demultiplexed-seqs $INPUT \
  --i-reference-seqs $REF \
  --p-trim-length 350 \
  --output-dir $OUTPUT 
