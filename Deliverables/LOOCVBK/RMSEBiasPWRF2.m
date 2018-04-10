% % %coment>copy/paste style code
% clear
% clc
%    ti=0;
% %Read Stormlist%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% filename='Stormlist.csv'
% FID=fopen(filename,'r')
% 
% Stnum = 1;
% while(~feof(FID));
%     
%     InputText =textscan(FID, '%s',1,'delimiter', '\n');
%     sizeT = size(InputText{1});
%     if sizeT(1)>0;
%         Storm{Stnum,1} = InputText{1};
%         Stnum = Stnum+1;
%     end
% end
% fclose(FID)
% 
% mkdir('BiasPWRFBSO')
% %make output folders
% % for i=1:(Stnum-1)
% %     mkdir(fullfile('ByStatOut',str2mat(Storm{i,1})))
% % end
% % %
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
% %Read MetMad%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% filename='MetMad.csv'
% FID=fopen(filename,'r')
% 
% Statnum = 1;
% while(~feof(FID));
%     
%     InputText =textscan(FID, '%s %s %s %s %s',1,'delimiter', ',');
%     sizeT = size(InputText{1});
%     if sizeT(1)>0;
%         FoStat{Statnum,1} = InputText{1};
%         Statnum = Statnum+1;
%     end
% end
% fclose(FID)
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %For element in (Stormlist)
% for st=1:(Stnum-1)
%     
%     
%     ElimName=['HElim',cell2mat(Storm{st,1})]
%     MaxName=['MaxReps',cell2mat(Storm{st,1})]
%     
%     locInp=['BiasBStat',cell2mat(Storm{st,1})];
%     locInp2=['WindBStat',cell2mat(Storm{st,1})];
%     locOut=['BiasPWRFBSO'];
%     
%     FNStoSta = fullfile(locInp,[ElimName,'.csv']);
%     MRname=fullfile(locInp,[MaxName,'.csv']);
%     maxReps=dlmread(MRname)
%     
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     %%%%ElimArray
%     %     ElimName=['Elim',,'.csv'];
%     %     MaxName= ['MaxReps',,'.csv'];
%     
%     ElimFo = fullfile(FNStoSta);
%     %     Reps=dlmread(fullfile(locInp,maxReps));
%     RMval=(maxReps(1,1));
%     howmany=0;
%     ElimID=fopen(ElimFo,'r');
%     Elimnum = 1;
%     while(~feof(ElimID));
%         % %Test this before running main code
%         if (RMval+1)==1
%             STelim2 =textscan(ElimID, '%s',1,'delimiter', ',');
%         end
%         howmany=howmany+1
%         
%         if (RMval+1)==2
%             STelim2 =textscan(ElimID, '%s %s','Delimiter',',');
%         end
%         
%         if (RMval+1)==3
%             STelim2 =textscan(ElimID, '%s %s %s',1,'delimiter', ',');
%         end
%         
%         if (RMval+1)==3
%             error('New Maximum >3')
%         end
%         
%         % %
%         %     Stnum=1;
%         %     sizeT = size(STelim{1});
%         %     if sizeT(1)>0;
%         %         STelim{Stnum,1} = SThold{1};
%         %         Stnum = Stnum+1;
%         %     end
%     end
%     fclose(ElimID)
%     SE=size(STelim2{1})
%     % %Note, this looks like an older version, make sure utd
%     for y=1:SE
%         for dim=1:(RMval+1)
%             
%             %How does the change in dimension size
%             %affect read
%             placehold{1,1}=STelim2{1,dim};
%             ph2=placehold{1,1}
%             STelim{y,dim}=ph2{y,1};
%         end
%         
%     end
%     numElim=size(STelim)
%     
%     for w=1:(Statnum-1)
%         
%         test=cell2mat(FoStat{w,1})
%         
%      
%         %For element in (MetMad)
%         for dimloop=1:(RMval+1)%Is RMval present yet?
%             
%             for MM=1:(SE-2)%MM IS NOT MedMad... its Elim
%                 
%                 filena=STelim(MM,dimloop)
%                 check=cell2mat(filena)
%                 StormPlace=Storm(st,1)
%                 stormname=cell2mat(StormPlace{1})
%                 sn=num2str(stormname)
%                 if size(test)==size(check)
%                     if test==check
%                         
% 
% %                         
%                         pk=exist(fullfile(locInp,strcat(['Bias',cell2mat(filena),'.csv'])))
%                         if pk>0
%                             placeFF=dlmread(fullfile(locInp,strcat(['Bias',cell2mat(filena),'.csv'])));
%                             FFmat(w,st)=placeFF(1,1);
%                             ti=ti+1;
%                             latFFArray(ti,1)=placeFF(1,1);
%                             
%                         end
%                         
% 						pk=exist(fullfile(locInp,strcat(['BiasRMSE',cell2mat(filena),'.csv'])))
%                         if pk>0
%                             placeUK=dlmread(fullfile(locInp,strcat(['BiasRMSE',cell2mat(filena),'.csv'])))
%                             RMSEmatUK(w,st)=placeUK(1,1)
% 							RMSEobsK(ti,1)=placeUK(1,1);
%                         end
% 						
% 						
%                         %%%%%%%%%WRF%%%%%%%%%%%%%%%%%%%%%
%                         pk=exist(fullfile(locInp2,strcat(['RMSEWRF',cell2mat(filena),'.csv'])))
%                         if pk>0
%                             RMSEWRF=dlmread(fullfile(locInp2,strcat(['RMSEWRF',cell2mat(filena),'.csv'])))
%                             RMSEWRFmat(w,st)=RMSEWRF(1,1)
% 							RMSEwrf(ti,1)=RMSEWRF(1,1)
%                         end                      
%                                                 
%                          pk=exist(fullfile(locInp2,strcat(['FFWRF',cell2mat(filena),'.csv'])))
%                         if pk>0
%                             FFWRF=dlmread(fullfile(locInp2,strcat(['FFWRF',cell2mat(filena),'.csv'])))
%                             FFWRFmat(w,st)=FFWRF(1,1)
%                             PWRFArray(ti,1)=FFWRF(1,1);
%                         end
%                         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         
%                         pk=exist(fullfile(locInp,strcat(['BiasUK',cell2mat(filena),'.csv'])))
%                         if pk>0
%                             FFUK=dlmread(fullfile(locInp,strcat(['BiasUK',cell2mat(filena),'.csv'])))
%                             FFmatUK(w,st)=FFUK(1,1)
%                             PredArray(ti,1)=FFUK(1,1)
%                         end
% %                         
% %                         pk=exist(fullfile(locInp,strcat(['FFWRF',cell2mat(filena),'.csv'])))
% %                         if pk>0
% %                             FFWRF=dlmread(fullfile(locInp,strcat(['FFWRF',cell2mat(filena),'.csv'])))
% %                             FFWRFmat(w,st)=FFWRF(1,1)
% %                             PWRFArray(ti,1)=FFWRF(1,1);
% %                         end
% %                         
% %                         pk=exist(fullfile(locInp,strcat(['RMSEWRF',cell2mat(filena),'.csv'])))
% %                         if pk>0
% %                             RMSEWRF=dlmread(fullfile(locInp,strcat(['RMSEWRF',cell2mat(filena),'.csv'])))
% %                             RMSEWRFmat(w,st)=RMSEWRF(1,1)
% %                         end
% %                         
% %                         
%                     end
%                     
%                     
%                     
%                     
%                 end
%    
%                 
%             end
%             
%         end
%     end
% end
% latFFArray=PWRFArray-latFFArray;
% PredArray=PWRFArray-PredArray;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         BsqArray=(PredArray-latFFArray).^2;
%         BiasArray=PredArray-latFFArray;;
% %         PredB(iiiii,matcheck)=KriBclose;
% %         latFF(iiiii,matcheck)=ff{iiiii,1};
% %         
%         
%        BsqWRFArray=(PWRFArray-latFFArray).^2;
%        BWRFArray=(PWRFArray-latFFArray);
%          %PredBWRF(iiiii,matcheck)=WRFclose;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     rmse=mean(RMSEobsK);
%     meanBias=mean(BiasArray);
%     
%     AvgFF=mean(latFFArray)
%     AvgUKFF=mean(PredArray)
%    AvgFFWRF=mean(PWRFArray)
%     rmseWRF=mean(RMSEwrf);
%    meanBiasWRF=mean(BWRFArray);
%     
%     maxData(1)=max(PredArray);
%     maxData(2)=max(latFFArray);
%    maxData(3)=max(PWRFArray)
%     minData(1)=min(PredArray);
%     minData(2)=min(latFFArray);
%     minDat(3)=min(PWRFArray);
%     
%     axisMax=(max(maxData));
%     axisMin=(min(minData));
%     % %%Automatic Plotting
%  save('PlotBPWRF.mat')

