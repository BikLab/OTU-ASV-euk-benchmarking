require(biomformat)
require(phyloseq)
require(tidyr)

##### INPUT Mapping File #####
mapdf <- import_qiime_sample_data("Desktop/NPRB-euk-benchmarking/NPRB_EukBench_MappingFile.txt")

##### INPUT VSearch - Was Large File Was Causing RStudio to Crash #####
vsearch_biom <- as.data.frame(as.matrix(biom_data(read_biom("Desktop/GoogleDrive/Euk_Bench/NPRB/BiomTables/VSearch/NPRB_Run3_Clustered_99_BiomTable.biom"))))
OTU = otu_table(vsearch_biom, taxa_are_rows = TRUE)

vsearch_tax <- read.table("Desktop/GoogleDrive/Euk_Bench/NPRB/BiomTables/VSearch_Taxonomy_Blast_Exported.tsv", header = T)
row.names(vsearch_tax) <- vsearch_tax$OTUID
vsearch_tax$OTUID <- NULL
vsearch_tax$confidence <- NULL
vsearch_tax <- separate(vsearch_tax,taxonomy,into=c("Rank1","Rank2","Rank3","Rank4","Rank5","Rank6","Rank7"), sep=";")
vsearch_matrix<- as.matrix(vsearch_tax)
TAX <- tax_table(vsearch_matrix)

##### INPUT UCLUST #####
uclust_biom <- import_biom("Desktop/GoogleDrive/Euk_Bench/NPRB/BiomTables/UCLUST/otu_table_mc2_w_tax.biom")

##### INPUT DADA2 - And Fix the SampleNames to Match the MappingFile #####
dada2_biom <- import_biom("Desktop/NPRB_Run3_ASV_BiomTable_w_BLAST_Taxonomy.biom")

otu_table(dada2_biom)
colnames(otu_table(dada2_biom)) <- gsub("NPRB3_", "", colnames(otu_table(dada2_biom)))
colnames(otu_table(dada2_biom)) <- gsub("_", ".", colnames(otu_table(dada2_biom)))
otu_table(dada2_biom)
