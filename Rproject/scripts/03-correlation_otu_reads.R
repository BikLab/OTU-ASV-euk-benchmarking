#################################
######### FOR HC Dataset ########
#################################
# wrangle Data to correct format 
hc_reads_sample_method <- bind_rows(hc_uclust_ReadCount, hc_vsearch_ReadCount, hc_dada2_ReadCount, hc_deblur_ReadCount)
hc_reads_sample_method <- hc_reads_sample_method[c("Reads", "Method", "X.SampleID")]

hc_MOTUs_Sample_Method <- bind_rows(hc_uclust_OTUCount, hc_vsearch_OTUCount, hc_dada2_OTUCount, hc_deblur_OTUCount)
hc_MOTUs_Sample_Method <- hc_MOTUs_Sample_Method[c("OTUs", "Method", "X.SampleID")]

hc_reads_MOTUs_sample_merged <- hc_reads_sample_method %>% right_join(hc_MOTUs_Sample_Method, by=c("X.SampleID","Method"))
hc_reads_MOTUs_sample_merged$Method <- factor(hc_reads_MOTUs_sample_merged$Method, c("UCLUST", "VSearch", "DADA2", "Deblur"))

# Correlation and OTU/Read boxpots for NPRB # 
hc_dataset_correlation <- correlation_otu_reads(hc_reads_MOTUs_sample_merged, color = "Method", xvar = "Reads", yvar = "OTUs", xaxis = "Reads", yaxis = "MOTUs") 
hc_dataset_boxplot_OTUs <- barplot_otu_reads(hc_reads_MOTUs_sample_merged, xvar = "Method", yvar = "OTUs", color = "Method", list = pairwise_comparisons_methods, xlabel = 2, ymax = 1e7, ylabel = T, label.y = 6.75) + labs(y="MOTUs")
hc_dataset_boxplot_reads <- barplot_otu_reads(hc_reads_MOTUs_sample_merged, xvar = "Method", yvar = "Reads", color = "Method", list = pairwise_comparisons_methods, xlabel = 2, ymax = 1e10, ylabel = T, label.y = 9.50)

#################################
######### FOR LC Dataset ########
#################################
# wrangle Data to correct format 
lc_reads_sample_method <- bind_rows(lc_uclust_ReadCount, lc_vsearch_ReadCount, lc_dada2_ReadCount, lc_deblur_ReadCount)
lc_reads_sample_method <- lc_reads_sample_method[c("Reads", "Method", "SampleID")]

lc_MOTUs_Sample_Method <- bind_rows(lc_uclust_OTUCount, lc_vsearch_OTUCount, lc_dada2_OTUCount, lc_deblur_OTUCount)
lc_MOTUs_Sample_Method <- lc_MOTUs_Sample_Method[c("OTUs", "Method", "SampleID")]

lc_reads_MOTUs_sample_merged <- lc_reads_sample_method %>% right_join(lc_MOTUs_Sample_Method, by=c("SampleID","Method"))
lc_reads_MOTUs_sample_merged$Method <- factor(lc_reads_MOTUs_sample_merged$Method, c("UCLUST", "VSearch", "DADA2", "Deblur"))

# Correlation and OTU/Read boxpots for MEMB # 
lc_dataset_correlation <- correlation_otu_reads(lc_reads_MOTUs_sample_merged, color = "Method", xvar = "Reads", yvar = "OTUs", xaxis = "Reads", yaxis = "MOTUs")
lc_dataset_boxplot_OTUs <- barplot_otu_reads(lc_reads_MOTUs_sample_merged, xvar = "Method", yvar = "OTUs", color = "Method",list = pairwise_comparisons_methods, xlabel = 2, ymax = 1e7, ylabel = T, label.y = 6.75) + labs(y="MOTUs")
lc_dataset_boxplot_reads <- barplot_otu_reads(lc_reads_MOTUs_sample_merged, xvar = "Method", yvar = "Reads", color = "Method", list = pairwise_comparisons_methods, xlabel = 2, ymax = 1e10, ylabel = T, label.y = 9.50)

#################################
####### FOR FINAL FIGURE ########
#################################
# Make and save final figure # 
correlation_final <- ggarrange(hc_dataset_correlation, lc_dataset_correlation, ncol = 2, nrow = 1, labels = c("C.", "F."), common.legend = T, legend = "right", label.y = 0.95)
boxplot_final <- ggarrange(hc_dataset_boxplot_OTUs, hc_dataset_boxplot_reads, lc_dataset_boxplot_OTUs, lc_dataset_boxplot_reads, ncol = 4, nrow = 1, widths = c(1.,1,1,1),
                           common.legend = T, legend = "right",labels = c("A.", "B.", "D.", "E."), label.y = 0.93)
correlation_otu_read_boxplot <- ggarrange(boxplot_final, correlation_final, ncol = 1, nrow = 2, common.legend = F)
correlation_otu_read_boxplot
ggsave("output/Figure-2-number-motus-reads-retained-correlation.png", width = 11.5, height = 8, dpi = 300, device = "png", bg = "white")
