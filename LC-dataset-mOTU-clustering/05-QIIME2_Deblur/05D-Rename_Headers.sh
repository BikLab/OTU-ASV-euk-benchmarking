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

INPUT=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/05-QIIME2_Deblur/05B-MEMB_Merged_QualityFiltered_Exported
OUTPUT=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/05-QIIME2_Deblur/05B-MEMB_Merged_QualityFiltered_HeaderRemoved_Exported

mkdir $OUTPUT

for file in $(ls $INPUT)
do NAME=$(echo $file | cut -d _ -f 1)
   zcat $INPUT/$file | awk -v var="$NAME" '{print (NR%4 == 1) ? "@" var "_" ++i "Seq" var : $0}'  | gzip -c > $OUTPUT/$file
done
