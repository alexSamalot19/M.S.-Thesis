clear
clc

stoArray=[6,16,29,39,44,57,64,69,81,96,105];%
folderin='ForCVTEST'


filename = 'MetCRno.csv';
fileID = fopen(filename, 'r');
RefLis=1;
folder='M03d2Met'
    while(~feof(fileID));
            
            InputText =textscan(fileID, '%s',5,'delimiter', ',');
            CRlist{RefLis,1} = InputText{1};
            if size(InputText{1}) > 0;
            RefLis = RefLis+1;
            end
    end
        
    fclose(fileID);
    
  firstArray=dlmread('firstarray2.txt')
    lastArray=dlmread('lastarray2.txt')
    
 STCVname='FC24JS.txt';
STCVID=fopen(STCVname,'r');
timnam = 1;
while(~feof(STCVID));
    
    InputText =textscan(STCVID, '%s',1,'delimiter', ',');
    TimeCell{timnam,1} = InputText{1};
    timnam = timnam+1;
    
end

fclose(STCVID); 


for storm=1:11
    t4=0
filestorm=stoArray(storm)
clearvars -except storm filestorm t4 ObsMV WRFMV KALMV LocMV folderin ...
DWRFMV DKalMV DsqWRFMV DsqKalMV stoArray CRlist Reflis firstArray ...
TimeCell  WRFcomp2 WRFMV2 CompWRFMV 

Obs=dlmread(fullfile(folderin,['ObsarT',num2str(filestorm),'.txt']))
WRFar=dlmread(fullfile(folderin,['WRFarT',num2str(filestorm),'.txt']))
KFarr=dlmread(fullfile(folderin,['KFarrT',num2str(filestorm),'.txt']))
Loarr=dlmread(fullfile(folderin,['LoarrT',num2str(filestorm),'.txt']))

AvHours=size(Loarr)

		t3=0
		t1=0
		t2=0
        
for stoLoop=1:AvHours(1)


    filebeg2 = Loarr(stoLoop);
 
    
       if stoLoop ==1;
          
   
     t1 = t1+1;
	t2=t2+1
	t3=t3+1
    Obsmat(1,t1) = Obs(t3,1);
    
           if Obsmat(t2,t1) ==0
        error('zeros line 75')
           end
    if t2>48
             error('zeros (gap)  line 77')
        end
    WRFmat(1,t1) = WRFar(t3,1);
    KALmat(1,t1) = KFarr(t3,1);
    LocMat(1,t1) = Loarr(t3,1);%for accuracy book keeping    
    DsqWRFMat(1,t1)=(WRFar(t3,1)-Obs(t3,1))^2;
    DsqKalMat(1,t1)=(KFarr(t3,1)-Obs(t3,1))^2;
	
	DWRFMat(1,t1)=WRFar(t3,1)-Obs(t3,1);
    DKalMat(1,t1)=KFarr(t3,1)-Obs(t3,1);
	
	
        prev = filebeg2;
       else
        if filebeg2 ==prev;
          t2=t2+1 
		  t3=t3+1
    Obsmat(t2,t1) = Obs(t3,1);
    if Obsmat(t2,t1) ==0
        error('zeros line 90')
    end
    if t2>48
             error('zeros (gap)  line 100 write location in loarr')
        end
    WRFmat(t2,t1) = WRFar(t3,1);
    KALmat(t2,t1) = KFarr(t3,1);
    LocMat(t2,t1) = Loarr(t3,1);%for accuracy book keeping    
     DsqWRFMat(t2,t1)=(WRFar(t3,1)-Obs(t3,1))^2;
    DsqKalMat(t2,t1)=(KFarr(t3,1)-Obs(t3,1))^2;
	
	DWRFMat(t2,t1)=WRFar(t3,1)-Obs(t3,1);
    DKalMat(t2,t1)=KFarr(t3,1)-Obs(t3,1);
	   


	   
         prev = filebeg2;
        else
             t1 = t1+1;
			 t2=1;
			 t3=t3+1;
    Obsmat(t2,t1) = Obs(t3,1);
   
        if Obsmat(t2,t1) ==0
        error('zeros line 111')
        end
         if t2>48
             error('zeros (gap)  line 111')
        end
    WRFmat(t2,t1) = WRFar(t3,1);
    KALmat(t2,t1) = KFarr(t3,1);
    LocMat(t2,t1) = Loarr(t3,1);%for accuracy book keeping  
    DsqWRFMat(t2,t1)=(WRFar(t3,1)-Obs(t3,1))^2;
    DsqKalMat(t2,t1)=(KFarr(t3,1)-Obs(t3,1))^2;
	
	DWRFMat(t2,t1)=WRFar(t3,1)-Obs(t3,1);
    DKalMat(t2,t1)=KFarr(t3,1)-Obs(t3,1);
	     
      
        prev = filebeg2;
        end
      
       end
    end
       
  


