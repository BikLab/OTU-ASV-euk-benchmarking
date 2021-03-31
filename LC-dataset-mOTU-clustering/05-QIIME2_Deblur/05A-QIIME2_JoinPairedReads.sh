#!/bin/bash

#SBATCH --job-name="QIIME2_joinPE"
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=100G
#SBATCH --time=14-00:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH -e QIIME2_JoinPE.err-%N
#SBATCH -o QIIME2_JoinPE.out-%N

#Path Variables
INPUT=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/02A-rRNAvariants_cutPrimers.qza
OUTPUT=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/05-QIIME2_Deblur/05A-MEMB_JoinedReads.qza

#Activate QIIME2v2018.8
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
source activate qiime2-2019.4

#Script
qiime vsearch join-pairs \
  --i-demultiplexed-seqs $INPUT \
  --o-joined-sequences $OUTPUT
  
