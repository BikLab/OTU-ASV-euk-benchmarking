#### Load Packages ####
require(biomformat)
require(phyloseq)
require(tidyr)
require(data.table)
require(ggplot2)
require(ggpubr)
require(scales)
require(dplyr)

##### INPUT Mapping File #####
mapdf <- import_qiime_sample_data("Desktop/GoogleDrive/BikLab/QIIME2-EukBenchmark/MappingFile/NPRB_EukBench_MappingFile.txt")

##### INPUT DADA2 'OptimalTrimming' #####
OT_BiomTable <- import_biom("Desktop/GoogleDrive/BikLab/QIIME2-EukBenchmark/BiomTable/DADA2_OptimalFiltering_SILVARef_Blast_Taxonomy.biom")

otu_table(OT_BiomTable)
colnames(otu_table(OT_BiomTable)) <- gsub("NPRB3_", "", colnames(otu_table(OT_BiomTable)))
colnames(otu_table(OT_BiomTable)) <- gsub("_", ".", colnames(otu_table(OT_BiomTable)))
otu_table(OT_BiomTable)

##### INPUT DADA2 'StringentTrimming' #####
ST_BiomTable <- import_biom("Desktop/GoogleDrive/BikLab/QIIME2-EukBenchmark/BiomTable/DADA2_Stringent_BiomTable_Taxonomy_BLAST.biom")

otu_table(ST_BiomTable)
colnames(otu_table(ST_BiomTable)) <- gsub("NPRB3_", "", colnames(otu_table(ST_BiomTable)))
colnames(otu_table(ST_BiomTable)) <- gsub("_", ".", colnames(otu_table(ST_BiomTable)))
otu_table(ST_BiomTable)

##### INPUT DADA2 'NoTrimming' #####
NT_BiomTable <- import_biom("Desktop/GoogleDrive/BikLab/QIIME2-EukBenchmark/BiomTable/DADA2_NoTrim_Taxonomy_SILVARef_Blast_Taxonomy.biom")

otu_table(NT_BiomTable)
colnames(otu_table(NT_BiomTable)) <- gsub("NPRB3_", "", colnames(otu_table(NT_BiomTable)))
colnames(otu_table(NT_BiomTable)) <- gsub("_", ".", colnames(otu_table(NT_BiomTable)))
otu_table(NT_BiomTable)

##### Convert to PhyloSeq Object #####
OT_Phylo <- merge_phyloseq(OT_BiomTable, mapdf)
ST_Phylo <- merge_phyloseq(ST_BiomTable, mapdf)
NT_Phylo <- merge_phyloseq(NT_BiomTable, mapdf)

sum(taxa_sums(OT_Phylo) == 1)
sum(taxa_sums(ST_Phylo) == 1)
sum(taxa_sums(NT_Phylo) == 1)

sum(taxa_sums(OT_Phylo) > 0)
sum(taxa_sums(ST_Phylo) > 0)
sum(taxa_sums(NT_Phylo) > 0)

OT_Phylo_SubsetNematoda <- subset_taxa(OT_Phylo, Rank7=="Nematoda")
ST_Phylo_SubsetNematoda <- subset_taxa(ST_Phylo, Rank7=="Nematoda")
NT_Phylo_SubsetNematoda <- subset_taxa(NT_Phylo, Rank7=="Nematoda")

tax_table(OT_Phylo_SubsetNematoda)[is.na(tax_table(OT_Phylo_SubsetNematoda))] <- "Unknown"
tax_table(ST_Phylo_SubsetNematoda)[is.na(tax_table(ST_Phylo_SubsetNematoda))] <- "Unknown"
tax_table(NT_Phylo_SubsetNematoda)[is.na(tax_table(NT_Phylo_SubsetNematoda))] <- "Unknown"

sum(taxa_sums(OT_Phylo_SubsetNematoda) > 0)
sum(taxa_sums(ST_Phylo_SubsetNematoda) > 0)
sum(taxa_sums(NT_Phylo_SubsetNematoda) > 0)

get_taxa_unique(OT_Phylo_SubsetNematoda, "Rank9")
get_taxa_unique(ST_Phylo_SubsetNematoda, "Rank9")
get_taxa_unique(NT_Phylo_SubsetNematoda, "Rank9")

sum(taxa_sums(subset_taxa(NT_Phylo_SubsetNematoda, Rank9=="Unknown")) > 0)

