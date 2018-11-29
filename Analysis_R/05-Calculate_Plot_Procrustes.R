library(tidyr)
library(dplyr)

pcoa_dada2_df <- as.data.frame(pcoa_dada2$data)
pcoa_dada2_df <- select(pcoa_dada2_df, Axis.1, Axis.2)

pcoa_uclust_df <- as.data.frame(pcoa_uclust$data)
pcoa_uclust_df <- select(pcoa_uclust_df, Axis.1, Axis.2)

pcoa_vsearch_df <- as.data.frame(pcoa_vsearch$data)
pcoa_vsearch_df <- select(pcoa_vsearch_df, Axis.1, Axis.2)

library(vegan)

# DADA2 AND UCLUST
common_dada2_uclust <- intersect(rownames(pcoa_dada2_df), rownames(pcoa_uclust_df))  
common_dada2_uclust <- as.data.frame(common_dada2_uclust)
rownames(common_dada2_uclust) <- common_dada2_uclust$common_dada2_uclust

dada2_prodf <- pcoa_dada2_df[rownames(common_dada2_uclust),] # give you common rows in data frame 1  
uclust_prodf<- pcoa_uclust_df[rownames(common_dada2_uclust),]

(dada2_uclust <- procrustes(dada2_prodf, uclust_prodf, scale = TRUE))
(protest(dada2_prodf, uclust_prodf, permutations = 999))

# DADA2 AND VSEARCH
common_dada2_vsearch <- intersect(rownames(pcoa_dada2_df), rownames(pcoa_vsearch_df))  
common_dada2_vsearch <- as.data.frame(common_dada2_vsearch)
rownames(common_dada2_vsearch) <- common_dada2_vsearch$common_dada2_vsearch

dada2_prodf <- pcoa_dada2_df[rownames(common_dada2_vsearch),] # give you common rows in data frame 1  
vsearch_prodf<- pcoa_vsearch_df[rownames(common_dada2_vsearch),]

(dada2_vsearch <- procrustes(dada2_prodf, vsearch_prodf, scale = TRUE))
(protest(dada2_prodf, vsearch_prodf, permutations = 999))

# UCLUST AND VSEARCH
common_uclust_vsearch <- intersect(rownames(pcoa_dada2_df), rownames(pcoa_vsearch_df))  
common_uclust_vsearch <- as.data.frame(common_uclust_vsearch)
rownames(common_uclust_vsearch) <- common_uclust_vsearch$common_uclust_vsearch

uclust_prodf <- pcoa_uclust_df[rownames(common_uclust_vsearch),] # give you common rows in data frame 1  
vsearch_prodf<- pcoa_vsearch_df[rownames(common_uclust_vsearch),]

(uclust_vsearch <- procrustes(uclust_prodf, vsearch_prodf, scale = TRUE))
(protest(uclust_prodf, vsearch_prodf, permutations = 999))


plot(dada2_vsearch)
plot(dada2_uclust)
plot(uclust_vsearch)

dada2_pro <- as.data.frame(dada2_vsearch$X)
dada2_pro$"Clustering Algorithm" <- rep("DADA2",nrow(dada2_pro))
colnames(dada2_pro)[colnames(dada2_pro) == 'Axis.1'] <- 'PC1'
colnames(dada2_pro)[colnames(dada2_pro) == 'Axis.2'] <- 'PC2'

vsearch_pro <- as.data.frame(dada2_vsearch$Yrot)
vsearch_pro$"xClustering Algorithm" <- rep("VSearch",nrow(vsearch_pro))
vsearch_pro$Sample <- rownames(vsearch_pro)
colnames(vsearch_pro)[colnames(vsearch_pro) == 'V1'] <- 'xPC1'
colnames(vsearch_pro)[colnames(vsearch_pro) == 'V2'] <- 'xPC2'

dada2_vsearch_merged <- merge(dada2_pro, vsearch_pro, by="row.names")
dada2_vsearch_merged$Row.names <- NULL

metadata_df <- as.data.frame(read.delim("Desktop/NPRB-euk-benchmarking/NPRB_EukBench_MappingFile.txt"))
names(metadata_df)[names(metadata_df) == 'X.SampleID'] <- 'Sample'
dada2_vsearch_merged <- merge(dada2_vsearch_merged, metadata_df, by="Sample")

plot_pro <- ggplot(dada2_vsearch_merged) +
  geom_point(aes(x=PC1, y=PC2, colour=`Clustering Algorithm`), shape="\u25D6", size=3, fill="black") +
  geom_point(aes(x=PC1, y=PC2, color=Region), shape="\u25D7", size=3) +  
  geom_point(aes(x=xPC1, y=xPC2, colour=`xClustering Algorithm`), shape="\u25D6", size=3, fill="red") +
  geom_point(aes(x=xPC1, y=xPC2, color=Region), shape="\u25D7", size=3) +
  scale_color_manual(values=c("blue", "green","black",  "red", "purple","yellow", "pink", "orange", "black", "red")) +
  scale_fill_manual(values=c("black", "red")) +
  geom_segment(aes(x=PC1,y=PC2,xend=xPC1,yend=xPC2),arrow=arrow(type = "open", length=unit(0.1,"cm")), color="black") +
  #facet_wrap(~ Subregion, ncol = 3)  +
  #facet_grid(cols = vars(Subregion)) +
  theme_bw() +
  facet_grid(. ~Subregion) +
  theme(aspect.ratio = 1) 
  
