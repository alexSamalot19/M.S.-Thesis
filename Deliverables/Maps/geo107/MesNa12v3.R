mbObsKMeansNA<- read.csv("F:\\Meth34nBase\\mbKF107v3.csv", header=FALSE)
mbWRFMeansNA<- read.csv("F:\\Meth34nBase\\mbWRF107v3.csv", header=FALSE)
mbUKMeansNA<- read.csv("F:\\Meth34nBase\\mbRK107v3.csv", header=FALSE)

ObsKMeansNA<- read.csv("F:\\Meth34nBase\\KF107v3.csv", header=FALSE)
WRFMeansNA<- read.csv("F:\\Meth34nBase\\WRF107v3.csv", header=FALSE)
UKMeansNA<- read.csv("F:\\Meth34nBase\\RK107v3.csv", header=FALSE)

mbObsKMeansNAOM<-na.omit(mbObsKMeansNA)
mbWRFMeansNAOM<-na.omit(mbWRFMeansNA)
mbUKMeansNAOM<-na.omit(mbUKMeansNA)
ObsKMeansNAOM<-na.omit(ObsKMeansNA)
WRFMeansNAOM<-na.omit(WRFMeansNA)
UKMeansNAOM<-na.omit(UKMeansNA)

write.table(mbObsKMeansNAOM, file="F:\\Meth34nBase\\mbKFMeans107v3.csv", sep=",",  row.names=FALSE, col.names=FALSE)
write.table(mbWRFMeansNAOM, file="F:\\Meth34nBase\\mbWRFMeans107v3.csv", sep=",",  row.names=FALSE, col.names=FALSE)
write.table(mbUKMeansNAOM, file="F:\\Meth34nBase\\mbRKMeans107v3.csv", sep=",",  row.names=FALSE, col.names=FALSE)
write.table(ObsKMeansNAOM, file="F:\\Meth34nBase\\KFMeans107v3.csv", sep=",",  row.names=FALSE, col.names=FALSE)
write.table(WRFMeansNAOM, file="F:\\Meth34nBase\\WRFMeans107v3.csv", sep=",",  row.names=FALSE, col.names=FALSE)
write.table(UKMeansNAOM, file="F:\\Meth34nBase\\RKMeans107v3.csv", sep=",",  row.names=FALSE, col.names=FALSE)



