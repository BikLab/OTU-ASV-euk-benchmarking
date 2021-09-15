read_otus_boxplot_facet <- function(df, yvar = "condition", ymax, labelposition, xvar = "condition", ylabel = F, breaks, pairwise = F, list = "", label.y, dataset = "") {
  finalplot <- ggplot(df, aes_string(x = xvar, y = yvar, fill = xvar)) + geom_boxplot() + facet_grid(~Method) +
    theme_linedraw() + theme(strip.text = element_text(size = 16),
                             axis.title = element_text(face = "bold", size = 12),
                             panel.grid.major = element_blank(), 
                             panel.grid.minor = element_blank()) +
    scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x), labels = trans_format("log10", math_format(10^.x)), limits = c(1e0,ymax), expand = c(0,0)) 
  no_label <- list(
    theme(axis.title=element_blank(), axis.text=element_blank(), axis.ticks=element_blank()) + theme(legend.position = "none"))
  label <- list(
    theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank(),
          legend.title=element_text(face = "bold", size = 12)) +  theme(legend.position = "right", legend.box = "vertical"))
  
  if (ylabel == T) {
    finalplot <- finalplot + label
  }
  else if (ylabel == F) {
    finalplot <- finalplot + no_label
  }
  
  if (pairwise == T) {
    finalplot <- finalplot + 
      stat_compare_means(label.y = label.y, label.x = labelposition, method = "kruskal.test", fontface = "bold", size = 3) +
      stat_compare_means(label = "p.signif", method = "wilcox.test", comparisons = list, show.legend = TRUE)
  }
  else if (pairwise == F) {
    finalplot <- finalplot + stat_compare_means(label.y = label.y, label.x = labelposition, method = "kruskal.test", fontface = "bold", size = 3)
  }
  
  if (dataset == "NPRB") {
    finalplot <- finalplot + scale_fill_manual(labels = c("Alaskan Beaufort Shelf", "Amundsen Gulf", "Banks Island", "Camden Bay", "Chukchi Sea", "Mackenzie River Plume"),
                                               values = c("coral", "darkgoldenrod3", "green4", "powderblue", "royalblue4", "orchid3"))
  }
  else if (dataset == "MEMB") {
    finalplot <- finalplot + scale_fill_manual(values = c("deeppink3", "lightsalmon", "seagreen1", "tan3"))
  }
  
  return(finalplot)
  
}
