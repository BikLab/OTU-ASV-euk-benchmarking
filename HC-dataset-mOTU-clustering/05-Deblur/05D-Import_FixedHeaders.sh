#!/bin/bash

#SBATCH --job-name="ImportSeq_Artifacts"
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=20G
#SBATCH --time=7-00:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH -e ImportSeq_Artifacts.err-%N
#SBATCH -o ImportSeq_Artifacts.out-%N

#Path Variables
INPUT=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/Deblur/new_header/
SEQ_ARTIFACT=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/Deblur/NPRB_Demultiplexed_MergedQualityFiltered_FixedNames.qza

#Activate QIIME2
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
source activate qiime2-2019.4

#Script
qiime tools import \
--type 'SampleData[SequencesWithQuality]' \
--input-path $INPUT \
--input-format CasavaOneEightSingleLanePerSampleDirFmt \
--output-path $SEQ_ARTIFACT
