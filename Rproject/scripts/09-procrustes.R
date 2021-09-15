#################################
######### FOR HC Dataset ########
#################################
# extract Data from beta div
pcoa_hc_uclust_bray <- as.data.frame(hc_uclust_bray$vectors)
pcoa_hc_uclust_ufrac <- as.data.frame(hc_uclust_ufrac$vectors)
pcoa_hc_uclust_wufrac <- as.data.frame(hc_uclust_wufrac$vectors)

pcoa_hc_vsearch_bray <- as.data.frame(hc_vsearch_bray$vectors)
pcoa_hc_vsearch_ufrac <- as.data.frame(hc_vsearch_ufrac$vectors)
pcoa_hc_vsearch_wufrac <- as.data.frame(hc_vsearch_wufrac$vectors)

pcoa_hc_dada2_bray <- as.data.frame(hc_dada2_bray$vectors)
pcoa_hc_dada2_ufrac <- as.data.frame(hc_dada2_ufrac$vectors)
pcoa_hc_dada2_wufrac <- as.data.frame(hc_dada2_wufrac$vectors)

pcoa_hc_deblur_bray <- as.data.frame(hc_deblur_bray$vectors)
pcoa_hc_deblur_ufrac <- as.data.frame(hc_deblur_ufrac$vectors)
pcoa_hc_deblur_wufrac <- as.data.frame(hc_deblur_wufrac$vectors)

## UCLUST VS VSearch ##
plot_pro_hc_uclust_vsearch_ufrac <- plot_procrustes(pcoa_hc_uclust_ufrac, pcoa_hc_vsearch_ufrac, "UCLUST", "VSearch")
plot_pro_hc_uclust_vsearch_wufrac <- plot_procrustes(pcoa_hc_uclust_wufrac, pcoa_hc_vsearch_wufrac, "UCLUST", "VSearch")
plot_pro_hc_uclust_vsearch_bray <- plot_procrustes(pcoa_hc_uclust_bray, pcoa_hc_vsearch_bray, "UCLUST", "VSearch")

plot_pro_hc_uclust_vsearch <- ggarrange(plot_pro_hc_uclust_vsearch_bray, plot_pro_hc_uclust_vsearch_ufrac, plot_pro_hc_uclust_vsearch_wufrac, common.legend = T, nrow = 3, ncol = 1) 
plot_pro_hc_uclust_vsearch <- annotate_figure(plot_pro_hc_uclust_vsearch, top = text_grob("UCLUST and VSearch", color = "black", face = "bold", size = 14))

## UCLUST vs DADA2 ##
plot_pro_hc_uclust_dada2_ufrac <- plot_procrustes(pcoa_hc_uclust_ufrac, pcoa_hc_dada2_ufrac, "UCLUST", "DADA2")
plot_pro_hc_uclust_dada2_wufrac <- plot_procrustes(pcoa_hc_uclust_wufrac, pcoa_hc_dada2_wufrac, "UCLUST", "DADA2")
plot_pro_hc_uclust_dada2_bray <- plot_procrustes(pcoa_hc_uclust_bray, pcoa_hc_dada2_bray, "UCLUST", "DADA2")

plot_pro_hc_uclust_dada2 <- ggarrange(plot_pro_hc_uclust_dada2_bray, plot_pro_hc_uclust_dada2_ufrac, plot_pro_hc_uclust_dada2_wufrac, common.legend = T, nrow = 3) 
plot_pro_hc_uclust_dada2 <- annotate_figure(plot_pro_hc_uclust_dada2, top = text_grob("UCLUST and DADA2", color = "black", face = "bold", size = 14))

## UCLUST vs Deblur ##
plot_pro_hc_uclust_deblur_ufrac <- plot_procrustes(pcoa_hc_uclust_ufrac, pcoa_hc_deblur_ufrac, "UCLUST", "Deblur")
plot_pro_hc_uclust_deblur_wufrac <- plot_procrustes(pcoa_hc_uclust_wufrac, pcoa_hc_deblur_wufrac, "UCLUST", "Deblur")
plot_pro_hc_uclust_deblur_bray <- plot_procrustes(pcoa_hc_uclust_bray, pcoa_hc_deblur_bray, "UCLUST", "Deblur")