ObsT= mean(Obsmat);
WRFT= mean(WRFmat);
KALT= mean(KALmat);
LocT= mean(LocMat);

DWRFt=mean(DWRFMat);
DKalt=mean(DKalMat);

DsqWRFt=sqrt(mean(DsqWRFMat));
DsqKALt=sqrt(mean(DsqKalMat));

BySTatFo=['WindBStat',num2str(filestorm)];
for ticks2=1:t1
  for t5=1:t2
      
      location=LocMat(1,ticks2);
 holdd=CRlist{location,1}
       
 Cnum=holdd{4,1};
         Rnum=holdd{5,1};
        Rclose = round(str2num(Rnum));
        Cclose = round(str2num(Cnum));
        LocClose = (Cclose-1)*330 + Rclose;
      
      
      
    time=firstArray(storm,1)+(t5-1);
     holder=cell2mat(TimeCell{time,1});
    filMod = [holder,'WRF.txt'];   
    WRF=dlmread(fullfile('G:','WRF',filMod));
%     sumtime=sumtime+1;
%Need a grid cell conversion based on MetCR
 WRFcomp2(t5,ticks2)=WRF(LocClose,1);
  end
end
 ObsT2=mean(WRFcomp2);
for ticks=1:t1

location=LocMat(1,ticks);
 holdd=CRlist{location,1}
       
 Cnum=holdd{4,1};
         Rnum=holdd{5,1};
        Rclose = round(str2num(Rnum));
        Cclose = round(str2num(Cnum));
        LocClose = (Cclose-1)*330 + Rclose;
     
     
%     %Read WRF at Time


 lname=holdd{1,1};
   MEANn=['MEANwrf',lname,'.csv']
 test=exist(fullfile('C:', 'Users', 'alex', 'Desktop', 'Storm3Test', ...
      BySTatFo,MEANn));
  
  if test>1
      t4=t4+1;

  mwrf=dlmread(fullfile('C:', 'Users', 'alex', 'Desktop', 'Storm3Test', ...
      BySTatFo,MEANn));
        
        
  RMSEn=['KalRMSEwrf',lname,'.csv']
  RMSEF=dlmread(fullfile('C:', 'Users', 'alex', 'Desktop', 'Storm3Test', ...
      BySTatFo,RMSEn));
 
CompWRFMV(t4,1)=mwrf(1,1);
CompDsqWRFMV(t4,1)=RMSEF(1,1);
ObsMV(t4,1)=ObsT(1,ticks);
WRFMV2(t4,1)=ObsT2(1,ticks);
WRFMV(t4,1)=WRFT(1,ticks);
KALMV(t4,1)=KALT(1,ticks);
LocMV(t4,1)=LocT(1,ticks);

DWRFMV(t4,1)=DWRFt(1,ticks);
DKalMV(t4,1)=DKalt(1,ticks);

DsqWRFMV(t4,1)=DsqWRFt(1,ticks);
DsqKalMV(t4,1)=DsqKALt(1,ticks);

tableWRF(t4,1)=location
tableWRF(t4,2)=mwrf(1,1)
tableWRF(t4,3)=WRFT(1,ticks)


end
end
% 
% clearvars ObsT Obsmat WRFT WRFmat KALT KALmat LocT LocMat DWRFt DWRFMat DKalt ... 
%     DKalMat DsqWRFt DsqWRFMat DsqKALt DsqKalMat

end

% error('break to isolate bad storms')

