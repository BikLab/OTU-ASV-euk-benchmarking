#!/bin/bash

#SBATCH --job-name="Denoise_MEMB"
#SBATCH --partition=highmem
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem-per-cpu=50G
#SBATCH --time=7-00:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH -e DenoiseMEMBB.err-%N
#SBATCH -o DenoiseMEMB.out-%N

#Path Variables

INPUT=/rhome/adesa002/shared/memb/18S/analysis-results/rRNA-variants-review/02-rRNAvariants_cutPrimers.qza
TABLE=/rhome/adesa002/shared/memb/18S/analysis-results/rRNA-variants-review/03-rRNAvariants_FeatureTables_DADA2.qza
SEQS=/rhome/adesa002/shared/memb/18S/analysis-results/rRNA-variants-review/03-rRNAvariants_FeatureSeq_DADA2.qza
STATS=/rhome/adesa002/shared/memb/18S/analysis-results/rRNA-variants-review/03-rRNAvariants_DenoiseStats.qza

#Activate QIIME2 conda env
module unload R 
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
source activate qiime2-2019.4

qiime dada2 denoise-paired \
  --i-demultiplexed-seqs $INPUT \
  --p-trim-left-f 0 \
  --p-trunc-len-f 232 \
  --p-trim-left-r 0 \
  --p-trunc-len-r 253 \
  --p-n-threads 5 \
  --o-table $TABLE \
  --o-representative-sequences $SEQS \
  --o-denoising-stats $STATS \
  --verbose


