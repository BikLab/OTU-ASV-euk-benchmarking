#################################
######### FOR HC Dataset ########
#################################
hc_uclust_single_sample_abundant <- merge_samples_most_abundant(hc_uclust)
hc_uclust_single_sample_abundant$Method <- "UCLUST"

hc_vsearch_single_sample_abundant <- merge_samples_most_abundant(hc_vsearch)
hc_vsearch_single_sample_abundant$Method <- "VSearch"

hc_dada2_single_sample_abundant <- merge_samples_most_abundant(hc_dada2)
hc_dada2_single_sample_abundant$Method <- "DADA2"

hc_deblur_single_sample_abundant <- merge_samples_most_abundant(hc_deblur)
hc_deblur_single_sample_abundant$Method <- "Deblur"

hc_single_sample_merged_all <- rbind(hc_uclust_single_sample_abundant, hc_vsearch_single_sample_abundant, 
                                     hc_dada2_single_sample_abundant, hc_deblur_single_sample_abundant)
unique(hc_single_sample_merged_all$Rank7)

# download to manually edit taxonomy 
write_delim(x = hc_single_sample_merged_all, file = "output/hc-taxonomy-summary.txt", delim = "\t")
hc_taxonomy_fixed <- read_tsv("data/hc-dataset/hc-taxonomy-summary-fixed.txt")

# Plot graphic using ggplot2
hc_taxonomy_fixed$Rank7 <- forcats::fct_relevel(hc_taxonomy_fixed$Rank7, "Other", after = Inf)
hc_taxonomy_fixed$Method <- factor(hc_taxonomy_fixed$Method, c("UCLUST", "VSearch", "DADA2", "Deblur"))
hc_colors <- c("#377EB8", "#4DAF4A", "#E41A1C", "#984EA3", "#FF7F00", "#DED3B3", "#FFFF33", "#F781BF", "grey")

hc_dataset_fam <- ggplot(hc_taxonomy_fixed, aes(x = Method, y = Abundance, fill = Rank7)) + #plotting by sample
  geom_bar(stat = "identity", width = 0.95) + # adds to 100%
  geom_text(aes(label = ifelse(round(Abundance*100) >= 3, paste(round(Abundance*100, digits = 0), "%"), "")), size = 5, position = position_stack(vjust = 0.5)) + # adds percetange label >3% and adjust the scale to 0-100%
  scale_fill_manual(values = hc_colors) +
  theme(axis.text.y = element_text(angle = 0, hjust = 1, size = 10, face = "bold")) + # adjusts text of y axis
  theme(axis.text.x = element_text(angle = 0, size = 10, face = "bold")) + # adjusts text of x axis and plot labels in a angle
  theme(axis.title.y = element_text(face = "bold", size = 12)) +  # adjusts the title of y axis
  theme(axis.title.x = element_text(face = "bold", size = 12)) + # adjusts the title of x axis
  scale_y_continuous(labels=scales::percent, expand = c(0.0, 0.0)) + # plot as % and remove the internal margins
  scale_x_discrete(expand = c(0.0, 0.0)) + # remove internal margins x-axis
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_rect(fill = "white")) + # removes the gridlines
  guides(fill = guide_legend(title = "Taxonomy", reverse = FALSE, keywidth = 1, keyheight = 1)) + # Plot the legend and change the title name to Taxonomy
  theme(legend.title = element_text(face = "bold", size =12), legend.title.align = 0.5) + # # adjusts the title of the legend
  ylab("Relative Abundance (%)") + # add the title on y axis
  xlab("Method")  + labs(fill = "Taxonomy") + guides(fill=guide_legend(ncol=1)) # add the title on x axis
hc_dataset_fam  

hc_dataset_fam <- ggarrange(hc_dataset_fam, legend = "right") + plot_annotation(title = 'B. hc Single Nematodes') & theme(plot.title = element_text(size=18))
ggsave("output/Figure-3A-taxonomy-barplots.png", width = 8, height = 7, dpi = 300,bg = "white")

