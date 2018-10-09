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
INPUT=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/VSearch/FeatureTable/NPRB_Run3_Clustered_99_FeatureTable.qza
OUTPUT=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/VSearch/FeatureTable/NPRB_Run3_Clustered_99_Rarefied_1000_FeatureTable.qza

#Activate QIIME2v2018.8
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
source activate qiime2-2018.8

#Rarefy BiomTable
qiime feature-table rarefy \
--i-table $INPUT \
--p-sampling-depth 1000 \
--o-rarefied-table $OUTPUT