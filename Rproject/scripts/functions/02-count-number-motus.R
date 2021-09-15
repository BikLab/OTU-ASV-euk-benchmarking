count_number_motus <- function(PhyloObj, Map, Algorithm) {
  OTUs_Method <- as.data.frame(colSums(otu_table(PhyloObj@otu_table) != 0))
  names(OTUs_Method)[1] <- "OTUs"
  OTUs_Method_Map <- merge(OTUs_Method, Map, by = "row.names")
  OTUs_Method_Map$Method <- Algorithm
  return(OTUs_Method_Map)
}
