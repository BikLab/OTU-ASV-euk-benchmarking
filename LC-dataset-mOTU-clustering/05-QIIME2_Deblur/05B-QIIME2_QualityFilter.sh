#!/bin/bash

#SBATCH --job-name="Quality_Filter"
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=100G
#SBATCH --time=14-00:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH -e QualFilter.err-%N
#SBATCH -o QualFilter.out-%N

#Path Variables
INPUT=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/05-QIIME2_Deblur/05A-MEMB_JoinedReads.qza
REPSEQ=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/05-QIIME2_Deblur/05B-MEMB_Merged_QualityFiltered.qza
STATS=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/05-QIIME2_Deblur/05B-MEMB_Merged_QualityFiltered_Stats.qza
VIS=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/05-QIIME2_Deblur/05B-MEMB_Merged_QualityFiltered_Stats_Vis.qzv

#Activate QIIME2v2019.4
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
source activate qiime2-2019.4

#script
qiime quality-filter q-score-joined \
  --i-demux $INPUT \
  --o-filter-stats $STATS \
  --o-filtered-sequences $REPSEQ \
  --verbose

qiime metadata tabulate \
  --m-input-file $STATS \
  --o-visualization $VIS