plot_pro_hc_uclust_deblur <- ggarrange(plot_pro_hc_uclust_deblur_bray, plot_pro_hc_uclust_deblur_ufrac, plot_pro_hc_uclust_deblur_wufrac, common.legend = T, nrow = 3) 
plot_pro_hc_uclust_deblur <- annotate_figure(plot_pro_hc_uclust_deblur, top = text_grob("UCLUST and Deblur", color = "black", face = "bold", size = 14))

## VSearch vs DADA2 ##
plot_pro_hc_vsearch_dada2_ufrac <- plot_procrustes(pcoa_hc_vsearch_ufrac, pcoa_hc_dada2_ufrac, "VSearch", "DADA2")
plot_pro_hc_vsearch_dada2_wufrac <- plot_procrustes(pcoa_hc_vsearch_wufrac, pcoa_hc_dada2_wufrac, "VSearch", "DADA2")
plot_pro_hc_vsearch_dada2_bray <- plot_procrustes(pcoa_hc_vsearch_bray, pcoa_hc_dada2_bray, "VSearch", "DADA2")

plot_pro_hc_vsearch_dada2 <- ggarrange(plot_pro_hc_vsearch_dada2_bray, plot_pro_hc_vsearch_dada2_ufrac, plot_pro_hc_vsearch_dada2_wufrac, common.legend = T, nrow = 3) 
plot_pro_hc_vsearch_dada2 <- annotate_figure(plot_pro_hc_vsearch_dada2, top = text_grob("VSearch and DADA2", color = "black", face = "bold", size = 14))

## Vsearch vs Deblur ##
plot_pro_hc_vsearch_deblur_ufrac <- plot_procrustes(pcoa_hc_vsearch_ufrac, pcoa_hc_deblur_ufrac, "VSearch", "Deblur")
plot_pro_hc_vsearch_deblur_wufrac <- plot_procrustes(pcoa_hc_vsearch_wufrac, pcoa_hc_deblur_wufrac, "VSearch", "Deblur")
plot_pro_hc_vsearch_deblur_bray <- plot_procrustes(pcoa_hc_vsearch_bray, pcoa_hc_deblur_bray, "VSearch", "Deblur")

plot_pro_hc_vsearch_deblur <- ggarrange(plot_pro_hc_vsearch_deblur_bray, plot_pro_hc_vsearch_deblur_ufrac, plot_pro_hc_vsearch_deblur_wufrac, common.legend = T, nrow = 3) 
plot_pro_hc_vsearch_deblur <- annotate_figure(plot_pro_hc_vsearch_deblur, top = text_grob("VSearch and Deblur", color = "black", face = "bold", size = 14))

## DADA2 vs Deblur ##
plot_pro_hc_dada2_deblur_ufrac <- plot_procrustes(pcoa_hc_dada2_ufrac, pcoa_hc_deblur_ufrac, "DADA2", "Deblur")
plot_pro_hc_dada2_deblur_wufrac <- plot_procrustes(pcoa_hc_dada2_wufrac, pcoa_hc_deblur_wufrac, "DADA2", "Deblur")
plot_pro_hc_dada2_deblur_bray <- plot_procrustes(pcoa_hc_dada2_bray, pcoa_hc_deblur_bray, "DADA2", "Deblur")

plot_pro_hc_dada2_deblur <- ggarrange(plot_pro_hc_dada2_deblur_bray, plot_pro_hc_dada2_deblur_ufrac, plot_pro_hc_dada2_deblur_wufrac, common.legend = T, nrow = 3) 
plot_pro_hc_dada2_deblur <- annotate_figure(plot_pro_hc_dada2_deblur, top = text_grob("DADA2 and Deblur", color = "black", face = "bold", size = 14))

plot_pro_hc_final <- ggarrange(plot_pro_hc_uclust_vsearch, plot_pro_hc_uclust_dada2, plot_pro_hc_uclust_deblur, plot_pro_hc_vsearch_dada2, 
                            plot_pro_hc_vsearch_deblur, plot_pro_hc_dada2_deblur, nrow = 1, ncol = 6)
plot_pro_hc_final
ggsave("output/Figure-07A-hc-procrustes_final.tiff", plot_pro_hc_final, width = 14, height = 8, dpi = 300)

