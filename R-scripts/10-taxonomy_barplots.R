library(forcats)
library(RColorBrewer)
single_sample <- function(df) {
  merged_samples <- merge_samples(df, "merge")
  transform_samples  <- transform_sample_counts(merged_samples, function(x) x / sum(x) )
  #filter_samples <- filter_taxa(transform_samples, function(x) mean(x) > 0, TRUE)
  ##### MEMB: Rank 10
  ##### NPRB: Rank 6
  taxonomy_rank <-tax_glom(transform_samples, taxrank="Rank10")
  top10 <- names(sort(taxa_sums(taxonomy_rank), TRUE)[1:10])
  top10OTU <- prune_taxa(top10, taxonomy_rank)
  dataframe_sample <- as.data.frame(psmelt(top10OTU))
  return(dataframe_sample)
}


UCLUST_sample <- single_sample(MEMB_UCLUST)
UCLUST_sample$Method <- "UCLUST"

VSearch_sample <- single_sample(MEMB_VSearch)
VSearch_sample$Method <- "VSearch"

DADA2_sample <- single_sample(MEMB_DADA2)
DADA2_sample$Method <- "DADA2"

Deblur_sample <- single_sample(MEMB_Deblur)
Deblur_sample$Method <- "Deblur"

single_sample <- rbind(UCLUST_sample, VSearch_sample, DADA2_sample, Deblur_sample)


#Download to fix strings 
#Reupload for visualization
library(RColorBrewer)
library(tidyMicro); library(magrittr)
edited_single_sample <- read.csv("/Users/alejandro/Downloads/edited-2021-03-09.csv")
edited_single_sample$Rank10 <- forcats::fct_relevel(edited_single_sample$Rank10, "Other", after = Inf)
colourCount = length(unique(edited_single_sample$Rank10))
edited_single_sample$Method <- factor(edited_single_sample$Method, c("UCLUST", "VSearch", "DADA2", "Deblur"))

taxonomy_barplot <- ggplot(data=edited_single_sample, aes(x=Method, y=Abundance, fill=Rank10)) +
  geom_bar(stat="identity") + theme_minimal() +
  scale_fill_manual(values = colorRampPalette(brewer.pal(15, "Paired"))(colourCount))
taxonomy_barplot
ggsave("qiime2-Results/MEMB/MEMB_all_samples_taxonomy.tiff", width = 11.5, height = 8, dpi = 300)

#####################
###### NPRB ########
#####################

UCLUST_sample <- single_sample(NPRB_UCLUST)
UCLUST_sample$Method <- "UCLUST"

VSearch_sample <- single_sample(NPRB_VSearch)
VSearch_sample$Method <- "VSearch"

DADA2_sample <- single_sample(NPRB_DADA2)
DADA2_sample$Method <- "DADA2"

Deblur_sample <- single_sample(NPRB_Deblur)
Deblur_sample$Method <- "Deblur"

single_sample <- rbind(UCLUST_sample, VSearch_sample, DADA2_sample, Deblur_sample)
#Download to fix strings 
#Reupload for visualization
edited_single_sample <- read.csv("/Users/alejandro/Downloads/edited-2021-03-30.csv")
edited_single_sample$Rank10 <- forcats::fct_relevel(edited_single_sample$Rank10, "Other", after = Inf)
colourCount = length(unique(edited_single_sample$Rank10))
edited_single_sample$Method <- factor(edited_single_sample$Method, c("UCLUST", "VSearch", "DADA2", "Deblur"))

taxonomy_barplot <- ggplot(data=edited_single_sample, aes(x=Method, y=Abundance, fill=Rank10)) +
  geom_bar(stat="identity") + theme_minimal() +
  scale_fill_manual(values = colorRampPalette(brewer.pal(15, "Paired"))(colourCount))
taxonomy_barplot
ggsave("qiime2-Results/NPRB/NPRB_all_samples_taxonomy.tiff", width = 11.5, height = 8, dpi = 300)
