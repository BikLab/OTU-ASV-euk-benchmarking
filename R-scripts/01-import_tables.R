#################################
### FOR NPRB and MEMB Dataset ###
#################################

#### Set Working Directory #### 
setwd("/Volumes/GoogleDrive/My Drive/BikLab/QIIME2_Eukbench/")

#### Import MappingFile #### 
NPRB_MappingFile <- import_qiime_sample_data("DATA_Final/NPRB/MappingFile/NPRB_EukBench_MappingFile.txt")
MEMB_MappingFile <- import_qiime_sample_data("DATA_Final/MEMB/MappingFile/18S-euk-QIIME-mapping-final.txt")

##### INPUT NPRB BiomTable #####
##### INPUT UCLUST - Was Large File Was Causing RStudio to Crash #####
# OTU Table
UCLUST_biom <- as.data.frame(as.matrix(biom_data(read_biom("DATA_Final/NPRB/UCLUST/BiomTable/NPRB_Run3_Clustered99_Sans_Singletons_ChimericSeq.biom"))))
UCLUST_OTU <- otu_table(UCLUST_biom, taxa_are_rows = TRUE)
# Taxonomy
UCLUST_tax <- read.table("DATA_Final/NPRB/UCLUST/Taxonomy/NPRB_Run3_UCLUST_SILVA132_CustomDB_BLAST_Taxonomy_90PercID.tsv", sep = "\t", header = T)
row.names(UCLUST_tax) <- UCLUST_tax$OTUID
UCLUST_tax$OTUID <- NULL
UCLUST_tax$confidence <- NULL
UCLUST_tax <- separate(UCLUST_tax, taxonomy, into=c("Rank1","Rank2","Rank3","Rank4","Rank5","Rank6","Rank7", "Rank8", "Rank9", "Rank10", "Rank11", "Rank12", "Rank13", "Rank14", "Rank15"), sep=";")
UCLUST_matrix <- as.matrix(UCLUST_tax)
UCLUST_TAX <- tax_table(UCLUST_matrix)
#Tree and Ref Seq
UCLUST_tree <- read.tree("DATA_Final/NPRB/UCLUST/final_tree.tre")
UCLUST_SeqFile <- readDNAStringSet("DATA_Final/NPRB/UCLUST/NPRB_Run3_Clustered99_Sans_Singletons_ChimericSeq.fna")
# Phyloseq Obj
NPRB_UCLUST <- merge_phyloseq(UCLUST_OTU, UCLUST_TAX, NPRB_MappingFile, UCLUST_SeqFile, UCLUST_tree)

##### INPUT VSearch - Was Large File Was Causing RStudio to Crash #####
# OTU Table
VSearch_biom <- as.data.frame(as.matrix(biom_data(read_biom("DATA_Final/NPRB/VSearch/BiomTable/NPRB_Run3_FeatureTable_Filter_Singletons_Chimeras.biom"))))
VSearch_OTU <- otu_table(VSearch_biom, taxa_are_rows = TRUE)
# Taxonomy
VSearch_tax <- read.table("DATA_Final/NPRB/VSearch/Taxonomy/NPRB_Run3_VSearch_SILVA132_CustomDB_BLAST_90PercID.tsv", sep = "\t", header = T)
row.names(VSearch_tax) <- VSearch_tax$OTUID
VSearch_tax$OTUID <- NULL
VSearch_tax$confidence <- NULL
VSearch_tax <- separate(VSearch_tax, taxonomy, into=c("Rank1","Rank2","Rank3","Rank4","Rank5","Rank6","Rank7", "Rank8", "Rank9", "Rank10", "Rank11", "Rank12", "Rank13", "Rank14", "Rank15"), sep=";")
VSearch_matrix <- as.matrix(VSearch_tax)
VSearch_TAX <- tax_table(VSearch_matrix)
#Tree and Ref Seq
VSearch_tree <- read.tree("DATA_Final/NPRB/VSearch/PhyloTree/NPRB_Run3_Clustered_99_Sans_Singletons_and_Chimeras_RootedTree.nwk")
VSearch_SeqFile <- readDNAStringSet("DATA_Final/NPRB/VSearch/dna-sequences.fasta")
# Phyloseq Obj
NPRB_VSearch <- merge_phyloseq(VSearch_OTU, VSearch_tree, VSearch_TAX, VSearch_SeqFile, NPRB_MappingFile)


NPRB_UCLUST <- Phylo_Obj(biom = "DATA_Final/NPRB/UCLUST/BiomTable/NPRB_run3_UCLUST_SILVA132_CustomDB_90PerID_json.biom", 
                         treefile = "DATA_Final/NPRB/UCLUST/PhyloTree/NPRB_Run3_Clustered_99_Sans_Singletons_and_Chimeras_RootedTree.tre",
                         seqfile = "DATA_Final/NPRB/UCLUST/NPRB_Run3_Clustered99_Sans_Singletons_ChimericSeq.fna",
                         MappingFile = NPRB_MappingFile)

