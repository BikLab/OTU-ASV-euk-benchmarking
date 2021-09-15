plot_alpha_div_methods <- function(df1, df2, df3, df4, Ylimit, Pairwise, pairwiseList, Ylabel, variable = "", data = "") {
  rbound_dataset <- rbind_column(df1, df2, df3, df4, Variable = variable , dataset = data)
  rbound_dataset$Method <- factor(rbound_dataset$Method, c("UCLUST", "VSearch", "DADA2", "Deblur"))
  switch(Pairwise, 
         yes = ggplot(rbound_dataset, aes(x = Method, y = data.value, fill = Method)) + geom_boxplot() +
           stat_compare_means(label.y = Ylabel, label.x = 1.5, method = "kruskal.test", fontface = "bold", size = 4) +
           stat_compare_means(label = "p.signif", method = "wilcox.test", comparisons = pairwiseList, correct = F) +
           scale_fill_manual(values = c("coral", "darkgoldenrod3", "green4", "royalblue4", "orchid3")) +
           scale_y_continuous(expand = c(0,0), limits = c(0, Ylimit)) + theme_bw() +
           theme(axis.title = element_blank(), axis.text.x = element_blank(), 
                 axis.ticks.x = element_blank(), panel.grid.minor = element_blank(), legend.title = element_text(face = "bold", size =12), 
                 legend.title.align = 0.5, legend.text = element_text(size = 10), panel.grid.major = element_blank()) +
           guides(shape = guide_legend(order = 0), color = guide_legend(order = 1, title = "Subregion")), 
         no = ggplot(rbound_dataset, aes(x = Method, y = data.value, fill = Method)) + geom_boxplot() +
           stat_compare_means(label.y = Ylabel, label.x = 1, method = "kruskal.test", fontface = "bold", size = 4) +
           scale_fill_manual(values = c("coral", "darkgoldenrod3", "green4", "royalblue4", "orchid3")) +
           scale_y_continuous(expand = c(0,0), limits = c(0, Ylimit)) + theme_bw() +
           theme(axis.title = element_blank(), axis.text.x = element_blank(), 
                 axis.ticks.x = element_blank(), panel.grid.minor = element_blank(), legend.title = element_text(face = "bold", size =12), 
                 legend.title.align = 0.5, legend.text = element_text(size = 10), panel.grid.major = element_blank()) +
           guides(shape = guide_legend(order = 0), color = guide_legend(order = 1, title = "Subregion")),
         stop("Unkown parameter!"))
}