% 
% rmse = sqrt(mean(DsqKalMV));
%  rmseWRF = sqrt(mean(DsqWRFMV));
%  meanBias = mean(DKalMV);
%  meanBiasWRF = mean(DWRFMV);
%  
% 
%    latFFArray=ObsMV(:,1)
%    PredArray=KALMV(:,1)
%    PWRFArray=WRFMV(:,1)
%    WRFMV2gr=WRFMV2(:,1)
%  rmseWRF = sqrt(mean(DsqWRFMV));
%  rmseWRF2 = sqrt(mean(CompDsqWRFMV));
%  
%  num=2
%  
%   latFFArray=ObsMV(:,num)
%    PredArray=KALMV(:,num)
%    PWRFArray=WRFMV(:,num)
%    WRFMV2gr=WRFMV2(:,num)
%    CompWRFMVgr=CompWRFMV(:,num)
%   fig = figure;
% %     R=corrcoef(latFFArray, PredArray);
%     scatter(CompWRFMVgr,WRFMV2gr,'g');
% %     
%     %RWRF=corrcoef(CompWRFMV, PWRFArray);
%        
%       hold on;
%      scatter(CompWRFMVgr,PWRFArray,'c');
%      
%        hold on;
%      scatter(PWRFArray,WRFMV2gr,'r');
% %      P=polyfit(latFFArray,PredArray,1);
% %     yfit=P(1)*latFFArray+P(2);
% %     
%     PWRF=polyfit(CompWRFMV,PWRFArray,1);
%     yfitWRF=PWRF(1)*CompWRFMV+PWRF(2);
%     
% %      hold on;
% %      plot(CompWRFMV,yfit,'-g');
% %      
%      hold on;
%     plot(CompWRFMV,yfitWRF,'-c');
%     hold on
%     hline = refline([1 0]);
%      hline.Color = 'r';
%     
% %    fd=TimeCell{1}
%  %   firstDay=cell2mat(fd)
%     % titlestring=['y=',num2str(P(1)),'x+',num2str(P(2)),' R^2=',num2str(R(1,2))];
%     % title(titlestring);
%     line1 ='WRF Prediction Error 10% Storm History Metar Stations';
%     %['Station ID:  ',(STelim{j,1}),' ','Storm:  ', firstDay(1:8)]
% %     line2 =['UK RMSE (m/s)=',num2str(rmse)];
% %     line3=['UK Mean Bias (m/s)=',num2str(meanBias)];
% %     line4=['UK R^2=',num2str(R(1,2))];
%  line2 =['WRF RMSE (m/s)=',num2str(rmseWRF)];
%     line3=['WRF RMSE2 (m/s)=',num2str(rmseWRF2)];
%     line4=['WRF R^2=',num2str(RWRF(1,2))];
%     lines ={line1,line2,line3,line4};
%     
%     title(lines);
% %    axis([axisMin axisMax axisMin axisMax]);
%     xlabel('Individiual Station Strom Average Wind Speed (m/s)');
%     ylabel('Storm Average Wind Speed Estimate (m/s)');
%     
%     %gcf=.pdf';
%     %pname=[ statname{1,plottick +2}, '.pdf' ];
%     
%     
%     
%     theString = sprintf('y = %.2f x + %.2f', P(1),P(2));
%      theWRFString = sprintf('y = %.2f x + %.2f', PWRF(1),PWRF(2));
%     %text((1),axisMax, theString, 'FontSize', 10);
%     legend('WRF Estimate',theWRFString,'1:1 Reference Line','Location','northwest');
%     
%     
%     hold off;
%        
% %      NEUS=['M3MetWO.png'];
% %         %NEUSFo=fullfile(BySTatFo,NEUS)
% %         saveas(fig,NEUS);
% % 
% 
% 
% 
% error('break for wrf eval')
% %Plotting


 rmse = sqrt(mean(DsqKalMV));
 rmseWRF = sqrt(mean(DsqWRFMV));
 meanBias = mean(DKalMV);
 meanBiasWRF = mean(DWRFMV);
 

   latFFArray=ObsMV
   PredArray=KALMV
   PWRFArray=WRFMV
   
   dlmwrite('M3MetK2O.txt',latFFArray);
   dlmwrite('M3MetK2K.txt',KALMV);
   dlmwrite('M3MetK2W.txt',WRFMV);
   
   dlmwrite('M3MetK2Kmb.txt',DKalMV);
   dlmwrite('M3MetK2Krmse.txt',DsqKalMV);
   dlmwrite('M3MetK2Wmb.txt',DWRFMV);
   dlmwrite('M3MetK2Wrmse.txt',DsqWRFMV);
   
   maxAx(1,1)=max(latFFArray)
   maxAx(2,1)=max(PredArray)
   maxAx(3,1)=max(PWRFArray)
   
   
   minAx(1,1)=min(latFFArray)
   minAx(2,1)=min(PredArray)
   minAx(3,1)=min(PWRFArray)
   
   axisMin= min(minAx)
   axisMax= max(maxAx)
   
   
