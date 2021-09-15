#################################
####### FOR LC Dataset ########
#################################
lc_uclust_family_melt <- melt_asv_lc_dataset(lc_uclust_family, method = "UCLUST")
lc_uclust_family_melt <- rank_asv_lc_dataset(lc_uclust_family_melt)

lc_vsearch_family_melt <- melt_asv_lc_dataset(lc_vsearch_family, method = "VSearch")
lc_vsearch_family_melt <- rank_asv_lc_dataset(lc_vsearch_family_melt)

lc_dada2_family_melt <- melt_asv_lc_dataset(lc_dada2_family, method = "DADA2")
lc_dada2_family_melt <- rank_asv_lc_dataset(lc_dada2_family_melt)

lc_deblur_family_melt <- melt_asv_lc_dataset(lc_deblur_family, method = "Deblur")
lc_deblur_family_melt <- rank_asv_lc_dataset(lc_deblur_family_melt)

lc_family_melt_final <- rbind(lc_uclust_family_melt, lc_vsearch_family_melt, lc_dada2_family_melt, lc_deblur_family_melt)

## plot head-tail patterns ##
lc_dataset_head_tail <- plot_asv_patterns(lc_family_melt_final, ymax = 1e7, xmax = 1e5)
lc_dataset_head_tail <- lc_dataset_head_tail + labs(x="MOTU Rank", y="Reads") + guides(color = F, fill=guide_legend(title="Method"))
lc_dataset_head_tail

ggsave("output/Figure-S5-LC-families-rank-abundance.png", width = 11.5, height = 8, dpi = 300, device = "png", bg = "white")