##### Merge Phyloseq Objects by Subregions #####
OT_Phylo_MergedSubRegion <- merge_samples(OT_Phylo, "Subregion")
sample_data(OT_Phylo_MergedSubRegion)[ "Subregion" ] <- rownames(sample_data(OT_Phylo_MergedSubRegion))
sample_data(OT_Phylo_MergedSubRegion)$Region <- gsub('1', 'Beaufort Sea', sample_data(OT_Phylo_MergedSubRegion)$Region)
sample_data(OT_Phylo_MergedSubRegion)$Region <- gsub('2', 'Chukchi Sea', sample_data(OT_Phylo_MergedSubRegion)$Region)

ST_Phylo_MergedSubRegion <- merge_samples(ST_Phylo, "Subregion")
sample_data(ST_Phylo_MergedSubRegion)[ "Subregion" ] <- rownames(sample_data(ST_Phylo_MergedSubRegion))
sample_data(ST_Phylo_MergedSubRegion)$Region <- gsub('1', 'Beaufort Sea', sample_data(ST_Phylo_MergedSubRegion)$Region)
sample_data(ST_Phylo_MergedSubRegion)$Region <- gsub('2', 'Chukchi Sea', sample_data(ST_Phylo_MergedSubRegion)$Region)

NT_Phylo_MergedSubRegion <- merge_samples(NT_Phylo, "Subregion")
sample_data(NT_Phylo_MergedSubRegion)[ "Subregion" ] <- rownames(sample_data(NT_Phylo_MergedSubRegion))
sample_data(NT_Phylo_MergedSubRegion)$Region <- gsub('1', 'Beaufort Sea', sample_data(NT_Phylo_MergedSubRegion)$Region)
sample_data(NT_Phylo_MergedSubRegion)$Region <- gsub('2', 'Chukchi Sea', sample_data(NT_Phylo_MergedSubRegion)$Region)

##### Plot Observed Richness #####
plot_theme <- theme_bw() + theme(axis.text.x = element_blank(), axis.title.x = element_blank(), axis.ticks = element_blank())

OT_ObservedRichness <- plot_richness(OT_Phylo_MergedSubRegion, color = "Subregion", measures=c("Observed"), title = "Optimal") + geom_point(size = 5, alpha = 0.5) + 
  plot_theme + theme(axis.title.y = element_text(face = "bold", size = 14), plot.title = element_text(face = "bold", size = 14)) + ylab("Observed ASVs") +
  scale_color_manual(values = c("deepskyblue4", "darkslateblue", "darkorange4", "goldenrod4", "deeppink4", "darkolivegreen4")) + ylim(0, 2500) 

ST_ObservedRichness <- plot_richness(ST_Phylo_MergedSubRegion, color = "Subregion", measures=c("Observed"), title = "Stringent") + geom_point(size = 5, alpha = 0.5) + 
  plot_theme + theme(axis.text = element_blank(), axis.title = element_blank(), plot.title = element_text(face = "bold", size = 14)) +
  scale_color_manual(values = c("deepskyblue4", "darkslateblue", "darkorange4", "goldenrod4", "deeppink4", "darkolivegreen4")) + ylim(0, 2500) 

NT_ObservedRichness <- plot_richness(NT_Phylo_MergedSubRegion, color = "Subregion", measures=c("Observed"), title = "None") + geom_point(size = 5, alpha = 0.5) +
  plot_theme + theme(axis.text = element_blank(), axis.title = element_blank(), plot.title = element_text(face = "bold", size = 14)) +
  scale_color_manual(values = c("deepskyblue4", "darkslateblue", "darkorange4", "goldenrod4", "deeppink4", "darkolivegreen4")) + ylim(0, 2500)


##### Plot Shannon Index ##### 
plot_theme <- theme_bw() + theme(axis.text.x = element_blank(), axis.title.x = element_blank(), axis.ticks = element_blank(), strip.background = element_blank(), strip.text.x = element_blank())

OT_ShannonRichness <- plot_richness(OT_Phylo_MergedSubRegion, color = "Subregion", measures=c("Shannon")) + geom_point(size = 5, alpha = 0.5) + 
  plot_theme + theme(axis.title.y = element_text(face = "bold", size = 14)) + ylab("Shannon Index") +
  scale_color_manual(values = c("deepskyblue4", "darkslateblue", "darkorange4", "goldenrod4", "deeppink4", "darkolivegreen4")) + ylim(2.5, 5) 

ST_ShannonRichness <- plot_richness(ST_Phylo_MergedSubRegion, color = "Subregion", measures=c("Shannon")) + geom_point(size = 5, alpha = 0.5) + plot_theme +
  theme(axis.text = element_blank(), axis.title = element_blank()) +
  scale_color_manual(values = c("deepskyblue4", "darkslateblue", "darkorange4", "goldenrod4", "deeppink4", "darkolivegreen4")) + ylim(2.5, 5) 

