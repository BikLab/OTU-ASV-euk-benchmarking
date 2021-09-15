rbind_column <- function(Dataframe1, Dataframe2, Dataframe3, Dataframe4, Variable, dataset = "NPRB") {
  if (dataset == "NPRB") {
    Dataframe1_Kept <- Dataframe1[ which(Dataframe1$data.Subregion == Variable), ] 
    Dataframe2_Kept <- Dataframe2[ which(Dataframe2$data.Subregion == Variable), ] 
    Dataframe3_Kept <- Dataframe3[ which(Dataframe3$data.Subregion == Variable), ] 
    Dataframe4_Kept <- Dataframe4[ which(Dataframe4$data.Subregion == Variable), ] 
    BoundDataframe <- rbind(Dataframe1_Kept, Dataframe2_Kept, Dataframe3_Kept, Dataframe4_Kept)
  }
  else if (dataset == "MEMB") {
    Dataframe1_Kept <- Dataframe1[ which(Dataframe1$data.NematodeFamily == Variable), ] 
    Dataframe2_Kept <- Dataframe2[ which(Dataframe2$data.NematodeFamily == Variable), ] 
    Dataframe3_Kept <- Dataframe3[ which(Dataframe3$data.NematodeFamily == Variable), ] 
    Dataframe4_Kept <- Dataframe4[ which(Dataframe4$data.NematodeFamily == Variable), ] 
    BoundDataframe <- rbind(Dataframe1_Kept, Dataframe2_Kept, Dataframe3_Kept, Dataframe4_Kept)
  }
  return(BoundDataframe)
}
