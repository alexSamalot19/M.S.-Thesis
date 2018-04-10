clear
clc

M3MetK2O=dlmread('M3MetK2O.txt');
M3MadK2O=dlmread('M3MadK2O.txt');
latFFArray=vertcat(M3MetK2O,M3MadK2O);

M3MetK2K= dlmread('M3MetK2K.txt');
M3MadK2K=dlmread('M3MadK2K.txt');
PredArray=vertcat(M3MetK2K,M3MadK2K);

M3MetK2W=dlmread('M3MetK2W.txt');
M3MadK2W=dlmread('M3MadK2W.txt');
PWRFArray=vertcat(M3MetK2W,M3MadK2W);

M3MetK2Kmb=dlmread('M3MetK2Kmb.txt');
M3MadK2Kmb=dlmread('M3MadK2Kmb.txt');
MBK=vertcat(M3MetK2Kmb,M3MadK2Kmb);
meanBias=mean(MBK);

M3MetK2Krmse=dlmread('M3MetK2Krmse.txt');
M3MadK2Krmse=dlmread('M3MadK2Krmse.txt');
MsqEK=vertcat(M3MetK2Krmse,M3MadK2Krmse);
rmse=sqrt(mean(MsqEK));

M3MetK2Wmb=dlmread('M3MetK2Wmb.txt');
M3MadK2Wmb=dlmread('M3MadK2Wmb.txt');
MBW=vertcat(M3MetK2Wmb,M3MadK2Wmb);
meanBiasWRF=mean(MBW);

M3MetK2Wrmse=dlmread('M3MetK2Wrmse.txt');
M3MadK2Wrmse=dlmread('M3MadK2Wrmse.txt');
MsqEW=vertcat(M3MetK2Wrmse,M3MadK2Wrmse);
rmseWRF=sqrt(mean(MsqEW));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   maxAx(1,1)=max(latFFArray)
   maxAx(2,1)=max(PredArray)
   maxAx(3,1)=max(PWRFArray)
   
   
   minAx(1,1)=min(latFFArray)
   minAx(2,1)=min(PredArray)
   minAx(3,1)=min(PWRFArray)
   
   axisMin= min(minAx)
   axisMax= max(maxAx)
   
   
save('M3Comb.mat')

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
    line1 ='WRF & Kalman Filter (2D) Wind Speed Prediction Error 10% Storm History Stations';
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
       
     NEUS=['M3CombKC.png'];
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
    line1 ='Kalman Filter (2D) Wind Speed Prediction Error 10% Storm History Stations';
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
       
     NEUS=['M3CombKO.png'];
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
    line1 ='WRF Prediction Error 10% Storm History Stations';
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
       
     NEUS=['M3CombWO.png'];
        %NEUSFo=fullfile(BySTatFo,NEUS)
        saveas(fig,NEUS);
















