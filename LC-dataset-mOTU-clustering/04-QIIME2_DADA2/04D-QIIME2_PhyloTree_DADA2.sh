#!/bin/bash

#SBATCH --job-name="CreateTree"
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=100G
#SBATCH --time=7-00:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH -e CreateTree.err-%N
#SBATCH -o CreateTree.out-%N

#Path Variables
INPUT=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/04-QIIME2_DADA2/04B-rRNAvariants_FeatureSeq_DADA2.qza
OUTPUT_ALIGNEDSEQ=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/04-QIIME2_DADA2/06A-MEMB_ASV_Aligned_FeatureSeq.qza
OUTPUT_MASKEDALIGNED=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/04-QIIME2_DADA2/06B-MEMB_ASV_MaskAligned_FeatureSeq.qza
OUTPUT_UNROOTEDTREE=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/04-QIIME2_DADA2/07A-MEMB_ASB_UnrootedTree.qza
OUTPUT_ROOTEDTREE=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/04-QIIME2_DADA2/07B-MEMB_ASV_RootedTree.qza

#Activate QIIME2v2019.4
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
source activate qiime2-2019.4

#Create Phylogeny Tree
qiime phylogeny align-to-tree-mafft-fasttree \
  --i-sequences $INPUT \
  --o-alignment $OUTPUT_ALIGNEDSEQ \
  --o-masked-alignment $OUTPUT_MASKEDALIGNED \
  --o-tree $OUTPUT_UNROOTEDTREE \
  --o-rooted-tree $OUTPUT_ROOTEDTREE
