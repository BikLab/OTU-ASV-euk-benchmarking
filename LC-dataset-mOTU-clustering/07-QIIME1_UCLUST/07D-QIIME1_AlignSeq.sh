#!/bin/bash

#SBATCH --job-name="Align_Seq"
#SBACTH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=50G
#SBATCH --time=14-00:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=END,FAIL
#SBATCH -e Align_Seq.err-%N
#SBATCH -o Align_Seq.out-%N


module unload miniconda2
module load qiime

# Paths to Files
INPUT=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/07-QIIME1-UCLUST/07C-MEMB_Clustered99_FilteredSingletons_Sans_ChimericSeq.fna
OUTPUT=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/07-QIIME1-UCLUST/07D-MEMB_AlignedSeq_FilteredSingletons_ChimericSeq
REF=/rhome/adesa002/shared/ref-dbs/SILVA_132_QIIME_release/rep_set_aligned/99/99_alignment.fna

# Script
align_seqs.py \
    -i $INPUT \
    -o $OUTPUT \
    -t $REF \
    --alignment_method pynast \
    --pairwise_alignment_method uclust \
    --min_percent_id 70.0 
