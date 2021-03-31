#!/bin/bash

#SBATCH --job-name="Create_PhyloTree"
#SBACTH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=150G
#SBATCH --time=14-00:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=END,FAIL
#SBATCH -e Create_PhyloTree.err-%N
#SBATCH -o Create_PhyloTree.out-%N


module unload miniconda2
module load qiime

# Paths to Files
INPUT=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/uclust/FilterAlignment/NPRB_Run3_Clustered99_Sans_Singletons_ChimericSeq_aligned_pfiltered.fasta
OUTPUT=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/uclust/final_tree.tre

# Script
make_phylogeny.py \
    -i $INPUT \
    -o $OUTPUT \
    --tree_method fasttree \
    -r midpoint
