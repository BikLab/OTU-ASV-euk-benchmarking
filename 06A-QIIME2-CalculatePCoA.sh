#!/bin/bash

#SBATCH --job-name="CalculatePCoA"
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=50G
#SBATCH --time=7-00:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH -e CalculatePCoA.err-%N
#SBATCH -o CalculatePCoA.out-%N

#Path Variables
INPUT=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/DADA2/BetaDiversity
OUTPUT=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/DADA2/PCoA

#Activate QIIME2v2018.8
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
source activate qiime2-2018.8

#Calculate PCoA
for file in $INPUT/*.qza; do
fbname=$(basename $file _DistanceMatrix.qza)_PCoA.qza
qiime diversity pcoa  \
--i-distance-matrix $file \
--o-pcoa $OUTPUT/$fbname
done