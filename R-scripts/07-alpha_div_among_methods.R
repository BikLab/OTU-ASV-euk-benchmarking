#################################
### FOR NPRB and MEMB Dataset ###
#################################

##### Alpha Diversity Matrix (NPRB) #####
NPRB_UCLUST_AlphaDiv <- CalculateAlphaDiv(NPRB_UCLUST_Rarefied, DivMeasurement = "Simpson", ClusteringMethod = "UCLUST")
NPRB_VSearch_AlphaDiv <- CalculateAlphaDiv(NPRB_VSearch_Rarefied, DivMeasurement = "Simpson", ClusteringMethod = "VSearch")
NPRB_DADA2_AlphaDiv <- CalculateAlphaDiv(NPRB_DADA2_Rarefied, DivMeasurement = "Simpson", ClusteringMethod = "DADA2")
NPRB_Deblur_AlphaDiv <- CalculateAlphaDiv(NPRB_Deblur_Rarefied, DivMeasurement = "Simpson", ClusteringMethod = "Deblur")

AlaskanBeaufortShelf <- RbindSubregions(NPRB_UCLUST_AlphaDiv, NPRB_VSearch_AlphaDiv, NPRB_DADA2_AlphaDiv, NPRB_Deblur_AlphaDiv, Variable = "AlaskanBeaufortShelf")
AlaskanBeaufortShelf$Method <- factor(AlaskanBeaufortShelf$Method, c("UCLUST", "VSearch", "DADA2", "Deblur"))
plotAlaskanBeaufortShelf <- ggplotSigFig(AlaskanBeaufortShelf, 2, Pairwise = "no")

AmundsenGulf <- RbindSubregions(NPRB_UCLUST_AlphaDiv, NPRB_VSearch_AlphaDiv, NPRB_DADA2_AlphaDiv, NPRB_Deblur_AlphaDiv, Variable = "AmundsenGulf")
AmundsenGulf$Method <- factor(AmundsenGulf$Method, c("UCLUST", "VSearch", "DADA2", "Deblur"))
plotAmundsenGulf <- ggplotSigFig(AmundsenGulf, 2, Pairwise = "yes", pairwiseList = my_list_method)

BanksIsland <- RbindSubregions(NPRB_UCLUST_AlphaDiv, NPRB_VSearch_AlphaDiv, NPRB_DADA2_AlphaDiv, NPRB_Deblur_AlphaDiv, Variable = "BanksIsland")
BanksIsland$Method <- factor(BanksIsland$Method, c("UCLUST", "VSearch", "DADA2", "Deblur"))
plotBanksIsland <- ggplotSigFig(BanksIsland, 2, Pairwise = "no")

MackenzieRiverPlume <- RbindSubregions(NPRB_UCLUST_AlphaDiv, NPRB_VSearch_AlphaDiv, NPRB_DADA2_AlphaDiv, NPRB_Deblur_AlphaDiv, Variable = "MackenzieRiverPlume")
MackenzieRiverPlume$Method <- factor(MackenzieRiverPlume$Method, c("UCLUST", "VSearch", "DADA2", "Deblur"))
plotMackenzieRiverPlume <- ggplotSigFig(MackenzieRiverPlume, 2, Pairwise = "yes", pairwiseList = my_list_method)

CamdenBay <- RbindSubregions(NPRB_UCLUST_AlphaDiv, NPRB_VSearch_AlphaDiv, NPRB_DADA2_AlphaDiv, NPRB_Deblur_AlphaDiv, Variable = "CamdenBay")
CamdenBay$Method <- factor(CamdenBay$Method, c("UCLUST", "VSearch", "DADA2", "Deblur"))
plotCamdenBay <- ggplotSigFig(CamdenBay, 2, Pairwise = "no")

ChukchiSea <- RbindSubregions(NPRB_UCLUST_AlphaDiv, NPRB_VSearch_AlphaDiv, NPRB_DADA2_AlphaDiv, NPRB_Deblur_AlphaDiv, Variable = "ChukchiSea")
ChukchiSea$Method <- factor(ChukchiSea$Method, c("UCLUST", "VSearch", "DADA2", "Deblur"))
plotChukchiSea <- ggplotSigFig(ChukchiSea, 2, Pairwise = "yes", pairwiseList = my_list_method)

AlphaDivMethods <- ggarrange(plotAlaskanBeaufortShelf, plotAmundsenGulf, plotBanksIsland, plotCamdenBay, plotChukchiSea, plotMackenzieRiverPlume,
          common.legend = T, ncol = 3, nrow = 2, labels = c("A. Alaskan Beaufort Shelf", "B. Amundsen Gulf", 
                                                            "C. Banks Island", "D. Camden Bay",
                                                            "E. Chukchi Sea", "F. Mackenzie River Plume"),
          hjust = 0, vjust = 0, label.x = 0.15, label.y = 0.05, font.label = list(size = 10))
ggsave("qiime2-Results/NPRB/NPRB_simpson_alphaDiv_methods.tiff", width = 11.5, height = 8, dpi = 300)

##### Alpha Diversity Matrix (MEMB) #####
MEMB_UCLUST_AlphaDiv <- CalculateAlphaDiv(MEMB_UCLUST_Rarefied, DivMeasurement = "Simpson", ClusteringMethod = "UCLUST")
MEMB_VSearch_AlphaDiv <- CalculateAlphaDiv(MEMB_VSearch_Rarefied, DivMeasurement = "Simpson", ClusteringMethod = "VSearch")
MEMB_DADA2_AlphaDiv <- CalculateAlphaDiv(MEMB_DADA2_Rarefied, DivMeasurement = "Simpson", ClusteringMethod = "DADA2")
MEMB_Deblur_AlphaDiv <- CalculateAlphaDiv(MEMB_Deblur_Rarefied, DivMeasurement = "Simpson", ClusteringMethod = "Deblur")

