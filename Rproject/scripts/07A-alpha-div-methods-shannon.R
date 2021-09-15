#################################
######### FOR HC Dataset ########
#################################
# shannon diversity
hc_uclust_shannon_measurement <- CalculateAlphaDiv(hc_uclust_rarefied, DivMeasurement = "Shannon", ClusteringMethod = "UCLUST")
hc_vsearch_shannon_measurement <- CalculateAlphaDiv(hc_vsearch_rarefied, DivMeasurement = "Shannon", ClusteringMethod = "VSearch")
hc_dada2_shannon_measurement <- CalculateAlphaDiv(hc_dada2_rarefied, DivMeasurement = "Shannon", ClusteringMethod = "DADA2")
hc_deblur_shannon_measurment <- CalculateAlphaDiv(hc_deblur_rarefied, DivMeasurement = "Shannon", ClusteringMethod = "Deblur")

AlaskanBeaufortShelf_shannon <- plot_alpha_div_methods(hc_uclust_shannon_measurement, hc_vsearch_shannon_measurement, hc_dada2_shannon_measurement, hc_deblur_shannon_measurment,
                                     10, Pairwise = "no", pairwiseList = pairwise_comparisons_methods, Ylabel = 9, variable = "AlaskanBeaufortShelf", data = "NPRB")

AmundsenGulf_shannon <- plot_alpha_div_methods(hc_uclust_shannon_measurement, hc_vsearch_shannon_measurement, hc_dada2_shannon_measurement, hc_deblur_shannon_measurment,
                             10, Pairwise = "yes", pairwiseList = pairwise_comparisons_methods, Ylabel = 9, variable = "AmundsenGulf", data = "NPRB")

BanksIsland_shannon <- plot_alpha_div_methods(hc_uclust_shannon_measurement, hc_vsearch_shannon_measurement, hc_dada2_shannon_measurement, hc_deblur_shannon_measurment,
                             10, Pairwise = "no", pairwiseList = pairwise_comparisons_methods, Ylabel = 9, variable = "BanksIsland", data = "NPRB")

CamdenBay_shannon <- plot_alpha_div_methods(hc_uclust_shannon_measurement, hc_vsearch_shannon_measurement, hc_dada2_shannon_measurement, hc_deblur_shannon_measurment,
                          10, Pairwise = "yes", pairwiseList = pairwise_comparisons_methods, Ylabel = 9, variable = "CamdenBay", data = "NPRB")

ChukchiSea_shannon <- plot_alpha_div_methods(hc_uclust_shannon_measurement, hc_vsearch_shannon_measurement, hc_dada2_shannon_measurement, hc_deblur_shannon_measurment,
                           10, Pairwise = "yes", pairwiseList = pairwise_comparisons_methods, Ylabel = 9, variable = "ChukchiSea", data = "NPRB")

MackenzieRiverPlume_shannon <- plot_alpha_div_methods(hc_uclust_shannon_measurement, hc_vsearch_shannon_measurement, hc_dada2_shannon_measurement, hc_deblur_shannon_measurment,
                                            10, Pairwise = "yes", pairwiseList = pairwise_comparisons_methods, Ylabel = 9, variable = "MackenzieRiverPlume", data = "NPRB")

# final plot and save
hc_dataset_shannon_methods <- ggarrange(AlaskanBeaufortShelf_shannon, AmundsenGulf_shannon, BanksIsland_shannon, CamdenBay_shannon, ChukchiSea_shannon, MackenzieRiverPlume_shannon,
                             common.legend = T, legend = "bottom", ncol = 3, nrow = 2, labels = c("Alaskan Beaufort Shelf", "Amundsen Gulf", 
                                                                                                  "Banks Island", "Camden Bay",
                                                                                                  "Chukchi Sea", "Mackenzie River Plume"),
                             hjust = 0, vjust = 0, label.x = 0.15, label.y = 0.035, font.label = list(size = 10)) +
  plot_annotation(title = 'A. HC Arctic Sediments') & theme(plot.title = element_text(size=18))
hc_dataset_shannon_methods
ggsave("output/Figure-5A-hc-shannon-alphaDiv-methods.tiff", width = 11.5, height = 8, dpi = 300, bg = "white")

#################################
######### FOR LC Dataset ########
#################################
# shannon diversity
lc_uclust_shannon_measurement <- CalculateAlphaDiv(lc_uclust_rarefied, DivMeasurement = "Shannon", ClusteringMethod = "UCLUST")
lc_vsearch_shannon_measurement <- CalculateAlphaDiv(lc_vsearch_rarefied, DivMeasurement = "Shannon", ClusteringMethod = "VSearch")
lc_dada2_shannon_measurement <- CalculateAlphaDiv(lc_dada2_rarefied, DivMeasurement = "Shannon", ClusteringMethod = "DADA2")
lc_deblur_shannon_measurement <- CalculateAlphaDiv(lc_deblur_rarefied, DivMeasurement = "Shannon", ClusteringMethod = "Deblur")

Chromadoridae_shannon <- plot_alpha_div_methods(lc_uclust_shannon_measurement, lc_vsearch_shannon_measurement, lc_dada2_shannon_measurement, lc_deblur_shannon_measurement,
                                      8, Pairwise = "yes", pairwiseList = pairwise_comparisons_methods, Ylabel = 7, variable = "Chromadoridae", data = "MEMB")

Comesomatidae_shannon <- plot_alpha_div_methods(lc_uclust_shannon_measurement, lc_vsearch_shannon_measurement, lc_dada2_shannon_measurement, lc_deblur_shannon_measurement,
                                        8, Pairwise = "yes", pairwiseList = pairwise_comparisons_methods, Ylabel = 7, variable = "Comesomatidae", data = "MEMB")

Desmoscolecidae_shannon <- plot_alpha_div_methods(lc_uclust_shannon_measurement, lc_vsearch_shannon_measurement, lc_dada2_shannon_measurement, lc_deblur_shannon_measurement,
                                          8, Pairwise = "yes", pairwiseList = pairwise_comparisons_methods, Ylabel = 7, variable = "Desmoscolecidae", data = "MEMB")

Oxystominidae_shannon <- plot_alpha_div_methods(lc_uclust_shannon_measurement, lc_vsearch_shannon_measurement, lc_dada2_shannon_measurement, lc_deblur_shannon_measurement,
                                        8, Pairwise = "yes", pairwiseList = pairwise_comparisons_methods, Ylabel = 7, variable = "Oxystominidae", data = "MEMB")

# final plot and save
lc_dataset_shannon_methods<- ggarrange(Chromadoridae_shannon, Comesomatidae_shannon, Desmoscolecidae_shannon, Oxystominidae_shannon, 
          common.legend = T, ncol = 2, nrow = 2, labels = c("Chromadoridae", "Comesomatidae", 
                                                            "Desmoscolecidae", "Oxystominidae"),
          hjust = 0, vjust = 0, label.x = 0.075, label.y = 0.035, font.label = list(size = 10), legend = "bottom") +
  plot_annotation(title = 'B. LC Single Nematodes') & theme(plot.title = element_text(size=18))
lc_dataset_shannon_methods
ggsave("output/Figure-5B-lc-shannon-alphaDiv-methods.tiff", width = 11.5, height = 8, dpi = 300, bg = "white")








