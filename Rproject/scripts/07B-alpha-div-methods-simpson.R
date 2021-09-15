#################################
######### FOR HC Dataset ########
#################################
# simpson diversity
hc_uclust_simpson_measurement <- CalculateAlphaDiv(hc_uclust_rarefied, DivMeasurement = "Simpson", ClusteringMethod = "UCLUST")
hc_vsearch_simpson_measurement <- CalculateAlphaDiv(hc_vsearch_rarefied, DivMeasurement = "Simpson", ClusteringMethod = "VSearch")
hc_dada2_simpson_measurement <- CalculateAlphaDiv(hc_dada2_rarefied, DivMeasurement = "Simpson", ClusteringMethod = "DADA2")
hc_deblur_simpson_measurment <- CalculateAlphaDiv(hc_deblur_rarefied, DivMeasurement = "Simpson", ClusteringMethod = "Deblur")

AlaskanBeaufortShelf_simpson <- plot_alpha_div_methods(hc_uclust_simpson_measurement, hc_vsearch_simpson_measurement, hc_dada2_simpson_measurement, hc_deblur_simpson_measurment,
                                                       2, Pairwise = "no", pairwiseList = pairwise_comparisons_methods, Ylabel = 1.75, variable = "AlaskanBeaufortShelf", data = "NPRB")

AmundsenGulf_simpson <- plot_alpha_div_methods(hc_uclust_simpson_measurement, hc_vsearch_simpson_measurement, hc_dada2_simpson_measurement, hc_deblur_simpson_measurment,
                                               2, Pairwise = "yes", pairwiseList = pairwise_comparisons_methods, Ylabel = 1.75, variable = "AmundsenGulf", data = "NPRB")

BanksIsland_simpson <- plot_alpha_div_methods(hc_uclust_simpson_measurement, hc_vsearch_simpson_measurement, hc_dada2_simpson_measurement, hc_deblur_simpson_measurment,
                                              2, Pairwise = "no", pairwiseList = pairwise_comparisons_methods, Ylabel = 1.75, variable = "BanksIsland", data = "NPRB")

CamdenBay_simpson <- plot_alpha_div_methods(hc_uclust_simpson_measurement, hc_vsearch_simpson_measurement, hc_dada2_simpson_measurement, hc_deblur_simpson_measurment,
                                            2, Pairwise = "no", pairwiseList = pairwise_comparisons_methods, Ylabel = 1.75, variable = "CamdenBay", data = "NPRB")

ChukchiSea_simpson <- plot_alpha_div_methods(hc_uclust_simpson_measurement, hc_vsearch_simpson_measurement, hc_dada2_simpson_measurement, hc_deblur_simpson_measurment,
                                             2, Pairwise = "yes", pairwiseList = pairwise_comparisons_methods, Ylabel = 1.75, variable = "ChukchiSea", data = "NPRB")

MackenzieRiverPlume_simpson <- plot_alpha_div_methods(hc_uclust_simpson_measurement, hc_vsearch_simpson_measurement, hc_dada2_simpson_measurement, hc_deblur_simpson_measurment,
                                                      2, Pairwise = "yes", pairwiseList = pairwise_comparisons_methods, Ylabel = 1.75, variable = "MackenzieRiverPlume", data = "NPRB")

# final plot and save
hc_dataset_simpson_methods <- ggarrange(AlaskanBeaufortShelf_simpson, AmundsenGulf_simpson, BanksIsland_simpson, CamdenBay_simpson, ChukchiSea_simpson, MackenzieRiverPlume_simpson,
                                        common.legend = T, legend = "bottom", ncol = 3, nrow = 2, labels = c("Alaskan Beaufort Shelf", "Amundsen Gulf", 
                                                                                                             "Banks Island", "Camden Bay",
                                                                                                             "Chukchi Sea", "Mackenzie River Plume"),
                                        hjust = 0, vjust = 0, label.x = 0.15, label.y = 0.035, font.label = list(size = 10)) +
  plot_annotation(title = 'A. HC Arctic Sediments') & theme(plot.title = element_text(size=18))
hc_dataset_simpson_methods
ggsave("output/Figure-6A-hc-simpson-alphaDiv-methods.tiff", width = 11.5, height = 8, dpi = 300, bg = "white")

#################################
######### FOR LC Dataset ########
#################################
# simpson diversity
lc_uclust_simpson_measurement <- CalculateAlphaDiv(lc_uclust_rarefied, DivMeasurement = "Simpson", ClusteringMethod = "UCLUST")
lc_vsearch_simpson_measurement <- CalculateAlphaDiv(lc_vsearch_rarefied, DivMeasurement = "Simpson", ClusteringMethod = "VSearch")
lc_dada2_simpson_measurement <- CalculateAlphaDiv(lc_dada2_rarefied, DivMeasurement = "Simpson", ClusteringMethod = "DADA2")
lc_deblur_simpson_measurement <- CalculateAlphaDiv(lc_deblur_rarefied, DivMeasurement = "Simpson", ClusteringMethod = "Deblur")

Chromadoridae_simpson <- plot_alpha_div_methods(lc_uclust_simpson_measurement, lc_vsearch_simpson_measurement, lc_dada2_simpson_measurement, lc_deblur_simpson_measurement,
                                                2, Pairwise = "yes", pairwiseList = pairwise_comparisons_methods, Ylabel = 1.75, variable = "Chromadoridae", data = "MEMB")

Comesomatidae_simpson <- plot_alpha_div_methods(lc_uclust_simpson_measurement, lc_vsearch_simpson_measurement, lc_dada2_simpson_measurement, lc_deblur_simpson_measurement,
                                                2, Pairwise = "yes", pairwiseList = pairwise_comparisons_methods, Ylabel = 1.75, variable = "Comesomatidae", data = "MEMB")

Desmoscolecidae_simpson <- plot_alpha_div_methods(lc_uclust_simpson_measurement, lc_vsearch_simpson_measurement, lc_dada2_simpson_measurement, lc_deblur_simpson_measurement,
                                                  2, Pairwise = "yes", pairwiseList = pairwise_comparisons_methods, Ylabel = 1.75, variable = "Desmoscolecidae", data = "MEMB")

Oxystominidae_simpson <- plot_alpha_div_methods(lc_uclust_simpson_measurement, lc_vsearch_simpson_measurement, lc_dada2_simpson_measurement, lc_deblur_simpson_measurement,
                                                2, Pairwise = "yes", pairwiseList = pairwise_comparisons_methods, Ylabel = 1.75, variable = "Oxystominidae", data = "MEMB")

# final plot and save
lc_dataset_simpson_methods<- ggarrange(Chromadoridae_simpson, Comesomatidae_simpson, Desmoscolecidae_simpson, Oxystominidae_simpson, 
                                       common.legend = T, ncol = 2, nrow = 2, labels = c("Chromadoridae", "Comesomatidae", 
                                                                                         "Desmoscolecidae", "Oxystominidae"),
                                       hjust = 0, vjust = 0, label.x = 0.075, label.y = 0.035, font.label = list(size = 10), legend = "bottom") +
  plot_annotation(title = 'B. LC Single Nematodes') & theme(plot.title = element_text(size=18))
lc_dataset_simpson_methods
ggsave("output/Figure-6B-lc-simpson-alphaDiv-methods.tiff", width = 11.5, height = 8, dpi = 300, bg = "white")








