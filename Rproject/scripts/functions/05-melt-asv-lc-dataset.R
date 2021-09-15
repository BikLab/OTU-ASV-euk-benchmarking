melt_asv_lc_dataset <- function(df, method) {
  df_merge <- merge_samples(df, "NematodeFamily")
  df_merge_prune <- prune_taxa(taxa_sums(df_merge)>=1, df_merge)
  df_melt <- psmelt(df_merge_prune)
  df_melt <- df_melt %>% filter(Abundance != 0)
  df_melt$method <- method
  df_melt <- subset(df_melt, select = -c(Rank8, Rank9, Rank10, Rank11, Rank12, Rank13, Rank14, Rank15))
  return(df_melt)
}
