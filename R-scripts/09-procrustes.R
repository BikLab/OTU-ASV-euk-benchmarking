require(vegan)

## use memb mapping file for LC dataset ##
metadata_df <- as.data.frame(read.delim("DATA_Final/NPRB/MappingFile/NPRB_EukBench_MappingFile.txt"))
names(metadata_df)[names(metadata_df) == 'X.SampleID'] <- 'Sample'
## for memb 
names(metadata_df)[names(metadata_df) == 'SampleID'] <- 'Sample'

metadata_df <- metadata_df[,c("Sample","NematodeFamily")]

plot_procrustes <- function(df1, df2, method1, method2) {
  df1_df2_common <- intersect(rownames(df1), rownames(df2))  
  df1_df2_common <- as.data.frame(df1_df2_common)
  rownames(df1_df2_common) <- df1_df2_common$df1_df2_common
  
  df1_prodf <- df1[rownames(df1_df2_common),]
  df2_prodf <- df2[rownames(df1_df2_common),]
  
  pro_df1_df2 <- procrustes(df1_prodf, df2_prodf, scale = TRUE, symmetric = TRUE)
#  protest <- protest(df1_prodf, df2_prodf, permutations = 9999, symmetry = T)
#  message(pro_df1_df2)
  
  pro_df1 <- as.data.frame(pro_df1_df2$X)
  pro_df1$"xMethod" <- rep(method1,nrow(pro_df1))
  pro_df1$"Sample" <- rownames(pro_df1)
  colnames(pro_df1)[colnames(pro_df1) == 'Axis.1'] <- 'xPC1'
  colnames(pro_df1)[colnames(pro_df1) == 'Axis.2'] <- 'xPC2'
  pro_df1 <- pro_df1[,c("xPC1","xPC2", "Sample", "xMethod")]
  
  pro_df2 <- as.data.frame(pro_df1_df2$Yrot)
  pro_df2$"yMethod" <- rep(method2,nrow(pro_df2))
  pro_df2$"Sample" <- rownames(pro_df2)
  colnames(pro_df2)[colnames(pro_df2) == 'V1'] <- 'yPC1'
  colnames(pro_df2)[colnames(pro_df2) == 'V2'] <- 'yPC2'
  pro_df2 <- pro_df2[,c("yPC1","yPC2", "Sample", "yMethod")]
  
  df1_df2_merged <- merge(pro_df1, pro_df2, by = "Sample")
  df1_df2_merged <- merge(df1_df2_merged, metadata_df, by="Sample")
  
  plot_pro_df1_df2 <- ggplot(df1_df2_merged) +
    geom_point(aes(x=xPC1, y=xPC2, colour=`xMethod`), size=1, fill="black") +
    geom_point(aes(x=yPC1, y=yPC2, colour=`yMethod`), size=1, fill="red") +
    scale_color_manual(breaks = c(method1, method2) ,values=c("black","blue", "red")) +
    scale_x_continuous(breaks = NULL) +
    scale_y_continuous(breaks = NULL) +
    guides(color=guide_legend(title="")) +
    geom_segment(aes(x=xPC1,y=xPC2,xend=yPC1,yend=yPC2, color="black"),arrow=arrow(type = "open", length=unit(0.1,"cm"))) +
    theme_linedraw() + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.title = element_blank(),
                             strip.text = element_text(size = 12),
                             plot.title = element_text(hjust = 0.5, size = 12)) + theme(aspect.ratio = 1) 
  return(plot_pro_df1_df2)
}


#### Procrustes Extract Data ####
pcoa_uclust_ufrac <- as.data.frame(UCLUST_UFrac$vectors)
pcoa_uclust_wufrac <- as.data.frame(UCLUST_WUFrac$vectors)
pcoa_uclust_bray <- as.data.frame(UCLUST_Bray$vectors)

pcoa_vsearch_ufrac <- as.data.frame(VSearch_UFrac$vectors)
pcoa_vsearch_wufrac <- as.data.frame(VSearch_WUFrac$vectors)
pcoa_vsearch_bray <- as.data.frame(VSearch_Bray$vectors)

