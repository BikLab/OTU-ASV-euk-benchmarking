plot_head_tail <- function(df, method, ymax, ylabel) {
  finalplot <- ggplot(df, aes(x = Rank/100, y = Abundance)) +
    geom_point(aes(fill = method, colour=method), pch=21) +
    theme_bw() +
    theme(legend.position = "none") +
    xlab("MOTU Rank * 100") +
    scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                  labels = trans_format("log10", math_format(10^.x)),
                  limits = c(1e0,ymax),
                  expand = c (0,0)) +
    scale_x_continuous(expand = c(0,0)) +
    scale_fill_manual(values = c("UCLUST"="coral", "VSearch"="darkgoldenrod3", "DADA2"="green4", "Deblur"="royalblue4")) +
    scale_color_manual(values = c("UCLUST"="coral", "VSearch"="darkgoldenrod3", "DADA2"="green4", "Deblur"="royalblue4")) 
  no_label <- list(
    theme(axis.title.y=element_blank(), axis.text.y=element_blank(), axis.ticks.y=element_blank(), axis.title = element_text(face = "bold", size = 12),
          panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + theme(legend.position = "none"))
  label <- list(
    theme(axis.title = element_text(face = "bold", size = 12), legend.text=element_text(face = "bold"), panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +  
      theme(legend.position = "none"))
  
  if (ylabel == T) {
    finalplot <- finalplot + label
  }
  else if (ylabel == F) {
    finalplot <- finalplot + no_label
  }
  return(finalplot)
}
