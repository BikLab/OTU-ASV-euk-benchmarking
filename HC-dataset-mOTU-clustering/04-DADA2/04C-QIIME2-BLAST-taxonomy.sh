#!/bin/bash

#SBATCH --job-name="AssignTaxBlast_DADA2"
#SBATCH --partition=bik_p
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=50G
#SBATCH --time=7-00:00:00
#SBATCH --mail-user=ad14556@uga.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH -e AssignTaxBlast_DADA2.err-%N
#SBATCH -o AssignTaxBlast_DADA2.out-%N


#Path Variables
INPUT=/scratch/ad14556/nprb/DADA2/FeatureSeq/NPRB_Run3_ASV_FeatureSeq.qza
REFSEQ=/scratch/ad14556/memb/silva-taxonomy/CustomDatabase_SILVA_and_SingleNem_Sequences.qza
REFTAX=/scratch/ad14556/memb/silva-taxonomy/CustomDatabase_SILVA_and_SingleNem_Taxonomy.qza
OUTPUT=/scratch/ad14556/nprb/DADA2/Taxonomy/NPRB_Run3_DADA2_BLAST_SILVA_132_CustomDB_90PercId.qza

#Activate QIIME2
module load Miniconda2
source activate qiime2-2019.4

qiime feature-classifier classify-consensus-blast \
--i-query $INPUT \
--i-reference-reads $REFSEQ \
--i-reference-taxonomy $REFTAX \
--p-perc-identity 0.9 \
--o-classification $OUTPUT \
--verbose