save('M3Met.mat')

    fig = figure;
    R=corrcoef(latFFArray, PredArray);
    scatter(latFFArray,PredArray,'g');
    
    RWRF=corrcoef(latFFArray, PWRFArray);
       
      hold on;
     scatter(latFFArray,PWRFArray,'c');
     P=polyfit(latFFArray,PredArray,1);
    yfit=P(1)*latFFArray+P(2);
    
    PWRF=polyfit(latFFArray,PWRFArray,1);
    yfitWRF=PWRF(1)*latFFArray+PWRF(2);
    
     hold on;
     plot(latFFArray,yfit,'-g');
     
     hold on;
    plot(latFFArray,yfitWRF,'-c');
    hold on
    hline = refline([1 0]);
     hline.Color = 'r';
    
%    fd=TimeCell{1}
 %   firstDay=cell2mat(fd)
    % titlestring=['y=',num2str(P(1)),'x+',num2str(P(2)),' R^2=',num2str(R(1,2))];
    % title(titlestring);
    line1 ='WRF & Kalman Filter (2D) Wind Speed Prediction Error 10% Storm History  Metar Stations';
    %['Station ID:  ',(STelim{j,1}),' ','Storm:  ', firstDay(1:8)]
%     line2 =['UK RMSE (m/s)=',num2str(rmse)];
%     line3=['UK Mean Bias (m/s)=',num2str(meanBias)];
%     line4=['UK R^2=',num2str(R(1,2))];
 line2 =['Kalman RMSE (m/s)=',num2str(rmse), '   ','WRF RMSE (m/s)=',num2str(rmseWRF)];
    line3=['Kalman Mean Bias (m/s)=',num2str(meanBias),'   ','WRF Mean Bias(m/s)=',num2str(meanBiasWRF)];
    line4=['Kalman R^2=',num2str(R(1,2)),'   ','WRF R^2=',num2str(RWRF(1,2))];
    lines ={line1,line2,line3,line4};
    
    title(lines);
    axis([axisMin axisMax axisMin axisMax]);
    xlabel('Individiual Station Strom Average Wind Speed (m/s)');
    ylabel('Storm Average Wind Speed Estimate (m/s)');
    
    %gcf=.pdf';
    %pname=[ statname{1,plottick +2}, '.pdf' ];
    
    
    
    theString = sprintf('y = %.2f x + %.2f', P(1),P(2));
     theWRFString = sprintf('y = %.2f x + %.2f', PWRF(1),PWRF(2));
    %text((1),axisMax, theString, 'FontSize', 10);
    legend('Kalman Estimate','WRF Estimate',theString,theWRFString, ...
        '1:1 Reference Line','Location','northwest');
    
    
    hold off;
       
     NEUS=['M3MetKC.png'];
        %NEUSFo=fullfile(BySTatFo,NEUS)
        saveas(fig,NEUS);


fig = figure;
    R=corrcoef(latFFArray, PredArray);
    scatter(latFFArray,PredArray,'g');
    
%     RWRF=corrcoef(latFFArray, PWRFArray);
       
      hold on;
%      scatter(latFFArray,PWRFArray,'c');
     P=polyfit(latFFArray,PredArray,1);
    yfit=P(1)*latFFArray+P(2);
    
%     PWRF=polyfit(latFFArray,PWRFArray,1);
%     yfitWRF=PWRF(1)*latFFArray+PWRF(2);
%     
     hold on;
     plot(latFFArray,yfit,'-g');
%      
%      hold on;
%     plot(latFFArray,yfitWRF,'-c');
    hold on
    hline = refline([1 0]);
     hline.Color = 'r';
    
