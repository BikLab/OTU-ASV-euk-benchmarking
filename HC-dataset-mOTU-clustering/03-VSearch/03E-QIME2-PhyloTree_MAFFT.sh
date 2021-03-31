#!/bin/bash

#SBATCH --job-name="CreateTree"
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=150G
#SBATCH --time=7-00:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH -e CreateTree.err-%N
#SBATCH -o CreateTree.out-%N

#Path Variables
INPUT=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/VSearch/FeatureSeq/NPRB_Run3_Clustered_99_FeatureSeq_Filtered_Singletons_and_ChimericSeq.qza
OUTPUT=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/VSearch/PhyloTree/

#Activate QIIME2
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
source activate qiime2-2019.4

#Create Phylogeny Tree
qiime phylogeny align-to-tree-mafft-fasttree \
--i-sequences $INPUT \
--output-dir $OUTPUT \
--verbose
