#!/bin/bash

#SBATCH --job-name="ImportSeq_Artifacts"
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=50G
#SBATCH --time=7-00:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH -e ImportSeq_Artifacts.err-%N
#SBATCH -o ImportSeq_Artifacts.out-%N

#Path Variables
INPUT=/bigdata/biklab/shared/NPRB/18S/data-clean/NPRB_18S_2014_2016_2017_allsamplesMerged.faa
SEQ_ARTIFACT=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/NPRB_DemulSeq_AllRuns_FASTA.qza

#Activate QIIME2v2018.8
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
source activate qiime2-2018.8

#Script
qiime tools import \
--type 'SampleData[Sequences]' \
--input-path $INPUT \
--output-path $SEQ_ARTIFACT
