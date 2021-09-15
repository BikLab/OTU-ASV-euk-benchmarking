### Source packages ###
files.sources = list.files("scripts/functions/", pattern = "*.R", full.names = T); sapply(files.sources, source)

#### Import Mapping Files #### 
hc_mapping_file <- import_qiime_sample_data("data/hc-dataset/mapping-file/hc-dataset-mapping-file.txt")
lc_mapping_file <- import_qiime_sample_data("data/lc-dataset/mapping-file/lc-dataset-mapping-file.txt")

#################################
######### FOR HC Dataset ########
#################################
##### INPUT HC VSearch - Was Large File Was Causing RStudio to Crash #####
hc_vsearch <- import_large_tables_phylo_obj(biom = "data/hc-dataset/vsearch/hc-vsearch-feature-table-sans-singletons-chimeras.biom",
                                            treefile = "data/hc-dataset/vsearch/hc-vsearch-rooted-tree-sans-singletons-chimeras.nwk",
                                            seqfile = "data/hc-dataset/vsearch/hc-vsearch-feature-sequences.fasta",
                                            taxonomy = "data/hc-dataset/vsearch/hc-vsearch-taxonomy-SILVA132-customDB-blast-90PercID.tsv",
                                            MappingFile = hc_mapping_file)

##### INPUT HC UCLUST - Was Large File Was Causing RStudio to Crash #####
hc_uclust <- import_large_tables_phylo_obj(biom = "data/hc-dataset/uclust/hc-uclust-feature-table-sans-singletons-chimeras.biom",
                                           treefile = "data/hc-dataset/uclust/hc-uclust-rooted-tree-sans-singletons-chimeras.tre",
                                           seqfile = "data/hc-dataset/uclust/hc-uclust-feature-sequences.fna",
                                           taxonomy = "data/hc-dataset/uclust/hc-uclust-taxonomy-SILVA132-customDB-blast-90PercID.tsv",
                                           MappingFile = hc_mapping_file)

##### INPUT HC DADA2 #####
hc_dada2 <- import_tables_phylo_obj(biom = "data/hc-dataset/dada2/hc-dada2-feature-table-taxonomy-SILVA132-customDB-blast-90PercID.biom",
                        treefile = "data/hc-dataset/dada2/hc-dada2-rooted-tree-sans-chimeras.nwk",
                        seqfile = "data/hc-dataset/dada2/hc-dada2-feature-sequences.fasta",
                        MappingFile = hc_mapping_file, data = "hc_DADA2")

##### INPUT HC Deblur #####
hc_deblur <- import_tables_phylo_obj(biom = "data/hc-dataset/deblur/hc-deblur-feature-table-taxonomy-SILVA132-customDB-blast-90PercID.biom",
                         treefile = "data/hc-dataset/deblur/hc-deblur-rooted-tree-sans-chimeras.nwk",
                         seqfile = "data/hc-dataset/deblur/hc-deblur-feature-sequences.fasta",
                         MappingFile = hc_mapping_file)

#################################
######### FOR LC Dataset ########
#################################
##### INPUT MEMB BiomTable #####
lc_uclust <- import_tables_phylo_obj(biom = "data/lc-dataset/uclust/lc-uclust-feature-table-taxonomy-SILVA132-customDB-blast-90PercID.biom", 
                         treefile = "data/lc-dataset/uclust/lc-uclust-rooted-tree-sans-singletons-chimeras.tre",
                         seqfile = "data/lc-dataset/uclust/lc-uclust-feature-sequences.fa",
                         MappingFile = lc_mapping_file)

lc_vsearch <- import_tables_phylo_obj(biom = "data/lc-dataset/vsearch/lc-vsearch-feature-table-taxonomy-SILVA132-customDB-blast-90PercID.biom", 
                          treefile = "data/lc-dataset/vsearch/lc-vsearch-rooted-tree-sans-singletons-chimeras.nwk",
                          seqfile = "data/lc-dataset/vsearch/lc-vsearch-feature-sequences.fa",
                          MappingFile = lc_mapping_file)

lc_dada2 <- import_tables_phylo_obj(biom = "data/lc-dataset/dada2/lc-dada2-feature-table-taxonomy-SILVA132-customDB-blast-90PercID.biom",
                        treefile = "data/lc-dataset/dada2/lc-dada2-rooted-tree-sans-chimeras.nwk",
                        seqfile = "data/lc-dataset/dada2/lc-dada2-feature-sequences.fa",
                        MappingFile = lc_mapping_file, data = "lc_dada2")

lc_deblur <- import_tables_phylo_obj(biom = "data/lc-dataset/deblur/lc-deblur-feature-table-taxonomy-SILVA132-customDB-blast-90PercID.biom",
                         treefile = "data/lc-dataset/deblur/lc-deblur-rooted-tree-sans-chimeras.nwk",
                         seqfile = "data/lc-dataset/deblur/lc-deblur-feature-sequences.fa",
                         MappingFile = lc_mapping_file, data = "lc_deblur")

##### For LC Dataset Remove Outliers #####
lc_uclust <- filter_outliers_ctrls(lc_uclust)
lc_vsearch <- filter_outliers_ctrls(lc_vsearch)
lc_dada2 <- filter_outliers_ctrls(lc_dada2)
lc_deblur <- filter_outliers_ctrls(lc_deblur)