pcoa_dada2_ufrac <- as.data.frame(DADA2_UFrac$vectors)
pcoa_dada2_wufrac <- as.data.frame(DADA2_WUFrac$vectors)
pcoa_dada2_bray <- as.data.frame(DADA2_Bray$vectors)

pcoa_deblur_ufrac <- as.data.frame(Deblur_UFrac$vectors)
pcoa_deblur_wufrac <- as.data.frame(Deblur_WUFrac$vectors)
pcoa_deblur_bray <- as.data.frame(Deblur_Bray$vectors)

## UCLUST VS VSearch ##
plot_pro_uclust_vsearch_ufrac <- plot_procrustes(pcoa_uclust_ufrac, pcoa_vsearch_ufrac, "UCLUST", "VSearch")
plot_pro_uclust_vsearch_ufrac 
plot_pro_uclust_vsearch_wufrac <- plot_procrustes(pcoa_uclust_wufrac, pcoa_vsearch_wufrac, "UCLUST", "VSearch")
plot_pro_uclust_vsearch_wufrac
plot_pro_uclust_vsearch_bray <- plot_procrustes(pcoa_uclust_bray, pcoa_vsearch_bray, "UCLUST", "VSearch")
plot_pro_uclust_vsearch_bray

plot_pro_uclust_vsearch <- ggarrange(plot_pro_uclust_vsearch_bray, plot_pro_uclust_vsearch_ufrac, plot_pro_uclust_vsearch_wufrac, common.legend = T, nrow = 3, ncol = 1) 
plot_pro_uclust_vsearch <- annotate_figure(plot_pro_uclust_vsearch, top = text_grob("UCLUST and VSearch", color = "black", face = "bold", size = 14))

## UCLUST vs DADA2 ##
plot_pro_uclust_dada2_ufrac <- plot_procrustes(pcoa_uclust_ufrac, pcoa_dada2_ufrac, "UCLUST", "DADA2")
plot_pro_uclust_dada2_ufrac
plot_pro_uclust_dada2_wufrac <- plot_procrustes(pcoa_uclust_wufrac, pcoa_dada2_wufrac, "UCLUST", "DADA2")
plot_pro_uclust_dada2_wufrac
plot_pro_uclust_dada2_bray <- plot_procrustes(pcoa_uclust_bray, pcoa_dada2_bray, "UCLUST", "DADA2")
plot_pro_uclust_dada2_bray

plot_pro_uclust_dada2 <- ggarrange(plot_pro_uclust_dada2_bray, plot_pro_uclust_dada2_ufrac, plot_pro_uclust_dada2_wufrac, common.legend = T, nrow = 3) 
plot_pro_uclust_dada2 <- annotate_figure(plot_pro_uclust_dada2, top = text_grob("UCLUST and DADA2", color = "black", face = "bold", size = 14))

## UCLUST vs Deblur ##
plot_pro_uclust_deblur_ufrac <- plot_procrustes(pcoa_uclust_ufrac, pcoa_deblur_ufrac, "UCLUST", "Deblur")
plot_pro_uclust_deblur_ufrac
plot_pro_uclust_deblur_wufrac <- plot_procrustes(pcoa_uclust_wufrac, pcoa_deblur_wufrac, "UCLUST", "Deblur")
plot_pro_uclust_deblur_wufrac
plot_pro_uclust_deblur_bray <- plot_procrustes(pcoa_uclust_bray, pcoa_deblur_bray, "UCLUST", "Deblur")
plot_pro_uclust_deblur_bray

plot_pro_uclust_deblur <- ggarrange(plot_pro_uclust_deblur_bray, plot_pro_uclust_deblur_ufrac, plot_pro_uclust_deblur_wufrac, common.legend = T, nrow = 3) 
plot_pro_uclust_deblur <- annotate_figure(plot_pro_uclust_deblur, top = text_grob("UCLUST and Deblur", color = "black", face = "bold", size = 14))

