#################################
### FOR NPRB and MEMB Dataset ###
#################################

### Calculate Alpha Div for 3 Methods (DADA2, VSearch, UCLUST) ###
### Rarefy Data ###
MEMB_UCLUST_Filtered <- filter_families(MEMB_UCLUST)
MEMB_VSearch_Filtered <- filter_families(MEMB_VSearch)
MEMB_DADA2_Filtered <- filter_families(MEMB_DADA2)
MEMB_Deblur_Filtered <- filter_families(MEMB_Deblur)

NPRB_UCLUST_Rarefied <- rarefy_even_depth(NPRB_UCLUST, sample.size = 1000, rngseed = 150)
NPRB_VSearch_Rarefied <- rarefy_even_depth(NPRB_VSearch, sample.size = 1000, rngseed = 150)
NPRB_DADA2_Rarefied <- rarefy_even_depth(NPRB_DADA2, sample.size = 1000, rngseed = 150)
NPRB_Deblur_Rarefied <- rarefy_even_depth(NPRB_Deblur, sample.size = 1000, rngseed = 150)

MEMB_UCLUST_Rarefied <- rarefy_even_depth(MEMB_UCLUST_Filtered, sample.size = 1000, rngseed = 150)
MEMB_VSearch_Rarefied <- rarefy_even_depth(MEMB_VSearch_Filtered, sample.size = 1000, rngseed = 150)
MEMB_DADA2_Rarefied <- rarefy_even_depth(MEMB_DADA2_Filtered, sample.size = 1000, rngseed = 150)
MEMB_Deblur_Rarefied <- rarefy_even_depth(MEMB_Deblur_Filtered, sample.size = 1000, rngseed = 150)

##### Alpha Diversity Matrix (Shannon) - Rarefied #####
NPRB_UCLUST_Shannon <- plot_alpha_div(NPRB_UCLUST_Rarefied, div_measure = "Shannon", y = 7, color = "Subregion", dataset = "NPRB")
NPRB_VSearch_Shannon <- plot_alpha_div(NPRB_VSearch_Rarefied, div_measure = "Shannon", y = 7, color = "Subregion",dataset = "NPRB")
NPRB_DADA2_Shannon <- plot_alpha_div(NPRB_DADA2_Rarefied, div_measure = "Shannon", y = 7, color = "Subregion", dataset = "NPRB")
NPRB_Deblur_Shannon <- plot_alpha_div(NPRB_Deblur_Rarefied, div_measure = "Shannon", y =7, color = "Subregion", dataset = "NPRB")

MEMB_UCLUST_Shannon <- plot_alpha_div(MEMB_UCLUST_Rarefied, div_measure = "Shannon", y = 7, color = "NematodeFamily", dataset = "MEMB")
MEMB_VSearch_Shannon <- plot_alpha_div(MEMB_VSearch_Rarefied, div_measure = "Shannon", y = 7, color = "NematodeFamily", dataset = "MEMB")
MEMB_DADA2_Shannon <- plot_alpha_div(MEMB_DADA2_Rarefied, div_measure = "Shannon", y = 7, color = "NematodeFamily", dataset = "MEMB", Pairwise = T, pairwiseList = my_list_families)
MEMB_Deblur_Shannon <- plot_alpha_div(MEMB_Deblur_Rarefied, div_measure = "Shannon", y =7, color = "NematodeFamily", dataset = "MEMB")

##### Alpha Diversity Matrix (Simpson) - Rarefied #####
NPRB_UCLUST_Simpson <- plot_alpha_div(NPRB_UCLUST_Rarefied, div_measure = "Simpson", y = 2, color = "Subregion", dataset = "NPRB")
NPRB_VSearch_Simpson <- plot_alpha_div(NPRB_VSearch_Rarefied, div_measure = "Simpson", y = 2, color = "Subregion",dataset = "NPRB")
NPRB_DADA2_Simpson <- plot_alpha_div(NPRB_DADA2_Rarefied, div_measure = "Simpson", y = 2, color = "Subregion", dataset = "NPRB")
NPRB_Deblur_Simpson <- plot_alpha_div(NPRB_Deblur_Rarefied, div_measure = "Simpson", y = 2, color = "Subregion", dataset = "NPRB")