clear
clc
load('PlotBPWRF.mat')
    
    fig = figure;
    R=corrcoef(latFFArray, PredArray);
    scatter(latFFArray,PWRFArray,'r');
    hold on
    scatter(latFFArray,PredArray,'m');
    
    RWRF=corrcoef(latFFArray, PWRFArray);
       
     hold on;
    P=polyfit(latFFArray,PredArray,1);
    yfit=P(1)*latFFArray+P(2);
    
    PWRF=polyfit(latFFArray,PWRFArray,1);
    yfitWRF=PWRF(1)*latFFArray+PWRF(2);
    
    hold on;
    plot(latFFArray,yfitWRF,'-r');
    
    hold on;
    plot(latFFArray,yfit,'-m');
    
     
    hold on
   refX=[0:axisMax];
   refY=[0:axisMax];
   line(refX,refY,'Color','k')
%    fd=TimeCell{1}
 %   firstDay=cell2mat(fd)
    % titlestring=['y=',num2str(P(1)),'x+',num2str(P(2)),' R^2=',num2str(R(1,2))];
    % title(titlestring);
    line1 ='Bias UK LOO CV Wind Speed 11 Storm Events'
    line1p5='and Corresponding WRF Predictions';
    %['Station ID:  ',(STelim{j,1}),' ','Storm:  ', firstDay(1:8)]