NT_ShannonRichness <- plot_richness(NT_Phylo_MergedSubRegion, color = "Subregion", measures=c("Shannon")) + geom_point(size = 5, alpha = 0.5) + plot_theme + 
  theme(axis.text = element_blank(), axis.title = element_blank()) +
  scale_color_manual(values = c("deepskyblue4", "darkslateblue", "darkorange4", "goldenrod4", "deeppink4", "darkolivegreen4")) + ylim(2.5, 5)

##### Plot Simpson Index ##### 
OT_SimpsonRichness <- plot_richness(OT_Phylo_MergedSubRegion, color = "Subregion", measures=c("Simpson")) + geom_point(size = 5, alpha = 0.5) + 
  plot_theme + theme(axis.title.y = element_text(face = "bold", size = 14)) + ylab("Simpson Index") +
  scale_color_manual(values = c("deepskyblue4", "darkslateblue", "darkorange4", "goldenrod4", "deeppink4", "darkolivegreen4")) + ylim(0.8, 1) 

ST_SimpsonRichness <- plot_richness(ST_Phylo_MergedSubRegion, color = "Subregion", measures=c("Simpson")) + geom_point(size = 5, alpha = 0.5) + plot_theme + 
  theme(axis.text = element_blank(), axis.title = element_blank()) +
  scale_color_manual(values = c("deepskyblue4", "darkslateblue", "darkorange4", "goldenrod4", "deeppink4", "darkolivegreen4")) + ylim(0.8, 1) 

NT_SimpsonRichness <- plot_richness(NT_Phylo_MergedSubRegion, color = "Subregion", measures=c("Simpson")) + geom_point(size = 5, alpha = 0.5) + plot_theme + 
  theme(axis.text = element_blank(), axis.title = element_blank()) +
  scale_color_manual(values = c("deepskyblue4", "darkslateblue", "darkorange4", "goldenrod4", "deeppink4", "darkolivegreen4")) + ylim(0.8, 1) 

##### Add all the Alpha Diversity Plots to One Graph #####
DADA2_AlphaDiversity <- ggarrange(OT_ObservedRichness, ST_ObservedRichness, NT_ObservedRichness,
                                  OT_ShannonRichness, ST_ShannonRichness, NT_ShannonRichness,
                                  OT_SimpsonRichness, ST_SimpsonRichness, NT_SimpsonRichness,
                                  common.legend = TRUE, ncol = 3, nrow = 3, legend = "right", align = "hv") 

DADA2_AlphaDiversity <- annotate_figure(DADA2_AlphaDiversity, bottom = text_grob("Subregion", face = "bold", size = 14), 
                                        top = text_grob("Alpha Diversity on Different Trimming Parameters", face = "bold", size = 14))
DADA2_AlphaDiversity

tiff(file = "Desktop/GoogleDrive/BikLab/QIIME2-EukBenchmark/Analysis/DADA2-FilteringParameters/AlphaDiversity_Measures.tiff", 
     width=11.5, height=8, units = "in", res = 300)
DADA2_AlphaDiversity
dev.off()

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

##### Plot Reads per Subregion ##### 
ReadsSubRegion <- ggplot(Final_DataFrame, aes(Subregion, Abundance, fill=Subregion)) + geom_bar(stat="identity", position = "stack") + 
  theme_bw() + theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) + facet_grid(. ~ TreatmentOrder) + 
  scale_y_continuous(labels = comma) + labs(title = "Number of Reads per Trimming Parameter", y = "Number of Reads") + 
  scale_fill_manual(values = c("deepskyblue4", "darkslateblue", "darkorange4", "goldenrod4", "deeppink4", "darkolivegreen4"))
ReadsSubRegion

tiff(file = "Desktop/GoogleDrive/BikLab/QIIME2-EukBenchmark/Analysis/DADA2-FilteringParameters/NumberofReads_Subregions.tiff", 
     width=11.5, height=8, units = "in", res = 300)
ReadsSubRegion
dev.off()

##### Rarefy Samples to 1000Seq/Samples and 2500 Seq/Sample #####
OT_Phylo_Rarefied1000 <- rarefy_even_depth(OT_Phylo, sample.size = 1000, replace = FALSE, rngseed = TRUE)
ST_Phylo_Rarefied1000 <- rarefy_even_depth(ST_Phylo, sample.size = 1000, replace = FALSE, rngseed = TRUE)
NT_Phylo_Rarefied1000 <- rarefy_even_depth(NT_Phylo, sample.size = 1000, replace = FALSE, rngseed = TRUE)

##### Ordinate Datasets Using BrayCurt Dissimilarity Matrix #####
OT_Ordinate1000 = ordinate(OT_Phylo_Rarefied1000, "PCoA", "bray")
ST_Ordinate1000 = ordinate(ST_Phylo_Rarefied1000, "PCoA", "bray")
NT_Ordinate1000 = ordinate(NT_Phylo_Rarefied1000, "PCoA", "bray")

