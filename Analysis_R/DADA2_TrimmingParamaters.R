#### Import Biom Tables ####
#### Load Packages Required to Run the Script ####
require(biomformat)
require(phyloseq)
require(tidyr)
require(data.table)
require(ggplot2)
require(ggpubr)
require(scales)
require(dplyr)

##### INPUT Mapping File #####
mapdf <- import_qiime_sample_data("Desktop/QIIME2-EukBenchmark/MappingFile/NPRB_EukBench_MappingFile.txt")

##### INPUT DADA2 'OptimalTrimming' #####
OT_BiomTable <- import_biom("Desktop/QIIME2-EukBenchmark/BiomTables/DADA2_OptimalTrimming_BiomTable_BLAST_Taxonomy.biom")

otu_table(OT_BiomTable)
colnames(otu_table(OT_BiomTable)) <- gsub("NPRB3_", "", colnames(otu_table(OT_BiomTable)))
colnames(otu_table(OT_BiomTable)) <- gsub("_", ".", colnames(otu_table(OT_BiomTable)))
otu_table(OT_BiomTable)

##### INPUT DADA2 'StringentTrimming' #####
ST_BiomTable <- import_biom("Desktop/QIIME2-EukBenchmark/BiomTables/DADA2_Stringent_BiomTable_BLAST_Taxonomy.biom")

otu_table(ST_BiomTable)
colnames(otu_table(ST_BiomTable)) <- gsub("NPRB3_", "", colnames(otu_table(ST_BiomTable)))
colnames(otu_table(ST_BiomTable)) <- gsub("_", ".", colnames(otu_table(ST_BiomTable)))
otu_table(ST_BiomTable)

##### INPUT DADA2 'NoTrimming' #####
NT_BiomTable <- import_biom("Desktop/QIIME2-EukBenchmark/BiomTables/DADA2_NoTrimming_BiomTable_BLAST_Taxonomy.biom")

otu_table(NT_BiomTable)
colnames(otu_table(NT_BiomTable)) <- gsub("NPRB3_", "", colnames(otu_table(NT_BiomTable)))
colnames(otu_table(NT_BiomTable)) <- gsub("_", ".", colnames(otu_table(NT_BiomTable)))
otu_table(NT_BiomTable)

##### Convert to PhyloSeq Object #####
OT_Phylo <- merge_phyloseq(OT_BiomTable, mapdf)
ST_Phylo <- merge_phyloseq(ST_BiomTable, mapdf)
NT_Phylo <- merge_phyloseq(NT_BiomTable, mapdf)

##### Clean up Data - Remove Singletons & Taxa Containing Mitochondria/Chloroplast #####
OT_Phylo <- subset_taxa(OT_Phylo, !Rank5=="Mitochondria" & !Rank3=="Chloroplast")
ST_Phylo <- subset_taxa(ST_Phylo, !Rank5=="Mitochondria" & !Rank3=="Chloroplast")
NT_Phylo <- subset_taxa(NT_Phylo, !Rank5=="Mitochondria" & !Rank3=="Chloroplast")

otu_table(OT_Phylo) = otu_table(OT_Phylo)[rowSums(otu_table(OT_Phylo)) > 1,]
otu_table(ST_Phylo) = otu_table(ST_Phylo)[rowSums(otu_table(ST_Phylo)) > 1,]
otu_table(NT_Phylo) = otu_table(NT_Phylo)[rowSums(otu_table(NT_Phylo)) > 1,]

##### Melt Phyloseq into LongForm #####
OT_DataFrame <- psmelt(OT_Phylo)
ST_DataFrame <- psmelt(ST_Phylo)
NT_DataFrame <- psmelt(NT_Phylo)

##### Add New Column and Combine Data Frames ##### 
OT_DataFrame$Treatment <- "Optimal"
ST_DataFrame$Treatment <- "Stringent"
NT_DataFrame$Treatment <- "None"

OT_ST_DataFrame <- rbind(OT_DataFrame, ST_DataFrame)
Final_DataFrame <- rbind(OT_ST_DataFrame, NT_DataFrame)
Final_DataFrame$TreatmentOrder = factor(Final_DataFrame$Treatment, levels=c('Optimal','Stringent','None'))

##### Plot Reads per Subregion - Edit ylim Accordingly ##### 
ReadsSubRegion <- ggplot(Final_DataFrame, aes(Subregion, Abundance, fill=Subregion)) + geom_bar(stat="identity", position = "stack") + 
  theme_bw() + theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) + facet_grid(. ~ TreatmentOrder) + 
  scale_y_continuous(labels = comma) + labs(title = "Number of Reads per Trimming Parameter", y = "Number of Reads")

ReadsSubRegion

