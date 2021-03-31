#!/bin/bash

#SBATCH --job-name="VSearch_ChimericCheck"
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=75G
#SBATCH --time=7-00:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH -e VSearch_ChimericCheck.err-%N
#SBATCH -o VSearch_ChimericCheck.out-%N

#Path Variables
TABLE=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/06-QIIME2-VSearch/06D-MEMB_Clustered_99_RepTable_FilteredSingletons_VSearch.qza
SEQ=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/06-QIIME2-VSearch/06D-MEMB_Clustered_99_RepSeq_FilteredSingletons_VSearch.qza
OUTPUT=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/06-QIIME2-VSearch/06E-MEMB_Clustered_99_FilteredSingletons_ChimericCheck_VSearch/

#Activate QIIME2v2018.8
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
source activate qiime2-2019.4

#Script
qiime vsearch uchime-denovo \
--i-table $TABLE \
--i-sequences $SEQ \
--output-dir $OUTPUT