## VSearch vs DADA2 ##
plot_pro_vsearch_dada2_ufrac <- plot_procrustes(pcoa_vsearch_ufrac, pcoa_dada2_ufrac, "VSearch", "DADA2")
plot_pro_vsearch_dada2_ufrac
plot_pro_vsearch_dada2_wufrac <- plot_procrustes(pcoa_vsearch_wufrac, pcoa_dada2_wufrac, "VSearch", "DADA2")
plot_pro_vsearch_dada2_wufrac
plot_pro_vsearch_dada2_bray <- plot_procrustes(pcoa_vsearch_bray, pcoa_dada2_bray, "VSearch", "DADA2")
plot_pro_vsearch_dada2_bray

plot_pro_vsearch_dada2 <- ggarrange(plot_pro_vsearch_dada2_bray, plot_pro_vsearch_dada2_ufrac, plot_pro_vsearch_dada2_wufrac, common.legend = T, nrow = 3) 
plot_pro_vsearch_dada2 <- annotate_figure(plot_pro_vsearch_dada2, top = text_grob("VSearch and DADA2", color = "black", face = "bold", size = 14))

## Vsearch vs Deblur ##
plot_pro_vsearch_deblur_ufrac <- plot_procrustes(pcoa_vsearch_ufrac, pcoa_deblur_ufrac, "VSearch", "Deblur")
plot_pro_vsearch_deblur_ufrac
plot_pro_vsearch_deblur_wufrac <- plot_procrustes(pcoa_vsearch_wufrac, pcoa_deblur_wufrac, "VSearch", "Deblur")
plot_pro_vsearch_deblur_wufrac
plot_pro_vsearch_deblur_bray <- plot_procrustes(pcoa_vsearch_bray, pcoa_deblur_bray, "VSearch", "Deblur")
plot_pro_vsearch_deblur_bray

plot_pro_vsearch_deblur <- ggarrange(plot_pro_vsearch_deblur_bray, plot_pro_vsearch_deblur_ufrac, plot_pro_vsearch_deblur_wufrac, common.legend = T, nrow = 3) 
plot_pro_vsearch_deblur <- annotate_figure(plot_pro_vsearch_deblur, top = text_grob("VSearch and Deblur", color = "black", face = "bold", size = 14))

## DADA2 vs Deblur ##
plot_pro_dada2_deblur_ufrac <- plot_procrustes(pcoa_dada2_ufrac, pcoa_deblur_ufrac, "DADA2", "Deblur")
plot_pro_dada2_deblur_ufrac
plot_pro_dada2_deblur_wufrac <- plot_procrustes(pcoa_dada2_wufrac, pcoa_deblur_wufrac, "DADA2", "Deblur")
plot_pro_dada2_deblur_wufrac
plot_pro_dada2_deblur_bray <- plot_procrustes(pcoa_dada2_bray, pcoa_deblur_bray, "DADA2", "Deblur")
plot_pro_dada2_deblur_bray

plot_pro_dada2_deblur <- ggarrange(plot_pro_dada2_deblur_bray, plot_pro_dada2_deblur_ufrac, plot_pro_dada2_deblur_wufrac, common.legend = T, nrow = 3) 
plot_pro_dada2_deblur <- annotate_figure(plot_pro_dada2_deblur, top = text_grob("DADA2 and Deblur", color = "black", face = "bold", size = 14))
                                                                                                                          
plot_pro_final <- ggarrange(plot_pro_uclust_vsearch, plot_pro_uclust_dada2, plot_pro_uclust_deblur, plot_pro_vsearch_dada2, 
          plot_pro_vsearch_deblur, plot_pro_dada2_deblur, nrow = 1, ncol = 6)
plot_pro_final
ggsave("DATA_Final/NPRB/Analysis/procrustes_final_nprb.tiff", plot_pro_final, width = 14, height = 8, dpi = 300)

