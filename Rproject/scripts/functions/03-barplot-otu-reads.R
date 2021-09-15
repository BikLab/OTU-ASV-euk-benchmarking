barplot_otu_reads <- function(df, xvar = "", yvar = "", color = "", list = "", ymax, xlabel, ylabel = T, label.y) {
  finalplot <- ggplot(df, aes_string(x=xvar, y=yvar, fill=color)) + geom_boxplot() +
    theme_linedraw() + 
    scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x), 
                  labels = trans_format("log10", math_format(10^.x)), limits = c(1e0,ymax), expand = c(0,0)) +
    #    stat_boxplot(geom = "errorbar", width=0.1) +
    stat_compare_means(label.y =  label.y, label.x = xlabel, method = "kruskal.test", fontface = "bold", size = 3) +
    stat_compare_means(label = "p.signif", method = "wilcox.test", comparisons = list) +
    scale_fill_manual(values = c("coral", "darkgoldenrod3", "green4", "royalblue4", "royalblue4", "orchid3"))
  no_label <- list(
    theme(axis.title=element_blank(), axis.text=element_blank(), axis.ticks=element_blank(),
          legend.text=element_text(face = "bold", size = 12), 
          panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
          legend.title = element_text(face = "bold", hjust = 0.5)) +
      theme(legend.position = "none"))
  label <- list(
    theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank(),
          axis.title = element_text(face = "bold", size = 12),
          panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
          legend.text=element_text(),
          legend.title = element_text(face = "bold", hjust = 0.5)) +  theme(legend.position = "right", legend.box = "vertical"))
  if (ylabel == T) {
    finalplot <- finalplot + label
  }
  else if (ylabel == F) {
    finalplot <- finalplot + no_label
  }
  
  return(finalplot)
  
}
