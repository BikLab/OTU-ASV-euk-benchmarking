import_tables_phylo_obj <- function(biom = "", treefile = "", seqfile = "", MappingFile, data = "none") {
  BiomTable <- import_biom(biom) # import biom table #
  TreeFile <- read_tree(treefile) # import tree file #
  SeqFile <- readDNAStringSet(seqfile) # import rep seq file #
  
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
  phyloObj <- merge_phyloseq(BiomTable, TreeFile, SeqFile, MappingFile)
}
