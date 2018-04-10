clear
clc
load('fin111grm1m2.mat')
% %Stats%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DRDKalmb=mean(BTKal);
DRDwrfmb=mean(BTwrf);
DRDpKalmb=mean(BTpKal);
DRDsqKalrmse=sqrt(mean(BTsqKal));
DRDsqwrfrmse=sqrt(mean(BTsqwrf));
DRDsqpKalrmse=sqrt(mean(BTsqpKal));
% 
% dlmwrite('KalRM111m1m2.txt',DRDsqKal);
% dlmwrite('RKRM111m1m2.txt',DRDsqpKal);
% dlmwrite('WRFrm111m1m2.txt',DRDsqwrf);
% 
% dlmwrite('KalB111m1m2.txt',DRDKal);
% dlmwrite('PkalB111m1m2.txt',DRDpKal);
% dlmwrite('WRFb111m1m2.txt',DRDwrf);


%Plots%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Axis>>
maxAx(1,1)=max(DRKal);
maxAx(2,1)=max(DRwrf);
maxAx(3,1)=max(DRpKal);
maxAx(4,1)=max(DRlatFFArray);
minAx(1,1)=min(DRKal);
minAx(2,1)=min(DRwrf);
minAx(3,1)=min(DRpKal);
minAx(4,1)=min(DRlatFFArray);
axisMin= min(minAx);
axisMax= max(maxAx);
% %<<


%Linear Fits>>
Rwrf=corrcoef(DRlatFFArray, DRwrf);
Rpkal=corrcoef(DRlatFFArray, DRpKal);
Rkal=corrcoef(DRlatFFArray, DRKal);

Pwrf=polyfit(DRlatFFArray, DRwrf,1);
yfitwrf=Pwrf(1)*DRlatFFArray+Pwrf(2);
Ppkal=polyfit(DRlatFFArray, DRpKal,1);
yfitpkal=Ppkal(1)*DRlatFFArray+Ppkal(2);
Pkal=polyfit(DRlatFFArray, DRKal,1);
yfitkal=Pkal(1)*DRlatFFArray+Pkal(2);
% %<<


%Label wrf>>
line1 ='Prediction History 10% Storm Sample Corresponding WRF';
line2 =['WRF RMSE (m/s)=',num2str(DRDsqwrfrmse)];
line3=['WRF Bias (m/s)=',num2str(DRDwrfmb)];
line4=['WRF R^2=',num2str(Rwrf(1,2))];
lineswrf ={line1,line2,line3,line4};
axis([0 (axisMax +1) 0 (axisMax +1)]);
xlabel('Individiual Station Strom Average Wind Speed (m/s)');
ylabel('Storm Average Wind Speed Estimate (m/s)');
WRFString = sprintf('y = %.2f x + %.2f', Pwrf(1),Pwrf(2));
% %<<

%Label pKal>>
line1 ='RK of Kalman Filter (2D) Expected residuals 10% Storm Sample';
line2 =['RK RMSE (m/s)=',num2str(DRDsqpKalrmse)];
line3=['RK Bias (m/s)=',num2str(DRDpKalmb)];
line4=['RK R^2=',num2str(Rpkal(1,2))];
linespkal ={line1,line2,line3,line4};
axis([0 (axisMax +1) 0 (axisMax +1)]);
xlabel('Individiual Station Strom Average Wind Speed (m/s)');
ylabel('Storm Average Wind Speed Estimate (m/s)');
pkalString = sprintf('y = %.2f x + %.2f', Ppkal(1),Ppkal(2));
% %<<


%Label Kal>>
line1 ='M1 KF Wind Speed Predictions vs. Observed Wind 107 Storm Events';
line2 =['KF M1 (2D) RMSE (m/s)=',num2str(DRDsqKalrmse)];
line3=['KF M1 (2D) Bias (m/s)=',num2str(DRDKalmb)];
line4=['KF M1 (2D) R^2=',num2str(Rkal(1,2))];
lineskal =line1%,line2,line3,line4};
axis([0 (axisMax +1) 0 (axisMax +1)]);
xlabel('Observed Wind Speed (m/s)');
    ylabel('Estimated Wind Speed (m/s)');
kalString = sprintf('y = %.2f x + %.2f', Pkal(1),Pkal(2));
% %<<



%Produce WRF Plot>>
fig = figure;
scatter(DRlatFFArray,DRwrf,'MarkerEdgeColor',[.8 .2 .2])
hold on;
plot(DRlatFFArray,yfitwrf,'Color',[.8 .2 .2]);
title(lineswrf);
axis([0 (axisMax +1) 0 (axisMax +1)]);
refX=[0:axisMax];
refY=[0:axisMax];
line(refX,refY,'Color','k')
xlabel('Individiual Station Strom Average Wind Speed (m/s)');
ylabel('Storm Average Wind Speed Estimate (m/s)');
legend('WRF Estimate',WRFString,'1:1 Reference Line', ...
    'Location','southeast');

hold off
% %<<

