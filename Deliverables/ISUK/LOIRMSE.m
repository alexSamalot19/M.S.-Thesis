% %FILE PREVIEW
% 
% %coment>copy/paste style code
% clear
% clc
% ti=0;
% tism=0;
% Bigtism=0;
% CompArray=['CEELab20';'CEELab26';'CEELab27';'CEELab05';'CEELab22'; ...
% 'CEELab23';'CEELab06';'CEELab21';'CEELab24';'CEELab07';'CEELab25'];%
% DriveInfo=fullfile('F:','Meth34Diff');
% %Read Stormlist%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% filename='Stormlist.csv'
% FID=fopen(fullfile(DriveInfo,filename),'r');
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
% 
% filename='MetMad.csv'
% FID=fopen(fullfile(DriveInfo,filename),'r')
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
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for st=1:(Stnum-1)
%         COMP=CompArray(st,:);
%     BySTatFo=['WindBStat',cell2mat(Storm{st,1})];
%     
%     for w=1:(Statnum-1)
%         filena=cell2mat(FoStat{w,1});
%         lname=strtrim(filena);
%         
%         
%         
%         
% pkloi=exist(fullfile(COMP,BySTatFo,['loiFF',lname,'.csv']));
% 
% if pkloi>0
%     tism=tism+1;
%     Bigtism=Bigtism+1;
%     
%     loiFF=dlmread(fullfile(COMP,BySTatFo,['loiFF',lname,'.csv']));
%     loiUK=dlmread(fullfile(COMP,BySTatFo,['loiUK',lname,'.csv']));
%     loiWRF=dlmread(fullfile(COMP,BySTatFo,['loiWRF',lname,'.csv']));
%     
%     %Differences
%     DDwrf= loiWRF-loiFF;
%     DDloiUK=loiUK-loiFF;
%     
%     DDsqwrf=(loiWRF-loiFF).^2;
%     DDsqloiUK=(loiUK-loiFF).^2;
%     %Means
%     DRDwrf(tism,1)= mean(DDwrf);
%     DRDloiUK(tism,1)=mean(DDloiUK);
%     
%     MatBwrf(w,st)= mean(DDwrf);
%     MatBloiUK(w,st)=mean(DDloiUK);
%     
%     DRDsqwrf(tism,1)=sqrt(mean(DDsqwrf));
%     DRDsqloiUK(tism,1)=sqrt(mean(DDsqloiUK));
%     
%     Matsqwrf(w,st)=sqrt(mean(DDsqwrf));
%     MatsqloiUK(w,st)=sqrt(mean(DDsqloiUK));
%     
%     BTwrf(Bigtism:Bigtism+47,1)=DDwrf;
%     BTloiUK(Bigtism:Bigtism+47,1)=DDloiUK;
%     
%     BTsqwrf(Bigtism:Bigtism+47,1)=DDsqwrf;
%     BTsqploiUK(Bigtism:Bigtism+47,1)=DDsqloiUK;
%     
%     Bigtism=Bigtism+47;
%     
%     DRwrf(tism,1)= mean(loiWRF);
%     DRloiUK(tism,1)=mean(loiUK);
%     DRlatFF(tism,1)=mean(loiFF);
% end
%     end
% end
% 
% save('loiukMatcv.mat');
clear
clc
load('loiukMatcv.mat')
scatter(DRlatFF,DRloiUK)
rmse=sqrt(mean(BTsqploiUK));
rmseWRF=sqrt(mean(BTsqwrf));

meanBias=mean(BTloiUK);
meanBiasWRF=mean(BTwrf);

latFFArray=DRlatFF
PredArray=DRloiUK
PWRFArray=DRwrf


maxAx(1,1)=max(latFFArray)
maxAx(2,1)=max(PredArray)
maxAx(3,1)=max(PWRFArray)


minAx(1,1)=min(latFFArray)
minAx(2,1)=min(PredArray)
minAx(3,1)=min(PWRFArray)

axisMin= min(minAx)
axisMax= max(maxAx)
% scatter(DRIlatFFArray,latFFArray)
% scatter(DRIPredArray,latFFArray)
% scatter(DRIPredArray,PredArray)

fig = figure;
R=corrcoef(latFFArray, PredArray);
% % scatter(latFFArray,PWRFArray,'MarkerEdgeColor',[.8 .2 .2]);

RWRF=corrcoef(latFFArray, PWRFArray);


scatter(latFFArray,PredArray,'MarkerEdgeColor',[0 0 0.3]);
P=polyfit(latFFArray,PredArray,1);
yfit=P(1)*latFFArray+P(2);
hold on;

% PWRF=polyfit(latFFArray,PWRFArray,1);
% yfitWRF=PWRF(1)*latFFArray+PWRF(2);


% hold on;
% plot(latFFArray,yfitWRF,'Color',[.8 .2 .2]);
hold on;
plot(latFFArray,yfit,'Color',[.0 0 0.3]);

hold on
refX=[0:axisMax];
refY=[0:axisMax];
line(refX,refY,'Color','k')

%    fd=TimeCell{1}
%   firstDay=cell2mat(fd)
% titlestring=['y=',num2str(P(1)),'x+',num2str(P(2)),' R^2=',num2str(R(1,2))];
% title(titlestring);
line1 ='In Sample (IS) UK Wind History  vs. Observed Wind 10% Storm Sample';
%['Station ID:  ',(STelim{j,1}),' ','Storm:  ', firstDay(1:8)]
    line2 =['UK RMSE (m/s)=',num2str(rmse)];
    line3=['UK Mean Bias (m/s)=',num2str(meanBias)];
    line4=['UK R^2=',num2str(R(1,2))];
% line2 ='Corresponding WRF predictions'
%     line3=['Kalman Mean Bias (m/s)=',num2str(meanBias),'   ','WRF Mean Bias(m/s)=',num2str(meanBiasWRF)];
%     line4=['Kalman R^2=',num2str(R(1,2)),'   ','WRF R^2=',num2str(RWRF(1,2))];
lines ={line1,line2,line3,line4};

title(line1);
set(gca,'XTick',0:2:14)
%axis([0 (axisMax +1) 0 (axisMax +1)]);
xlabel('Observed Wind Speed (m/s)');
    ylabel('Estimated Wind Speed (m/s)');
%gcf=.pdf';
%pname=[ statname{1,plottick +2}, '.pdf' ];



theString = sprintf('y = %.2f x + %.2f', P(1),P(2));
% theWRFString = sprintf('y = %.2f x + %.2f', PWRF(1),PWRF(2));
%text((1),axisMax, theString, 'FontSize', 10);
legend('UK IS',theString, ...
    '1:1 Reference Line','Location','southeast');


hold off;

NEUS=['loiUK.png'];
%NEUSFo=fullfile(BySTatFo,NEUS)
saveas(fig,NEUS);


% dlmwrite('MatBloiWRF.txt',MatBwrf)
% dlmwrite('MatBloiUK.txt',MatBloiUK)
% dlmwrite('MatRloiWRF.txt',Matsqwrf)
% dlmwrite('MatRloiUK.txt',MatsqloiUK)