%    fd=TimeCell{1}
 %   firstDay=cell2mat(fd)
    % titlestring=['y=',num2str(P(1)),'x+',num2str(P(2)),' R^2=',num2str(R(1,2))];
    % title(titlestring);
    line1 ='Kalman Filter (2D) Wind Speed Prediction Error 10% Storm History Metar Stations';
    %['Station ID:  ',(STelim{j,1}),' ','Storm:  ', firstDay(1:8)]
%     line2 =['UK RMSE (m/s)=',num2str(rmse)];
%     line3=['UK Mean Bias (m/s)=',num2str(meanBias)];
%     line4=['UK R^2=',num2str(R(1,2))];
 line2 =['Kalman RMSE (m/s)=',num2str(rmse)];
    line3=['Kalman Mean Bias (m/s)=',num2str(meanBias)];
    line4=['Kalman R^2=',num2str(R(1,2))];
    lines ={line1,line2,line3,line4};
    
    title(lines);
    axis([axisMin axisMax axisMin axisMax]);
    xlabel('Individiual Station Strom Average Wind Speed (m/s)');
    ylabel('Storm Average Wind Speed Estimate (m/s)');
    
    %gcf=.pdf';
    %pname=[ statname{1,plottick +2}, '.pdf' ];
    
    
    
    theString = sprintf('y = %.2f x + %.2f', P(1),P(2));
     %theWRFString = sprintf('y = %.2f x + %.2f', PWRF(1),PWRF(2));
    %text((1),axisMax, theString, 'FontSize', 10);
    legend('Kalman Estimate',theString,'1:1 Reference Line','Location','northwest');
    
    
    hold off;
       
     NEUS=['M3MetKO.png'];
        %NEUSFo=fullfile(BySTatFo,NEUS)
        saveas(fig,NEUS);
        
        
        
        fig = figure;
%     R=corrcoef(latFFArray, PredArray);
%     scatter(latFFArray,PredArray,'g');
%     
    RWRF=corrcoef(latFFArray, PWRFArray);
       
%       hold on;
     scatter(latFFArray,PWRFArray,'c');
%      P=polyfit(latFFArray,PredArray,1);
%     yfit=P(1)*latFFArray+P(2);
%     
    PWRF=polyfit(latFFArray,PWRFArray,1);
    yfitWRF=PWRF(1)*latFFArray+PWRF(2);
    
%      hold on;
%      plot(latFFArray,yfit,'-g');
%      
     hold on;
    plot(latFFArray,yfitWRF,'-c');
    hold on
    hline = refline([1 0]);
     hline.Color = 'r';
    
%    fd=TimeCell{1}
 %   firstDay=cell2mat(fd)
    % titlestring=['y=',num2str(P(1)),'x+',num2str(P(2)),' R^2=',num2str(R(1,2))];
    % title(titlestring);
    line1 ='WRF Prediction Error 10% Storm History Metar Stations';
    %['Station ID:  ',(STelim{j,1}),' ','Storm:  ', firstDay(1:8)]
%     line2 =['UK RMSE (m/s)=',num2str(rmse)];
%     line3=['UK Mean Bias (m/s)=',num2str(meanBias)];
%     line4=['UK R^2=',num2str(R(1,2))];
 line2 =['WRF RMSE (m/s)=',num2str(rmseWRF)];
    line3=['WRF Mean Bias(m/s)=',num2str(meanBiasWRF)];
    line4=['WRF R^2=',num2str(RWRF(1,2))];
    lines ={line1,line2,line3,line4};
    
    title(lines);
    axis([axisMin axisMax axisMin axisMax]);
    xlabel('Individiual Station Strom Average Wind Speed (m/s)');
    ylabel('Storm Average Wind Speed Estimate (m/s)');
    
    %gcf=.pdf';
    %pname=[ statname{1,plottick +2}, '.pdf' ];
    
    
    
    theString = sprintf('y = %.2f x + %.2f', P(1),P(2));
     theWRFString = sprintf('y = %.2f x + %.2f', PWRF(1),PWRF(2));
    %text((1),axisMax, theString, 'FontSize', 10);
    legend('WRF Estimate',theWRFString,'1:1 Reference Line','Location','northwest');
    
    
    hold off;
       
     NEUS=['M3MetWO.png'];
        %NEUSFo=fullfile(BySTatFo,NEUS)
        saveas(fig,NEUS);


