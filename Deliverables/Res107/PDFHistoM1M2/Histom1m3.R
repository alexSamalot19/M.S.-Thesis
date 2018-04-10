#Just Histograms>>
KalRMSE<-read.table("F:\\Meth34nBase\\KalRMSE13.txt", header=FALSE)
PkalRMSE<-read.table("F:\\Meth34nBase\\PkalRMSE13.txt", header=FALSE)
WRFrmse<-read.table("F:\\Meth34nBase\\WRFrmse13.txt", header=FALSE)

KalBIAS<-read.table("F:\\Meth34nBase\\KalBIAS13.txt", header=FALSE)
PkalBIAS<-read.table("F:\\Meth34nBase\\PkalBIAS13.txt", header=FALSE)
WRFbias<-read.table("F:\\Meth34nBase\\WRFbias13.txt", header=FALSE)
# #<<

#Absolute bias>>
ABSkalB<-abs(KalBIAS)
ABSpkalB<-abs(PkalBIAS)
ABSwrfB<-abs(WRFbias)

# #<<

library(ggplot2)
#Labeling>>
KalRMSE$Estimation<-'M1 KF'
PkalRMSE$Estimation<-'M2 RK'
WRFrmse$Estimation<-'WRF'

colnames(KalRMSE)[colnames(KalRMSE)=="V1"] <- "RMSE"
colnames(PkalRMSE)[colnames(PkalRMSE)=="V1"] <- "RMSE"
colnames(WRFrmse)[colnames(WRFrmse)=="V1"] <- "RMSE"

KalBIAS$Estimation<-'M1 KF'
PkalBIAS$Estimation<-'M2 RK'
WRFbias$Estimation<-'WRF'


colnames(KalBIAS)[colnames(KalBIAS)=="V1"] <- "Bias"
colnames(PkalBIAS)[colnames(PkalBIAS)=="V1"] <- "Bias"
colnames(WRFbias)[colnames(WRFbias)=="V1"] <- "Bias"

ABSkalB$Estimation<-'M1 KF'
ABSpkalB$Estimation<-'M2 RK'
ABSwrfB$Estimation<-'WRF'

colnames(ABSkalB)[colnames(ABSkalB)=="V1"] <- "AbsBias"
colnames(ABSpkalB)[colnames(ABSpkalB)=="V1"] <- "AbsBias"
colnames(ABSwrfB)[colnames(ABSwrfB)=="V1"] <- "AbsBias"

# #<<


#concatenate data
RMSElengths<-rbind(PkalRMSE,KalRMSE,WRFrmse)
BIASlengths<-rbind(PkalBIAS,KalBIAS,WRFbias)
ABSlengths<-rbind(ABSpkalB,ABSkalB,ABSwrfB)
# #<<

#PDF's>>
ggplot(RMSElengths,aes(RMSE,fill=Estimation))+geom_density(alpha=0.2)
ggplot(BIASlengths,aes(Bias,fill=Estimation))+geom_density(alpha=0.2)
ggplot(ABSlengths,aes(AbsBias,fill=Estimation))+geom_density(alpha=0.2)
# #<<

#Boxplots>>
boxplot(BIASlengths$Bias~BIASlengths$Estimation, main="Final Output Bias",
        ylab="Bias (m/s)", col=(c("indianred1","palegreen","lightskyblue1")))
boxplot(ABSlengths$AbsBias~ABSlengths$Estimation, main="Final Output Abs Bias",
        ylab="Abs Bias (m/s)", col=(c("indianred1","palegreen","lightskyblue1")))
boxplot(RMSElengths$RMSE~RMSElengths$Estimation, main="Final Output RMSE", 
        ylab="RMSE (m/s)", col=(c("indianred1","palegreen","lightskyblue1")))
# #<<






#Assorted Loose Stats, not really essential>>
kalrms<-sapply(KalRMSE,as.numeric)
hist(kalrms)

pkalrms<-sapply(PkalRMSE,as.numeric)
hist(pkalrms)

wrfrms<-sapply(WRFrmse,as.numeric)
hist(wrfrms)

kalb<-sapply(KalBIAS,as.numeric)
hist(kalb)

pkalb<-sapply(PkalBIAS,as.numeric)
hist(pkalb)

wrfb<-sapply(WRFbias,as.numeric)
hist(wrfb)
# #<<