%     line2 =['UK RMSE (m/s)=',num2str(rmse)];
%     line3=['UK Mean Bias (m/s)=',num2str(meanBias)];
%     line4=['UK R^2=',num2str(R(1,2))];
 line2 =['WRF with CV Bias RMSE (m/s)=',num2str(rmse), '   ','WRF RMSE (m/s)=',num2str(2.0566)];
    line3=['WRF with CV Bias Mean Bias (m/s)=',num2str(meanBias),'   ','WRF Mean Bias(m/s)=',num2str(meanBiasWRF)];
    line4=['WRF with CV Bias R^2=',num2str(R(1,2)),'   ','WRF R^2=',num2str(RWRF(1,2))];
    lines ={line1,line1p5}%line2,line3,line4};
    
    title(lines);
    axis([axisMin axisMax axisMin axisMax]);
    xlabel('Observed Wind Speed (m/s)');
    ylabel('Estimated Wind Speed (m/s)');
    
    %gcf=.pdf';
    %pname=[ statname{1,plottick +2}, '.pdf' ];
    
    
    
    theString = sprintf('y = %.2f x + %.2f', P(1),P(2));
     theWRFString = sprintf('y = %.2f x + %.2f', PWRF(1),PWRF(2));
    %text((1),axisMax, theString, 'FontSize', 10);
    legend('WRF','BK CV',theString,theWRFString, ...
        '1:1 Reference Line','Location','southeast');
    
    
    hold off;
       
     NEUS=['BPWRF.png'];
        %NEUSFo=fullfile(BySTatFo,NEUS)
        saveas(fig,NEUS);
