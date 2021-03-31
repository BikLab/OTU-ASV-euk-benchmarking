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
INPUT=/rhome/adesa002/shared/NPRB/18S/data-raw/18S-euk-2017-run3/NPRB_Run3_TrimmedMerged.fa
OUT=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/uclust/
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


