#!/bin/bash

#SBATCH --job-name="Create_PhyloTree"
#SBACTH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=50G
#SBATCH --time=14-00:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=END,FAIL
#SBATCH -e Create_PhyloTree.err-%N
#SBATCH -o Create_PhyloTree.out-%N


module unload miniconda2
module load qiime

# Paths to Files
INPUT=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/07-QIIME1-UCLUST/07E-MEMB_RemoveGaps_Alignment/07C-MEMB_Clustered99_FilteredSingletons_Sans_ChimericSeq_aligned_pfiltered.fasta
OUTPUT=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/07-QIIME1-UCLUST/07F-MEMB_PhyloTree_UCLUST.tre

# Script
make_phylogeny.py \
    -i $INPUT \
    -o $OUTPUT \
    --tree_method fasttree \
    -r midpoint
