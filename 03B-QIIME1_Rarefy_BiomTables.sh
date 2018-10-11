#!/bin/bash

#SBATCH --job-name="Rarefy-BiomTable"
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=50G
#SBATCH --time=7-00:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH -e Rarefy-BiomTable.err-%N
#SBATCH -o Rarefy-BiomTable.out-%N

#Path Variables
INPUT=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_EukBenchmark_05Oct2018/UCLUST/otu_table_mc2.biom
OUTPUT=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_EukBenchmark_05Oct2018/UCLUST/otu_table_mc2_rarefied_1000.biom

#Activate QIIME2v2018.8
module unload miniconda3
module load miniconda2
module load qiime/1.9.1

#Rarefy BiomTable
single_rarefaction.py \
-i $INPUT \
-d 1000 \
-o $OUTPUT