##### Plot PCoA #####
OT_PCoA1000 <- plot_ordination(OT_Phylo_Rarefied1000, OT_Ordinate1000, color="Subregion", title = "Optimal") + geom_point(size=2) + theme_bw() + 
  theme(aspect.ratio = 1) + scale_color_manual(values = c("deepskyblue4", "darkslateblue", "darkorange4", "goldenrod4", "deeppink4", "darkolivegreen4"))
ST_PCoA1000 <- plot_ordination(ST_Phylo_Rarefied1000, ST_Ordinate1000, color="Subregion", title = "Stringent") + geom_point(size=2) + theme_bw() + 
  theme(aspect.ratio = 1) + scale_color_manual(values = c("deepskyblue4", "darkslateblue", "darkorange4", "goldenrod4", "deeppink4", "darkolivegreen4"))
NT_PCoA1000 <- plot_ordination(NT_Phylo_Rarefied1000, NT_Ordinate1000, color="Subregion", title = "None") + geom_point(size=2) + theme_bw() + 
  theme(aspect.ratio = 1) + scale_color_manual(values = c("deepskyblue4", "darkslateblue", "darkorange4", "goldenrod4", "deeppink4", "darkolivegreen4"))

PCoA1000 <- ggarrange(OT_PCoA1000, ST_PCoA1000, NT_PCoA1000, common.legend = TRUE,
                       ncol = 3, nrow = 1, legend = "right", align = "hv") 
PCoA1000

tiff(file = "Desktop/GoogleDrive/BikLab/QIIME2-EukBenchmark/Analysis/DADA2-FilteringParameters/PCoA_SubRegions_Rarefied1000.tiff", 
     width=11.5, height=8, units = "in", res = 300)
PCoA1000
dev.off()

##### Rarefy Samples to 1000Seq/Samples and 2500 Seq/Sample #####
OT_Phylo_Rarefied2500 <- rarefy_even_depth(OT_Phylo, sample.size = 2500, replace = FALSE, rngseed = TRUE)
ST_Phylo_Rarefied2500 <- rarefy_even_depth(ST_Phylo, sample.size = 2500, replace = FALSE, rngseed = TRUE)
NT_Phylo_Rarefied2500 <- rarefy_even_depth(NT_Phylo, sample.size = 2500, replace = FALSE, rngseed = TRUE)

##### Ordinate Datasets Using BrayCurt Dissimilarity Matrix #####
OT_Ordinate2500 = ordinate(OT_Phylo_Rarefied2500, "PCoA", "bray")
ST_Ordinate2500 = ordinate(ST_Phylo_Rarefied2500, "PCoA", "bray")
NT_Ordinate2500 = ordinate(NT_Phylo_Rarefied2500, "PCoA", "bray")

##### Plot PCoA #####
OT_PCoA2500 <- plot_ordination(OT_Phylo_Rarefied2500, OT_Ordinate2500, color="Subregion", title = "Optimal") + geom_point(size=2) + theme_bw() + 
  theme(aspect.ratio = 1) + scale_color_manual(values = c("deepskyblue4", "darkslateblue", "darkorange4", "goldenrod4", "deeppink4", "darkolivegreen4"))
ST_PCoA2500 <- plot_ordination(ST_Phylo_Rarefied2500, ST_Ordinate2500, color="Subregion", title = "Stringent") + geom_point(size=2) + theme_bw() + 
  theme(aspect.ratio = 1) + scale_color_manual(values = c("deepskyblue4", "darkslateblue", "darkorange4", "goldenrod4", "deeppink4", "darkolivegreen4"))
NT_PCoA2500 <- plot_ordination(NT_Phylo_Rarefied2500, NT_Ordinate2500, color="Subregion", title = "None") + geom_point(size=2) + theme_bw() + 
  theme(aspect.ratio = 1) + scale_color_manual(values = c("deepskyblue4", "darkslateblue", "darkorange4", "goldenrod4", "deeppink4", "darkolivegreen4"))

PCoA2500 <- ggarrange(OT_PCoA2500, ST_PCoA2500, NT_PCoA2500, common.legend = TRUE,
                      ncol = 3, nrow = 1, legend = "right", align = "hv") 
PCoA2500

tiff(file = "Desktop/GoogleDrive/BikLab/QIIME2-EukBenchmark/Analysis/DADA2-FilteringParameters/PCoA_SubRegions_Rarefied2500.tiff", 
     width=11.5, height=8, units = "in", res = 300)
PCoA2500
dev.off()
