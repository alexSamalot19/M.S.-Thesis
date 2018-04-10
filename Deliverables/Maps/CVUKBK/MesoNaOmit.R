mbObsKMeansNA<- read.csv("C:\\Users\\alex\\Desktop\\Storm3Test\\mbObsKMeans.csv", header=TRUE)
mbWRFMeansNA<- read.csv("C:\\Users\\alex\\Desktop\\Storm3Test\\mbWRFMeans.csv", header=TRUE)
mbUKMeansNA<- read.csv("C:\\Users\\alex\\Desktop\\Storm3Test\\mbUKMeans.csv", header=TRUE)

ObsKMeansNA<- read.csv("C:\\Users\\alex\\Desktop\\Storm3Test\\RMSEObsKMeans.csv", header=TRUE)
WRFMeansNA<- read.csv("C:\\Users\\alex\\Desktop\\Storm3Test\\RMSEWRFMeans.csv", header=TRUE)
UKMeansNA<- read.csv("C:\\Users\\alex\\Desktop\\Storm3Test\\RMSEUKMeans.csv", header=TRUE)

mbObsKMeansNAOM<-na.omit(mbObsKMeansNA)
mbWRFMeansNAOM<-na.omit(mbWRFMeansNA)
mbUKMeansNAOM<-na.omit(mbUKMeansNA)
ObsKMeansNAOM<-na.omit(ObsKMeansNA)
WRFMeansNAOM<-na.omit(WRFMeansNA)
UKMeansNAOM<-na.omit(UKMeansNA)

write.csv(mbObsKMeansNAOM, file="C:\\Users\\alex\\Desktop\\Storm3Test\\mbObsKMeansNAOM.csv")
write.csv(mbWRFMeansNAOM, file="C:\\Users\\alex\\Desktop\\Storm3Test\\mbWRFMeansNAOM.csv")
write.csv(mbUKMeansNAOM, file="C:\\Users\\alex\\Desktop\\Storm3Test\\mbUKMeansNAOM.csv")
write.csv(ObsKMeansNAOM, file="C:\\Users\\alex\\Desktop\\Storm3Test\\ObsKMeansNAOM.csv")
write.csv(WRFMeansNAOM, file="C:\\Users\\alex\\Desktop\\Storm3Test\\WRFMeansNAOM.csv")
write.csv(UKMeansNAOM, file="C:\\Users\\alex\\Desktop\\Storm3Test\\UKMeansNAOM.csv")



