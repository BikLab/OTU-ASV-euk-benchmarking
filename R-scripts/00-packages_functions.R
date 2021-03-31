########################
### For Both Dataset ###
########################

#### Load Packages Required to Run the Scripts ####
library(biomformat)
library(phyloseq)
library(tidyverse)
library(ape)
library(Biostrings)
library(scales)
library(ggplot2)
library(ggpubr)
library(patchwork)
library(dplyr)

#################################
####### 01- Import Table ########
#################################
### function for importing files and making phyloseq object ### 
Phylo_Obj <- function(biom = "", treefile = "", seqfile = "", MappingFile, data = "none") {
  BiomTable <- import_biom(biom) # import biom table #
  TreeFile <- read_tree(treefile) # import tree file #
  SeqFile <- readDNAStringSet(seqfile) # import rep seq file #
  
  if (data == "NPRB_DADA2") {   # Sample Names for NPRB DADA2 biom table must match the mapping file #
    colnames(otu_table(BiomTable)) <- gsub("NPRB3_", "", colnames(otu_table(BiomTable)))
    colnames(otu_table(BiomTable)) <- gsub("_", ".", colnames(otu_table(BiomTable)))
  }
  else if (data == "MEMB_DADA2") { # Sample Names for MEMB DADA2 biom table must match the mapping file #
    colnames(otu_table(BiomTable)) <- gsub("nem", "MEMB.nem.", colnames(otu_table(BiomTable)))
  }
  else if (data == "MEMB_Deblur") { # Sample Names for MEMB Deblur biom table must match the mapping file #
    colnames(otu_table(BiomTable)) <- gsub("nem", "MEMB.nem.", colnames(otu_table(BiomTable)))
  }
    phyloObj <- merge_phyloseq(BiomTable, TreeFile, SeqFile, MappingFile)
}
filter_outliers_ctrls <- function (biom = "") {
  newBiom = subset_samples(biom, SampleID != "MEMB.nem.95" & SampleID != "MEMB.nem.96" & SampleID != "MEMB.nem.99" &
                             SampleID != "MEMB.nem.105" & SampleID != "MEMB.nem.118" & SampleID != "MEMB.nem.125" & SampleID != "MEMB.nem.126" &
                             SampleID != "MEMB.nem.125" & SampleID != "MEMB.nem.126" & SampleID != "MEMB.nem.129" & SampleID != "MEMB.nem.141" &
                             SampleID != "MEMB.nem.150" & SampleID != "MEMB.nem.183" & SampleID != "MEMB.nem.184" & SampleID != "MEMB.nem.203" &
                             SampleID != "MEMB.nem.204" & SampleID != "MEMB.nem.235" & SampleID != "MEMB.nem.242" & SampleID != "MEMB.nem.260" &
                             SampleID != "MEMB.nem.261" & SampleID != "MEMB.nem.262" & SampleID != "MEMB.nem.281" & SampleID != "MEMB.nem.284" &
                             SampleID != "MEMB.nem.293" & SampleID != "MEMB.nem.294" & SampleID != "Neg.ctrl1" & SampleID != "Neg.ctrl2" &
                             SampleID != "Neg.ctrl3" & SampleID != "Neg.ctrl4" & SampleID != "Neg.ctrl5" & SampleID != "Zymo.stand.ctrl1" &
                             SampleID != "Zymo.stand.ctrl2" & SampleID != "Zymo.stand.ctrl3" & SampleID != "Zymo.stand.ctrl4" & SampleID != "Zymo.stand.ctrl5")
  return(newBiom)
}
filter_families <- function (biom = "") {
  newBiom = subset_samples(biom, NematodeFamily %in% c("Chromadoridae", "Comesomatidae", "Desmoscolecidae", "Oxystominidae"))
  
  return(newBiom)
}

