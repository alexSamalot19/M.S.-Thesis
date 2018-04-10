WRFLOI<- read.csv("F:\\CV62015Cast\\MatRloiWRF.txt", header=FALSE)
UKLOI<- read.csv("F:\\CV62015Cast\\MatRloiUK.txt", header=FALSE)
MetMad<- read.csv("C:\\Users\\alex\\Desktop\\Storm3Test\\MetMadMeso.txt", header=FALSE)


WRFLOI[WRFLOI==0] <- NA
WRFMeansLOI<-rowMeans(WRFLOI,na.rm=TRUE)

UKLOI[UKLOI==0] <- NA
UKMeansLOI<-rowMeans(UKLOI,na.rm=TRUE)

mbUKLOI<- read.csv("F:\\CV62015Cast\\MatBloiUK.txt", header=FALSE)
mbWRFLOI<- read.csv("F:\\CV62015Cast\\MatBloiWRF.txt", header=FALSE)

mbUKLOI[mbUKLOI==0] <- NA

mbWRFLOI[mbWRFLOI==0] <- NA

mbWRFMeansLOI<-rowMeans(mbWRFLOI,na.rm=TRUE)
mbUKMeansLOI<-rowMeans(mbUKLOI,na.rm=TRUE)

write.csv(mbWRFMeansLOI, file="C:\\Users\\alex\\Desktop\\Storm3Test\\LOImbWRFv2.csv")
write.csv(mbUKMeansLOI, file="C:\\Users\\alex\\Desktop\\Storm3Test\\LOImbUKv2.csv")
write.csv(WRFMeansLOI, file="C:\\Users\\alex\\Desktop\\Storm3Test\\LOIRWRFv2.csv")
write.csv(UKMeansLOI, file="C:\\Users\\alex\\Desktop\\Storm3Test\\LOIRUKv2.csv")


