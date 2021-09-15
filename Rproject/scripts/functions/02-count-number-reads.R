count_number_reads <- function(PhyloObj, Map, Algorithm) {
  Reads_Method <- as.data.frame(colSums(otu_table(PhyloObj@otu_table)))
  names(Reads_Method)[1] <- "Reads"
  Reads_Method_Map <- merge(Reads_Method, Map, by = "row.names")
  Reads_Method_Map$Method <- Algorithm
  return(Reads_Method_Map)
}
