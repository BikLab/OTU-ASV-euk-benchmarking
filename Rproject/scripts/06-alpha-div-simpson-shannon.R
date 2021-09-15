#################################
######### FOR HC Dataset ########
#################################
# calculate alpha diversity for all methods
# rarefy data
hc_uclust_rarefied <- rarefy_even_depth(hc_uclust, sample.size = 1000, rngseed = 150)
hc_vsearch_rarefied <- rarefy_even_depth(hc_vsearch, sample.size = 1000, rngseed = 150)
hc_dada2_rarefied <- rarefy_even_depth(hc_dada2, sample.size = 1000, rngseed = 150)
hc_deblur_rarefied <- rarefy_even_depth(hc_deblur, sample.size = 1000, rngseed = 150)

# shannon diversity index
hc_uclust_shannon <- plot_alpha_div(hc_uclust_rarefied, div_measure = "Shannon", y = 7, color = "Subregion", dataset = "NPRB", ylabel = 6.5)
hc_vsearch_shannon <- plot_alpha_div(hc_vsearch_rarefied, div_measure = "Shannon", y = 7, color = "Subregion",dataset = "NPRB", ylabel = 6.5)
hc_dada2_shannon <- plot_alpha_div(hc_dada2_rarefied, div_measure = "Shannon", y = 7, color = "Subregion", dataset = "NPRB", ylabel = 6.5)
hc_deblur_shannon <- plot_alpha_div(hc_deblur_rarefied, div_measure = "Shannon", y =7, color = "Subregion", dataset = "NPRB", ylabel = 6.5)

# simpson diversity index
hc_uclust_simpson <- plot_alpha_div(hc_uclust_rarefied, div_measure = "Simpson", y = 2, color = "Subregion", dataset = "NPRB", ylabel = 1.85)
hc_vsearch_simpson <- plot_alpha_div(hc_vsearch_rarefied, div_measure = "Simpson", y = 2, color = "Subregion",dataset = "NPRB", ylabel = 1.85)
hc_dada2_simpson <- plot_alpha_div(hc_dada2_rarefied, div_measure = "Simpson", y = 2, color = "Subregion", dataset = "NPRB", ylabel = 1.85)
hc_deblur_simpson <- plot_alpha_div(hc_deblur_rarefied, div_measure = "Simpson", y = 2, color = "Subregion", dataset = "NPRB", ylabel = 1.85)

# save plot 
hc_dataset_alpha_div <- ((hc_uclust_shannon | hc_vsearch_shannon | hc_dada2_shannon | hc_deblur_shannon)) /
  ((hc_uclust_simpson | hc_vsearch_simpson | hc_dada2_simpson | hc_deblur_simpson)) +
  plot_layout(guides = "collect")  & theme(legend.position = "right")
hc_dataset_alpha_div
ggsave("output/Figure-S4A-hc-alpha-div-metrics.tiff", width = 14, height = 8, dpi = 300)

#################################
######### FOR LC Dataset ########
#################################
# calculate alpha diversity for all methods
# rarefy data
lc_uclust_rarefied <- rarefy_even_depth(lc_uclust_family, sample.size = 1000, rngseed = 150)
lc_vsearch_rarefied <- rarefy_even_depth(lc_vsearch_family, sample.size = 1000, rngseed = 150)
lc_dada2_rarefied <- rarefy_even_depth(lc_dada2_family, sample.size = 1000, rngseed = 150)
lc_deblur_rarefied <- rarefy_even_depth(lc_deblur_family, sample.size = 1000, rngseed = 150)

# shannon diversity index
lc_uclust_shannon <- plot_alpha_div(lc_uclust_rarefied, div_measure = "Shannon", y = 7, color = "NematodeFamily", dataset = "MEMB", ylabel = 6.5) +
  guides(fill=guide_legend(title="Nematode Family"))
lc_vsearch_shannon <- plot_alpha_div(lc_vsearch_rarefied, div_measure = "Shannon", y = 7, color = "NematodeFamily", dataset = "MEMB", ylabel = 6.5) +
  guides(fill=guide_legend(title="Nematode Family"))
lc_dada2_shannon <- plot_alpha_div(lc_dada2_rarefied, div_measure = "Shannon", y = 7, color = "NematodeFamily", dataset = "MEMB",ylabel = 6.5, Pairwise = T, pairwiseList = pairwise_comparisons_families) +
  guides(fill=guide_legend(title="Nematode Family"))
lc_deblur_shannon <- plot_alpha_div(lc_deblur_rarefied, div_measure = "Shannon", y =7, color = "NematodeFamily", dataset = "MEMB", ylabel = 6.5) +
  guides(fill=guide_legend(title="Nematode Family"))

# simpson diversity index
lc_uclust_simpson <- plot_alpha_div(lc_uclust_rarefied, div_measure = "Simpson", y = 2, color = "NematodeFamily", dataset = "MEMB", ylabel = 1.85) +
  guides(fill=guide_legend(title="Nematode Family"))
lc_vsearch_simpson <- plot_alpha_div(lc_vsearch_rarefied, div_measure = "Simpson", y = 2, color = "NematodeFamily", dataset = "MEMB", ylabel = 1.85) +
  guides(fill=guide_legend(title="Nematode Family"))
lc_dada2_simpson <- plot_alpha_div(lc_dada2_rarefied, div_measure = "Simpson", y = 2, color = "NematodeFamily", dataset = "MEMB", ylabel = 1.85, Pairwise = T, pairwiseList = pairwise_comparisons_families) +
  guides(fill=guide_legend(title="Nematode Family"))
lc_deblur_simpson <- plot_alpha_div(lc_deblur_rarefied, div_measure = "Simpson", y = 2, color = "NematodeFamily", dataset = "MEMB", ylabel = 1.85) +
  guides(fill=guide_legend(title="Nematode Family"))

# save plot 
lc_dataset_alpha_div <- (( lc_uclust_shannon | lc_vsearch_shannon | lc_dada2_shannon | lc_deblur_shannon)) /
  ((lc_uclust_simpson | lc_vsearch_simpson | lc_dada2_simpson | lc_deblur_simpson)) +
  plot_layout(guides = "collect")  & theme(legend.position = "right")
lc_dataset_alpha_div
ggsave("output/Figure-S4B-lc-alpha-div-metrics.tiff", width = 14, height = 8, dpi = 300)

# to get median value: 
# MEMB_Deblur_Simpson$data %>%
#  group_by(FeedingGroup) %>% summarise(Median=median(value))
