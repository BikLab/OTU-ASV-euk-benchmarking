#### Import Biom Tables (VSearch Requires Different Importation Method Due to Having too Many Rows) ####
#### Load Packages Required to Run the Script ####
require(biomformat)
require(phyloseq)
require(tidyr)

##### INPUT Mapping File #####
mapdf <- import_qiime_sample_data("Desktop/NPRB-euk-benchmarking/NPRB_EukBench_MappingFile.txt")

##### INPUT VSearch BiomTable #####
vsearch_biom <- as.data.frame(as.matrix(biom_data(read_biom("Desktop/BiomTable_TaxonomyFiles/VSearch_BiomTable.biom"))))
OTU = otu_table(vsearch_biom, taxa_are_rows = TRUE)

##### INPUT VSearch Taxonomy File #####
vsearch_tax <- read.table("Desktop/BiomTable_TaxonomyFiles/VSearch_BlastTaxonomy.tsv", header = TRUE)
row.names(vsearch_tax) <- vsearch_tax$OTUID
vsearch_tax$OTUID <- NULL
vsearch_tax$confidence <- NULL
vsearch_tax <- separate(vsearch_tax,taxonomy,into=c("Rank1","Rank2","Rank3","Rank4","Rank5","Rank6","Rank7"), sep=";")
vsearch_matrix<- as.matrix(vsearch_tax)
TAX <- tax_table(vsearch_matrix)

##### INPUT UCLUST #####
uclust_biom <- import_biom("Desktop/BiomTable_TaxonomyFiles/UCLUST_BiomTable_w_RDPTaxonomy.biom")

##### INPUT DADA2 - And Fix the SampleNames to Match the MappingFile #####
dada2_biom <- import_biom("Desktop/BiomTable_TaxonomyFiles/DADA2_OptimalFiltering_SILVARef_Blast_Taxonomy.biom")

otu_table(dada2_biom)
colnames(otu_table(dada2_biom)) <- gsub("NPRB3_", "", colnames(otu_table(dada2_biom)))
colnames(otu_table(dada2_biom)) <- gsub("_", ".", colnames(otu_table(dada2_biom)))
otu_table(dada2_biom)