MEMB_UCLUST_Simpson <- plot_alpha_div(MEMB_UCLUST_Rarefied, div_measure = "Simpson", y = 2, color = "NematodeFamily", dataset = "MEMB")
MEMB_VSearch_Simpson <- plot_alpha_div(MEMB_VSearch_Rarefied, div_measure = "Simpson", y = 2, color = "NematodeFamily", dataset = "MEMB")
MEMB_DADA2_Simpson <- plot_alpha_div(MEMB_DADA2_Rarefied, div_measure = "Simpson", y = 2, color = "NematodeFamily", dataset = "MEMB", Pairwise = T, pairwiseList = my_list_families)
MEMB_Deblur_Simpson <- plot_alpha_div(MEMB_Deblur_Rarefied, div_measure = "Simpson", y = 2, color = "NematodeFamily", dataset = "MEMB")

#SimpsonAlphaDiv <- ((NPRB_UCLUST_Simpson | NPRB_VSearch_Simpson | NPRB_DADA2_Simpson | NPRB_Deblur_Simpson)) /
#  ((MEMB_UCLUST_Simpson | MEMB_VSearch_Simpson | MEMB_DADA2_Simpson | MEMB_Deblur_Simpson)) +
#  plot_layout(guides = "collect") + plot_annotation(tag_levels = c('A'), tag_suffix = '.') & theme(legend.position = "right")
#SimpsonAlphaDiv
#ggsave("qiime2-Results/NPRB/simpson_alphaDiv.tiff", width = 14, height = 8, dpi = 300)

#ShannonAlphaDiv <- ((NPRB_UCLUST_Shannon | NPRB_VSearch_Shannon | NPRB_DADA2_Shannon | NPRB_Deblur_Shannon)) /
#  ((MEMB_UCLUST_Shannon | MEMB_VSearch_Shannon | MEMB_DADA2_Shannon | MEMB_Deblur_Shannon)) +
#  plot_layout(guides = "collect") + plot_annotation(tag_levels = c('A'), tag_suffix = '.') & theme(legend.position = "right")
#ShannonAlphaDiv
#ggsave("qiime2-Results/NPRB/Shannon_alphaDiv.tiff", width = 14, height = 8, dpi = 300)

NPRB_AlphaDiv <- ((NPRB_UCLUST_Shannon | NPRB_VSearch_Shannon | NPRB_DADA2_Shannon | NPRB_Deblur_Shannon)) /
  ((NPRB_UCLUST_Simpson | NPRB_VSearch_Simpson | NPRB_DADA2_Simpson | NPRB_Deblur_Simpson)) +
  plot_layout(guides = "collect")  & theme(legend.position = "right")
NPRB_AlphaDiv
ggsave("qiime2-Results/NPRB/NPRB_alphaDiv.tiff", width = 14, height = 8, dpi = 300)

MEMB_AlphaDiv <- ((MEMB_UCLUST_Shannon | MEMB_VSearch_Shannon | MEMB_DADA2_Shannon | MEMB_Deblur_Shannon)) /
  ((MEMB_UCLUST_Simpson | MEMB_VSearch_Simpson | MEMB_DADA2_Simpson | MEMB_Deblur_Simpson)) +
  plot_layout(guides = "collect")  & theme(legend.position = "right")
MEMB_AlphaDiv
ggsave("qiime2-Results/MEMB/MEMB_alphaDiv.tiff", width = 14, height = 8, dpi = 300)

library(dplyr)
MEMB_Deblur_Simpson$data %>%
  group_by(FeedingGroup) %>% summarise(Median=median(value))
