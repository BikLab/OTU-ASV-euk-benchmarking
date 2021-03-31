#!/bin/bash

#SBATCH --job-name="Denoise_Stats"
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=50G
#SBATCH --time=1-00:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH -e DenoiseStats.err-%N
#SBATCH -o DenoiseStats.out-%N

#Path Variables
INPUT=/rhome/adesa002/shared/memb/18S/analysis-results/rRNA-variants-review/03-rRNAvariants_DenoiseStats.qza
OUTPUT=/rhome/adesa002/shared/memb/18S/analysis-results/rRNA-variants-review/export

#Activate QIIME2 conda env
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
source activate qiime2-2019.4

qiime tools export \
  --input-path $INPUT \
  --output-path $OUTPUT

mv $OUTPUT/* $OUTPUT/../04-rRNAvariants_Denoise_Stats_exported.txt
rm -r $OUTPUT
