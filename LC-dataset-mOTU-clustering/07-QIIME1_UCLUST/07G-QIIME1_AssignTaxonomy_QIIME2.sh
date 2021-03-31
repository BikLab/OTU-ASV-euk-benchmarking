#!/bin/bash

#SBATCH --job-name="AssignTaxBlast"
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=50G
#SBATCH --time=7-00:00:00
#SBATCH --mail-user=ad14556@ucr.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH -e AssignTaxBlast.err-%N
#SBATCH -o AssignTaxBlast.out-%N


#Path Variables
INPUT=/scratch/ad14556/memb/QIIME2_Eukbench_Jan2020/07-QIIME1-UCLUST/07C-MEMB_Clustered99_FilteredSingletons_Sans_ChimericSeq.qza
REFTAXA=/scratch/ad14556/memb/silva-taxonomy/CustomDatabase_SILVA_and_SingleNem_Taxonomy.qza
REFSEQ=/scratch/ad14556/memb/silva-taxonomy/CustomDatabase_SILVA_and_SingleNem_Sequences.qza
OUTPUT=/scratch/ad14556/memb/QIIME2_Eukbench_Jan2020/07-QIIME1-UCLUST/07G-MEMB_Clustered99_FilteredSingletons_SansChimeras_Taxonomy_BLAST.qza

#Activate QIIME2
module load Miniconda2
source activate qiime2-2019.4

qiime feature-classifier classify-consensus-blast \
--i-query $INPUT \
--i-reference-reads $REFSEQ \
--i-reference-taxonomy $REFTAXA \
--p-perc-identity 0.9 \
--o-classification $OUTPUT \
--verbose
