#!/bin/bash

#SBATCH --job-name="AssignTaxBlast_UCLUST"
#SBATCH --partition=bik_p
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=50G
#SBATCH --time=7-00:00:00
#SBATCH --mail-user=ad14556@uga.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH -e AssignTaxBlast_UCLUST.err-%N
#SBATCH -o AssignTaxBlast_UCLUST.out-%N


#Path Variables
INPUT=/scratch/ad14556/nprb/uclust/NPRB_Run3_Clustered99_Sans_Singletons_ChimericSeq_FixedHeaders.qza
REFSEQ=/scratch/ad14556/memb/silva-taxonomy/CustomDatabase_SILVA_and_SingleNem_Sequences.qza
REFTAX=/scratch/ad14556/memb/silva-taxonomy/CustomDatabase_SILVA_and_SingleNem_Taxonomy.qza
OUTPUT=/scratch/ad14556/nprb/uclust/Taxonomy/NPRB_Run3_UCLUST_Taxonomy_BLAST_SILVA132_RefNR_CustomDB_90PercId.qza

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
