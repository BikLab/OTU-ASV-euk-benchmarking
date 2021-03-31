#!/bin/bash

#SBATCH --job-name="SummarizeFASTQ"
#SBATCH --partition=short
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=50G
#SBATCH --time=0-01:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH -e SummarizeFASTQ.err-%N
#SBATCH -o SummarizeFASTQ.out-%N

#Path Variables
INPUT=/rhome/adesa002/shared/memb/18S/analysis-results/rRNA-variants-review/02A-rRNAvariants_cutPrimers.qza
OUTPUT=/rhome/adesa002/shared/memb/18S/analysis-results/rRNA-variants-review/03A-rRNAvariants_summarize.qzv

#Activate QIIME2 conda env
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
source activate qiime2-2019.4

qiime demux summarize \
  --i-data $INPUT \
  --o-visualization $OUTPUT