#################################
######### FOR LC Dataset ########
#################################
# extract Data from beta div
pcoa_lc_uclust_bray <- as.data.frame(lc_uclust_bray$vectors)
pcoa_lc_uclust_ufrac <- as.data.frame(lc_uclust_ufrac$vectors)
pcoa_lc_uclust_wufrac <- as.data.frame(lc_uclust_wufrac$vectors)

pcoa_lc_vsearch_bray <- as.data.frame(lc_vsearch_bray$vectors)
pcoa_lc_vsearch_ufrac <- as.data.frame(lc_vsearch_ufrac$vectors)
pcoa_lc_vsearch_wufrac <- as.data.frame(lc_vsearch_wufrac$vectors)

pcoa_lc_dada2_bray <- as.data.frame(lc_dada2_bray$vectors)
pcoa_lc_dada2_ufrac <- as.data.frame(lc_dada2_ufrac$vectors)
pcoa_lc_dada2_wufrac <- as.data.frame(lc_dada2_wufrac$vectors)

pcoa_lc_deblur_bray <- as.data.frame(lc_deblur_bray$vectors)
pcoa_lc_deblur_ufrac <- as.data.frame(lc_deblur_ufrac$vectors)
pcoa_lc_deblur_wufrac <- as.data.frame(lc_deblur_wufrac$vectors)

## UCLUST VS VSearch ##
plot_pro_lc_uclust_vsearch_ufrac <- plot_procrustes(pcoa_lc_uclust_ufrac, pcoa_lc_vsearch_ufrac, "UCLUST", "VSearch")
plot_pro_lc_uclust_vsearch_wufrac <- plot_procrustes(pcoa_lc_uclust_wufrac, pcoa_lc_vsearch_wufrac, "UCLUST", "VSearch")
plot_pro_lc_uclust_vsearch_bray <- plot_procrustes(pcoa_lc_uclust_bray, pcoa_lc_vsearch_bray, "UCLUST", "VSearch")

plot_pro_lc_uclust_vsearch <- ggarrange(plot_pro_lc_uclust_vsearch_bray, plot_pro_lc_uclust_vsearch_ufrac, plot_pro_lc_uclust_vsearch_wufrac, common.legend = T, nrow = 3, ncol = 1) 
plot_pro_lc_uclust_vsearch <- annotate_figure(plot_pro_lc_uclust_vsearch, top = text_grob("UCLUST and VSearch", color = "black", face = "bold", size = 14))

## UCLUST vs DADA2 ##
plot_pro_lc_uclust_dada2_ufrac <- plot_procrustes(pcoa_lc_uclust_ufrac, pcoa_lc_dada2_ufrac, "UCLUST", "DADA2")
plot_pro_lc_uclust_dada2_wufrac <- plot_procrustes(pcoa_lc_uclust_wufrac, pcoa_lc_dada2_wufrac, "UCLUST", "DADA2")
plot_pro_lc_uclust_dada2_bray <- plot_procrustes(pcoa_lc_uclust_bray, pcoa_lc_dada2_bray, "UCLUST", "DADA2")

plot_pro_lc_uclust_dada2 <- ggarrange(plot_pro_lc_uclust_dada2_bray, plot_pro_lc_uclust_dada2_ufrac, plot_pro_lc_uclust_dada2_wufrac, common.legend = T, nrow = 3) 
plot_pro_lc_uclust_dada2 <- annotate_figure(plot_pro_lc_uclust_dada2, top = text_grob("UCLUST and DADA2", color = "black", face = "bold", size = 14))

## UCLUST vs Deblur ##
plot_pro_lc_uclust_deblur_ufrac <- plot_procrustes(pcoa_lc_uclust_ufrac, pcoa_lc_deblur_ufrac, "UCLUST", "Deblur")
plot_pro_lc_uclust_deblur_wufrac <- plot_procrustes(pcoa_lc_uclust_wufrac, pcoa_lc_deblur_wufrac, "UCLUST", "Deblur")
plot_pro_lc_uclust_deblur_bray <- plot_procrustes(pcoa_lc_uclust_bray, pcoa_lc_deblur_bray, "UCLUST", "Deblur")

