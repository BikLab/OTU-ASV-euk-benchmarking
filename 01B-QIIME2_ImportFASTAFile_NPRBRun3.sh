#!/bin/bash

#SBATCH --job-name="ImportFASTA"
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=50G
#SBATCH --time=7-00:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH -e ImportFASTA.err-%N
#SBATCH -o ImportFASTA.out-%N

#Path Variables
INPUT=/rhome/adesa002/shared/NPRB/18S/data-raw/18S-euk-2017-run3/demul_redo/NPRB_Run3_TrimmedMerged.fa
OUTPUT=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/NPRB_DemulSeq_Run3Raw_FASTA.qza

#Activate QIIME2v2018.8
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
source activate qiime2-2018.8

#Script
qiime tools import \
--input-path $INPUT \
--output-path $OUTPUT \
--type 'SampleData[Sequences]'

