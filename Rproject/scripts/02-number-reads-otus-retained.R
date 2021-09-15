#################################
######### FOR HC Dataset ########
#################################
### merge read count with mapping file 
hc_uclust_ReadCount <- count_number_reads(hc_uclust, hc_mapping_file, "UCLUST")
hc_vsearch_ReadCount <- count_number_reads(hc_vsearch, hc_mapping_file, "VSearch")
hc_dada2_ReadCount <- count_number_reads(hc_dada2, hc_mapping_file, "DADA2")
hc_deblur_ReadCount <- count_number_reads(hc_deblur, hc_mapping_file, "Deblur")

### merge OTU count with mapping file 
hc_uclust_OTUCount <- count_number_motus(hc_uclust, hc_mapping_file, "UCLUST")
hc_vsearch_OTUCount <- count_number_motus(hc_vsearch, hc_mapping_file, "VSearch")
hc_dada2_OTUCount <- count_number_motus(hc_dada2, hc_mapping_file, "DADA2")
hc_deblur_OTUCount <- count_number_motus(hc_deblur, hc_mapping_file, "Deblur")

### plot barplots with Reads in the y-axis  
hc_uclust_ReadCount_barplot <- read_otus_boxplot_facet(hc_uclust_ReadCount, yvar = "Reads", xvar = "Subregion", ylabel = T, ymax = 1e7,
                                        labelposition = 2.15, breaks = 10000, label.y = 6, dataset = "NPRB") 
hc_vsearch_ReadCount_barplot <- read_otus_boxplot_facet(hc_vsearch_ReadCount, yvar = "Reads", xvar = "Subregion", ylabel = F, ymax = 1e7, 
                                         labelposition = 2.15,  breaks = 10000, label.y = 6, dataset = "NPRB")
hc_dada2_ReadCount_barplot <- read_otus_boxplot_facet(hc_dada2_ReadCount, yvar = "Reads", xvar = "Subregion", ylabel = F, ymax = 1e7, 
                                       labelposition = 2.15, breaks = 10000, label.y = 6, dataset = "NPRB")
hc_deblur_ReadCount_barplot <- read_otus_boxplot_facet(hc_deblur_ReadCount, yvar = "Reads", xvar = "Subregion", ylabel = F, ymax = 1e7, 
                                        labelposition = 2.15, breaks = 10000, label.y = 6, dataset = "NPRB")

### plot barplots with OTUs in the y-axis and save 
hc_uclust_OTUCount_Barplot <- read_otus_boxplot_facet(hc_uclust_OTUCount, yvar = "OTUs", xvar = "Subregion", ylabel = T, ymax = 1e5, 
                                      labelposition = 2.15, breaks = 10000, label.y = 4.5, dataset = "NPRB") + labs(y= "MOTUs")
hc_vsearch_OTUCount_Barplot <- read_otus_boxplot_facet(hc_vsearch_OTUCount, yvar = "OTUs", xvar = "Subregion", ylabel = F, ymax = 1e5, 
                                       labelposition = 2.15,  breaks = 10000, label.y = 4.5, dataset = "NPRB") + labs(y= "MOTUs")
hc_dada2_OTUCount_Barplot <- read_otus_boxplot_facet(hc_dada2_OTUCount, yvar = "OTUs", xvar = "Subregion", ylabel = F, ymax = 1e5, 
                                     labelposition = 2.15, breaks = 10000, label.y = 4.5, dataset = "NPRB") + labs(y= "MOTUs")
hc_deblur_OTUCount_Barplot <- read_otus_boxplot_facet(hc_deblur_OTUCount, yvar = "OTUs", xvar = "Subregion", ylabel = F, ymax = 1e5, 
                                      labelposition = 2.15, breaks = 10000, label.y = 4.5, dataset = "NPRB") + labs(y= "MOTUs")

hc_dataset_Barplot <- ((hc_uclust_ReadCount_barplot | hc_vsearch_ReadCount_barplot | hc_dada2_ReadCount_barplot | hc_deblur_ReadCount_barplot)) /
  ((hc_uclust_OTUCount_Barplot | hc_vsearch_OTUCount_Barplot | hc_dada2_OTUCount_Barplot | hc_deblur_OTUCount_Barplot)) + 
  plot_layout(guides = "collect") + plot_annotation(title = 'HC Arctic Sediment', tag_levels = c('A'), tag_suffix = '.') & 
  theme(plot.title = element_text(size=24), plot.tag = element_text(face = "bold"), legend.title = element_text(face = "bold", hjust = 0.5)) 
hc_dataset_Barplot
ggsave("output/Figure-S2-high-complexity-reads-motus-retained.png", dpi = 300, width = 11.5, height = 8, device = "png")


#################################
######### FOR LC Dataset ########
#################################
### filter the major (most abundant) families 
lc_uclust_family <- filter_nematode_families(lc_uclust)
lc_vsearch_family <- filter_nematode_families(lc_vsearch)
lc_dada2_family <- filter_nematode_families(lc_dada2)
lc_deblur_family <- filter_nematode_families(lc_deblur)