#################################
## 02- Reads and OTUs Retained ##
#################################
### For MEMB DataSet, filter stuff out
remove_blanks_unknown <- function(df, datatype = "dataframe") {
  if (datatype == "phyloseq") {
    df_san_blanks_unknown <- subset_samples(df, FeedingGroup != "unknown")
    df_san_blanks_unknown <- subset_samples(df_san_blanks_unknown, FeedingGroup != "NegPCRControl")
    df_san_blanks_unknown <- subset_samples(df_san_blanks_unknown, FeedingGroup != "MockCommunity")
    df_san_blanks_unknown <- subset_samples(df_san_blanks_unknown, FeedingGroup != "Blank")
    df_san_blanks_unknown <- subset_samples(df_san_blanks_unknown, FeedingGroup != "Unknown")
  }
  else if (datatype == "dataframe") {
    df_san_blanks_unknown <-df[!(df$FeedingGroup=="unknown"),]
    df_san_blanks_unknown <-df_san_blanks_unknown[!(df_san_blanks_unknown$FeedingGroup=="NegPCRControl"),]
    df_san_blanks_unknown <-df_san_blanks_unknown[!(df_san_blanks_unknown$FeedingGroup=="MockCommunity"),]
    df_san_blanks_unknown <-df_san_blanks_unknown[!(df_san_blanks_unknown$FeedingGroup=="Blank"),]
    df_san_blanks_unknown <-df_san_blanks_unknown[!(df_san_blanks_unknown$FeedingGroup=="Unknown"),]
  }

  return(df_san_blanks_unknown)
}

### functions for merging data and making boxplots with sig.
reads_merged_map <- function(PhyloObj, Map, Algorithm) {
  Reads_Method <- as.data.frame(colSums(otu_table(PhyloObj@otu_table)))
  names(Reads_Method)[1] <- "Reads"
  Reads_Method_Map <- merge(Reads_Method, Map, by = "row.names")
  Reads_Method_Map$Method <- Algorithm
  return(Reads_Method_Map)
}
otus_merged_map <- function(PhyloObj, Map, Algorithm) {
  OTUs_Method <- as.data.frame(colSums(otu_table(PhyloObj@otu_table) != 0))
  names(OTUs_Method)[1] <- "OTUs"
  OTUs_Method_Map <- merge(OTUs_Method, Map, by = "row.names")
  OTUs_Method_Map$Method <- Algorithm
  return(OTUs_Method_Map)
}
ggplot_box <- function(df, yvar = "condition", ymax, labelposition, xvar = "condition", ylabel = F, breaks, pairwise = F, list = "", label.y, dataset = "") {
  finalplot <- ggplot(df, aes_string(x = xvar, y = yvar, fill = xvar)) + geom_boxplot() + facet_grid(~Method) +
    theme_linedraw() + theme(strip.text = element_text(size = 16)) +
    scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x), labels = trans_format("log10", math_format(10^.x)), limits = c(1e0,ymax)) 
  no_label <- list(
    theme(axis.title=element_blank(), axis.text=element_blank(), axis.ticks=element_blank(),
        legend.text=element_text(face = "bold")) + theme(legend.position = "none"))
  label <- list(
    theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank(),
          legend.text=element_text(face = "bold")) +  theme(legend.position = "right", legend.box = "vertical"))
  
  if (ylabel == T) {
    finalplot <- finalplot + label
  }
  else if (ylabel == F) {
    finalplot <- finalplot + no_label
  }
  
  if (pairwise == T) {
    finalplot <- finalplot + stat_compare_means(label.y = label.y, label.x = labelposition, method = "kruskal.test", fontface = "bold", size = 3) +
      stat_compare_means(label = "p.signif", method = "wilcox.test", comparisons = list)
  }
  else if (pairwise == F) {
    finalplot <- finalplot + stat_compare_means(label.y = label.y, label.x = labelposition, method = "kruskal.test", fontface = "bold", size = 3)
  }
  
  if (dataset == "NPRB") {
    finalplot <- finalplot + scale_fill_manual(values = c("coral", "darkgoldenrod3", "green4", "powderblue", "royalblue4", "orchid3"))
  }
  else if (dataset == "MEMB") {
    finalplot <- finalplot + scale_fill_manual(values = c("deeppink3", "lightsalmon", "seagreen1", "tan3"))
  }
  
  return(finalplot)

}