NPRB_VSearch <- Phylo_Obj(biom = "DATA_Final/NPRB/VSearch/BiomTable/NPRB_Run3_FeatureTable_Filter_Singletons_Chimeras_BLAST_QIIMEForm_SILVA132.biom", 
                          treefile = "DATA_Final/NPRB/VSearch/PhyloTree/NPRB_Run3_Clustered_99_Sans_Singletons_and_Chimeras_RootedTree.nwk",
                          seqfile = "DATA_Final/NPRB/VSearch/dna-sequences.fasta",
                          MappingFile = NPRB_MappingFile)

NPRB_DADA2 <- Phylo_Obj(biom = "DATA_Final/NPRB/DADA2/BiomTable/NPRB_Run3_DADA2_SILVA132_CustomDB_BLAST_90PercID.biom",
                        treefile = "DATA_Final/NPRB/DADA2/PhyloTree/NPRB_Run3_ASV_RootedTree.nwk",
                        seqfile = "DATA_Final/NPRB/DADA2/NPRB_Run3_ASV_FeatureSeq_Exported.fasta",
                        MappingFile = NPRB_MappingFile, data = "NPRB_DADA2")

NPRB_Deblur <- Phylo_Obj(biom = "DATA_Final/NPRB/Deblur/BiomTable/NPRB_Run3_ASV_Deblur_SILVA132_CustomDB_BLAST_90PercID.biom",
                         treefile = "DATA_Final/NPRB/Deblur/PhyloTree/NPRB_Run3_ASV_Deblur_RootedTree.nwk",
                         seqfile = "DATA_Final/NPRB/Deblur/NPRB_Run3_ASV_Deblur_FeatureSeq_exported.fasta",
                         MappingFile = NPRB_MappingFile)

##### INPUT MEMB BiomTable #####
MEMB_UCLUST <- Phylo_Obj(biom = "DATA_Final/MEMB/UCLUST/MEMB_OTU_Clustered99_UCLUST_Biom_Taxonomy_BLAST.biom", 
                         treefile = "DATA_Final/MEMB/UCLUST/MEMB_OTU_Clustered99_UCLUST_RootedTree.tre",
                         seqfile = "DATA_Final/MEMB/UCLUST/MEMB_OTU_Clustered99_UCLUST_Sequences.fa",
                         MappingFile = MEMB_MappingFile)

MEMB_VSearch <- Phylo_Obj(biom = "DATA_Final/MEMB/VSearch/MEMB_OTU_Clustered99_VSearch_Biom_Taxonomy_BLAST.biom", 
                          treefile = "DATA_Final/MEMB/VSearch/MEMB_OTU_Clustered99_VSearch_RootedTree.nwk",
                          seqfile = "DATA_Final/MEMB/VSearch/MEMB_OTU_Clustered99_VSearch_FeatureSeq.fa",
                          MappingFile = MEMB_MappingFile)

MEMB_DADA2 <- Phylo_Obj(biom = "DATA_Final/MEMB/DADA2/MEMB_ASV_DADA2_Biom_Taxonomy_BLAST.biom",
                        treefile = "DATA_Final/MEMB/DADA2/MEMB_ASV_DADA2_RootedTree.nwk",
                        seqfile = "DATA_Final/MEMB/DADA2/MEMB_ASV_DADA2_FeatureSeq.fa",
                        MappingFile = MEMB_MappingFile, data = "MEMB_DADA2")

MEMB_Deblur <- Phylo_Obj(biom = "DATA_Final/MEMB/Deblur/MEMB_ASV_Deblur_Biom_Taxonomy_BLAST.biom",
                         treefile = "DATA_Final/MEMB/Deblur/MEMB_ASV_Deblur_RootedTree.nwk",
                         seqfile = "DATA_Final/MEMB/Deblur/MEMB_ASV_Deblur_FeatureSeq.fa",
                         MappingFile = MEMB_MappingFile, data = "MEMB_Deblur")

##### For MEMB Dataset Remove Outliers #####
MEMB_UCLUST <- filter_outliers_ctrls(MEMB_UCLUST)
MEMB_VSearch <- filter_outliers_ctrls(MEMB_VSearch)
MEMB_DADA2 <- filter_outliers_ctrls(MEMB_DADA2)
MEMB_Deblur <- filter_outliers_ctrls(MEMB_Deblur)

### count low abundant OTUs 
NPRB_rowSums <- as.data.frame(rowSums(otu_table(NPRB_UCLUST)))
sum(NPRB_rowSums < 11)

NPRB_UCLUST_rare = prune_taxa(rowSums((otu_table(NPRB_UCLUST) < 11)))

NPRB_rowSums <- as.data.frame(rowSums(otu_table(NPRB_UCLUST)))
NPRB_subset <- subset(NPRB_rowSums, `rowSums(otu_table(NPRB_Deblur))` < 11)

nrow(NPRB_subset)
sum(NPRB_subset$`rowSums(otu_table(NPRB_Deblur))`)

nrow(otu_table(MEMB_DADA2))
nrow(otu_table(MEMB_Deblur))
nrow(otu_table(MEMB_UCLUST))
nrow(otu_table(MEMB_VSearch))

sum(as.data.frame(rowSums((otu_table(MEMB_DADA2)))) < 11)