### merge read count with mapping file
lc_uclust_ReadCount <- count_number_reads(lc_uclust_family, lc_mapping_file, "UCLUST")
lc_vsearch_ReadCount <- count_number_reads(lc_vsearch_family, lc_mapping_file, "VSearch")
lc_dada2_ReadCount <- count_number_reads(lc_dada2_family, lc_mapping_file, "DADA2")
lc_deblur_ReadCount <- count_number_reads(lc_deblur_family, lc_mapping_file, "Deblur")

### merge OTU count with mapping file 
lc_uclust_OTUCount <- count_number_motus(lc_uclust_family, lc_mapping_file, "UCLUST")
lc_vsearch_OTUCount <- count_number_motus(lc_vsearch_family, lc_mapping_file, "VSearch")
lc_dada2_OTUCount <- count_number_motus(lc_dada2_family, lc_mapping_file, "DADA2")
lc_deblur_OTUCount <- count_number_motus(lc_deblur_family, lc_mapping_file, "Deblur")

### plot barplots with Reads in the y-axis  
lc_uclust_ReadCount_barplot <- read_otus_boxplot_facet(lc_uclust_ReadCount, yvar = "Reads", xvar = "NematodeFamily", ylabel = T, label.y = 7, dataset = "MEMB",
                                                 ymax = 1e8, labelposition = 1.25, breaks = 10000, pairwise = T, list = pairwise_comparisons_families) + guides(fill=guide_legend(title="Nematode Family"))
lc_vsearch_ReadCount_barplot <- read_otus_boxplot_facet(lc_vsearch_ReadCount, yvar = "Reads", xvar = "NematodeFamily", ylabel = F, label.y = 7,dataset = "MEMB",
                                                  ymax = 1e8, labelposition = 1.25, breaks = 10000, pairwise = T, list = pairwise_comparisons_families) + guides(fill=guide_legend(title="Nematode Family"))
lc_dada2_ReadCount_barplot <- read_otus_boxplot_facet(lc_dada2_ReadCount, yvar = "Reads", xvar = "NematodeFamily", ylabel = F, label.y = 7, dataset = "MEMB",
                                                ymax = 1e8, labelposition = 1.25, breaks = 10000, pairwise = T, list = pairwise_comparisons_families) + guides(fill=guide_legend(title="Nematode Family"))
lc_deblur_ReadCount_barplot <- read_otus_boxplot_facet(lc_deblur_ReadCount, yvar = "Reads", xvar = "NematodeFamily", ylabel = F, label.y = 7,dataset = "MEMB",
                                                 ymax = 1e8, labelposition = 1.25, breaks = 10000, pairwise = T, list = pairwise_comparisons_families) + guides(fill=guide_legend(title="Nematode Family"))

### plot barplots with OTUs in the y-axis and save 
lc_uclust_OTUCount_Barplot <- read_otus_boxplot_facet(lc_uclust_OTUCount, yvar = "OTUs", xvar = "NematodeFamily", ylabel = T, label.y = 4.5, dataset = "MEMB",
                                                ymax = 1e5, labelposition = 1.25, breaks = 10000, pairwise = T, list = pairwise_comparisons_families) + labs(y= "MOTUs") + guides(fill=guide_legend(title="Nematode Family"))
lc_vsearch_OTUCount_Barplot <- read_otus_boxplot_facet(lc_vsearch_OTUCount, yvar = "OTUs", xvar = "NematodeFamily", ylabel = F, label.y = 4.5,dataset = "MEMB",
                                                 ymax = 1e5, labelposition = 1.25, breaks = 10000, pairwise = T, list = pairwise_comparisons_families) + labs(y= "MOTUs") + guides(fill=guide_legend(title="Nematode Family"))
lc_dada2_OTUCount_Barplot <- read_otus_boxplot_facet(lc_dada2_OTUCount, yvar = "OTUs", xvar = "NematodeFamily", ylabel = F, label.y = 4.5, dataset = "MEMB",
                                               ymax = 1e5, labelposition = 1.25, breaks = 10000, pairwise = T, list = pairwise_comparisons_families) + labs(y= "MOTUs")+ guides(fill=guide_legend(title="Nematode Family"))
lc_deblur_OTUCount_Barplot <- read_otus_boxplot_facet(lc_deblur_OTUCount, yvar = "OTUs", xvar = "NematodeFamily", ylabel = F, label.y = 4.5,dataset = "MEMB",
                                                ymax = 1e5, labelposition = 1.25, breaks = 10000, pairwise = T, list = pairwise_comparisons_families) + labs(y= "MOTUs")+ guides(fill=guide_legend(title="Nematode Family"))


lc_dataset_Barplot <- ((lc_uclust_ReadCount_barplot | lc_vsearch_ReadCount_barplot | lc_dada2_ReadCount_barplot | lc_deblur_ReadCount_barplot)) /
  ((lc_uclust_OTUCount_Barplot | lc_vsearch_OTUCount_Barplot | lc_dada2_OTUCount_Barplot | lc_deblur_OTUCount_Barplot)) +
  plot_layout(guides = "collect") + plot_annotation(title = 'LC Single Nematodes', tag_levels = c('A'), tag_suffix = '.') & 
  theme(plot.title = element_text(size=24),  plot.tag = element_text(face = "bold"), legend.title = element_text(face = "bold", hjust = 0.5))
lc_dataset_Barplot
ggsave("output/Figure-S3-low-complexity-reads-motus-retained.png", dpi = 300, width = 11.5, height = 8, device = "png")