#################################
######### FOR LC Dataset ########
#################################
lc_uclust_single_sample_abundant <- merge_samples_most_abundant(lc_uclust)
lc_uclust_single_sample_abundant$Method <- "UCLUST"

lc_vsearch_single_sample_abundant <- merge_samples_most_abundant(lc_vsearch)
lc_vsearch_single_sample_abundant$Method <- "VSearch"

lc_dada2_single_sample_abundant <- merge_samples_most_abundant(lc_dada2)
lc_dada2_single_sample_abundant$Method <- "DADA2"

lc_deblur_single_sample_abundant <- merge_samples_most_abundant(lc_deblur)
lc_deblur_single_sample_abundant$Method <- "Deblur"

lc_single_sample_merged_all <- rbind(lc_uclust_single_sample_abundant, lc_vsearch_single_sample_abundant, 
                                     lc_dada2_single_sample_abundant, lc_deblur_single_sample_abundant)
unique(lc_single_sample_merged_all$Rank7)

# download to manually edit taxonomy 
write_delim(x = lc_single_sample_merged_all, file = "output/lc-taxonomy-summary.txt", delim = "\t")
lc_taxonomy_fixed <- read_tsv("data/lc-dataset/lc-taxonomy-summary-fixed.txt")

# Plot graphic using ggplot2
lc_taxonomy_fixed$Rank7 <- forcats::fct_relevel(lc_taxonomy_fixed$Rank7, "Other", after = Inf)
lc_taxonomy_fixed$Method <- factor(lc_taxonomy_fixed$Method, c("UCLUST", "VSearch", "DADA2", "Deblur"))
lc_colors <- c("#377EB8", "#1B9E77", "#E7298A", "#FFFF99", "#DED3B3","grey")

lc_dataset_fam <- ggplot(lc_taxonomy_fixed, aes(x = Method, y = Abundance, fill = Rank7)) + #plotting by sample
  geom_bar(stat = "identity", width = 0.95) + # adds to 100%
  geom_text(aes(label = ifelse(round(Abundance*100) >= 3, paste(round(Abundance*100, digits = 0), "%"), "")), size = 5, position = position_stack(vjust = 0.5)) + # adds percetange label >3% and adjust the scale to 0-100%
  scale_fill_manual(values = lc_colors) +
  theme(axis.text.y = element_text(angle = 0, hjust = 1, size = 10, face = "bold")) + # adjusts text of y axis
  theme(axis.text.x = element_text(angle = 0, size = 10, face = "bold")) + # adjusts text of x axis and plot labels in a angle
  theme(axis.title.y = element_text(face = "bold", size = 12)) +  # adjusts the title of y axis
  theme(axis.title.x = element_text(face = "bold", size = 12)) + # adjusts the title of x axis
  scale_y_continuous(labels=scales::percent, expand = c(0.0, 0.0)) + # plot as % and remove the internal margins
  scale_x_discrete(expand = c(0.0, 0.0)) + # remove internal margins x-axis
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_rect(fill = "white")) + # removes the gridlines
  guides(fill = guide_legend(title = "Taxonomy", reverse = FALSE, keywidth = 1, keyheight = 1)) + # Plot the legend and change the title name to Taxonomy
  theme(legend.title = element_text(face = "bold", size =12), legend.title.align = 0.5) + # # adjusts the title of the legend
  ylab("Relative Abundance (%)") + # add the title on y axis
  xlab("Method")  + labs(fill = "Taxonomy") + guides(fill=guide_legend(ncol=1)) # add the title on x axis
lc_dataset_fam  

lc_dataset_fam <- ggarrange(lc_dataset_fam, legend = "right") + plot_annotation(title = 'B. LC Single Nematodes') & theme(plot.title = element_text(size=18))
ggsave("output/Figure-3B-taxonomy-barplots.png", width = 8, height = 7, dpi = 300,bg = "white")


