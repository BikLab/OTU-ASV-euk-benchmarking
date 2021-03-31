#!/bin/bash

#SBATCH --job-name="RemoveChimericSeq"
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=50G
#SBATCH --time=7-00:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH -e Remove_ChimericSeq.err-%N
#SBATCH -o Remove_ChimericSeq.out-%N

#Path Variables
TABLE=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/06-QIIME2-VSearch/06D-MEMB_Clustered_99_RepTable_FilteredSingletons_VSearch.qza
METADATA=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/06-QIIME2-VSearch/06E-MEMB_Clustered_99_FilteredSingletons_ChimericCheck_VSearch/nonchimeras.qza
SEQ=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/06-QIIME2-VSearch/06D-MEMB_Clustered_99_RepSeq_FilteredSingletons_VSearch.qza
OUTTABLE=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/06-QIIME2-VSearch/06F-MEMB_Clustered_99_RepTable_FilteredSingletons_SansChimeras_VSearch.qza
OUTSEQ=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/06-QIIME2-VSearch/06F-MEMB_Clustered_99_RepSeq_FilteredSingletons_SansChimeras_VSearch.qza

#Activate QIIME2v2019.4
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
source activate qiime2-2019.4

#Script
qiime feature-table filter-features \
  --i-table $TABLE \
  --m-metadata-file $METADATA \
  --o-filtered-table $OUTTABLE &&
qiime feature-table filter-seqs \
  --i-data $SEQ \
  --m-metadata-file $METADATA \
  --o-filtered-data $OUTSEQ

