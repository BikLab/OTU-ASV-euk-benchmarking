#!/bin/bash

#SBATCH --job-name="RenameHeaders"
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=50G
#SBATCH --time=7-00:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH -e RenameHeaders.err-%N
#SBATCH -o RenameHeaders.out-%N

INPUT=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/Deblur/copy_export_rename_header
OUTPUT=/rhome/adesa002/shared/NPRB/18S/analysis-results/QIIME2018v8_18s_05Sep2018/Deblur/new_header

mkdir $OUTPUT

for file in $(ls $INPUT)
do NAME=$(echo $file | cut -d _ -f 1)
   zcat $INPUT/$file | awk -v var="$NAME" '{print (NR%4 == 1) ? "@" var "_" ++i "Seq" var : $0}'  | gzip -c > $OUTPUT/$file
done
