CalculateAlphaDiv <- function(PhyObject, DivMeasurement, ClusteringMethod) {
  DiversityMeasurement <- plot_richness(PhyObject, x = "Subregion", measures = c(DivMeasurement)) 
  DiversityMeasurementDataframe <- as.data.frame(DiversityMeasurement["data"])
  DiversityMeasurementDataframe$Method <- ClusteringMethod
  return(DiversityMeasurementDataframe)
}
