filter_outliers_ctrls <- function (biom = "") {
  newBiom = subset_samples(biom, SampleID != "MEMB.nem.95" & SampleID != "MEMB.nem.96" & SampleID != "MEMB.nem.99" &
                             SampleID != "MEMB.nem.105" & SampleID != "MEMB.nem.118" & SampleID != "MEMB.nem.125" & SampleID != "MEMB.nem.126" &
                             SampleID != "MEMB.nem.129" & SampleID != "MEMB.nem.141" &
                             SampleID != "MEMB.nem.150" & SampleID != "MEMB.nem.183" & SampleID != "MEMB.nem.184" & SampleID != "MEMB.nem.203" &
                             SampleID != "MEMB.nem.204" & SampleID != "MEMB.nem.235" & SampleID != "MEMB.nem.242" & SampleID != "MEMB.nem.260" &
                             SampleID != "MEMB.nem.261" & SampleID != "MEMB.nem.262" & SampleID != "MEMB.nem.281" & SampleID != "MEMB.nem.284" &
                             SampleID != "MEMB.nem.293" & SampleID != "MEMB.nem.294" & SampleID != "Neg.ctrl1" & SampleID != "Neg.ctrl2" &
                             SampleID != "Neg.ctrl3" & SampleID != "Neg.ctrl4" & SampleID != "Neg.ctrl5" & SampleID != "Zymo.stand.ctrl1" &
                             SampleID != "Zymo.stand.ctrl2" & SampleID != "Zymo.stand.ctrl3" & SampleID != "Zymo.stand.ctrl4" & SampleID != "Zymo.stand.ctrl5")
  return(newBiom)
}
