require(ggplot2)
require(ggpubr)

##### Alpha Diversity Matrix #####
simpson_vsearch <- plot_richness(vsearch_phylo_filtered, x = "Region", color = "Subregion", measures = "Simpson") + 
  theme_bw() +
  geom_point(size = 3) +
  theme(plot.title = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(), 
        axis.text.x = element_text(size = 8),
        axis.text.y = element_text(size = 8),
        panel.grid.minor = element_blank(),
        legend.title = element_text(face = "bold", size =12), 
        legend.title.align = 0.5,
        legend.text = element_text(size = 10)) +
  guides(shape = guide_legend(order = 0), color = guide_legend(order = 1, title = "Subregion"))

observed_vsearch <- plot_richness(vsearch_phylo_filtered, x = "Region", color = "Subregion", measures = "Observed") + 
  theme_bw() +
  geom_point(size = 3) +
  theme(plot.title = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(), 
        axis.text.x = element_text(size = 8),
        axis.text.y = element_text(size = 8),
        panel.grid.minor = element_blank(),
        legend.title = element_text(face = "bold", size =12), 
        legend.title.align = 0.5,
        legend.text = element_text(size = 10)) +
  guides(shape = guide_legend(order = 0), color = guide_legend(order = 1, title = "Subregion"))

simpson_uclust <- plot_richness(uclust_phylo_filtered, x = "Region", color = "Subregion", measures = "Simpson") + 
  theme_bw() +
  geom_point(size = 3) +
  theme(plot.title = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(), 
        axis.text.x = element_text(size = 8),
        axis.text.y = element_text(size = 8),
        panel.grid.minor = element_blank(),
        legend.title = element_text(face = "bold", size =12), 
        legend.title.align = 0.5,
        legend.text = element_text(size = 10)) +
  guides(shape = guide_legend(order = 0), color = guide_legend(order = 1, title = "Subregion"))

observed_uclust <- plot_richness(uclust_phylo_filtered, x = "Region", color = "Subregion", measures = "Observed") + 
  theme_bw() +
  geom_point(size = 3) +
  theme(plot.title = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(), 
        axis.text.x = element_text(size = 8),
        axis.text.y = element_text(size = 8),
        panel.grid.minor = element_blank(),
        legend.title = element_text(face = "bold", size =12), 
        legend.title.align = 0.5,
        legend.text = element_text(size = 10)) +
  guides(shape = guide_legend(order = 0), color = guide_legend(order = 1, title = "Subregion"))

simpson_dada2 <- plot_richness(dada2_phylo_filtered, x = "Region", color = "Subregion", measures = "Simpson") + 
  theme_bw() +
  geom_point(size = 3) +
  theme(plot.title = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(), 
        axis.text.x = element_text(size = 8),
        axis.text.y = element_text(size = 8),
        panel.grid.minor = element_blank(),
        legend.title = element_text(face = "bold", size =12), 
        legend.title.align = 0.5,
        legend.text = element_text(size = 10)) +
  guides(shape = guide_legend(order = 0), color = guide_legend(order = 1, title = "Subregion"))

observed_dada2 <- plot_richness(dada2_phylo_filtered, x = "Region", color = "Subregion", measures = "Observed") + 
  theme_bw() +
  geom_point(size = 3) +
  theme(plot.title = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(), 
        axis.text.x = element_text(size = 8),
        axis.text.y = element_text(size = 8),
        panel.grid.minor = element_blank(),
        legend.title = element_text(face = "bold", size =12), 
        legend.title.align = 0.5,
        legend.text = element_text(size = 10)) +
  guides(shape = guide_legend(order = 0), color = guide_legend(order = 1, title = "Subregion"))

plot <- ggarrange(observed_dada2, observed_uclust, observed_vsearch,
                  labels = c("A","B", "C"), common.legend = TRUE,
                  ncol = 3, nrow = 1, legend = "right", align = "hv")
plot

#save file
tiff(file = "Desktop/AlphaDiv_Observed_OTUs_All_Algorithms.tif", 
     width=11.5, height=8, units = "in", res = 300)
plot
dev.off()

