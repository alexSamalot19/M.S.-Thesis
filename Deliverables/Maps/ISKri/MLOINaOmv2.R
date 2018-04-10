#mbObsKMeansNA<- read.csv("C:\\Users\\alex\\Desktop\\Storm3Test\\mbObsKMeans.csv", header=TRUE)
mbWRFMeansNA<- read.csv("C:\\Users\\alex\\Desktop\\Storm3Test\\LOImbWRFv2.csv", header=FALSE)
mbUKMeansNA<- read.csv("C:\\Users\\alex\\Desktop\\Storm3Test\\LOImbUKv2.csv", header=FALSE)
#ObsKMeansNA<- read.csv("C:\\Users\\alex\\Desktop\\Storm3Test\\RMSEObsKMeans.csv", header=TRUE)
WRFMeansNA<- read.csv("C:\\Users\\alex\\Desktop\\Storm3Test\\LOIRWRFv2.csv", header=FALSE)
UKMeansNA<- read.csv("C:\\Users\\alex\\Desktop\\Storm3Test\\LOIRUKv2.csv", header=FALSE)

#mbObsKMeansNAOM<-na.omit(mbObsKMeansNA)
mbWRFMeansNAOM<-na.omit(mbWRFMeansNA)
mbUKMeansNAOM<-na.omit(mbUKMeansNA)
#ObsKMeansNAOM<-na.omit(ObsKMeansNA)
WRFMeansNAOM<-na.omit(WRFMeansNA)
UKMeansNAOM<-na.omit(UKMeansNA)

#write.csv(mbObsKMeansNAOM, file="C:\\Users\\alex\\Desktop\\Storm3Test\\mbObsKMeansNAOM.csv")
write.table(mbWRFMeansNAOM, file="C:\\Users\\alex\\Desktop\\Storm3Test\\LOImbWRFNAOMv2.csv", sep=",",  row.names=FALSE, col.names=FALSE)
write.table(mbUKMeansNAOM, file="C:\\Users\\alex\\Desktop\\Storm3Test\\LOImbUKNAOMv2.csv", sep=",",  row.names=FALSE, col.names=FALSE)
#write.csv(ObsKMeansNAOM, file="C:\\Users\\alex\\Desktop\\Storm3Test\\ObsKMeansNAOM.csv")
write.table(WRFMeansNAOM, file="C:\\Users\\alex\\Desktop\\Storm3Test\\LOIWRFNAOMv2.csv", sep=",",  row.names=FALSE, col.names=FALSE)
write.table(UKMeansNAOM, file="C:\\Users\\alex\\Desktop\\Storm3Test\\LOIUKNAOMv2.csv", sep=",",  row.names=FALSE, col.names=FALSE)



