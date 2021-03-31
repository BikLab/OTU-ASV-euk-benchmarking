#################################
### FOR NPRB and MEMB Dataset ###
#################################

## melt phyloseq objects to dataframe ##
NPRB_UCLUST_melt <- rank_asv_otu(NPRB_UCLUST)
NPRB_VSearch_melt <- rank_asv_otu(NPRB_VSearch)
NPRB_DADA2_melt <- rank_asv_otu(NPRB_DADA2)
NPRB_Deblur_melt <- rank_asv_otu(NPRB_Deblur)

#MEMB_UCLUST_Filtered <- remove_blanks_unknown(MEMB_UCLUST, datatype = "phyloseq")
#MEMB_VSearch_Filtered <- remove_blanks_unknown(MEMB_VSearch, datatype = "phyloseq")
#MEMB_DADA2_Filtered <- remove_blanks_unknown(MEMB_DADA2, datatype = "phyloseq")
#MEMB_Deblur_Filtered <- remove_blanks_unknown(MEMB_Deblur, datatype = "phyloseq")

MEMB_UCLUST_melt <- rank_asv_otu(MEMB_UCLUST)
MEMB_VSearch_melt <- rank_asv_otu(MEMB_VSearch)
MEMB_DADA2_melt <- rank_asv_otu(MEMB_DADA2)
MEMB_Deblur_melt <- rank_asv_otu(MEMB_Deblur)

## plot head-tail patterns ##
NPRB_UCLUST_head_tail <- plot_head_tail(NPRB_UCLUST_melt, "UCLUST", ymax = 1e7, ylabel = T)
NPRB_VSearch_head_tail <- plot_head_tail(NPRB_VSearch_melt, "VSearch", ymax = 1e7, ylabel = F)
NPRB_DADA2_head_tail <- plot_head_tail(NPRB_DADA2_melt, "DADA2", ymax = 1e7, ylabel = F)
NPRB_Deblur_head_tail <- plot_head_tail(NPRB_Deblur_melt, "Deblur", ymax = 1e7, ylabel = F)

MEMB_UCLUST_head_tail <- plot_head_tail(MEMB_UCLUST_melt, "UCLUST", ymax = 1e7, ylabel = T)
MEMB_VSearch_head_tail <- plot_head_tail(MEMB_VSearch_melt, "VSearch", ymax = 1e7, ylabel = F)
MEMB_DADA2_head_tail <- plot_head_tail(MEMB_DADA2_melt, "DADA2", ymax = 1e7, ylabel = F)
MEMB_Deblur_head_tail <- plot_head_tail(MEMB_Deblur_melt, "Deblur", ymax = 1e7, ylabel = F)


head_tail_pattern <- ((NPRB_UCLUST_head_tail | NPRB_VSearch_head_tail | NPRB_DADA2_head_tail | NPRB_Deblur_head_tail)) /
  ((MEMB_UCLUST_head_tail | MEMB_VSearch_head_tail | MEMB_DADA2_head_tail | MEMB_Deblur_head_tail)) +
  plot_layout(guides = "collect") + plot_annotation(tag_levels = c('A'), tag_suffix = '.') & theme(legend.position = "right")
head_tail_pattern
ggsave("qiime2-Results/NPRB/head_tail_pattern.tiff", width = 11.5, height = 8, dpi = 300)

