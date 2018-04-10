for storm=1:11;
    
clearvars -except storm
DriveInfo=fullfile('media','alex','My Passport')
CompArray=['CEELab20';'CEELab26';'CEELab27';'CEELab05';'CEELab22'; ...
'CEELab23';'CEELab06';'CEELab21';'CEELab24';'CEELab07';'CEELab25'];%
stoArray=[6,16,29,39,44,57,64,69,81,96,105];%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
RN=stoArray(storm)%Rand #
STstring=num2str(RN);
string=STstring
starTime=RN
COMP=CompArray(storm,:);
%%%%%%%%%%%%%%%%%%%%%%%%%%%

MetarFo='KrInMetDiff';
    MadisFo='KrInMadDiff';
    AdjFo=['BiasCombOutDiff',STstring];
    BySTatFo=['BiasBStDiff',STstring];
    ZfFo=['BiasZfKrigDiff',STstring];
wksp=['CVGC',STstring,'.mat']

clearvars -except wksp storm
load(wksp)
% 
% 
% clear
% clc
% load('wksp6.mat')
  for y=1:(Cit-1)
    for dim=1:(RMval+1)
       
            %How does the change in dimension size
            %affect read
            placehold{1,1}=STelim2{1,dim};
            ph2=placehold{1,1}
            STelim{y,dim}=ph2{y,1};
        end
        
    end
  
for j=1:lif
    for t=1:(timnam-2)
        
        PredArray(t,1)=PredB(j,t);
        latFFArray(t,1)=latFF(j,t);
        
        BsqArray(t,1)= Bsquared(j,t);
        BiasArray(t,1)=Bias(j,t);
%         
%         
%         PWRFArray(t,1)=PredBWRF(j,t);
%         %latFFArray(t,1)=latFF(j,t);
%         
%         BsqWRFArray(t,1)= BsqWRF(j,t);
%         BWRFArray(t,1)=BiasWRF(j,t);
    end
    
    rmse=sqrt(mean(BsqArray));
    meanBias=mean(BiasArray);
    
    AvgFF=mean(latFFArray)
    AvgUKFF=mean(PredArray)
%     AvgFFWRF=mean(PWRFArray)
%     
%     rmseWRF=sqrt(mean(BsqWRFArray));
%     meanBiasWRF=mean(BWRFArray);
    
    maxData(1)=max(PredArray);
    maxData(2)=max(latFFArray);
%     maxData(3)=max(PWRFArray)
    minData(1)=min(PredArray);
    minData(2)=min(latFFArray);
%     minDat(3)=min(PWRFArray);
    
    axisMax=(max(maxData));
    axisMin=(min(minData));
 
    
    
    for dim=1:(RMval+1)
        
          FFname=['KalFFa',(STelim{j,dim}),'.csv']
        FFFo=fullfile(BySTatFo,FFname);
        blankmat=ones(2,2);
        dlmwrite(FFFo,latFFArray);
        
         FFUKname=['KPFFa',(STelim{j,dim}),'.csv']
        FFUKFo=fullfile(BySTatFo,FFUKname);
        blankmat=ones(2,2);
        dlmwrite(FFUKFo,PredArray);

    end
    
    
    
    
    
    %fn=num2str(j);
    %mkdir(BySTatFo,cell2mat(STelim{j,1}));
    %
    % NEUS=['NEUS',cell2mat(STelim{j,1}),STstring,'.png'];
    % NEUSFo=fullfile(BySTatFo,(STelim{j,1}),NEUS)
    % saveas(fig,NEUSFo);
end
% % %
% cd ..
%
end
