merge_samples_most_abundant <- function(df) {
  merged_samples <- merge_samples(df, "merge")
  transform_samples  <- transform_sample_counts(merged_samples, function(x) x / sum(x) )
  taxonomy_rank <-tax_glom(transform_samples, taxrank="Rank7")
  dataframe_sample <- as.data.frame(psmelt(taxonomy_rank))
  dataframe_sample_filtered <- dataframe_sample %>% filter(Abundance > 0.005) %>%  
    return(dataframe_sample_filtered)
}
