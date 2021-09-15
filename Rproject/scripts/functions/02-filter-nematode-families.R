filter_nematode_families <- function (biom = "") {
  newBiom = subset_samples(biom, NematodeFamily %in% c("Chromadoridae", "Comesomatidae", "Desmoscolecidae", "Oxystominidae"))
  return(newBiom)
}
