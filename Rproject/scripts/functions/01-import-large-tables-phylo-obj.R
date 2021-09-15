import_large_tables_phylo_obj <- function(biom = "", treefile = "", seqfile = "", MappingFile, data = "none", taxonomy = "") {
  BiomTable <- as.data.frame(as.matrix(biom_data(read_biom(biom))))
  BiomTable <- otu_table(BiomTable, taxa_are_rows = TRUE)
  TreeFile <- read.tree(treefile) # import tree file #
  SeqFile <- readDNAStringSet(seqfile) # import rep seq file #
  TaxFile <- read.table(taxonomy, sep = "\t", header = T)
  row.names(TaxFile) <- TaxFile$OTUID
  TaxFile$OTUID <- NULL
  TaxFile$confidence <- NULL
  TaxFile <- separate(TaxFile, taxonomy, into=c("Rank1","Rank2","Rank3","Rank4","Rank5","Rank6","Rank7", "Rank8", "Rank9", "Rank10", "Rank11", "Rank12", "Rank13", "Rank14", "Rank15"), sep=";")
  TaxFile <- as.matrix(TaxFile)
  TaxFile <- tax_table(TaxFile)
  
  if (data == "hc_dada2") {   # Sample Names for NPRB DADA2 biom table must match the mapping file #
    colnames(otu_table(BiomTable)) <- gsub("NPRB3_", "", colnames(otu_table(BiomTable)))
    colnames(otu_table(BiomTable)) <- gsub("_", ".", colnames(otu_table(BiomTable)))
  }
  else if (data == "lc_dada2") { # Sample Names for MEMB DADA2 biom table must match the mapping file #
    colnames(otu_table(BiomTable)) <- gsub("nem", "MEMB.nem.", colnames(otu_table(BiomTable)))
  }
  else if (data == "lc_deblur") { # Sample Names for MEMB Deblur biom table must match the mapping file #
    colnames(otu_table(BiomTable)) <- gsub("nem", "MEMB.nem.", colnames(otu_table(BiomTable)))
  }
  phyloObj <- merge_phyloseq(BiomTable, TreeFile, TaxFile, SeqFile, MappingFile)
}