### lists for pairwise comparisons using stat_compare_means
my_list_method <- list(c("UCLUST", "VSearch"), c("UCLUST", "DADA2"), c("UCLUST", "Deblur"), c("VSearch", "DADA2"), c("VSearch", "Deblur"), c("DADA2", "Deblur"))
my_list_feeding_group <- list(c("1A", "1B"), c("1A", "2A"), c("1A", "2B"), c("1B", "2A"), c("1B", "2B"), c("2A", "2B"))
my_list_families <- list(c("Chromadoridae", "Comesomatidae"), c("Chromadoridae", "Desmoscolecidae"), c("Chromadoridae", "Oxystominidae"),
                         c("Comesomatidae", "Desmoscolecidae"), c("Comesomatidae", "Oxystominidae"), c("Desmoscolecidae", "Oxystominidae"))
#################################
### 03- Correlation OTU/Reads ###
#################################
### functions for linear correlation OTU/Reads ###
correlation_otu_reads <- function(df, xvar = "", yvar = "", color = "", yaxis = "", xaxis = "") {
  finalplot <- ggplot(df, aes_string(x = xvar, y = yvar, fill=color)) +
    geom_point(aes_string(fill = color, colour=color), pch=21) + 
    theme_linedraw() + theme(legend.position = "right", legend.box = "vertical") +
    geom_smooth(aes_string(color=color),method = "lm", se = FALSE) +
    scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x), labels = trans_format("log10", math_format(10^.x))) +
    scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x), labels = trans_format("log10", math_format(10^.x))) +
    stat_cor(aes(color = Method,label =paste(..rr.label.., p.label,cut(..p.., 
                                                 breaks = c(-Inf, 0.0001, 0.001, 0.01, 0.05, Inf),
                                                 labels = c("'****'", "'***'", "'**'", "'*'", "'ns'")), 
                                             sep = "~"), fontface = "bold"), method = "pearson", show.legend = FALSE) +
    ylab(yaxis) + xlab(xaxis) +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
    scale_fill_manual(values = c("UCLUST" = "coral", "VSearch" = "darkgoldenrod3", "DADA2" = "green4", "Deblur" = "royalblue4")) +
    scale_color_manual(values = c("UCLUST" = "coral", "VSearch" = "darkgoldenrod3", "DADA2" = "green4", "Deblur" = "royalblue4")) 
    
  return(finalplot)
}
barplot_otu_reads <- function(df, xvar = "", yvar = "", color = "", list = "", ymax, xlabel, ylabel = T, label.y) {
  finalplot <- ggplot(df, aes_string(x=xvar, y=yvar, fill=color)) + geom_boxplot() +
    theme_linedraw() + 
    scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x), 
                  labels = trans_format("log10", math_format(10^.x)), limits = c(1e0,ymax)) +
    stat_boxplot(geom = "errorbar", width=0.1) +
    stat_compare_means(label.y =  label.y, label.x = xlabel, method = "kruskal.test", fontface = "bold", size = 3) +
    stat_compare_means(label = "p.signif", method = "wilcox.test", comparisons = list) +
    scale_fill_manual(values = c("coral", "darkgoldenrod3", "green4", "royalblue4", "royalblue4", "orchid3"))
  no_label <- list(
    theme(axis.title=element_blank(), axis.text=element_blank(), axis.ticks=element_blank(), 
          legend.text=element_text(face = "bold")) + theme(legend.position = "none"))
  label <- list(
    theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank(),
          legend.text=element_text(face = "bold")) +  theme(legend.position = "right", legend.box = "vertical"))
  if (ylabel == T) {
    finalplot <- finalplot + label
  }
  else if (ylabel == F) {
    finalplot <- finalplot + no_label
  }
  
  return(finalplot)
  
}

#################################
##### 04- Head Tail Pattern #####
#################################

