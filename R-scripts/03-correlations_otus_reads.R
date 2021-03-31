#################################
### FOR NPRB and MEMB Dataset ###
#################################

### Wrangle Data to correct format 
NPRB_Reads_Sample_Method <- bind_rows(NPRB_UCLUST_ReadCount, NPRB_VSearch_ReadCount, NPRB_DADA2_ReadCount, NPRB_Deblur_ReadCount)
NPRB_Reads_Sample_Method <- NPRB_Reads_Sample_Method[c("Reads", "Method", "X.SampleID")]

NPRB_OTUs_Sample_Method <- bind_rows(NPRB_UCLUST_OTUCount, NPRB_VSearch_OTUCount, NPRB_DADA2_OTUCount, NPRB_Deblur_OTUCount)
NPRB_OTUs_Sample_Method <- NPRB_OTUs_Sample_Method[c("OTUs", "Method", "X.SampleID")]

NPRB_OTUs_Reads_Sample_Merged <- NPRB_Reads_Sample_Method %>% right_join(NPRB_OTUs_Sample_Method, by=c("X.SampleID","Method"))
NPRB_OTUs_Reads_Sample_Merged$Method <- factor(NPRB_OTUs_Reads_Sample_Merged$Method, c("UCLUST", "VSearch", "DADA2", "Deblur"))

MEMB_Reads_Sample_Method <- bind_rows(MEMB_UCLUST_ReadCount, MEMB_VSearch_ReadCount, MEMB_DADA2_ReadCount, MEMB_Deblur_ReadCount)
MEMB_Reads_Sample_Method <- MEMB_Reads_Sample_Method[c("Reads", "Method", "SampleID")]

MEMB_OTUs_Sample_Method <- bind_rows(MEMB_UCLUST_OTUCount, MEMB_VSearch_OTUCount, MEMB_DADA2_OTUCount, MEMB_Deblur_OTUCount)
MEMB_OTUs_Sample_Method <- MEMB_OTUs_Sample_Method[c("OTUs", "Method", "SampleID")]

MEMB_OTUs_Reads_Sample_Merged <- MEMB_Reads_Sample_Method %>% right_join(MEMB_OTUs_Sample_Method, by=c("SampleID","Method"))
MEMB_OTUs_Reads_Sample_Merged$Method <- factor(MEMB_OTUs_Reads_Sample_Merged$Method, c("UCLUST", "VSearch", "DADA2", "Deblur"))

# Correlation and OTU/Read boxpots for NPRB # 
NPRB_correlation <- correlation_otu_reads(NPRB_OTUs_Reads_Sample_Merged, color = "Method", xvar = "Reads", yvar = "OTUs", xaxis = "Reads", yaxis = "ASVs/OTUs") 
NPRB_boxplot_OTUs <- barplot_otu_reads(NPRB_OTUs_Reads_Sample_Merged, xvar = "Method", yvar = "OTUs", color = "Method", list = my_list_method, xlabel = 2, ymax = 1e7, ylabel = T, label.y = 9) +
                      labs(y="ASVs/OTUs")
NPRB_boxplot_reads <- barplot_otu_reads(NPRB_OTUs_Reads_Sample_Merged, xvar = "Method", yvar = "Reads", color = "Method", list = my_list_method, xlabel = 2, ymax = 1e10, ylabel = T, label.y = 12)

# Correlation and OTU/Read boxpots for MEMB # 
MEMB_correlation <- correlation_otu_reads(MEMB_OTUs_Reads_Sample_Merged, color = "Method", xvar = "Reads", yvar = "OTUs", xaxis = "Reads", yaxis = "ASVs/OTUs")
MEMB_boxplot_OTUs <- barplot_otu_reads(MEMB_OTUs_Reads_Sample_Merged, xvar = "Method", yvar = "OTUs", color = "Method", list = my_list_method, xlabel = 2, ymax = 1e7, ylabel = T, label.y = 9) +
                      labs(y="ASVs/OTUs")
MEMB_boxplot_reads <- barplot_otu_reads(MEMB_OTUs_Reads_Sample_Merged, xvar = "Method", yvar = "Reads", color = "Method", list = my_list_method, xlabel = 2, ymax = 1e10, ylabel = T, label.y = 12)

# Make and save final figure # 
correlation_final <- ggarrange(NPRB_correlation, MEMB_correlation, ncol = 2, nrow = 1, labels = c("C.", "F."), common.legend = T, legend = "right", label.y = 0.95)
boxplot_final <- ggarrange(NPRB_boxplot_OTUs, NPRB_boxplot_reads, MEMB_boxplot_OTUs, MEMB_boxplot_reads, ncol = 4, nrow = 1, widths = c(1.,1,1,1),
                               common.legend = T, legend = "right",labels = c("A.", "B.", "D.", "E."), label.y = 0.93)
correlation_otu_read_boxplot <- ggarrange(boxplot_final, correlation_final, ncol = 1, nrow = 2, common.legend = F)
correlation_otu_read_boxplot
ggsave("qiime2-Results/NPRB/correlation_barplots_OTUs_ASVs.tiff", width = 11.5, height = 8, dpi = 300)
