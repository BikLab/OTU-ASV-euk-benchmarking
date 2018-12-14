require(ggplot2)
require(ggpubr)

vsearch_phylo_filtered_rarefy <- rarefy_even_depth(vsearch_phylo_filtered, sample.size = 1000, replace = FALSE, rngseed = TRUE)
uclust_phylo_filtered_rarefy <- rarefy_even_depth(uclust_phylo_filtered, sample.size = 1000, replace = FALSE, rngseed = TRUE)
dada2_phylo_filtered_rarefy <- rarefy_even_depth(dada2_phylo_filtered, sample.size = 1000, replace = FALSE, rngseed = TRUE)

ordinate_vsearch = ordinate(vsearch_phylo_filtered_rarefy, "PCoA", "bray")
ordinate_uclust = ordinate(uclust_phylo_filtered_rarefy, "PCoA", "bray")
ordinate_dada2 = ordinate(dada2_phylo_filtered_rarefy, "PCoA", "bray")

pcoa_vsearch <- plot_ordination(vsearch_phylo_filtered_rarefy, ordinate_vsearch, color="Subregion") +
  geom_point(size=2) +
  theme_bw() +theme(aspect.ratio = 1)

pcoa_uclust <- plot_ordination(uclust_phylo_filtered_rarefy, ordinate_uclust, color="Subregion") +
  geom_point(size=2) +
  theme_bw() + theme(aspect.ratio = 1)

pcoa_dada2 <- plot_ordination(dada2_phylo_filtered_rarefy, ordinate_dada2, color="Subregion") +
  geom_point(size=2) +
  theme_bw() + theme(aspect.ratio = 1)

plot_pcoa <- ggarrange(pcoa_dada2, pcoa_uclust, pcoa_vsearch,
                       labels = c("A. DADA2","B. UCLUST", "C. VSearch"), common.legend = TRUE,
                       ncol = 3, nrow = 1, legend = "right", align = "hv") 
plot_pcoa

#save file
tiff(file = "Desktop/BrayCurtis_PCoA_Rarefied_1000_All_Algorithms.tif", 
     width=11.5, height=8, units = "in", res = 300)
plot_pcoa
dev.off()
