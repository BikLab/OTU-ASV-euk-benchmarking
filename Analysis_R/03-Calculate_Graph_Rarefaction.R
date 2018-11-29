# Purpose: Make Rarefaction Curves
# Edit Input and Output Files and Edit Variable by which to Merge

require(phyloseq)
require(biomformat)
require(ggplot2)

#Merge Variables based on Variable in Metadata
merged_phy = merge_samples(dada2_phylo_filtered, "Subregion")

#Calculate Rarefaction Curves
rarefaction_curve_data <- calculate_rarefaction_curves(merged_phy, c('Observed'), rep(c(1, 10, 100, 1000, 1:100 * 10000), each = 10))
summary(rarefaction_curve_data)

#Summarise Rarefaction Cure 
rarefaction_curve_data_summary <- ddply(rarefaction_curve_data, c('Depth', 'Sample', 'Measure'), summarise, Alpha_diversity_mean = mean(Alpha_diversity), Alpha_diversity_sd = sd(Alpha_diversity))

#Merge Rarefaction Curve Data with Metadata
rarefaction_curve_data_summary_verbose <- merge(rarefaction_curve_data_summary, data.frame(sample_data(dada2_phylo_filtered)), by.x = 'Sample', by.y = 'Subregion')

#Plot Rarefaction Curve (Repeat for Each Algorithm)
plot_dada2 <- ggplot(rarefaction_curve_data_summary_verbose, aes(x=Depth.x,y = Alpha_diversity_mean, 
                                                    ymin = Alpha_diversity_mean - Alpha_diversity_sd, 
                                                   ymax = Alpha_diversity_mean + Alpha_diversity_sd,
                                                   colour = Sample, group = Sample)) + 
geom_line() + geom_pointrange() + facet_wrap(facets = ~ Measure, scales = 'free_y') +
  theme_bw() +
  theme(plot.title = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(), 
        axis.text.x = element_text(size = 8),
        axis.text.y = element_text(size = 8),
        panel.grid.minor = element_blank(),
        legend.title = element_text(face = "bold", size =12), 
        legend.title.align = 0.5,
        legend.text = element_text(size = 10)) 
plot_dada2

plot <- ggarrange(plot_dada2, plot_uclust, plot_vsearch,
                  labels = c("A","B", "C"), common.legend = TRUE,
                  ncol = 3, nrow = 1, legend = "right", align = "hv")
plot

#Save file
tiff(file = "Desktop/RarefactionCurves_ObservedOTUs_All_Algorithms.tif", 
     width=11.5, height=6, units = "in", res = 300)
plot
dev.off()

