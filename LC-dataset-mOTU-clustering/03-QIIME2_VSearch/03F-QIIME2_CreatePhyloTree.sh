#!/bin/bash

#SBATCH --job-name="CreateTree"
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=75G
#SBATCH --time=7-00:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH -e CreateTree.err-%N
#SBATCH -o CreateTree.out-%N

#Path Variables
INPUT=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/06-QIIME2-VSearch/06F-MEMB_Clustered_99_RepSeq_FilteredSingletons_SansChimeras_VSearch.qza
OUTPUT=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/06-QIIME2-VSearch/06G-MEMB_PhylogeneticTree/

#Activate QIIME2v2019.4
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
source activate qiime2-2019.4

#Create Phylogeny Tree
qiime phylogeny align-to-tree-mafft-fasttree \
--i-sequences $INPUT \
--output-dir $OUTPUT \
--verbose