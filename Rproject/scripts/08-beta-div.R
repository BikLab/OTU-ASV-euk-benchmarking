#################################
######### FOR HC Dataset ########
#################################
# beta div for uclust
hc_uclust_bray <- ordinate(hc_uclust_rarefied, "PCoA", "bray")
hc_uclust_ufrac  <- ordinate(hc_uclust_rarefied, "PCoA", "unifrac")
hc_uclust_wufrac  <- ordinate(hc_uclust_rarefied, "PCoA", "wunifrac")

# beta div for vsearch
hc_vsearch_bray <- ordinate(hc_vsearch_rarefied, "PCoA", "bray")
hc_vsearch_ufrac  <- ordinate(hc_vsearch_rarefied, "PCoA", "unifrac")
hc_vsearch_wufrac  <- ordinate(hc_vsearch_rarefied, "PCoA", "wunifrac")

# beta div for dada2
hc_dada2_bray <- ordinate(hc_dada2_rarefied, "PCoA", "bray")
hc_dada2_ufrac  <- ordinate(hc_dada2_rarefied, "PCoA", "unifrac")
hc_dada2_wufrac  <- ordinate(hc_dada2_rarefied, "PCoA", "wunifrac")

# beta div for deblur
hc_deblur_bray <- ordinate(hc_deblur_rarefied, "PCoA", "bray")
hc_deblur_ufrac  <- ordinate(hc_deblur_rarefied, "PCoA", "unifrac")
hc_deblur_wufrac  <- ordinate(hc_deblur_rarefied, "PCoA", "wunifrac")

#################################
######### FOR LC Dataset ########
#################################
# beta div for uclust
lc_uclust_bray <- ordinate(lc_uclust_rarefied, "PCoA", "bray")
lc_uclust_ufrac  <- ordinate(lc_uclust_rarefied, "PCoA", "unifrac")
lc_uclust_wufrac  <- ordinate(lc_uclust_rarefied, "PCoA", "wunifrac")

# beta div for vsearch
lc_vsearch_bray <- ordinate(lc_vsearch_rarefied, "PCoA", "bray")
lc_vsearch_ufrac  <- ordinate(lc_vsearch_rarefied, "PCoA", "unifrac")
lc_vsearch_wufrac  <- ordinate(lc_vsearch_rarefied, "PCoA", "wunifrac")

# beta div for dada2
lc_dada2_bray <- ordinate(lc_dada2_rarefied, "PCoA", "bray")
lc_dada2_ufrac  <- ordinate(lc_dada2_rarefied, "PCoA", "unifrac")
lc_dada2_wufrac  <- ordinate(lc_dada2_rarefied, "PCoA", "wunifrac")

# beta div for deblur
lc_deblur_bray <- ordinate(lc_deblur_rarefied, "PCoA", "bray")
lc_deblur_ufrac  <- ordinate(lc_deblur_rarefied, "PCoA", "unifrac")
lc_deblur_wufrac  <- ordinate(lc_deblur_rarefied, "PCoA", "wunifrac")

