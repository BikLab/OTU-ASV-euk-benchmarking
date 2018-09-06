#!/bin/bash

#SBATCH --job-name="QIIME2_VSearch"
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=250G
#SBATCH --time=14-00:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH -e QIIME2_VSearch.err-%N
#SBATCH -o QIIME2_VSearch.out-%N

#Path Variables
INPUT=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/NPRB_DemulSeq.qza
OUTPUT_JOINEDSEQ=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/VSearch/NPRB_JoinPairs_VSearch.qza
OUTPUT_TABLE=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/VSearch/NPRB_OutTable_VSearch.qza
OUTPUT_REPSEQ=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/VSearch/NPRB_RepSeq_VSearch.qza

#Activate QIIME2v2018.8
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
source activate qiime2-2018.8

#Script
qiime vsearch join-pairs \
--i-demultiplexed-seqs $INPUT \
--p-truncqual 32 \
--o-joined-sequences $OUTPUT_JOINEDSEQ &&

qiime vsearch dereplication \
--i-sequences $OUTPUT_JOINEDSEQ \
--o-dereplicated-table $OUTPUT_TABLE \
--o-dereplicated-sequences $OUTPUT_REPSEQ
