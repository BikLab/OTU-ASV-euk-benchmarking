#################################
### FOR NPRB and MEMB Dataset ###
#################################

### NPRB: Merge read count with mapping file # 
NPRB_UCLUST_ReadCount <- reads_merged_map(NPRB_UCLUST, NPRB_MappingFile, "UCLUST")
NPRB_VSearch_ReadCount <- reads_merged_map(NPRB_VSearch, NPRB_MappingFile, "VSearch")
NPRB_DADA2_ReadCount <- reads_merged_map(NPRB_DADA2, NPRB_MappingFile, "DADA2")
NPRB_Deblur_ReadCount <- reads_merged_map(NPRB_Deblur, NPRB_MappingFile, "Deblur")

### MEMB: Merge read count with mapping file # 
MEMB_UCLUST_Family <- filter_families(MEMB_UCLUST)
MEMB_VSearch_Family <- filter_families(MEMB_VSearch)
MEMB_DADA2_Family <- filter_families(MEMB_DADA2)
MEMB_Deblur_Family <- filter_families(MEMB_Deblur)

MEMB_UCLUST_ReadCount <- reads_merged_map(MEMB_UCLUST_Family, MEMB_MappingFile, "UCLUST")
MEMB_VSearch_ReadCount <- reads_merged_map(MEMB_VSearch_Family, MEMB_MappingFile, "VSearch")
MEMB_DADA2_ReadCount <- reads_merged_map(MEMB_DADA2_Family, MEMB_MappingFile, "DADA2")
MEMB_Deblur_ReadCount <- reads_merged_map(MEMB_Deblur_Family, MEMB_MappingFile, "Deblur")

#MEMB_UCLUST_ReadCount <- remove_blanks_unknown(MEMB_UCLUST_ReadCount)
#MEMB_VSearch_ReadCount <- remove_blanks_unknown(MEMB_VSearch_ReadCount)
#MEMB_DADA2_ReadCount <- remove_blanks_unknown(MEMB_DADA2_ReadCount)
#MEMB_Deblur_ReadCount <- remove_blanks_unknown(MEMB_Deblur_ReadCount)

### plot barplots with Reads in the y-axis and save #
NPRB_UCLUST_Reads_Barplot <- ggplot_box(NPRB_UCLUST_ReadCount, yvar = "Reads", xvar = "Subregion", ylabel = T, ymax = 1e7,
                                        labelposition = 2.15, breaks = 10000, label.y = 7, dataset = "NPRB") 
NPRB_VSearch_Reads_Barplot <- ggplot_box(NPRB_VSearch_ReadCount, yvar = "Reads", xvar = "Subregion", ylabel = F, ymax = 1e7, 
                                         labelposition = 2.15,  breaks = 10000, label.y = 7, dataset = "NPRB")
NPRB_DADA2_Reads_Barplot <- ggplot_box(NPRB_DADA2_ReadCount, yvar = "Reads", xvar = "Subregion", ylabel = F, ymax = 1e7, 
                                       labelposition = 2.15, breaks = 10000, label.y = 7, dataset = "NPRB")
NPRB_Deblur_Reads_Barplot <- ggplot_box(NPRB_Deblur_ReadCount, yvar = "Reads", xvar = "Subregion", ylabel = F, ymax = 1e7, 
                                        labelposition = 2.15, breaks = 10000, label.y = 7, dataset = "NPRB")

MEMB_UCLUST_Reads_Barplot <- ggplot_box(MEMB_UCLUST_ReadCount, yvar = "Reads", xvar = "NematodeFamily", ylabel = T, label.y = 8, dataset = "MEMB",
                                          ymax = 1e8, labelposition = 1.25, breaks = 10000, pairwise = F, list = my_list_families) 
MEMB_VSearch_Reads_Barplot <- ggplot_box(MEMB_VSearch_ReadCount, yvar = "Reads", xvar = "NematodeFamily", ylabel = F, label.y = 8,dataset = "MEMB",
                                        ymax = 1e8, labelposition = 1.25, breaks = 10000, pairwise = F, list = my_list_families) 
MEMB_DADA2_Reads_Barplot <- ggplot_box(MEMB_DADA2_ReadCount, yvar = "Reads", xvar = "NematodeFamily", ylabel = F, label.y = 8, dataset = "MEMB",
                                         ymax = 1e8, labelposition = 1.25, breaks = 10000, pairwise = F, list = my_list_families) 
MEMB_Deblur_Reads_Barplot <- ggplot_box(MEMB_Deblur_ReadCount, yvar = "Reads", xvar = "NematodeFamily", ylabel = F, label.y = 8,dataset = "MEMB",
                                         ymax = 1e8, labelposition = 1.25, breaks = 10000, pairwise = F, list = my_list_families) 

### NPRB: Merge OTU count with mapping file # 
NPRB_UCLUST_OTUCount <- otus_merged_map(NPRB_UCLUST, NPRB_MappingFile, "UCLUST")
NPRB_VSearch_OTUCount <- otus_merged_map(NPRB_VSearch, NPRB_MappingFile, "VSearch")
NPRB_DADA2_OTUCount <- otus_merged_map(NPRB_DADA2, NPRB_MappingFile, "DADA2")
NPRB_Deblur_OTUCount <- otus_merged_map(NPRB_Deblur, NPRB_MappingFile, "Deblur")

