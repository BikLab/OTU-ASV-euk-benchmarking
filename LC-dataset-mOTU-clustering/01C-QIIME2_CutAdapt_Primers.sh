#!/bin/bash

#SBATCH --job-name="Remove_Primers"
#SBATCH --partition=highmem
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem-per-cpu=30G
#SBATCH --time=7-00:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH -e Remove_Primers.err-%N
#SBATCH -o Remove_Primers.out-%N

#Path Variables

INPUT=/rhome/adesa002/shared/memb/18S/analysis-results/rRNA-variants-review/01-rRNAvariants_FASTQ_Artifact.qza
OUTPUT=/rhome/adesa002/shared/memb/18S/analysis-results/rRNA-variants-review/02-rRNAvariants_cutPrimers.qza

#Activate QIIME2 conda env
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
source activate qiime2-2019.4

qiime cutadapt trim-paired \
  --i-demultiplexed-sequences $INPUT \
  --p-cores 5 \
  --p-adapter-f GGCTTAATCTTTGAGACAAGCCGAATTACCATA \
  --p-adapter-r TCCAAGGAAGGCAGCAGGCTACTGGCTGACT \
  --o-trimmed-sequences $OUTPUT

