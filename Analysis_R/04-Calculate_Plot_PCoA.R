require(ggplot2)
require(ggpubr)

#Rarefy Samples to 1000Seq/Samples and 2500 Seq/Sample
vsearch_phylo_filtered_rarefy <- rarefy_even_depth(vsearch_phylo_filtered, sample.size = 1000, replace = FALSE, rngseed = TRUE)
uclust_phylo_filtered_rarefy <- rarefy_even_depth(uclust_phylo_filtered, sample.size = 1000, replace = FALSE, rngseed = TRUE)
dada2_phylo_filtered_rarefy <- rarefy_even_depth(dada2_phylo_filtered, sample.size = 1000, replace = FALSE, rngseed = TRUE)

#Subset Rarefied BiomTables (Sampling Gear, Year Collected)
#vsearch_phylo_filtered_rarefy_subset_boxCore <- subset_samples(vsearch_phylo_filtered_rarefy, Sampling_gear=="van_veen_grab")
#uclust_phylo_filtered_rarefy_subset_boxCore <- subset_samples(uclust_phylo_filtered_rarefy, Sampling_gear=="van_veen_grab")
#dada2_phylo_filtered_rarefy_subset_boxCore <- subset_samples(dada2_phylo_filtered_rarefy, Sampling_gear=="van_veen_grab")

#Ordinate Datasets Using BrayCurt Dissimilarity Matrix 
ordinate_vsearch = ordinate(vsearch_phylo_filtered_rarefy, "PCoA", "bray")
ordinate_uclust = ordinate(uclust_phylo_filtered_rarefy, "PCoA", "bray")
ordinate_dada2 = ordinate(dada2_phylo_filtered_rarefy, "PCoA", "bray")

#Plot PCoA
pcoa_vsearch <- plot_ordination(vsearch_phylo_filtered_rarefy, ordinate_vsearch, color="Subregion") +
  geom_point(size=2) +
  theme_bw() +theme(aspect.ratio = 1)

pcoa_uclust <- plot_ordination(uclust_phylo_filtered_rarefy, ordinate_uclust, color="Subregion") +
  geom_point(size=2) +
  theme_bw() + theme(aspect.ratio = 1)

pcoa_dada2 <- plot_ordination(dada2_phylo_filtered_rarefy, ordinate_dada2, color="Subregion") +
  geom_point(size=2) +
  theme_bw() + theme(aspect.ratio = 1)

#Plot PCoA Using GGArrange
plot_pcoa <- ggarrange(pcoa_dada2, pcoa_uclust, pcoa_vsearch,
                       labels = c("A. DADA2","B. UCLUST", "C. VSearch"), common.legend = TRUE,
                       ncol = 3, nrow = 1, legend = "right", align = "hv") 
plot_pcoa

#Save Figure
tiff(file = "Desktop/QIIME2-EukBench-Figures/PCoA_BrayCurtis_Rarefied_1000.tif", 
     width=11.5, height=8, units = "in", res = 300)
plot_pcoa
dev.off()
