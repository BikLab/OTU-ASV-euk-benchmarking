#################################
####### FOR MEMB Dataset ########
#################################

melt_asv <- function(df, method) {
  df_merge <- merge_samples(df, "NematodeFamily")
  df_merge_prune <- prune_taxa(taxa_sums(df_merge)>=1, df_merge)
  df_melt <- psmelt(df_merge_prune)
  df_melt <- df_melt %>% filter(Abundance != 0)
  df_melt$method <- method
  df_melt <- subset(df_melt, select = -c(Rank8, Rank9, Rank10, Rank11, Rank12, Rank13, Rank14, Rank15))
  return(df_melt)
}

rank_asv <- function(df) {
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

plot_asv_patterns <- function(df, ymax, xmax) {
  finalplot <- ggplot(df, aes(x = Rank, y = Abundance)) +
    geom_point(aes(fill = df$method, colour=df$method), pch=21) +
    facet_wrap(~ Sample) +
    theme_bw() +
    theme(legend.position = "none") +
    scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                  labels = trans_format("log10", math_format(10^.x)),
                  limits = c(1e0,ymax)) +
    scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                  labels = trans_format("log10", math_format(10^.x)),
                  limits = c(1e0,xmax)) +
    scale_fill_manual(values = c("UCLUST"="coral", "VSearch"="darkgoldenrod3", "DADA2"="green4", "Deblur"="royalblue4")) +
    scale_color_manual(values = c("UCLUST"="coral", "VSearch"="darkgoldenrod3", "DADA2"="green4", "Deblur"="royalblue4")) 
  
  label <- list(
    theme(legend.text=element_text(face = "bold")) +  theme(legend.position = "right", legend.box = "vertical"))
  finalPlot <- finalplot + label
  return(finalPlot)
}


MEMB_UCLUST_melt_filtered <- melt_asv(MEMB_UCLUST_Filtered, method = "UCLUST")
MEMB_UCLUST_melt_filtered <- rank_asv(MEMB_UCLUST_melt_filtered)

MEMB_VSearch_melt_filtered <- melt_asv(MEMB_VSearch_Filtered, method = "VSearch")
MEMB_VSearch_melt_filtered <- rank_asv(MEMB_VSearch_melt_filtered)

MEMB_DADA2_melt_filtered <- melt_asv(MEMB_DADA2_Filtered, method = "DADA2")
MEMB_DADA2_melt_filtered <- rank_asv(MEMB_DADA2_melt_filtered)

MEMB_Deblur_melt_filtered <- melt_asv(MEMB_Deblur_Filtered, method = "Deblur")
MEMB_Deblur_melt_filtered <- rank_asv(MEMB_Deblur_melt_filtered)

MEMB_all_melt_filtered <- rbind(MEMB_UCLUST_melt_filtered, MEMB_VSearch_melt_filtered, MEMB_DADA2_melt_filtered, MEMB_Deblur_melt_filtered)
## plot head-tail patterns ##
MEMB_head_tail <- plot_asv_patterns(MEMB_all_melt_filtered, ymax = 1e7, xmax = 1e5)
MEMB_head_tail <- MEMB_head_tail + labs(x="Ranked OTU/ASV", y="Number of Reads") + guides(color=guide_legend(title="Method"))
MEMB_head_tail

ggsave("qiime2-Results/MEMB/MEMB_ranked_OTU_ASV_pattern.tiff", width = 11.5, height = 8, dpi = 300)

