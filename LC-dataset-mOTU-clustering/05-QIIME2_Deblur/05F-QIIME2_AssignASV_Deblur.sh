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
REF=/rhome/adesa002/shared/ref-dbs/SILVA_132_QIIME_release/rep_set/rep_set_18S_only/99/silva_132_99_18S.qza
INPUT=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/05-QIIME2_Deblur/05D-MEMB_Merged_QualityFiltered_HeaderRenamed.qza
OUTPUT=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/05-QIIME2_Deblur/05E-MEMB_AssignedASVs_Deblur

#Activate QIIME2v2018.8
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
source activate qiime2-2019.4

#Script
qiime deblur denoise-other \
  --i-demultiplexed-seqs $INPUT \
  --i-reference-seqs $REF \
  --p-trim-length 360 \
  --output-dir $OUTPUT 
