plot_alpha_div <- function(phylo, div_measure, color= "", y = 0, dataset = "NPRB", Pairwise = F, pairwiseList, ylabel = 0) {
  info1 <- list(
    theme_linedraw(),
    geom_point(size = 3),
    geom_boxplot(aes_string(fill=color)),
    theme(axis.title = element_blank(), axis.text.x = element_blank(), 
          axis.ticks.x = element_blank(), panel.grid.minor = element_blank(), legend.title = element_text(face = "bold", size =12), 
          legend.title.align = 0.5, legend.text = element_text(size = 10), panel.grid.major = element_blank()),
    guides(shape = guide_legend(order = 0), color = guide_legend(order = 1, title = color)),
    labs(title = " "),
    stat_compare_means(label.y = ylabel, label.x = 1.6, method = "kruskal", fontface = "bold", size = 4)
  )
  
  finalplot <- plot_richness(phylo, x = color, measures = c(div_measure)) + scale_y_continuous(expand = c(0,0), limits = c(0,y)) + info1
  
  if (dataset == "NPRB") {
    finalplot <- finalplot + scale_fill_manual(labels = c("Alaskan Beaufort Shelf", "Amundsen Gulf", "Banks Island", "Camden Bay", "Chukchi Sea", "Mackenzie River Plume"),
                                               values = c("coral", "darkgoldenrod3", "green4", "powderblue", "royalblue4", "orchid3"))
  }
  else if (dataset == "MEMB") {
    finalplot <- finalplot + scale_fill_manual(values = c("deeppink3", "lightsalmon", "seagreen1", "tan3"))
  }
  
  if(Pairwise == T) {
    finalplot <- finalplot + stat_compare_means(label = "p.signif", method = "wilcox.test", comparisons = pairwiseList) 
  }
  return(finalplot)
  
}
