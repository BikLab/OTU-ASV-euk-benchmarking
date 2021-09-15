#################################
######### FOR HC Dataset ########
#################################
# melt phyloseq objects to dataframe 
hc_uclust_melt <- rank_asv_otu(hc_uclust)
hc_vsearch_melt <- rank_asv_otu(hc_vsearch)
hc_dada2_melt <- rank_asv_otu(hc_dada2)
hc_deblur_melt <- rank_asv_otu(hc_deblur)

# plot head-tail patterns 
hc_uclust_head_tail <- plot_head_tail(hc_uclust_melt, "UCLUST", ymax = 1e7, ylabel = T) + labs(y  = "Reads")
hc_vsearch_head_tail <- plot_head_tail(hc_vsearch_melt, "VSearch", ymax = 1e7, ylabel = F) + labs(y  = "Reads")
hc_dada2_head_tail <- plot_head_tail(hc_dada2_melt, "DADA2", ymax = 1e7, ylabel = F) + labs(y  = "Reads")
hc_deblur_head_tail <- plot_head_tail(hc_deblur_melt, "Deblur", ymax = 1e7, ylabel = F) + labs(y  = "Reads")

# keep rare OTUs
hc_uclust_rare <- filter_taxa(hc_uclust, function(x) sum(x) < 11, TRUE)
hc_vsearch_rare <- filter_taxa(hc_vsearch, function(x) sum(x) < 11, TRUE)
hc_dada2_rare <- filter_taxa(hc_dada2, function(x) sum(x) < 11, TRUE)
hc_deblur_rare <- filter_taxa(hc_deblur, function(x) sum(x) < 11, TRUE)

# merge read count with mapping file 
hc_uclust_rare_ReadCount <- as.data.frame(apply(otu_table(hc_uclust_rare) > 0, 2, sum)); names(hc_uclust_rare_ReadCount)[1] <- "MOTUs"
hc_uclust_rare_ReadCount$Method <- "UCLUST"
hc_vsearch_rare_ReadCount <- as.data.frame(apply(otu_table(hc_vsearch_rare) > 0, 2, sum));names(hc_vsearch_rare_ReadCount)[1] <- "MOTUs"
hc_vsearch_rare_ReadCount$Method <- "VSearch"
hc_dada2_rare_ReadCount <- as.data.frame(apply(otu_table(hc_dada2_rare) > 0, 2, sum)); names(hc_dada2_rare_ReadCount)[1] <- "MOTUs"
hc_dada2_rare_ReadCount$Method <- "DADA2"
hc_deblur_rare_ReadCount <- as.data.frame(apply(otu_table(hc_deblur_rare) > 0, 2, sum)); names(hc_deblur_rare_ReadCount)[1] <- "MOTUs"
hc_deblur_rare_ReadCount$Method <- "Deblur"

# plot barplots with Reads in the y-axis and save 
hc_reads_sample_method <- list(hc_uclust_rare_ReadCount, hc_vsearch_rare_ReadCount, hc_dada2_rare_ReadCount, hc_deblur_rare_ReadCount) %>% map_df(rownames_to_column, 'Sample')
hc_total_motu <- read.csv("data/hc-dataset/HC-totalMOTU.csv") # from table S2
hc_final_table <- merge(hc_reads_sample_method, hc_total_motu, by = c("Sample", "Method"))
hc_final_table$Rel <- (hc_final_table$MOTUs / hc_final_table$totalMOTU) * 100
hc_final_table$Method <- factor(hc_final_table$Method, c("UCLUST", "VSearch", "DADA2", "Deblur"))
hc_final_table <- filter(hc_final_table, totalMOTU > 0)

hc_dataset_boxplot_reads <- barplot_otu_reads(hc_final_table, xvar = "Method", yvar = "Rel", color = "Method",list = pairwise_comparisons_methods, xlabel = 2, ymax = 200, ylabel = T, label.y = 175) + 
  labs(y="% Rare MOTUs") + scale_y_continuous(expand = c(0,0), limits = c(0, 200)) 

#################################
######### FOR LC Dataset ########
#################################
# melt phyloseq objects to dataframe 
lc_uclust_melt <- rank_asv_otu(lc_uclust)
lc_vsearch_melt <- rank_asv_otu(lc_vsearch)
lc_dada2_melt <- rank_asv_otu(lc_dada2)
lc_deblur_melt <- rank_asv_otu(lc_deblur)

# plot head-tail patterns 
lc_uclust_head_tail <- plot_head_tail(lc_uclust_melt, "UCLUST", ymax = 1e7, ylabel = T) + labs(y  = "Reads")
lc_vsearch_head_tail <- plot_head_tail(lc_vsearch_melt, "VSearch", ymax = 1e7, ylabel = F) + labs(y  = "Reads")
lc_dada2_head_tail <- plot_head_tail(lc_dada2_melt, "DADA2", ymax = 1e7, ylabel = F) + labs(y  = "Reads")
lc_deblur_head_tail <- plot_head_tail(lc_deblur_melt, "Deblur", ymax = 1e7, ylabel = F) + labs(y  = "Reads")

