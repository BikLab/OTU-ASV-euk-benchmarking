#!/bin/bash

#SBATCH --job-name="ImportFASTQ"
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=15G
#SBATCH --time=7-00:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH -e ImportFASTQ.err-%N
#SBATCH -o ImportFASTQ.out-%N

#Path Variables
INPUT=/rhome/adesa002/shared/NPRB/18S/data-raw/18S-euk-2017-run3/demul_redo/qiime_ready/ExtendedFrags/ManifestFile_Import
OUTPUT=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/NPRB_DemulSeq_Run3_TrimmedMerged_FASTQ.qza

#Activate QIIME2
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
source activate qiime2-2019.4

#Script
qiime tools import \
  --type 'SampleData[SequencesWithQuality]' \
  --input-path $INPUT \
  --output-path $OUTPUT \
  --input-format SingleEndFastqManifestPhred33
