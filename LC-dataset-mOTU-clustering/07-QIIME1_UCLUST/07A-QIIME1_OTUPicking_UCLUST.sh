#!/bin/bash

#SBATCH --job-name="pickOTUopenRef-18s-NPRB"
#SBACTH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=100G
#SBATCH --time=14-00:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=END,FAIL
#SBATCH -e pickOTUopenRef-18s-NPRB.err-%N
#SBATCH -o pickOTUopenRef-18s-NPRB.out-%N


module unload miniconda2
module load qiime/1.9.1

# Change these paths according to files
INPUT=/rhome/adesa002/shared/memb/18S/data-clean/18S-euk-memb1-filtered-samples-QIIME2Eukbench.fa
OUT=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/07-QIIME1-UCLUST/
PARA99=/rhome/adesa002/shared/NPRB/18S/qiime-files/parameters/18S_openref99.txt

# Step1: pick otu using 99 similarity score
pick_open_reference_otus.py \
    -i $INPUT \
    -o $OUT \
    -p $PARA99 \
    -s .10 \
    --prefilter_percent_id 0.0 \
    --suppress_align_and_tree \
    --suppress_taxonomy_assignment


