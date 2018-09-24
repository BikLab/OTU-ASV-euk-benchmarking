#!/bin/bash

#SBATCH --job-name="QIIME2_VSearch"
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=100G
#SBATCH --time=14-00:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH -e QIIME2_VSearch.err-%N
#SBATCH -o QIIME2_VSearch.out-%N

#Path Variables
INPUT=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/NPRB_DemulSeq_Run3Raw_FASTA.qza
REF_SEQ=/rhome/adesa002/shared/ref-dbs/SILVA_132_QIIME_release/rep_set/rep_set_18S_only/99/silva_132_99_18S.qza
OUTPUT_TABLE=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/VSearch/NPRB_Run3_Dereplicate_OutTable_VSearch.qza
OUTPUT_REPSEQ=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/VSearch/NPRB_Run3_Dereplicate_RepSeq_VSearch.qza
OUTPUT_CLUSTERED_TABLE=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/VSearch/NPRB_Run3_Clustered_99_OutTable_VSearch.qza
OUTPUT_CLUSTERED_REPSEQ=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/VSearch/NPRB_Run3_Clustered_99_RepSeq_VSearch.qza
NEW_REFSEQ=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/VSearch/NPRB_Run3_NewRefSeq_VSearch.qza

#Activate QIIME2v2018.8
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
source activate qiime2-2018.8

#Script
qiime vsearch dereplicate-sequences \
--i-sequences $INPUT \
--o-dereplicated-table $OUTPUT_TABLE \
--o-dereplicated-sequences $OUTPUT_REPSEQ &&

qiime vsearch cluster-features-open-reference \
--i-sequences $OUTPUT_REPSEQ \
--i-table $OUTPUT_TABLE \
--i-reference-sequences $REF_SEQ \
--p-perc-identity .99 \
--o-clustered-table $OUTPUT_CLUSTERED_TABLE \
--o-clustered-sequences $OUTPUT_CLUSTERED_REPSEQ \
--o-new-reference-sequences $NEW_REFSEQ \
--p-threads 5 \
--verbose

