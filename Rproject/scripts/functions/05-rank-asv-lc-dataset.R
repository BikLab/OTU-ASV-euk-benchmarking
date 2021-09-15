rank_asv_lc_dataset <- function(df) {
  df_come <- df %>% filter(Sample == "Comesomatidae")
  desmoscolecidae_asv_sorted <- apply(df_come, 2, sort, decreasing=T)
  df_come <- df_come[order(-df_come$Abundance),]
  df_come$Rank <- 1:nrow(df_come)
  df_chroma <- df %>% filter(Sample == "Chromadoridae")
  df_chroma <- df_chroma[order(-df_chroma$Abundance),]
  
  df_chroma$Rank <- 1:nrow(df_chroma)
  df_desmo <- df %>% filter(Sample == "Desmoscolecidae")
  df_desmo <- df_desmo[order(-df_desmo$Abundance),]
  
  df_desmo$Rank <- 1:nrow(df_desmo)
  df_oxy <- df %>% filter(Sample == "Oxystominidae")
  df_oxy <- df_oxy[order(-df_oxy$Abundance),]
  
  df_oxy$Rank <- 1:nrow(df_oxy)
  final_df <-rbind(df_come, df_chroma, df_desmo, df_oxy)
  return(final_df)
}
