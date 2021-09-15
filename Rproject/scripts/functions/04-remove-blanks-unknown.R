remove_blanks_unknown <- function(df, datatype = "dataframe") {
  if (datatype == "phyloseq") {
    df_san_blanks_unknown <- subset_samples(df, FeedingGroup != "unknown")
    df_san_blanks_unknown <- subset_samples(df_san_blanks_unknown, FeedingGroup != "NegPCRControl")
    df_san_blanks_unknown <- subset_samples(df_san_blanks_unknown, FeedingGroup != "MockCommunity")
    df_san_blanks_unknown <- subset_samples(df_san_blanks_unknown, FeedingGroup != "Blank")
    df_san_blanks_unknown <- subset_samples(df_san_blanks_unknown, FeedingGroup != "Unknown")
  }
  else if (datatype == "dataframe") {
    df_san_blanks_unknown <-df[!(df$FeedingGroup=="unknown"),]
    df_san_blanks_unknown <-df_san_blanks_unknown[!(df_san_blanks_unknown$FeedingGroup=="NegPCRControl"),]
    df_san_blanks_unknown <-df_san_blanks_unknown[!(df_san_blanks_unknown$FeedingGroup=="MockCommunity"),]
    df_san_blanks_unknown <-df_san_blanks_unknown[!(df_san_blanks_unknown$FeedingGroup=="Blank"),]
    df_san_blanks_unknown <-df_san_blanks_unknown[!(df_san_blanks_unknown$FeedingGroup=="Unknown"),]
  }
  
  return(df_san_blanks_unknown)
}