# keep rare OTUs
lc_uclust_rare <- filter_taxa(lc_uclust, function(x) sum(x) < 11, TRUE)
lc_vsearch_rare <- filter_taxa(lc_vsearch, function(x) sum(x) < 11, TRUE)
lc_dada2_rare <- filter_taxa(lc_dada2, function(x) sum(x) < 11, TRUE)
lc_deblur_rare <- filter_taxa(lc_deblur, function(x) sum(x) < 11, TRUE)

# merge read count with mapping file 
lc_uclust_rare_ReadCount <- as.data.frame(apply(otu_table(lc_uclust_rare) > 0, 2, sum)); names(lc_uclust_rare_ReadCount)[1] <- "MOTUs"
lc_uclust_rare_ReadCount$Method <- "UCLUST"
lc_vsearch_rare_ReadCount <- as.data.frame(apply(otu_table(lc_vsearch_rare) > 0, 2, sum));names(lc_vsearch_rare_ReadCount)[1] <- "MOTUs"
lc_vsearch_rare_ReadCount$Method <- "VSearch"
lc_dada2_rare_ReadCount <- as.data.frame(apply(otu_table(lc_dada2_rare) > 0, 2, sum)); names(lc_dada2_rare_ReadCount)[1] <- "MOTUs"
lc_dada2_rare_ReadCount$Method <- "DADA2"
lc_deblur_rare_ReadCount <- as.data.frame(apply(otu_table(lc_deblur_rare) > 0, 2, sum)); names(lc_deblur_rare_ReadCount)[1] <- "MOTUs"
lc_deblur_rare_ReadCount$Method <- "Deblur"

# plot barplots with Reads in the y-axis and save 
lc_reads_sample_method <- list(lc_uclust_rare_ReadCount, lc_vsearch_rare_ReadCount, lc_dada2_rare_ReadCount, lc_deblur_rare_ReadCount) %>% map_df(rownames_to_column, 'Sample')
lc_total_motu <- read.csv("data/lc-dataset/LC-totalMOTUs.csv") # info from table S1
lc_total_motu <- merge(lc_reads_sample_method, lc_total_motu, by = c("Sample", "Method"))
lc_total_motu$Rel <- (lc_total_motu$MOTUs / lc_total_motu$totalMOTU) * 100
lc_total_motu$Method <- factor(lc_total_motu$Method, c("UCLUST", "VSearch", "DADA2", "Deblur"))
lc_final_table <- filter(lc_total_motu, totalMOTU > 0)

hc_dataset_boxplot_reads <- barplot_otu_reads(lc_final_table, xvar = "Method", yvar = "Rel", color = "Method",list = pairwise_comparisons_methods, xlabel = 2, ymax = 200, ylabel = T, label.y = 175) + 
  labs(y="% Rare MOTUs") + scale_y_continuous(expand = c(0,0), limits = c(0, 200)) 


#################################
###### FOR LC & HC Dataset ######
#################################
hc_head_tail <- ggarrange(hc_uclust_head_tail, hc_vsearch_head_tail, hc_dada2_head_tail, hc_deblur_head_tail, ncol = 4, nrow = 1, legend = "none", label.y = 0.95, widths = c(1.2,1,1,1)) + 
  plot_annotation(title = 'A. HC Arctic Sediments') & theme(plot.title = element_text(size=18))
lc_head_tail <- ggarrange(lc_uclust_head_tail, lc_vsearch_head_tail, lc_dada2_head_tail, lc_deblur_head_tail, ncol = 4, nrow = 1, legend = "none", label.y = 0.95, widths = c(1.2,1,1,1)) +
  plot_annotation(title = 'B. LC Single Nematodes') & theme(plot.title = element_text(size=18))

hc_dataset_boxplot_reads <- ggarrange(hc_dataset_boxplot_reads, legend = "none") + plot_annotation(title = 'C. HC Arctic Sediments') & theme(plot.title = element_text(size=18))
lc_dataset_boxplot_reads <- ggarrange(lc_dataset_boxplot_reads, legend = "none") + plot_annotation(title = 'D. LC Single Nematodes') & theme(plot.title = element_text(size=18))

head_tail_pattern_rare_otus <- ggarrange(hc_head_tail, hc_dataset_boxplot_reads, lc_head_tail, lc_dataset_boxplot_reads, ncol = 2, nrow = 2, common.legend = T, legend = "bottom", widths = c(3,1))
head_tail_pattern_rare_otus
ggsave("output/Figure-4-head-tail-pattern-rare-reads-boxplot.tiff", width = 11.5, height = 8, dpi = 300)