plot_pro_lc_uclust_deblur <- ggarrange(plot_pro_lc_uclust_deblur_bray, plot_pro_lc_uclust_deblur_ufrac, plot_pro_lc_uclust_deblur_wufrac, common.legend = T, nrow = 3) 
plot_pro_lc_uclust_deblur <- annotate_figure(plot_pro_lc_uclust_deblur, top = text_grob("UCLUST and Deblur", color = "black", face = "bold", size = 14))

## VSearch vs DADA2 ##
plot_pro_lc_vsearch_dada2_ufrac <- plot_procrustes(pcoa_lc_vsearch_ufrac, pcoa_lc_dada2_ufrac, "VSearch", "DADA2")
plot_pro_lc_vsearch_dada2_wufrac <- plot_procrustes(pcoa_lc_vsearch_wufrac, pcoa_lc_dada2_wufrac, "VSearch", "DADA2")
plot_pro_lc_vsearch_dada2_bray <- plot_procrustes(pcoa_lc_vsearch_bray, pcoa_lc_dada2_bray, "VSearch", "DADA2")

plot_pro_lc_vsearch_dada2 <- ggarrange(plot_pro_lc_vsearch_dada2_bray, plot_pro_lc_vsearch_dada2_ufrac, plot_pro_lc_vsearch_dada2_wufrac, common.legend = T, nrow = 3) 
plot_pro_lc_vsearch_dada2 <- annotate_figure(plot_pro_lc_vsearch_dada2, top = text_grob("VSearch and DADA2", color = "black", face = "bold", size = 14))

## Vsearch vs Deblur ##
plot_pro_lc_vsearch_deblur_ufrac <- plot_procrustes(pcoa_lc_vsearch_ufrac, pcoa_lc_deblur_ufrac, "VSearch", "Deblur")
plot_pro_lc_vsearch_deblur_wufrac <- plot_procrustes(pcoa_lc_vsearch_wufrac, pcoa_lc_deblur_wufrac, "VSearch", "Deblur")
plot_pro_lc_vsearch_deblur_bray <- plot_procrustes(pcoa_lc_vsearch_bray, pcoa_lc_deblur_bray, "VSearch", "Deblur")

plot_pro_lc_vsearch_deblur <- ggarrange(plot_pro_lc_vsearch_deblur_bray, plot_pro_lc_vsearch_deblur_ufrac, plot_pro_lc_vsearch_deblur_wufrac, common.legend = T, nrow = 3) 
plot_pro_lc_vsearch_deblur <- annotate_figure(plot_pro_lc_vsearch_deblur, top = text_grob("VSearch and Deblur", color = "black", face = "bold", size = 14))

## DADA2 vs Deblur ##
plot_pro_lc_dada2_deblur_ufrac <- plot_procrustes(pcoa_lc_dada2_ufrac, pcoa_lc_deblur_ufrac, "DADA2", "Deblur")
plot_pro_lc_dada2_deblur_wufrac <- plot_procrustes(pcoa_lc_dada2_wufrac, pcoa_lc_deblur_wufrac, "DADA2", "Deblur")
plot_pro_lc_dada2_deblur_bray <- plot_procrustes(pcoa_lc_dada2_bray, pcoa_lc_deblur_bray, "DADA2", "Deblur")

plot_pro_lc_dada2_deblur <- ggarrange(plot_pro_lc_dada2_deblur_bray, plot_pro_lc_dada2_deblur_ufrac, plot_pro_lc_dada2_deblur_wufrac, common.legend = T, nrow = 3) 
plot_pro_lc_dada2_deblur <- annotate_figure(plot_pro_lc_dada2_deblur, top = text_grob("DADA2 and Deblur", color = "black", face = "bold", size = 14))

plot_pro_lc_final <- ggarrange(plot_pro_lc_uclust_vsearch, plot_pro_lc_uclust_dada2, plot_pro_lc_uclust_deblur, plot_pro_lc_vsearch_dada2, 
                               plot_pro_lc_vsearch_deblur, plot_pro_lc_dada2_deblur, nrow = 1, ncol = 6)
plot_pro_lc_final
ggsave("output/Figure-07B-lc-procrustes_final.tiff", plot_pro_lc_final, width = 14, height = 8, dpi = 300)

