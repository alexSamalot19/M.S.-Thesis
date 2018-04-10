WRF107<- read.csv("F:\\Meth34nBase\\matDRDWRFv4.txt", header=FALSE)
RK107<- read.csv("F:\\Meth34nBase\\matDRDpKalv4.txt", header=FALSE)
KF107<- read.csv("F:\\Meth34nBase\\matDRDKalv4.txt", header=FALSE)
MetMad<- read.csv("C:\\Users\\alex\\Desktop\\Storm3Test\\MetMadMeso.txt", header=FALSE)


#FFmat<- read.csv("C:\\Users\\alex\\Desktop\\Storm3Test\\MesMapFF.txt", header=FALSE)
mbRK107<- read.csv("F:\\Meth34nBase\\matDRDpKalv4.txt", header=FALSE)
mbWRF107<- read.csv("F:\\Meth34nBase\\matDRDWRFv4.txt", header=FALSE)
mbKF107<- read.csv("F:\\Meth34nBase\\matDRDKalv4.txt", header=FALSE)

WRF107[WRF107==100] <- NA
RK107[RK107==100] <- NA
KF107[KF107==100] <- NA

#FFmat[FFmat==0] <- NA
mbRK107[mbRK107==100] <- NA
mbKF107[mbKF107==100] <- NA
mbWRF107[mbWRF107==100] <- NA

WRFMeans107<-rowMeans(WRF107,na.rm=TRUE)
RKMeans107<-rowMeans(RK107,na.rm=TRUE)
KFMeans107<-rowMeans(KF107,na.rm=TRUE)

mbKFMeans107<-rowMeans(mbKF107,na.rm=TRUE)
mbWRFMeans107<-rowMeans(mbWRF,na.rm=TRUE)
mbRKMeans107<-rowMeans(mbRK107,na.rm=TRUE)

write.csv(mbKFMeans107, file="F:\\Meth34nBase\\mbKF107v4.csv")
write.csv(mbWRFMeans107, file="F:\\Meth34nBase\\mbWRF107v4.csv")
write.csv(mbRKMeans107, file="F:\\Meth34nBase\\mbRK107v4.csv")

write.csv(KFMeans107, file="F:\\Meth34nBase\\KF107v4.csv")
write.csv(WRFMeans107, file="F:\\Meth34nBase\\WRF107v4.csv")
write.csv(RKMeans107, file="F:\\Meth34nBase\\RK107v4.csv")