%    error('look at first')
%     %%Just UK%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig = figure;
    R=corrcoef(latFFArray, PredArray);
    scatter(latFFArray,PredArray,'m');
    
    %RWRF=corrcoef(latFFArray, PWRFArray);
       
     %hold on;
    %catter(latFFArray,PWRFArray,'c');
    P=polyfit(latFFArray,PredArray,1);
    yfit=P(1)*latFFArray+P(2);
    
    %PWRF=polyfit(latFFArray,PWRFArray,1);
    %yfitWRF=PWRF(1)*latFFArray+PWRF(2);
    
    hold on;
    plot(latFFArray,yfit,'-m');
    
    % hold on;
    %lot(latFFArray,yfitWRF,'-c');
    refX=[0:axisMax];
refY=[0:axisMax];
   line(refX,refY,'Color','k')
    
%    fd=TimeCell{1}
 %   firstDay=cell2mat(fd)
    % titlestring=['y=',num2str(P(1)),'x+',num2str(P(2)),' R^2=',num2str(R(1,2))];
    % title(titlestring);
    line1 ='BK LOOCV Wind vs. Observed Wind 10% of Storms'
    %line1p5='WRF Prediction with Bias Field ';
    %['Station ID:  ',(STelim{j,1}),' ','Storm:  ', firstDay(1:8)]
%     line2 =['UK RMSE (m/s)=',num2str(rmse)];
%     line3=['UK Mean Bias (m/s)=',num2str(meanBias)];
%     line4=['UK R^2=',num2str(R(1,2))];
 line2 =['WRF with CV Bias RMSE (m/s)=',num2str(rmse)];
    line3=['WRF with CV Bias Mean Bias (m/s)=',num2str(meanBias)];
    line4=['WRF with CV Bias R^2=',num2str(R(1,2))];
    lines ={line1,line2,line3,line4};
    
    title(line1);
    axis([axisMin axisMax axisMin axisMax]);
   xlabel('Observed Wind Speed (m/s)');
    ylabel('Estimated Wind Speed (m/s)');
    
    %gcf=.pdf';
    %pname=[ statname{1,plottick +2}, '.pdf' ];
    
    
    
    theString = sprintf('y = %.2f x + %.2f', P(1),P(2));
     theWRFString = sprintf('y = %.2f x + %.2f', PWRF(1),PWRF(2));
    %text((1),axisMax, theString, 'FontSize', 10);
    legend('BK CV',theString, ...
        '1:1 Reference Line','Location','southeast');
    
    
    hold off;











