##### Merge All OTU Tables to Phyloseq Objects #####
vsearch_phylo <- phyloseq(OTU, TAX, sample_data(mapdf))
uclust_phylo <- merge_phyloseq(uclust_biom, mapdf)
dada2_phylo <- merge_phyloseq(dada2_biom, mapdf)

##### Clean up Data - Remove Prefix From Taxq #####
tax_table(vsearch_phylo) <- gsub('D_[0-9]__','', tax_table(vsearch_phylo))
tax_table(uclust_phylo) <- gsub('D_[0-9]__','', tax_table(uclust_phylo))
tax_table(dada2_phylo) <- gsub('D_[0-9]__','', tax_table(dada2_phylo))

##### Clean up Data - Remove Singletons & Taxa Containing Mitochondria/Chloroplast #####
vsearch_phylo_filtered <- subset_taxa(vsearch_phylo, !Rank5=="Mitochondria" & !Rank3=="Chloroplast")
otu_table(vsearch_phylo_filtered) = otu_table(vsearch_phylo_filtered)[rowSums(otu_table(vsearch_phylo_filtered)) > 1,]

uclust_phylo_filtered <- subset_taxa(uclust_phylo, !Rank5=="Mitochondria" & !Rank3=="Chloroplast")
otu_table(uclust_phylo_filtered) = otu_table(uclust_phylo_filtered)[rowSums(otu_table(uclust_phylo_filtered)) > 1,]

dada2_phylo_filtered <- subset_taxa(dada2_phylo, !Rank5=="Mitochondria" & !Rank3=="Chloroplast")
otu_table(dada2_phylo_filtered) = otu_table(dada2_phylo_filtered)[rowSums(otu_table(dada2_phylo_filtered)) > 1,]
