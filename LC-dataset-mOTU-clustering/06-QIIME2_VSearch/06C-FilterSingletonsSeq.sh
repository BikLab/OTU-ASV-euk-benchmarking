#!/bin/bash

#SBATCH --job-name="FilterSingletons"
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=50G
#SBATCH --time=7-00:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH -e FilterSingletons.err-%N
#SBATCH -o FilterSingletons.out-%N

#Path Variables
SEQ=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/06-QIIME2-VSearch/06C-MEMB_Clustered_99_RepSeq_VSearch.qza
INPUT=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/06-QIIME2-VSearch/06D-MEMB_Clustered_99_RepTable_FilteredSingletons_VSearch.qza
OUTPUT=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/06-QIIME2-VSearch/06D-MEMB_Clustered_99_RepSeq_FilteredSingletons_VSearch.qza

#Activate QIIME2v2019.4
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
source activate qiime2-2019.4

#Script
qiime feature-table filter-seqs \
  --i-data $SEQ \
  --i-table $INPUT \
  --o-filtered-data $OUTPUT