%Produce pKal Plot>>
fig = figure;
scatter(DRlatFFArray,DRpKal,'MarkerEdgeColor',[.5 .5 .5])
hold on;
plot(DRlatFFArray,yfitpkal,'Color',[.5 .5 .5]);
title(linespkal)
axis([0 (axisMax +1) 0 (axisMax +1)]);
refX=[0:axisMax];
refY=[0:axisMax];
line(refX,refY,'Color','k')
xlabel('Individiual Station Strom Average Wind Speed (m/s)');
ylabel('Storm Average Wind Speed Estimate (m/s)');
legend('RK Estimate',pkalString,'1:1 Reference Line', ...
    'Location','southeast');
hold off
% %<<

%Produce Kal Plot>>
fig = figure;
scatter(DRlatFFArray,DRKal,'MarkerEdgeColor',[0 0 0.3])
hold on;
plot(DRlatFFArray,yfitkal,'Color',[0 0 0.3]);
title(lineskal);
axis([0 (axisMax +1) 0 (axisMax +1)]);
refX=[0:axisMax];
refY=[0:axisMax];
line(refX,refY,'Color','k')
xlabel('Observed Wind Speed (m/s)');
    ylabel('Estimated Wind Speed (m/s)');legend('M1 KF',kalString,'1:1 Reference Line', ...
    'Location','southeast');
title(lineskal);
hold off
% %<<



%Combined Plotting (ALL)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Produce WRF Plot>>
fig = figure;
%Label Comb>>
line1 ='M1 KF, RK, Corresponding WRF Predictions 107 Storm Events';
% %<<
scatter(DRlatFFArray,DRwrf,'MarkerEdgeColor',[.8 .2 .2])
hold on;
scatter(DRlatFFArray,DRpKal,'MarkerEdgeColor',[0 .8 0])
scatter(DRlatFFArray,DRKal,'MarkerEdgeColor',[0 0 0.3])

plot(DRlatFFArray,yfitwrf,'Color',[.8 .2 .2]);
plot(DRlatFFArray,yfitpkal,'Color',[0 .8 0]);
plot(DRlatFFArray,yfitkal,'Color',[0 0 0.3]);

title(line1);
axis([0 (axisMax +1) 0 (axisMax +1)]);
refX=[0:axisMax];
refY=[0:axisMax];
line(refX,refY,'Color','k')
xlabel('Individiual Station Strom Average Wind Speed (m/s)');
ylabel('Storm Average Wind Speed Estimate (m/s)');
legend('WRF','RK','M1 KF',WRFString,pkalString,kalString,'1:1 Reference Line', ...
    'Location','southeast');

hold off
% %<<

% % %Combined Plotting KAl & RK%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %Produce WRF Plot>>
% % fig = figure;
% % %Label Comb>>
% % line1 ='M1 KF and RK Estimation of Wind Speed 10% Sample of Storms';
% % % %<<
% % 
% % 
% % scatter(DRlatFFArray,DRpKal,'MarkerEdgeColor',[0 .8 0])
% % hold on;
% % scatter(DRlatFFArray,DRKal,'MarkerEdgeColor',[0 0 0.3])
% % 
% % plot(DRlatFFArray,yfitpkal,'Color',[0 .8 0]);
% % plot(DRlatFFArray,yfitkal,'Color',[0 0 0.3]);
% % 
% % title(line1);
% % axis([0 (axisMax +1) 0 (axisMax +1)]);
% % refX=[0:axisMax];
% % refY=[0:axisMax];
% % line(refX,refY,'Color','k')
% % xlabel('Observed Wind Speed (m/s)');
% % ylabel('Estimated Wind Speed (m/s)');
% % legend('RK','KF',pkalString,kalString,'1:1 Reference Line', ...
% %     'Location','southeast');
% % 
% % hold off
% % % %<<
% % 
% % %Combined Plotting RK and WRF%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %Produce WRF Plot>>
% % fig = figure;
% % %Label Comb>>
% % line1 ='M1 KF, Corresponding WRF Predictions 10% Predicted History';
% % % %<<
% % scatter(DRlatFFArray,DRwrf,'MarkerEdgeColor',[.8 .2 .2])
% % hold on;
% % scatter(DRlatFFArray,DRpKal,'MarkerEdgeColor',[0 .8 0])
% % 
% % 
% % plot(DRlatFFArray,yfitwrf,'Color',[.8 .2 .2]);
% % plot(DRlatFFArray,yfitpkal,'Color',[0 .8 0]);
% % 
% % 
% % title(line1);
% % axis([0 (axisMax +1) 0 (axisMax +1)]);
% % refX=[0:axisMax];
% % refY=[0:axisMax];
% % line(refX,refY,'Color','k')
% % xlabel('Individiual Station Strom Average Wind Speed (m/s)');
% % ylabel('Storm Average Wind Speed Estimate (m/s)');
% % legend('WRF','RK',WRFString,pkalString,'1:1 Reference Line', ...
% %     'Location','southeast');
% % 
% % hold off
% % % %<<
