#!/bin/bash

#SBATCH --job-name="BetaDiv"
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=50G
#SBATCH --time=7-00:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH -e BetaDiv.err-%N
#SBATCH -o BetaDiv.out-%N

#Path Variables
INPUT=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/DADA2/FeatureTable/NPRB_Run3_ASV_Rarefied_1000_FeatureTable.qza
OUTPUT=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/DADA2/BetaDiversity/NPRB_Run3_ASV_Rarefied_1000_WeightedUnifrac_DistanceMatrix.qza
TREE=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/DADA2/PhylogeneticTree/NPRB_Run3_ASV_RootedTree.qza

#Activate QIIME2v2018.8
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
source activate qiime2-2018.8

#Create Phylogeny Tree
qiime diversity beta-phylogenetic 
--i-table $INPUT \
--i-phylogeny $TREE \
--p-metric weighted_unifrac \
--o-distance-matrix $OUTPUT