plot_procrustes <- function(df1, df2, method1, method2) {
  df1_df2_common <- intersect(rownames(df1), rownames(df2))  
  df1_df2_common <- as.data.frame(df1_df2_common)
  rownames(df1_df2_common) <- df1_df2_common$df1_df2_common
  
  df1_prodf <- df1[rownames(df1_df2_common),]
  df2_prodf <- df2[rownames(df1_df2_common),]
  
  pro_df1_df2 <- procrustes(df1_prodf, df2_prodf, scale = TRUE, symmetric = TRUE)
  
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
#  df1_df2_merged <- merge(df1_df2_merged, metadata_df, by = "Sample")
  
  plot_pro_df1_df2 <- ggplot(df1_df2_merged) +
    geom_point(aes(x=xPC1, y=xPC2, colour=`xMethod`), size=1, fill="black") +
    geom_point(aes(x=yPC1, y=yPC2, colour=`yMethod`), size=1, fill="red") +
    scale_color_manual(breaks = c(method1, method2) ,values=c("blue", "red", "black")) +
    scale_x_continuous(breaks = NULL) +
    scale_y_continuous(breaks = NULL) +
    guides(color=guide_legend(title="")) +
    geom_segment(aes(x=xPC1,y=xPC2,xend=yPC1,yend=yPC2, color="black"),arrow=arrow(type = "open", length=unit(0.1,"cm"))) +
    theme_linedraw() + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.title = element_blank(),
                             strip.text = element_text(size = 12),
                            plot.title = element_text(hjust = 0.5, size = 12)) + theme(aspect.ratio = 1) 
  return(plot_pro_df1_df2)
}