plot_pro

cairo_pdf("Desktop/DADA2_VSearch_Procruste_Analysis_Facet.pdf", family="Arial Unicode MS", 4,4,
          width=11.5, height=8)
plot_pro
dev.off()

dada2_pro <- as.data.frame(dada2_uclust$X)
dada2_pro$"Clustering Algorithm" <- rep("DADA2",nrow(dada2_pro))
colnames(dada2_pro)[colnames(dada2_pro) == 'Axis.1'] <- 'PC1'
colnames(dada2_pro)[colnames(dada2_pro) == 'Axis.2'] <- 'PC2'

uclust_pro <- as.data.frame(dada2_uclust$Yrot)
uclust_pro$"xClustering Algorithm" <- rep("UCLUST",nrow(uclust_pro))
uclust_pro$Sample <- rownames(uclust_pro)
colnames(uclust_pro)[colnames(uclust_pro) == 'V1'] <- 'xPC1'
colnames(uclust_pro)[colnames(uclust_pro) == 'V2'] <- 'xPC2'

dada2_uclust_merged <- merge(dada2_pro, uclust_pro, by="row.names")
dada2_uclust_merged$Row.names <- NULL

names(metadata_df)[names(metadata_df) == 'X.SampleID'] <- 'Sample'
dada2_uclust_merged <- merge(dada2_uclust_merged, metadata_df, by="Sample")


plot_pro <- ggplot(dada2_uclust_merged) +
  geom_point(aes(x=PC1, y=PC2, colour=`Clustering Algorithm`), shape="\u25D6", size=3, fill="black") +
  geom_point(aes(x=PC1, y=PC2, color=Region), shape="\u25D7", size=3) +  
  geom_point(aes(x=xPC1, y=xPC2, colour=`xClustering Algorithm`), shape="\u25D6", size=3, fill="red") +
  geom_point(aes(x=xPC1, y=xPC2, color=Region), shape="\u25D7", size=3) +
  scale_color_manual(values=c("blue", "green","black",  "red", "purple","yellow", "pink", "orange", "black", "red")) +
  scale_fill_manual(values=c("black", "red")) +
  geom_segment(aes(x=PC1,y=PC2,xend=xPC1,yend=xPC2),arrow=arrow(type = "open", length=unit(0.1,"cm")), color="black") +
  #facet_wrap(~ Subregion, ncol = 3)  +
  #facet_grid(cols = vars(Subregion)) +
  theme_bw() +
  facet_grid(. ~Subregion) +
  theme(aspect.ratio = 1) 

plot_pro

cairo_pdf("Desktop/DADA2_UCLUST_Procruste_Analysis_Facet.pdf", family="Arial Unicode MS", 4,4,
          width=11.5, height=8)
plot_pro
dev.off()


uclust_pro <- as.data.frame(uclust_vsearch$X)
uclust_pro$"Clustering Algorithm" <- rep("UCLUST",nrow(uclust_pro))
colnames(uclust_pro)[colnames(uclust_pro) == 'Axis.1'] <- 'PC1'
colnames(uclust_pro)[colnames(uclust_pro) == 'Axis.2'] <- 'PC2'

vsearch_pro <- as.data.frame(uclust_vsearch$Yrot)
vsearch_pro$"xClustering Algorithm" <- rep("VSearch",nrow(vsearch_pro))
vsearch_pro$Sample <- rownames(vsearch_pro)
colnames(vsearch_pro)[colnames(vsearch_pro) == 'V1'] <- 'xPC1'
colnames(vsearch_pro)[colnames(vsearch_pro) == 'V2'] <- 'xPC2'

uclust_vsearch_merged <- merge(uclust_pro, vsearch_pro, by="row.names")
uclust_vsearch_merged$Row.names <- NULL

names(metadata_df)[names(metadata_df) == 'X.SampleID'] <- 'Sample'
uclust_vsearch_merged <- merge(uclust_vsearch_merged, metadata_df, by="Sample")

plot_pro <- ggplot(uclust_vsearch_merged) +
  geom_point(aes(x=PC1, y=PC2, colour=`Clustering Algorithm`), shape="\u25D6", size=3, fill="black") +
  geom_point(aes(x=PC1, y=PC2, color=Region), shape="\u25D7", size=3) +  
  geom_point(aes(x=xPC1, y=xPC2, colour=`xClustering Algorithm`), shape="\u25D6", size=3, fill="red") +
  geom_point(aes(x=xPC1, y=xPC2, color=Region), shape="\u25D7", size=3) +
  scale_color_manual(values=c("blue", "green","black",  "red", "purple","yellow", "pink", "orange", "black", "red")) +
  scale_fill_manual(values=c("black", "red")) +
  geom_segment(aes(x=PC1,y=PC2,xend=xPC1,yend=xPC2),arrow=arrow(type = "open", length=unit(0.1,"cm")), color="black") +
  #facet_wrap(~ Subregion, ncol = 3)  +
  #facet_grid(cols = vars(Subregion)) +
  theme_bw() +
  facet_grid(. ~Subregion) +
  theme(aspect.ratio = 1) 

plot_pro

cairo_pdf("Desktop/UCLUST_VSearch_Procruste_Analysis_Facet.pdf", family="Arial Unicode MS", 4,4,
          width=11.5, height=8)
plot_pro
dev.off()