### functions for viewing head-tail pattern
rank_asv_otu <- function(df) {
  # df_merge <- subset_samples(df, X.SampleID=="MEMB.nem.257")
  df_merge <- merge_samples(df, "merge")
  df_merge_prune <- prune_taxa(taxa_sums(df_merge)>=1, df_merge)
  df_melt <- psmelt(df_merge_prune)
  df_melt$Rank <- 1:nrow(df_melt)
  return(df_melt)
}
plot_head_tail <- function(df, method, ymax, ylabel) {
  finalplot <- ggplot(df, aes(x = Rank, y = Abundance)) +
    geom_point(aes(fill = method, colour=method), pch=21) +
    theme_bw() +
    theme(legend.position = "none") +
    scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                  labels = trans_format("log10", math_format(10^.x)),
                  limits = c(1e0,ymax)) +
    scale_fill_manual(values = c("UCLUST"="coral", "VSearch"="darkgoldenrod3", "DADA2"="green4", "Deblur"="royalblue4")) +
    scale_color_manual(values = c("UCLUST"="coral", "VSearch"="darkgoldenrod3", "DADA2"="green4", "Deblur"="royalblue4")) 
  no_label <- list(
    theme(axis.title.y=element_blank(), axis.text.y=element_blank(), axis.ticks.y=element_blank(),
          legend.text=element_text(face = "bold")) + theme(legend.position = "none"))
  label <- list(
    theme(legend.text=element_text(face = "bold")) +  theme(legend.position = "right", legend.box = "vertical"))
  
  if (ylabel == T) {
    finalplot <- finalplot + label
  }
  else if (ylabel == F) {
    finalplot <- finalplot + no_label
  }
  return(finalplot)
}

#################################
##### 04- Alpha Diversity  ######
#################################

plot_alpha_div <- function(phylo, div_measure, color= "", y = 0, dataset = "NPRB", Pairwise = F, pairwiseList) {
  info <- list(
    theme_linedraw(),
    geom_point(size = 3),
    geom_boxplot(aes_string(fill=color)),
    theme(axis.title = element_blank(), axis.text.x = element_blank(), 
          axis.ticks.x = element_blank(), panel.grid.minor = element_blank(), legend.title = element_text(face = "bold", size =12), 
          legend.title.align = 0.5, legend.text = element_text(size = 10), panel.grid.major = element_blank()),
    guides(shape = guide_legend(order = 0), color = guide_legend(order = 1, title = color)),
    labs(title = " "),
    stat_compare_means(label.y = y, label.x = 1.6, method = "kruskal", fontface = "bold", size = 4)
    )
  if (div_measure == "Shannon") {
    finalplot <- plot_richness(phylo, x = color, measures = c("Shannon")) + ylim(0, y) + info
  }
  else if (div_measure == "Simpson") {
    finalplot <- plot_richness(phylo, x = color, measures = c("Simpson")) + ylim(0, y) + info
  }
  
  if (dataset == "NPRB") {
    finalplot <- finalplot + scale_fill_manual(values = c("coral", "darkgoldenrod3", "green4", "powderblue", "royalblue4", "orchid3"))
  }
  else if (dataset == "MEMB") {
    finalplot <- finalplot + scale_fill_manual(values = c("deeppink3", "lightsalmon", "seagreen1", "tan3"))
  }
  
  if(Pairwise == T) {
    finalplot <- finalplot + stat_compare_means(label = "p.signif", method = "wilcox.test", comparisons = pairwiseList) 
  }
  return(finalplot)

}

