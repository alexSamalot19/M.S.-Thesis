WRF<- read.csv("C:\\Users\\alex\\Desktop\\Storm3Test\\MesoMapRMSEWRF.txt", header=FALSE)
UK<- read.csv("C:\\Users\\alex\\Desktop\\Storm3Test\\MesoMapRMSEmatUK.txt", header=FALSE)
ObsK<- read.csv("C:\\Users\\alex\\Desktop\\Storm3Test\\MesoMapObsK.txt", header=FALSE)
MetMad<- read.csv("C:\\Users\\alex\\Desktop\\Storm3Test\\MetMadMeso.txt", header=FALSE)


WRF[WRF==0] <- NA
WRFMeans<-rowMeans(WRF,na.rm=TRUE)

UK[UK==0] <- NA
UKMeans<-rowMeans(UK,na.rm=TRUE)

ObsK[ObsK==0] <- NA
ObsKMeans<-rowMeans(ObsK,na.rm=TRUE)

FFmat<- read.csv("C:\\Users\\alex\\Desktop\\Storm3Test\\MesoMapFF.txt", header=FALSE)
UKmat<- read.csv("C:\\Users\\alex\\Desktop\\Storm3Test\\MesoMapFFUK.txt", header=FALSE)
WRFmat<- read.csv("C:\\Users\\alex\\Desktop\\Storm3Test\\MesoMapWRF.txt", header=FALSE)
ObsKmat<- read.csv("C:\\Users\\alex\\Desktop\\Storm3Test\\MesoMapObsK.txt", header=FALSE)

FFmat[FFmat==0] <- NA

UKmat[UKmat==0] <- NA

ObsKmat[ObsKmat==0] <- NA

WRFmat[WRFmat==0] <- NA

Biaskmat=WRFmat-ObsKmat

mbObsK<-Biaskmat-FFmat
mbWRF<-WRFmat-FFmat
mbUK<-UKmat-FFmat
mbObsKMeans<-rowMeans(mbObsK,na.rm=TRUE)
mbWRFMeans<-rowMeans(mbWRF,na.rm=TRUE)
mbUKMeans<-rowMeans(mbUK,na.rm=TRUE)

write.csv(mbObsKMeans, file="C:\\Users\\alex\\Desktop\\Storm3Test\\mbObsKMeans.csv")
write.csv(mbWRFMeans, file="C:\\Users\\alex\\Desktop\\Storm3Test\\mbWRFMeans.csv")
write.csv(mbUKMeans, file="C:\\Users\\alex\\Desktop\\Storm3Test\\mbUKMeans.csv")

write.csv(ObsKMeans, file="C:\\Users\\alex\\Desktop\\Storm3Test\\RMSEObsKMeans.csv")
write.csv(WRFMeans, file="C:\\Users\\alex\\Desktop\\Storm3Test\\RMSEWRFMeans.csv")
write.csv(UKMeans, file="C:\\Users\\alex\\Desktop\\Storm3Test\\RMSEUKMeans.csv")


