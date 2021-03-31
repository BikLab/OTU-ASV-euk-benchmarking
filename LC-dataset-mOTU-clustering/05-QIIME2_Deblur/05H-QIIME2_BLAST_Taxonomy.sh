#!/bin/bash

#SBATCH --job-name="AssignTaxBlast"
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=50G
#SBATCH --time=7-00:00:00
#SBATCH --mail-user=adesa002@ucr.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH -e AssignTaxBlast.err-%N
#SBATCH -o AssignTaxBlast.out-%N


#Path Variables
INPUT=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/05-QIIME2_Deblur/05E-MEMB_AssignedASVs_Deblur/representative_sequences.qza
REFSEQ=/rhome/adesa002/shared/ref-dbs/CustomDatabase_SILVA_and_SingleNem_Sequences.qza
REFTAX=/rhome/adesa002/shared/ref-dbs/CustomDatabase_SILVA_and_SingleNem_Taxonomy.qza
OUTPUT=/rhome/adesa002/shared/memb/18S/analysis-results/QIIME2_Eukbench_Jan2020/05-QIIME2_Deblur/05G-MEMB_BLAST_Taxonomy.qza

#Activate QIIME2
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
source activate qiime2-2019.4

qiime feature-classifier classify-consensus-blast \
--i-query $INPUT \
--i-reference-reads $REFSEQ \
--i-reference-taxonomy $REFTAX \
--p-perc-identity 0.9 \
--o-classification $OUTPUT \
--verbose