CalculateAlphaDiv <- function(PhyObject, DivMeasurement, ClusteringMethod) {
  DiversityMeasurement <- plot_richness(PhyObject, x = "Subregion", measures = c(DivMeasurement)) 
  DiversityMeasurementDataframe <- as.data.frame(DiversityMeasurement["data"])
  DiversityMeasurementDataframe$Method <- ClusteringMethod
  return(DiversityMeasurementDataframe)
}
RbindSubregions <- function(Dataframe1, Dataframe2, Dataframe3, Dataframe4, Variable, dataset = "NPRB") {
  if (dataset == "NPRB") {
  Dataframe1_Kept <- Dataframe1[ which(Dataframe1$data.Subregion == Variable), ] 
  Dataframe2_Kept <- Dataframe2[ which(Dataframe2$data.Subregion == Variable), ] 
  Dataframe3_Kept <- Dataframe3[ which(Dataframe3$data.Subregion == Variable), ] 
  Dataframe4_Kept <- Dataframe4[ which(Dataframe4$data.Subregion == Variable), ] 
  BoundDataframe <- rbind(Dataframe1_Kept, Dataframe2_Kept, Dataframe3_Kept, Dataframe4_Kept)
  }
  else if (dataset == "MEMB") {
    Dataframe1_Kept <- Dataframe1[ which(Dataframe1$data.NematodeFamily == Variable), ] 
    Dataframe2_Kept <- Dataframe2[ which(Dataframe2$data.NematodeFamily == Variable), ] 
    Dataframe3_Kept <- Dataframe3[ which(Dataframe3$data.NematodeFamily == Variable), ] 
    Dataframe4_Kept <- Dataframe4[ which(Dataframe4$data.NematodeFamily == Variable), ] 
    BoundDataframe <- rbind(Dataframe1_Kept, Dataframe2_Kept, Dataframe3_Kept, Dataframe4_Kept)
  }
  return(BoundDataframe)
}
ggplotSigFig <- function(Dataframe, Ylimit, Pairwise, pairwiseList) {
  switch(Pairwise, 
         yes = ggplot(Dataframe, aes(x = Method, y = data.value, fill = Method)) + geom_boxplot() +
           stat_compare_means(label.y = Ylimit, label.x = 1.5, method = "kruskal.test", fontface = "bold", size = 4) +
           stat_compare_means(label = "p.signif", method = "wilcox.test", comparisons = pairwiseList) +
           scale_fill_manual(values = c("coral", "darkgoldenrod3", "green4", "powderblue", "royalblue4", "orchid3")) +
           ylim(-0.1, Ylimit) + theme_bw() +
           theme(axis.title = element_blank(), axis.text.x = element_blank(), 
                 axis.ticks.x = element_blank(), panel.grid.minor = element_blank(), legend.title = element_text(face = "bold", size =12), 
                 legend.title.align = 0.5, legend.text = element_text(size = 10), panel.grid.major = element_blank()) +
           guides(shape = guide_legend(order = 0), color = guide_legend(order = 1, title = "Subregion")), 
         no = ggplot(Dataframe, aes(x = Method, y = data.value, fill = Method)) + geom_boxplot() +
           stat_compare_means(label.y = Ylimit, label.x = 1, method = "kruskal.test", fontface = "bold", size = 4) +
           scale_fill_manual(values = c("coral", "darkgoldenrod3", "green4", "powderblue", "royalblue4", "orchid3")) +
           ylim(0, Ylimit) + theme_bw() +
           theme(axis.title = element_blank(), axis.text.x = element_blank(), 
                 axis.ticks.x = element_blank(), panel.grid.minor = element_blank(), legend.title = element_text(face = "bold", size =12), 
                 legend.title.align = 0.5, legend.text = element_text(size = 10), panel.grid.major = element_blank()) +
           guides(shape = guide_legend(order = 0), color = guide_legend(order = 1, title = "Subregion")),
         stop("Unkown parameter!"))
}

#################################
######### 07- Taxonomy  #########
#################################