%     
%     fig = figure;
%     R=corrcoef(latFFArray, PredArray);
%     scatter(latFFArray,PredArray,'g');
%     
% %     RWRF=corrcoef(latFFArray, PWRFArray);
%        
%      hold on;
% %     scatter(latFFArray,PWRFArray,'c');
%     P=polyfit(latFFArray,PredArray,1);
%     yfit=P(1)*latFFArray+P(2);
%     
% %     PWRF=polyfit(latFFArray,PWRFArray,1);
% %     yfitWRF=PWRF(1)*latFFArray+PWRF(2);
%     
%     hold on;
%     plot(latFFArray,yfit,'-g');
% %     
% %      hold on;
% %     plot(latFFArray,yfitWRF,'-c');
%     hold on
%     hline = refline([1 0]);
%      hline.Color = 'r';
%     
% %    fd=TimeCell{1}
%  %   firstDay=cell2mat(fd)
%     % titlestring=['y=',num2str(P(1)),'x+',num2str(P(2)),' R^2=',num2str(R(1,2))];
%     % title(titlestring);
%     line1 ='All Storms';
%     %['Station ID:  ',(STelim{j,1}),' ','Storm:  ', firstDay(1:8)]
%     line2 =['UK RMSE (m/s)=',num2str(rmse)];
%     line3=['UK Mean Bias (m/s)=',num2str(meanBias)];
%     line4=['UK R^2=',num2str(R(1,2))];
%  
%     lines ={line1,line2,line3,line4};
%     
%     title(lines);
%     axis([0 axisMax 0 axisMax]);
%     xlabel('Storm Average NE US Observed Wind Speed (m/s)');
%     ylabel('Storm Average Estimated Wind Speed (m/s)');
%     
%     %gcf=.pdf';
%     %pname=[ statname{1,plottick +2}, '.pdf' ];
%     
%     
%     theString = sprintf('y = %.2f x + %.2f', P(1),P(2));
% %      theWRFString = sprintf('y = %.2f x + %.2f', PWRF(1),PWRF(2));
%     %text((1),axisMax, theString, 'FontSize', 10);
%     legend('UK Estimate',theString, ...
%         '1:1 Reference Line','Location','northwest');
%     
%     
%     hold off;
%     
%     
%     
%     %Just WRF %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     fig = figure;
% %     R=corrcoef(latFFArray, PredArray);
% %     scatter(latFFArray,PredArray,'g');
% %     
%     RWRF=corrcoef(latFFArray, PWRFArray);
%        
% %      hold on;
%     scatter(latFFArray,PWRFArray,'c');
% %     P=polyfit(latFFArray,PredArray,1);
% %     yfit=P(1)*latFFArray+P(2);
%     
%     PWRF=polyfit(latFFArray,PWRFArray,1);
%     yfitWRF=PWRF(1)*latFFArray+PWRF(2);
%     
% %     hold on;
% %     plot(latFFArray,yfit,'-g');
%     
%      hold on;
%     plot(latFFArray,yfitWRF,'-c');
%     hold on
%     hline = refline([1 0]);
%      hline.Color = 'r';
%     
% %    fd=TimeCell{1}
%  %   firstDay=cell2mat(fd)
%     % titlestring=['y=',num2str(P(1)),'x+',num2str(P(2)),' R^2=',num2str(R(1,2))];
%     % title(titlestring);
%     line1 ='All Storms';
%     %['Station ID:  ',(STelim{j,1}),' ','Storm:  ', firstDay(1:8)]
%     line2 =['WRF RMSE (m/s)=',num2str(rmseWRF)];
%     line3=['WRF Mean Bias(m/s)=',num2str(meanBiasWRF)];
%     line4=['WRF R^2=',num2str(RWRF(1,2))];
%  
%     lines ={line1,line2,line3,line4};
%     
%     title(lines);
%     axis([0 axisMax 0 axisMax]);
%     xlabel('Storm Average NE US Observed Wind Speed (m/s)');
%     ylabel('Storm Average Estimated Wind Speed (m/s)');
%     
%     %gcf=.pdf';
%     %pname=[ statname{1,plottick +2}, '.pdf' ];
%     
%     
% %     theString = sprintf('y = %.2f x + %.2f', P(1),P(2));
%     theWRFString = sprintf('y = %.2f x + %.2f', PWRF(1),PWRF(2));
%     %text((1),axisMax, theString, 'FontSize', 10);
%     legend('WRF Estimate',theWRFString, ...
%         '1:1 Reference Line','Location','northwest');
%     
%     
%     hold off;
    
    

% 
% dlmwrite('BiasPWRFRMSE.txt',RMSEmatUK)
% dlmwrite('BiasPWRFmat.txt',FFmat)
% dlmwrite('BiasPWRFPredMat.txt',FFmatUK)
% % dlmwrite('FFWRFmat.txt',FFWRFmat)
% % dlmwrite('RMSEWRFmat.txt',RMSEWRFmat)
% save('asBiasPWRFWksp.mat')
