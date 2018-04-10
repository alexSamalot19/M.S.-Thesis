% % % % % %Creating the new dacewind and artificial coordinates missing values
% % % % %creating the read matrix

clear
clc
% tiLCA=0
firstArray=dlmread('firstarray2.txt')
lastArray=dlmread('lastarray2.txt')
    
    
for storm=1:11;   
    
clearvars -except storm firstArray lastArray tiLCA
CompArray=['CEELab20';'CEELab26';'CEELab27';'CEELab05';'CEELab22'; ...
'CEELab23';'CEELab06';'CEELab21';'CEELab24';'CEELab07';'CEELab25'];%
stoArray=[6,16,29,39,44,57,64,69,81,96,105];%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
RN=stoArray(storm)%Rand #
STstring=num2str(RN);
string=STstring
starTime=RN
CompFo=CompArray(storm,:);
%%%%%%%%%%%%%%%%%%%%%%%%%%

SStime=firstArray(storm,1);
SSend=lastArray(storm,1);
%clearvars -except RN string SStime starTime STstring FoStat CompFo

MetarFo=['WindMetOut',STstring];
MadisFo=['WindMadOut',STstring];
AdjFo=['WindCombOut',STstring];
BySTatFo=['WindBStat',STstring];
ZfFo=['ZfKrig',STstring];
Wkvar=['fin',STstring,'.mat'];

clearvars -except Wkvar storm

load(Wkvar)

for j=1:lif-1
    for t=1:(timnam-2)
        
        PredArray(t,1)=KalmanG(j,t);
        latFFArray(t,1)=ObsG(j,t);
        PWRFArray(t,1)=WRFG(j,t);
%         
        BsqArrayKal(t,1)= BsqKal(j,t);
        BsqArrayWRF(t,1)= BsqWRF(j,t);
        
        BiasArrayKal(t,1)=BiasKal(j,t);
        BiasArrayWRF(t,1)=BiasWRF(j,t);
        
        
    end
    rmseKal=sqrt(mean(BsqArrayKal));
    rmseWRF=sqrt(mean(BsqArrayWRF));

    meanKal=mean(PredArray);
    meanWRF=mean(PWRFArray);
    
    meanBiasKal=mean(BiasArrayKal);
    meanBiasWRF=mean(BiasArrayWRF);
    

    
    for dim=1:(RMval+1)
%    
%         
%         RMSEn=['finKalRMSEwrf',(STelim{j,dim}),'.csv']
%         RMSEF=fullfile(BySTatFo,RMSEn);
%         blankmat=ones(2,2);
%         dlmwrite(RMSEF,(rmseWRF.*blankmat));
%         
%         RMSEname=['finRMSEkal',(STelim{j,dim}),'.csv']
%         RMSEFo=fullfile(BySTatFo,RMSEname);
%         blankmat=ones(2,2);
%         dlmwrite(RMSEFo,(rmseKal.*blankmat));
%         
%         
%         MEANn=['finMEANwrf',(STelim{j,dim}),'.csv']
%         RMSEF=fullfile(BySTatFo,MEANn);
%         blankmat=ones(2,2);
%         dlmwrite(RMSEF,(meanWRF.*blankmat));
        
        MEANname=['finMEANkalAR',(STelim{j,dim}),'.csv'];
        RMSEFo=fullfile(BySTatFo,MEANname);
        blankmat=ones(2,2);
        dlmwrite(RMSEFo,(PredArray));
        
        obsname=['finobscAR',(STelim{j,dim}),'.csv'];
        RMSEFo=fullfile(BySTatFo,obsname);
        blankmat=ones(2,2);
        dlmwrite(RMSEFo,(latFFArray));
              
         WRFname=['finWRFcAR',(STelim{j,dim}),'.csv'];
        RMSEFo=fullfile(BySTatFo,WRFname);
        blankmat=ones(2,2);
        dlmwrite(RMSEFo,(PWRFArray));
        
         %saveas(fig,NEUSFo);
    end
    
  
end
save(Wkvar)
end


