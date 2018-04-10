% %Stats%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DRDKalmb=mean(DRDKal);
DRDwrfmb=mean(DRDwrf);
DRDpKalmb=mean(DRDpKal);
DRDsqKalrmse=mean(DRDsqKal);
DRDsqwrfrmse=mean(DRDsqwrf);
DRDsqpKalrmse=mean(DRDsqpKal);

dlmwrite('KalRMSE.txt',DRDsqKal);
dlmwrite('PkalRMSE.txt',DRDsqpKal);
dlmwrite('WRFrmse.txt',DRDsqWRF);

dlmwrite('KalBIAS.txt',DRDKal);
dlmwrite('PkalBIAS.txt',DRDpKal);
dlmwrite('WRFbias.txt',DRDWRF);


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
line1 ='CV of Kalman Filter (2D) Expected residuals 10% Storm Sample';
line2 =['CV RMSE (m/s)=',num2str(DRDsqpKalrmse)];
line3=['CV Bias (m/s)=',num2str(DRDpKalmb)];
line4=['CV R^2=',num2str(Rpkal(1,2))];
linespkal ={line1,line2,line3,line4};
axis([0 (axisMax +1) 0 (axisMax +1)]);
xlabel('Individiual Station Strom Average Wind Speed (m/s)');
ylabel('Storm Average Wind Speed Estimate (m/s)');
pkalString = sprintf('y = %.2f x + %.2f', Ppkal(1),Ppkal(2));
% %<<


%Label Kal>>
line1 ='Kalman Filter (2D) Expected residuals 10% Storm Sample';
line2 =['KF (2D) RMSE (m/s)=',num2str(DRDsqKalrmse)];
line3=['KF (2D) Bias (m/s)=',num2str(DRDKalmb)];
line4=['KF (2D) R^2=',num2str(Rkal(1,2))];
lineskal ={line1,line2,line3,line4};
axis([0 (axisMax +1) 0 (axisMax +1)]);
xlabel('Individiual Station Strom Average Wind Speed (m/s)');
ylabel('Storm Average Wind Speed Estimate (m/s)');
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
legend('CV Estimate',pkalString,'1:1 Reference Line', ...
    'Location','southeast');
hold off
% %<<

%Produce Kal Plot>>
fig = figure;
scatter(DRlatFFArray,DRKal,'MarkerEdgeColor',[0 0 0.3])
hold on;
plot(DRlatFFArray,yfitkal,'Color',[0 0 0.3]);
title(lines);
axis([0 (axisMax +1) 0 (axisMax +1)]);
refX=[0:axisMax];
refY=[0:axisMax];
line(refX,refY,'Color','k')
xlabel('Individiual Station Strom Average Wind Speed (m/s)');
ylabel('Storm Average Wind Speed Estimate (m/s)');
legend('KF (2D) Estimate',kalString,'1:1 Reference Line', ...
    'Location','southeast');
title(lineskal);
hold off
% %<<



%Combined Plotting (ALL)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Produce WRF Plot>>
fig = figure;
%Label Comb>>
line1 ='KF, CV of KF, Corresponding WRF Predictions 10% Predicted History';
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
legend('WRF','CV','KF',WRFString,pkalString,kalString,'1:1 Reference Line', ...
    'Location','southeast');

hold off
% %<<

%Combined Plotting KAl & CV%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Produce WRF Plot>>
fig = figure;
%Label Comb>>
line1 ='KF, CV of KF, Corresponding WRF Predictions 10% Predicted History';
% %<<


scatter(DRlatFFArray,DRpKal,'MarkerEdgeColor',[0 .8 0])
hold on;
scatter(DRlatFFArray,DRKal,'MarkerEdgeColor',[0 0 0.3])

plot(DRlatFFArray,yfitpkal,'Color',[0 .8 0]);
plot(DRlatFFArray,yfitkal,'Color',[0 0 0.3]);

title(line1);
axis([0 (axisMax +1) 0 (axisMax +1)]);
refX=[0:axisMax];
refY=[0:axisMax];
line(refX,refY,'Color','k')
xlabel('Individiual Station Strom Average Wind Speed (m/s)');
ylabel('Storm Average Wind Speed Estimate (m/s)');
legend('CV','KF',pkalString,kalString,'1:1 Reference Line', ...
    'Location','southeast');

hold off
% %<<

%Combined Plotting CV and WRF%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Produce WRF Plot>>
fig = figure;
%Label Comb>>
line1 ='CV of KF, Corresponding WRF Predictions 10% Predicted History';
% %<<
scatter(DRlatFFArray,DRwrf,'MarkerEdgeColor',[.8 .2 .2])
hold on;
scatter(DRlatFFArray,DRpKal,'MarkerEdgeColor',[0 .8 0])


plot(DRlatFFArray,yfitwrf,'Color',[.8 .2 .2]);
plot(DRlatFFArray,yfitpkal,'Color',[0 .8 0]);


title(line1);
axis([0 (axisMax +1) 0 (axisMax +1)]);
refX=[0:axisMax];
refY=[0:axisMax];
line(refX,refY,'Color','k')
xlabel('Individiual Station Strom Average Wind Speed (m/s)');
ylabel('Storm Average Wind Speed Estimate (m/s)');
legend('WRF','CV',WRFString,pkalString,'1:1 Reference Line', ...
    'Location','southeast');

hold off
% %<<
