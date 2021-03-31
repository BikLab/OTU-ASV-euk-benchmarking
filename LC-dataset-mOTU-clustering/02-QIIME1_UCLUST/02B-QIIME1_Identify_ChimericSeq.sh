#!/bin/bash

#SBATCH --job-name="Identify_ChimericSeq"
#SBACTH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=50G
#SBATCH --time=14-00:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=END,FAIL
#SBATCH -e Identify_ChimericSeq.err-%N
#SBATCH -o Identify_ChimericSeq.out-%N


module unload miniconda2
module load qiime
module load usearch

# Paths to Files
INPUT=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/07-QIIME1-UCLUST/rep_set.fna
OUTPUT=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/07-QIIME1-UCLUST/07B-QIIME1_ChimericSeq

# Script
identify_chimeric_seqs.py \
	-i $INPUT \
	-m usearch61 \
	-o $OUTPUT \
	--suppress_usearch61_ref
