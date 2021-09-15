rank_asv_otu <- function(df) {
  # df_merge <- subset_samples(df, X.SampleID=="MEMB.nem.257")
  df_merge <- merge_samples(df, "merge")
  df_merge_prune <- prune_taxa(taxa_sums(df_merge)>=1, df_merge)
  df_melt <- psmelt(df_merge_prune)
  df_melt$Rank <- 1:nrow(df_melt)
  return(df_melt)
}
