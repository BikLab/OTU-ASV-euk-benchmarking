plot_asv_patterns <- function(df, ymax, xmax) {
  finalplot <- ggplot(df, aes(x = Rank, y = Abundance)) +
    geom_point(aes(fill = method, colour= method), pch=21) +
    facet_wrap(~ Sample) +
    theme_bw() +
    theme(legend.position = "none") +
    scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                  labels = trans_format("log10", math_format(10^.x)),
                  limits = c(1e0,ymax), expand = c(0,0)) +
    scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                  labels = trans_format("log10", math_format(10^.x)),
                  limits = c(1e0,xmax), expand = c(0,0)) +
    scale_fill_manual(values = c("UCLUST"="coral", "VSearch"="darkgoldenrod3", "DADA2"="green4", "Deblur"="royalblue4")) +
    scale_color_manual(values = c("UCLUST"="coral", "VSearch"="darkgoldenrod3", "DADA2"="green4", "Deblur"="royalblue4")) 
  
  label <- list(
    theme(axis.title = element_text(face = "bold", size = 12), panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +  
      theme(legend.position = "right", legend.box = "vertical", legend.title = element_text(face = "bold", hjust = 0.5)))
  finalPlot <- finalplot + label
  return(finalPlot)
}
