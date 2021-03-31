#################################
### FOR MEMB and MEMB Dataset ###
#################################

#### Normalize Data and Ordinate for VSearch ####
#VSearch_Rarefied <- rarefy_even_depth(MEMB_VSearch_Filtered, sample.size = 1000, replace = FALSE, rngseed = TRUE)
#Rarefied_MEMB_VSearch_Phylo_Filtered <- transform_sample_counts(MEMB_VSearch_Rarefied, function(x) x/sum(x))

VSearch_Bray <- ordinate(NPRB_VSearch_Rarefied, "PCoA", "bray")
VSearch_UFrac  <- ordinate(NPRB_VSearch_Rarefied, "PCoA", "unifrac")
VSearch_WUFrac  <- ordinate(NPRB_VSearch_Rarefied, "PCoA", "wunifrac")

#### Normalize Data and Ordinate for UCLUST ####
#UCLUST_Rarefied <- rarefy_even_depth(MEMB_UCLUST_Filtered, sample.size = 500, replace = FALSE, rngseed = TRUE)
#Rarefied_MEMB_UCLUST_Phylo_Filtered <- transform_sample_counts(MEMB_UCLUST_Phylo, function(x) x/sum(x))

UCLUST_Bray <- ordinate(NPRB_UCLUST_Rarefied, "PCoA", "bray")
UCLUST_UFrac  <- ordinate(NPRB_UCLUST_Rarefied, "PCoA", "unifrac")
UCLUST_WUFrac  <- ordinate(NPRB_UCLUST_Rarefied, "PCoA", "wunifrac")

#### Normalize Data and Ordinate for DADA2 #### 
#DADA2_Rarefied <- rarefy_even_depth(MEMB_DADA2_Filtered, sample.size = 500, replace = FALSE, rngseed = TRUE)
#Rarefied_MEMB_DADA2_Phylo_Filtered <- transform_sample_counts(MEMB_DADA2_Phylo, function(x) x/sum(x) )

DADA2_Bray <- ordinate(NPRB_DADA2_Rarefied, "PCoA", "bray")
DADA2_UFrac  <- ordinate(NPRB_DADA2_Rarefied, "PCoA", "unifrac")
DADA2_WUFrac  <- ordinate(NPRB_DADA2_Rarefied, "PCoA", "wunifrac")

#### Normalize Data and Ordinate for Deblur ####
#Deblur_Rarefied <- rarefy_even_depth(MEMB_Deblur_Filtered, sample.size = 500, replace = FALSE, rngseed = TRUE)
#Rarefied_MEMB_Deblur_Phylo_Filtered <- transform_sample_counts(MEMB_Deblur_Phylo, function(x) x/sum(x) )

Deblur_Bray <- ordinate(NPRB_Deblur_Rarefied, "PCoA", "bray")
Deblur_UFrac  <- ordinate(NPRB_Deblur_Rarefied, "PCoA", "unifrac")
Deblur_WUFrac  <- ordinate(NPRB_Deblur_Rarefied, "PCoA", "wunifrac")

### Plot Ordination and use GGArrange to make into Figure ###

plot_VSearch_Bray <- beta_div_plot(NPRB_VSearch_Rarefied, VSearch_Bray, colors = "Subregion", dataset = "NPRB", title = "VSearch - Bray-Curtis")
plot_VSearch_UFrac <- beta_div_plot(NPRB_VSearch_Rarefied, VSearch_UFrac, colors = "Subregion", dataset = "NPRB", title = "VSearch - Unweighted Unifrac")
plot_VSearch_WUFrac <- beta_div_plot(NPRB_VSearch_Rarefied, VSearch_WUFrac, colors = "Subregion", dataset = "NPRB", title = "VSearch - Weighted Unifrac")

plot_UCLUST_Bray <- beta_div_plot(NPRB_UCLUST_Rarefied, UCLUST_Bray, colors = "Subregion", dataset = "NPRB", title = "UCLUST - Bray-Curtis")
plot_UCLUST_UFrac <- beta_div_plot(NPRB_UCLUST_Rarefied, UCLUST_UFrac, colors = "Subregion", dataset = "NPRB", title = "UCLUST - Unweighted Unifrac")
plot_UCLUST_WUFrac <- beta_div_plot(NPRB_UCLUST_Rarefied, UCLUST_WUFrac, colors = "Subregion", dataset = "NPRB", title = "UCLUST - Weighted Unifrac")

plot_DADA2_Bray <- beta_div_plot(NPRB_DADA2_Rarefied, DADA2_Bray, colors = "Subregion", dataset = "NPRB", title = "DADA2 - Bray-Curtis")
plot_DADA2_UFrac <- beta_div_plot(NPRB_DADA2_Rarefied, DADA2_UFrac, colors = "Subregion", dataset = "NPRB", title = "DADA2 - Unweighted Unifrac")
plot_DADA2_WUFrac <- beta_div_plot(NPRB_DADA2_Rarefied, DADA2_WUFrac, colors = "Subregion", dataset = "NPRB", title = "DADA2 - Weighted Unifrac")

plot_Deblur_Bray <- beta_div_plot(NPRB_Deblur_Rarefied, Deblur_Bray, colors = "Subregion", dataset = "NPRB", title = "Deblur - Bray-Curtis")
plot_Deblur_UFrac <- beta_div_plot(NPRB_Deblur_Rarefied, Deblur_UFrac, colors = "Subregion", dataset = "NPRB", title = "Deblur - Unweighted Unifrac")
plot_Deblur_WUFrac <- beta_div_plot(NPRB_Deblur_Rarefied, Deblur_WUFrac, colors = "Subregion", dataset = "NPRB", title = "Deblur - Weighted Unifrac")

BetaDiv_Plot <- ggarrange(plot_UCLUST_Bray, plot_VSearch_Bray, plot_DADA2_Bray, plot_Deblur_Bray, 
                          plot_UCLUST_UFrac, plot_VSearch_UFrac, plot_DADA2_UFrac, plot_Deblur_UFrac,
                          plot_UCLUST_WUFrac, plot_VSearch_WUFrac, plot_DADA2_WUFrac, plot_Deblur_WUFrac,
                          common.legend = TRUE, legend = "bottom")
BetaDiv_Plot
ggsave("qiime2-Results/NPRB/NPRB_betaDiv_Rarefied.tiff", BetaDiv_Plot, width = 11.5, height = 8, dpi = 300)