#Feeding1A <- RbindSubregions(MEMB_UCLUST_AlphaDiv, MEMB_VSearch_AlphaDiv, MEMB_DADA2_AlphaDiv, MEMB_Deblur_AlphaDiv, Variable = "1A", dataset = "MEMB")
#Feeding1A$Method <- factor(Feeding1A$Method, c("UCLUST", "VSearch", "DADA2", "Deblur"))
#plotFeeding1A <- ggplotSigFig(Feeding1A, 9, Pairwise = "yes")

#Feeding1B <- RbindSubregions(MEMB_UCLUST_AlphaDiv, MEMB_VSearch_AlphaDiv, MEMB_DADA2_AlphaDiv, MEMB_Deblur_AlphaDiv, Variable = "1B", dataset = "MEMB")
#Feeding1B$Method <- factor(Feeding1B$Method, c("UCLUST", "VSearch", "DADA2", "Deblur"))
#plotFeeding1B <- ggplotSigFig(Feeding1B, 9, Pairwise = "yes")

#Feeding2A <- RbindSubregions(MEMB_UCLUST_AlphaDiv, MEMB_VSearch_AlphaDiv, MEMB_DADA2_AlphaDiv, MEMB_Deblur_AlphaDiv, Variable = "2A", dataset = "MEMB")
#Feeding2A$Method <- factor(Feeding2A$Method, c("UCLUST", "VSearch", "DADA2", "Deblur"))
#plotFeeding2A <- ggplotSigFig(Feeding2A, 9, Pairwise = "yes")

#Feeding2B <- RbindSubregions(MEMB_UCLUST_AlphaDiv, MEMB_VSearch_AlphaDiv, MEMB_DADA2_AlphaDiv, MEMB_Deblur_AlphaDiv, Variable = "2B", dataset = "MEMB")
#Feeding2B$Method <- factor(Feeding2B$Method, c("UCLUST", "VSearch", "DADA2", "Deblur"))
#plotFeeding2B <- ggplotSigFig(Feeding2B, 9, Pairwise = "yes")


newBiom = subset_samples(biom, NematodeFamily %in% c("Chromadoridae", "Comesomatidae", "Desmoscolecidae", "Oxystominidae"))

Chromadoridae <- RbindSubregions(MEMB_UCLUST_AlphaDiv, MEMB_VSearch_AlphaDiv, MEMB_DADA2_AlphaDiv, MEMB_Deblur_AlphaDiv, Variable = "Chromadoridae", dataset = "MEMB")
Chromadoridae$Method <- factor(Chromadoridae$Method, c("UCLUST", "VSearch", "DADA2", "Deblur"))
plotChromadoridae <- ggplotSigFig(Chromadoridae, 2, Pairwise = "yes", pairwiseList = my_list_method)

Comesomatidae <- RbindSubregions(MEMB_UCLUST_AlphaDiv, MEMB_VSearch_AlphaDiv, MEMB_DADA2_AlphaDiv, MEMB_Deblur_AlphaDiv, Variable = "Comesomatidae", dataset = "MEMB")
Comesomatidae$Method <- factor(Comesomatidae$Method, c("UCLUST", "VSearch", "DADA2", "Deblur"))
plotComesomatidae <- ggplotSigFig(Comesomatidae, 2, Pairwise = "yes", pairwiseList = my_list_method)

Desmoscolecidae <- RbindSubregions(MEMB_UCLUST_AlphaDiv, MEMB_VSearch_AlphaDiv, MEMB_DADA2_AlphaDiv, MEMB_Deblur_AlphaDiv, Variable = "Desmoscolecidae", dataset = "MEMB")
Desmoscolecidae$Method <- factor(Desmoscolecidae$Method, c("UCLUST", "VSearch", "DADA2", "Deblur"))
plotDesmoscolecidae <- ggplotSigFig(Desmoscolecidae, 3, Pairwise = "yes", pairwiseList = my_list_method)

Oxystominidae <- RbindSubregions(MEMB_UCLUST_AlphaDiv, MEMB_VSearch_AlphaDiv, MEMB_DADA2_AlphaDiv, MEMB_Deblur_AlphaDiv, Variable = "Oxystominidae", dataset = "MEMB")
Oxystominidae$Method <- factor(Oxystominidae$Method, c("UCLUST", "VSearch", "DADA2", "Deblur"))
plotOxystominidae <- ggplotSigFig(Oxystominidae, 3, Pairwise = "yes", pairwiseList = my_list_method)

ggarrange(plotChromadoridae, plotComesomatidae, plotDesmoscolecidae, plotOxystominidae, 
          common.legend = T, ncol = 2, nrow = 2, labels = c("G. Chromadoridae", "H. Comesomatidae", 
                                                            "I. Desmoscolecidae", "J. Oxystominidae"),
          hjust = 0, vjust = 0, label.x = 0.15, label.y = 0.05, font.label = list(size = 10))
ggsave("qiime2-Results/NPRB/shannon_alphaDiv_methods_memb.tiff", width = 11.5, height = 8, dpi = 300)




