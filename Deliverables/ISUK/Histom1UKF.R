#Just Histograms>>
KalRMSE<-read.table("F:\\Meth34nBase\\loikfKalRMSE.txt", header=FALSE)
PkalRMSE<-read.table("F:\\Meth34nBase\\loikfPkalRMSE.txt", header=FALSE)
WRFrmse<-read.table("F:\\Meth34nBase\\loikfWRFrmse.txt", header=FALSE)

KalBIAS<-read.table("F:\\Meth34nBase\\loikfKalBIAS.txt", header=FALSE)
PkalBIAS<-read.table("F:\\Meth34nBase\\loikfPkalBIAS.txt", header=FALSE)
WRFbias<-read.table("F:\\Meth34nBase\\loikfWRFbias.txt", header=FALSE)
# #<<

#Absolute bias>>
ABSkalB<-abs(KalBIAS)
ABSpkalB<-abs(PkalBIAS)
ABSwrfB<-abs(WRFbias)

# #<<

library(ggplot2)
#Labeling>>
KalRMSE$Estimation<-'M1KF'
PkalRMSE$Estimation<-'UK'
WRFrmse$Estimation<-'WRF'

colnames(KalRMSE)[colnames(KalRMSE)=="V1"] <- "RMSE"
colnames(PkalRMSE)[colnames(PkalRMSE)=="V1"] <- "RMSE"
colnames(WRFrmse)[colnames(WRFrmse)=="V1"] <- "RMSE"

KalBIAS$Estimation<-'M1KF'
PkalBIAS$Estimation<-'UK'
WRFbias$Estimation<-'WRF'


colnames(KalBIAS)[colnames(KalBIAS)=="V1"] <- "Bias"
colnames(PkalBIAS)[colnames(PkalBIAS)=="V1"] <- "Bias"
colnames(WRFbias)[colnames(WRFbias)=="V1"] <- "Bias"

ABSkalB$Estimation<-'M1KF'
ABSpkalB$Estimation<-'UK'
ABSwrfB$Estimation<-'WRF'

colnames(ABSkalB)[colnames(ABSkalB)=="V1"] <- "AbsBias"
colnames(ABSpkalB)[colnames(ABSpkalB)=="V1"] <- "AbsBias"
colnames(ABSwrfB)[colnames(ABSwrfB)=="V1"] <- "AbsBias"

# #<<


#concatenate data
RMSElengths2<-rbind(PkalRMSE,WRFrmse,KalRMSE)
BIASlengths2<-rbind(PkalBIAS,WRFbias,KalBIAS)
ABSlengths2<-rbind(ABSpkalB,ABSwrfB,ABSkalB)
# #<<

#PDF's>>
ggplot(RMSElengths2,aes(RMSE,fill=Estimation))+geom_density(alpha=0.2)
ggplot(BIASlengths2,aes(Bias,fill=Estimation))+geom_density(alpha=0.2)
ggplot(ABSlengths2,aes(AbsBias,fill=Estimation))+geom_density(alpha=0.2)
# #<<

#Boxplots>>
boxplot(BIASlengths2$Bias~BIASlengths2$Estimation, main="Method 1 UK Bias Comparison",
        ylab="Bias (m/s)", col=(c("indianred1","palegreen","lightskyblue1")))
boxplot(ABSlengths2$AbsBias~ABSlengths2$Estimation, main="Method 1 Abs Bias",
        ylab="Abs Bias (m/s)", col=(c("indianred1","palegreen","lightskyblue1")))
boxplot(RMSElengths2$RMSE~RMSElengths2$Estimation, main="Method 1 RMSE Comparison", 
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