# focus on metazoa ONLY, agglomerate taxa at Rank6, and only keep taxa >1% Relative Abundance
taxonomy_filter <- function(df, merge_column = "merge", dataset = "NPRB") { 
#  df_glom_merged <- merge_samples(df, merge_column)
#  b1_genus <- tax_glom(df_glom_merged, taxrank="Rank10")
  df_glom_merged_relab <- transform_sample_counts(df, function(x) x / sum(x) * 100)
  b1_genus <- tax_glom(df_glom_merged_relab, taxrank="Rank10")
  Genus10 = names(sort(taxa_sums(b1_genus), TRUE)[1:10])
  if (dataset == "NPRB") {
     #df_merged_relab_subset <- subset_taxa(df_merged_relab, Rank4=="D_3__Metazoa (Animalia)")
    #df_glom <- tax_glom(df, taxrank="Rank5")
    
#       df_merged_relab_filter <- filter_taxa(df_merged_relab_subset, function(x) sum(x) > 1, TRUE)
  }
  else if (dataset == "MEMB") {
    #df_merged_relab_subset <- subset_taxa(df_merged_relab, Rank6=="D_5__Bilateria")
    #df_merged_relab_glom <- tax_glom(df_merged_relab_subset, taxrank="Rank9")
 #       df_merged_relab_filter <- filter_taxa(df_merged_relab_subset, function(x) sum(x) > .1, TRUE)
  }

  df_melt <- psmelt(Genus10)
  
  return(Genus10)
}
plot_taxonomy <- function(df, method, color, fill) {
  final_plot <- plot_bar(df, "merge", "Abundance", method, fill = fill) +
    geom_bar(aes_string(color=color, fill=fill), stat="identity", position="stack") + theme_linedraw() + theme(axis.text.x = element_blank(), axis.ticks.x = element_blank(), axis.title.x = element_blank()) +
    scale_y_continuous(breaks=c(10,20,30,40,50,60,70,80,90,100),labels = c('10','20','30','40','50','60','70','80','90','100'), limits=c(0,100))
  return(final_plot)
}

NPRB_fill <- scale_fill_manual(values = c("D_7__Chromadorea" = "coral","D_7__Enopla" = "darkgoldenrod3", "D_8__Echiura" ="green4", 
                                          "D_8__Enoplia" = "powderblue", "D_8__Palpata" = "royalblue4", "D_8__Scolecida" = "orchid3",
                                          "D_9__Copepoda" = "deeppink3", "D_9__Podocopa" = "lightsalmon"))
NPRB_color <- scale_color_manual(values = c("D_6__Annelida" = "coral","D_6__Arthropoda" = "darkgoldenrod3", "D_8__Echiura" ="green4", 
                                            "D_8__Enoplia" = "powderblue", "D_8__Palpata" = "royalblue4", "D_8__Scolecida" = "orchid3",
                                            "D_9__Copepoda" = "deeppink3", "D_9__Podocopa" = "lightsalmon"))

MEMB_fill <- scale_fill_manual(values = c("D_8__Araeolaimida" = "coral","D_8__Chromadorida" = "darkgoldenrod3", "D_8__Desmodorida" ="green4", 
                                          "D_8__Desmoscolecida" = "powderblue", "D_8__Enoplia" = "royalblue4", "D_8__Enoplida" = "orchid3",
                                          "D_8__Monhysterida" = "deeppink3", "D_8__Palpata" = "lightsalmon", "D_8__Plectida" = "darkseagreen1",
                                          "D_8__Scolecida" = "khaki1"))
MEMB_color <- scale_color_manual(values = c("D_8__Araeolaimida" = "coral","D_8__Chromadorida" = "darkgoldenrod3", "D_8__Desmodorida" ="green4", 
                                            "D_8__Desmoscolecida" = "powderblue", "D_8__Enoplia" = "royalblue4", "D_8__Enoplida" = "orchid3",
                                            "D_8__Monhysterida" = "deeppink3", "D_8__Palpata" = "lightsalmon", "D_8__Plectida" = "darkseagreen1",
                                            "D_8__Scolecida" = "khaki1"))

#################################
######### 08- BetaDiv  ##########
#################################

beta_div_plot <- function(df, betadiv, colors, dataset, title) {
  finalplot <- plot_ordination(df, betadiv, color=colors) +
    geom_point(size=2) + ggtitle(title) +
    theme_linedraw() + theme(aspect.ratio = 1) + theme(plot.title = element_text(size = 10), axis.title = element_text(size = 10))
  
  if (dataset == "NPRB") {
    finalplot <- finalplot + scale_color_manual(values = c("coral", "darkgoldenrod3", "green4", "powderblue", "royalblue4", "orchid3")) 
  }
  else if (dataset == "MEMB") {
    finalplot <- finalplot +  scale_fill_manual(values = c("deeppink3", "lightsalmon", "seagreen1", "tan3"))
  }
  return(finalplot)
}