### MEMB: Merge OTU count with mapping file # 
MEMB_UCLUST_OTUCount <- otus_merged_map(MEMB_UCLUST_Family, MEMB_MappingFile, "UCLUST")
MEMB_VSearch_OTUCount <- otus_merged_map(MEMB_VSearch_Family, MEMB_MappingFile, "VSearch")
MEMB_DADA2_OTUCount <- otus_merged_map(MEMB_DADA2_Family, MEMB_MappingFile, "DADA2")
MEMB_Deblur_OTUCount <- otus_merged_map(MEMB_Deblur_Family, MEMB_MappingFile, "Deblur")

#MEMB_UCLUST_OTUCount <- remove_blanks_unknown(MEMB_UCLUST_OTUCount)
#MEMB_VSearch_OTUCount <- remove_blanks_unknown(MEMB_VSearch_OTUCount)
#MEMB_DADA2_OTUCount <- remove_blanks_unknown(MEMB_DADA2_OTUCount)
#MEMB_Deblur_OTUCount <- remove_blanks_unknown(MEMB_Deblur_OTUCount)

### plot barplots with OTUs in the y-axis and save #
NPRB_UCLUST_OTU_Barplot <- ggplot_box(NPRB_UCLUST_OTUCount, yvar = "OTUs", xvar = "Subregion", ylabel = T, ymax = 1e5, 
                                        labelposition = 2.15, breaks = 10000, label.y = 5, dataset = "NPRB") + labs(y= "OTUs/ASVs")
NPRB_VSearch_OTU_Barplot <- ggplot_box(NPRB_VSearch_OTUCount, yvar = "OTUs", xvar = "Subregion", ylabel = F, ymax = 1e5, 
                                         labelposition = 2.15,  breaks = 10000, label.y = 5, dataset = "NPRB") + labs(y= "OTUs/ASVs")
NPRB_DADA2_OTU_Barplot <- ggplot_box(NPRB_DADA2_OTUCount, yvar = "OTUs", xvar = "Subregion", ylabel = F, ymax = 1e5, 
                                       labelposition = 2.15, breaks = 10000, label.y = 5, dataset = "NPRB") + labs(y= "OTUs/ASVs")
NPRB_Deblur_OTU_Barplot <- ggplot_box(NPRB_Deblur_OTUCount, yvar = "OTUs", xvar = "Subregion", ylabel = F, ymax = 1e5, 
                                        labelposition = 2.15, breaks = 10000, label.y = 5, dataset = "NPRB") + labs(y= "OTUs/ASVs")


MEMB_UCLUST_OTU_Barplot <- ggplot_box(MEMB_UCLUST_OTUCount, yvar = "OTUs", xvar = "NematodeFamily", ylabel = T, label.y = 5, dataset = "MEMB",
                                        ymax = 1e5, labelposition = 1.25, breaks = 10000, pairwise = F, list = my_list_families) + labs(y= "OTUs/ASVs")
MEMB_VSearch_OTU_Barplot <- ggplot_box(MEMB_VSearch_OTUCount, yvar = "OTUs", xvar = "NematodeFamily", ylabel = F, label.y = 5,dataset = "MEMB",
                                         ymax = 1e5, labelposition = 1.25, breaks = 10000, pairwise = F, list = my_list_families) + labs(y= "OTUs/ASVs") 
MEMB_DADA2_OTU_Barplot <- ggplot_box(MEMB_DADA2_OTUCount, yvar = "OTUs", xvar = "NematodeFamily", ylabel = F, label.y = 5, dataset = "MEMB",
                                       ymax = 1e5, labelposition = 1.25, breaks = 10000, pairwise = F, list = my_list_families) + labs(y= "OTUs/ASVs")
MEMB_Deblur_OTU_Barplot <- ggplot_box(MEMB_Deblur_OTUCount, yvar = "OTUs", xvar = "NematodeFamily", ylabel = F, label.y = 5,dataset = "MEMB",
                                        ymax = 1e5, labelposition = 1.25, breaks = 10000, pairwise = F, list = my_list_families) + labs(y= "OTUs/ASVs")

NPRB_Barplot <- ((NPRB_UCLUST_Reads_Barplot | NPRB_VSearch_Reads_Barplot | NPRB_DADA2_Reads_Barplot | NPRB_Deblur_Reads_Barplot)) /
  ((NPRB_UCLUST_OTU_Barplot | NPRB_VSearch_OTU_Barplot | NPRB_DADA2_OTU_Barplot | NPRB_Deblur_OTU_Barplot)) + 
  plot_layout(guides = "collect") + plot_annotation(title = 'HC Arctic Sediment', tag_levels = c('A'), tag_suffix = '.') & 
  theme(legend.position = "right", plot.title = element_text(size=24)) 
NPRB_Barplot
ggsave("qiime2-Results/NPRB/NPRB_Reads_OTUs_Barplot.tiff", dpi = 300, width = 11.5, height = 8)

MEMB_Barplot <- ((MEMB_UCLUST_Reads_Barplot | MEMB_VSearch_Reads_Barplot | MEMB_DADA2_Reads_Barplot | MEMB_Deblur_Reads_Barplot)) /
  ((MEMB_UCLUST_OTU_Barplot | MEMB_VSearch_OTU_Barplot | MEMB_DADA2_OTU_Barplot | MEMB_Deblur_OTU_Barplot)) +
  plot_layout(guides = "collect") + plot_annotation(title = 'LC Single Nematodes', tag_levels = c('A'), tag_suffix = '.') & 
  theme(legend.position = "right", plot.title = element_text(size=24))
MEMB_Barplot
ggsave("qiime2-Results/NPRB/MEMB_Reads_OTUs_Barplot_noPairwise.tiff", dpi = 300, width = 11.5, height = 8)

