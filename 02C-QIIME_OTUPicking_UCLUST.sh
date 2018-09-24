#!/bin/bash

#SBATCH --job-name="pickOTUopenRef-18s-NPRB"
#SBACTH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=10G
#SBATCH --time=14-00:00:00
#SBATCH --mail-user=tiagojp@ucr.edu
#SBATCH --mail-type=END,FAIL
#SBATCH -e pickOTUopenRef-18s-NPRB.err-%N
#SBATCH -o pickOTUopenRef-18s-NPRB.out-%N


module unload miniconda3
module load miniconda2
module load qiime/1.9.1

# These paths are the same in the entire script
REF=/rhome/adesa002/shared/ref-dbs/SILVA_132_QIIME_release/rep_set/rep_set_18S_only/99/silva_132_99_18S.fna

# Change these paths according to files
INPUT=/rhome/adesa002/shared/NPRB/18S/data-raw/18S-euk-2017-run3/NPRB_Run3_TrimmedMerged.fa
OUT=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/UCLUST
PARA99=/rhome/adesa002/shared/NPRB/18S/qiime-files/parameters/18S_openref99_rdp_silva128.txt

# Step1: pick otu using 99 similarity score
pick_open_reference_otus.py \
    -r $REF \
    -i $INPUT \
    -o $OUT \
    -p $PARA99 \
    -s 0.10 \
    --prefilter_percent_id 0.0 \
    --suppress_align_and_tree
# -s subsamples at 10% of discarded sequence reads
