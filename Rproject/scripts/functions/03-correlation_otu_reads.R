correlation_otu_reads <- function(df, xvar = "", yvar = "", color = "", yaxis = "", xaxis = "") {
  finalplot <- ggplot(df, aes_string(x = xvar, y = yvar, fill=color)) +
    geom_point(aes_string(fill = color, colour=color), pch=21) + 
    theme_linedraw() + theme(legend.position = "right", legend.box = "vertical") +
    geom_smooth(aes_string(color=color),method = "lm", se = FALSE) +
    scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x), labels = trans_format("log10", math_format(10^.x)), expand = c(0,0), limits = c(10^0, 10^6)) +
    scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x), labels = trans_format("log10", math_format(10^.x)), expand = c(0,0), limits = c(10^0, 10^4)) +
    stat_cor(aes(color = Method, label =paste(..rr.label.., p.label,cut(..p.., 
                                                                        breaks = c(-Inf, 0.0001, 0.001, 0.01, 0.05, Inf),
                                                                        labels = c("'****'", "'***'", "'**'", "'*'", "'ns'")), 
                                              sep = "~"), fontface = "bold"), label.x = 1, method = "pearson", show.legend = FALSE) +
    ylab(yaxis) + xlab(xaxis) +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
          axis.title = element_text(face = "bold", size = 12),
          legend.title = element_text(face = "bold", hjust = 0.5)) +
    scale_fill_manual(values = c("UCLUST" = "coral", "VSearch" = "darkgoldenrod3", "DADA2" = "green4", "Deblur" = "royalblue4")) +
    scale_color_manual(values = c("UCLUST" = "coral", "VSearch" = "darkgoldenrod3", "DADA2" = "green4", "Deblur" = "royalblue4")) 
  
  return(finalplot)
}
