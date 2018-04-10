%FILE PREVIEW

%coment>copy/paste style code
clear
clc
ti=0;
tism=0;
Bigtism=0;
%Read Stormlist%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
filename='Stormlist.csv'
FID=fopen(filename,'r');

Stnum = 1;
while(~feof(FID));
    
    InputText =textscan(FID, '%s',1,'delimiter', '\n');
    sizeT = size(InputText{1});
    if sizeT(1)>0;
        Storm{Stnum,1} = InputText{1};
        Stnum = Stnum+1;
    end
end
fclose(FID)


filename='MetMad.csv'
FID=fopen(filename,'r')

Statnum = 1;
while(~feof(FID));
    
    InputText =textscan(FID, '%s %s %s %s %s',1,'delimiter', ',');
    sizeT = size(InputText{1});
    if sizeT(1)>0;
        FoStat{Statnum,1} = InputText{1};
        Statnum = Statnum+1;
    end
end
fclose(FID)
CompArray=['CEELab20';'CEELab26';'CEELab27';'CEELab05';'CEELab22'; ...
'CEELab23';'CEELab06';'CEELab21';'CEELab24';'CEELab07';'CEELab25']

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DriveInfo=fullfile('F:','Meth34Diff');
DriveInfo2=fullfile('F:','CV62015Cast');
for st=1:(Stnum-1)
         COMP=CompArray(st,:);
    BySTatFo=['WindBStat',cell2mat(Storm{st,1})];
    BySTW=['M1loikf',cell2mat(Storm{st,1}),'.mat'];
    DiffFo=['BiasBStDiff',cell2mat(Storm{st,1})];
    for w=1:(Statnum-1)
        tiold=ti;
        filena=cell2mat(FoStat{w,1});
        lname=strtrim(filena);
        %F:\Meth34Diff Files%%%%%%%%%%%%%%
        FFname=['WMFFArr',lname,'.csv'];
        FFUKname=['WMFFUKArr',lname,'.csv'];
        
        
        %METAR%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        METJKO=['MetarrObs',lname,'.csv'];
        METJKW=['MetarrWRF',lname,'.csv'];
        METJKK=['MetarrKal',lname,'.csv'];
        
        %MADIS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        JKO=['madarObs',lname,'.csv'];
        JKW=['madarWRF',lname,'.csv'];
        JKK=['madarKal',lname,'.csv'];
        
        
        %         %OBS
        pkmad=exist(fullfile('C:', 'Users', 'alex', 'Desktop', ...
            'Storm3Test',BySTatFo,JKO));
        if pkmad>0
            ti=ti+1;
            
            %Obs
            ObsMV=dlmread(fullfile('C:', 'Users', 'alex', 'Desktop', ...
                'Storm3Test',BySTatFo,JKO));
            % %
            
            %WRF
            WRFMV=dlmread(fullfile('C:', 'Users', 'alex', 'Desktop', 'Storm3Test', ...
                BySTatFo,JKW));
            
            % %
            
            %KAL
            KALMV=dlmread(fullfile('C:', 'Users', 'alex', 'Desktop', 'Storm3Test', ...
                BySTatFo,JKK));
            % %
            
            %Differences
            DKal=KALMV-ObsMV;
            DWRF=WRFMV-ObsMV;
            DsqKal=(KALMV-ObsMV).^2;
            DsqWRF=(WRFMV-ObsMV).^2;
            %Means
            mbKal(ti,1)=mean(DKal);
            mbWRF(ti,1)=mean(DWRF);
            RMSEkal(ti,1)=sqrt(mean(DsqKal));
            RMSEwrf(ti,1)=sqrt(mean(DsqWRF));
            latFFArray(ti,1)=mean(ObsMV);
            PredArray(ti,1)=mean(KALMV);
            PWRFArray(ti,1)=mean(WRFMV);
            
            
            
        else
            pkmet=exist(fullfile('C:', 'Users', 'alex', 'Desktop', ...
                'Storm3Test',BySTatFo,METJKO));
            if pkmet>1
                ti=ti+1;
                ObsMV=dlmread(fullfile('C:', 'Users', 'alex', 'Desktop', ...
                    'Storm3Test',BySTatFo,METJKO));
                
                %WRF
                WRFMV=dlmread(fullfile('C:', 'Users', 'alex', 'Desktop', 'Storm3Test', ...
                    BySTatFo,METJKW));
                % %
                
                %KAL
                METKALMV=dlmread(fullfile('C:', 'Users', 'alex', 'Desktop', 'Storm3Test', ...
                    BySTatFo,METJKK));
                % %
                
                %Differences
                DKal= METKALMV- ObsMV;
                DWRF= WRFMV- ObsMV;
                DsqKal=( METKALMV- ObsMV).^2;
                DsqWRF=( WRFMV- ObsMV).^2;
                %Means
                mbKal(ti,1)=mean( DKal);
                mbWRF(ti,1)=mean( DWRF);
                RMSEkal(ti,1)=sqrt(mean(DsqKal));
                RMSEwrf(ti,1)=sqrt(mean(DsqWRF));
                latFFArray(ti,1)=mean( ObsMV);
                PredArray(ti,1)=mean( METKALMV);
                PWRFArray(ti,1)=mean( WRFMV);
                
                
            end
            
            
            
        end
        % %
        tinew=ti;
        
        pkdrive=exist(fullfile(DriveInfo,DiffFo,FFname));
        pkdrivec=exist(fullfile(DriveInfo,DiffFo,['KalFFa',lname,'.csv']));
        %%%%%%%%%Original Comparison (BiasBSCVDiff)%%%%%%%%%%%%%%%%%%%
        if tinew>tiold
            if pkdrive>0
                %             FFname=['WMFFArr',lname,'.csv'];
                %             FFUKname=['WMFFUKArr',lname,'.csv'];
                
                %Obs
                DRIObsMV=dlmread(fullfile(DriveInfo,DiffFo,FFname));
                % %
                %KAL
                DRIKALMV=dlmread(fullfile(DriveInfo,DiffFo,FFUKname));
                % %
                
                %Differences
                DRIDKal=DRIKALMV-ObsMV;
                DRIDobs=DRIObsMV-ObsMV;
                DRIDsqKal=(DRIKALMV-ObsMV).^2;
                DRIDsqobs=(DRIObsMV-ObsMV).^2;
                %Means
                DRImbKal(ti,1)=mean(DRIDKal);
                DRImbobs(ti,1)=mean(DRIDobs);
                DRIRMSEkal(ti,1)=sqrt(mean(DRIDsqKal));
                DRIRMSEobs(ti,1)=sqrt(mean(DRIDsqobs));
                DRIlatFFArray(ti,1)=mean(DRIObsMV);
                DRIPredArray(ti,1)=mean(DRIKALMV);
                
                
                %%%%%%%%%Grid cell Comparison (GCKM3)%%%%%%%%%%%%%%%%%%%
                if pkdrivec>0
                    tism=tism+1;
                    if tism>ti
                        error('not reading orig')
                    end
                    Bigtism=Bigtism+1;
                    %KALcompare
                    DRIKALC=dlmread(fullfile(DriveInfo,DiffFo,['KalFFa',lname,'.csv']));
                    DRIPKALC=dlmread(fullfile(DriveInfo2,COMP,BySTatFo,['loiUK',lname,'.csv']));
                    DRIM1KALC=dlmread(fullfile('C:', 'Users', 'alex', 'Desktop', ...
            'Storm3Test',BySTatFo,['finMEANkalAR',lname,'.csv']));
        
                     M1KALC=dlmread(fullfile('C:', 'Users', 'alex', 'Desktop', ...
            'Storm3Test',BySTatFo,['MEANkal',lname,'.csv']));
                    M1K=M1KALC(1,1);
                    DRIM1obs=dlmread(fullfile('C:', 'Users', 'alex', 'Desktop', ...
            'Storm3Test',BySTatFo,['finobscAR',lname,'.csv']));
        
        
         DRIM1WRF=dlmread(fullfile('C:', 'Users', 'alex', 'Desktop', ...
            'Storm3Test',BySTatFo,['finWRFcAR',lname,'.csv']));
        
                    DRIkal=DRIKALC+WRFMV;
                    DRIpkal=DRIPKALC%+WRFMV;
                    DRIM1kal=DRIM1KALC;
                    DRIk=DRIKALC;%just residuals
                    DRIpk=DRIPKALC;%just residuals
                    DRIkalC=PredArray;%Equivalent BiasCVDiff Kal
                    DRIplatFFArray=latFFArray;%Eqiuivalent BiasCV Obs
                    DRIwrf=WRFMV;%Equivalent BiasCV wrf
                    
                    
                    %Differences
                    DDKal=DRIkal-ObsMV;
                    DDwrf= DRIwrf-ObsMV;
                    DDpKal=DRIpkal-ObsMV;
                    DDM1Kal=DRIM1kal-DRIM1obs;
                    DDM1WRF=DRIM1WRF-DRIM1obs;
                    DDsqKal=(DRIkal-ObsMV).^2;
                    DDsqwrf=(DRIwrf-ObsMV).^2;
                    DDsqpKal=(DRIpkal-ObsMV).^2;
                    DDsqM1Kal=(DRIM1kal-DRIM1obs).^2;
                     DDsqM1WRF=(DRIM1WRF-DRIM1obs).^2;
                    %Means
                    DRDKal(tism,1)=mean(DDKal);
                    DRDwrf(tism,1)= mean(DDwrf);
                    DRDpKal(tism,1)=mean(DDpKal);
                    DRDM1Kal(tism,1)=mean(DDM1Kal);
                    DRDM1WRF(tism,1)=mean(DDM1WRF);
                    DRDsqKal(tism,1)=sqrt(mean(DDsqKal));
                    DRDsqwrf(tism,1)=sqrt(mean(DDsqwrf));
                    DRDsqpKal(tism,1)=sqrt(mean(DDsqpKal));
                    DRDsqM1Kal(tism,1)=sqrt(mean(DDsqM1Kal));
                    DRDsqM1WRF(tism,1)=sqrt(mean(DDsqM1WRF));
                    BTKal(Bigtism:Bigtism+47,1)=DDKal;
%                     if Bigtism>48
%                     error('check placement')
%                     end
                    BTwrf(Bigtism:Bigtism+47,1)=DDwrf;
                    BTpKal(Bigtism:Bigtism+47,1)=DDpKal;
                    BTM1Kal(Bigtism:Bigtism+47,1)=DDM1Kal;
                    BTsqKal(Bigtism:Bigtism+47,1)=DDsqKal;
                    BTsqwrf(Bigtism:Bigtism+47,1)=DDsqwrf;
                    BTsqpKal(Bigtism:Bigtism+47,1)=DDsqpKal;
                     BTsqM1Kal(Bigtism:Bigtism+47,1)=DDsqM1Kal;
                    Bigtism=Bigtism+47;
                    
                    DRKal(tism,1)=mean(DRIkal);
                    DRwrf(tism,1)= mean(DRIwrf);
                    DRpKal(tism,1)=mean(DRIpkal);
                    DRM1Kal(tism,1)=mean(DRIM1kal);
                    DRM1Obs(tism,1)=mean(DRIM1obs);
                    DRlatFFArray(tism,1)=mean(ObsMV);
                    DRM1Kalorig(tism,1)=M1KALC(1,1)+mean(DRIwrf);
                    
%                     DRDKalmat(w,st)=mean(DDKal);
%                     DRDwrfmat(w,st)= mean(DDwrf);
%                     DRDpKalmat(w,st)=mean(DDpKal);
%                     
%                     DRDsqKalmat(w,st)=sqrt(mean(DDsqKal));
%                     DRDsqwrfmat(w,st)=sqrt(mean(DDsqwrf));
%                     DRDsqpKalmat(w,st)=sqrt(mean(DDsqpKal));
                   
                    
                end
            else
                
                ti=ti-1;
                
            end
            
        end
        %%%%%scrap%%%%%%%%%%
        
        
        
        
    end
    save(BySTW)
end

% dlmwrite('M3KALbMAT.txt',DRDKalmat)
% dlmwrite('M3WRFbMAT.txt',DRDwrfmat)
% dlmwrite('M3PKALbMAT.txt',DRDpKalmat)
% 
% dlmwrite('M3KALrMAT.txt',DRDsqKalmat)
% dlmwrite('M3WRFrMAT.txt',DRDsqwrfmat)
% dlmwrite('M3PKALrMAT.txt',DRDsqpKalmat)




scatter(DRM1Kalorig,DRM1Kal)
scatter(DRlatFFArray,DRM1Obs)
error('is fin the same?')
scatter(DRlatFFArray,DRM1Kalorig,'r')
hold on
scatter(DRlatFFArray,DRM1Kal,'g')

%
% load(11th workspace)
%Everything is sequential so the 11th has all the data
%1-10 are essentially just breakpoints in case of code faliure
% clear
% clc
% load('sc3311.mat')

rmse=(mean(RMSEkal))
rmseWRF=(mean(RMSEwrf))
meanBias=mean(mbKal)
meanBiasWRF=mean(mbWRF)

maxAx(1,1)=max(latFFArray)
maxAx(2,1)=max(PredArray)
maxAx(3,1)=max(PWRFArray)


minAx(1,1)=min(latFFArray)
minAx(2,1)=min(PredArray)
minAx(3,1)=min(PWRFArray)

axisMin= min(minAx)
axisMax= max(maxAx)
scatter(DRIlatFFArray,latFFArray)
scatter(DRIPredArray,latFFArray)
scatter(DRIPredArray,PredArray)

fig = figure;
R=corrcoef(latFFArray, PredArray);
scatter(latFFArray,PWRFArray,'MarkerEdgeColor',[.8 .2 .2]);

RWRF=corrcoef(latFFArray, PWRFArray);

hold on;

scatter(latFFArray,PredArray,'MarkerEdgeColor',[0 0 0.3]);
P=polyfit(latFFArray,PredArray,1);
yfit=P(1)*latFFArray+P(2);

PWRF=polyfit(latFFArray,PWRFArray,1);
yfitWRF=PWRF(1)*latFFArray+PWRF(2);


hold on;
plot(latFFArray,yfitWRF,'Color',[.8 .2 .2]);
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
line1 ='Kalman Filter (2D) Prediction History 10% Storm Sample';
%['Station ID:  ',(STelim{j,1}),' ','Storm:  ', firstDay(1:8)]
%     line2 =['UK RMSE (m/s)=',num2str(rmse)];
%     line3=['UK Mean Bias (m/s)=',num2str(meanBias)];
%     line4=['UK R^2=',num2str(R(1,2))];
line2 ='Corresponding WRF predictions'
%     line3=['Kalman Mean Bias (m/s)=',num2str(meanBias),'   ','WRF Mean Bias(m/s)=',num2str(meanBiasWRF)];
%     line4=['Kalman R^2=',num2str(R(1,2)),'   ','WRF R^2=',num2str(RWRF(1,2))];
lines ={line1,line2};

title(lines);
axis([0 (axisMax +1) 0 (axisMax +1)]);
xlabel('Individiual Station Strom Average Wind Speed (m/s)');
ylabel('Storm Average Wind Speed Estimate (m/s)');

%gcf=.pdf';
%pname=[ statname{1,plottick +2}, '.pdf' ];



theString = sprintf('y = %.2f x + %.2f', P(1),P(2));
theWRFString = sprintf('y = %.2f x + %.2f', PWRF(1),PWRF(2));
%text((1),axisMax, theString, 'FontSize', 10);
legend('WRF Estimate','Kalman Estimate',theWRFString,theString, ...
    '1:1 Reference Line','Location','southeast');


hold off;

NEUS=['kfloi.png'];
%NEUSFo=fullfile(BySTatFo,NEUS)
saveas(fig,NEUS);


fig = figure;
R=corrcoef(latFFArray, PredArray);
scatter(latFFArray,PredArray,'MarkerEdgeColor',[0 0 0.3]);

%     RWRF=corrcoef(latFFArray, PWRFArray);

hold on;
%      scatter(latFFArray,PWRFArray,'c');
P=polyfit(latFFArray,PredArray,1);
yfit=P(1)*latFFArray+P(2);

%     PWRF=polyfit(latFFArray,PWRFArray,1);
%     yfitWRF=PWRF(1)*latFFArray+PWRF(2);
%
hold on;
plot(latFFArray,yfit,'Color',[0 0 0.3]);
%
%      hold on;
%     plot(latFFArray,yfitWRF,'-c');
hold on
refX=[0:axisMax];
refY=[0:axisMax];
line(refX,refY,'Color','k')
%    fd=TimeCell{1}
%   firstDay=cell2mat(fd)
% titlestring=['y=',num2str(P(1)),'x+',num2str(P(2)),' R^2=',num2str(R(1,2))];
% title(titlestring);
line1 ='Kalman Filter (2D) Prediction History 10% Storm Sample';
%['Station ID:  ',(STelim{j,1}),' ','Storm:  ', firstDay(1:8)]
%     line2 =['UK RMSE (m/s)=',num2str(rmse)];
%     line3=['UK Mean Bias (m/s)=',num2str(meanBias)];
%     line4=['UK R^2=',num2str(R(1,2))];
line2 =['Kalman RMSE (m/s)=',num2str(rmse)];
%     line3=['Kalman Mean Bias (m/s)=',num2str(meanBias)];
% %     line4=['Kalman R^2=',num2str(R(1,2))];
%     lines ={line1,line2,line3,line4};
%
title(line1);
axis([0 (maxAx(2,1)+1) 0 (maxAx(2,1)+1)]);
xlabel('Individiual Station Strom Average Wind Speed (m/s)');
ylabel('Storm Average Wind Speed Estimate (m/s)');

%gcf=.pdf';
%pname=[ statname{1,plottick +2}, '.pdf' ];



theString = sprintf('y = %.2f x + %.2f', P(1),P(2));
%theWRFString = sprintf('y = %.2f x + %.2f', PWRF(1),PWRF(2));
%text((1),axisMax, theString, 'FontSize', 10);
legend('Kalman Estimate',theString,'1:1 Reference Line','Location','southeast');


hold off;

NEUS=['loikf2.png'];
%NEUSFo=fullfile(BySTatFo,NEUS)
saveas(fig,NEUS);



fig = figure;
%     R=corrcoef(latFFArray, PredArray);
%     scatter(latFFArray,PredArray,'g');
%
RWRF=corrcoef(latFFArray, PWRFArray);

%       hold on;
scatter(latFFArray,PWRFArray,'MarkerEdgeColor',[.8 .2 .2]);
%      P=polyfit(latFFArray,PredArray,1);
%     yfit=P(1)*latFFArray+P(2);
%
PWRF=polyfit(latFFArray,PWRFArray,1);
yfitWRF=PWRF(1)*latFFArray+PWRF(2);

%      hold on;
%      plot(latFFArray,yfit,'-g');
%
hold on;
plot(latFFArray,yfitWRF,'Color',[.8 .2 .2]);
hold on
refX=[0:axisMax];
refY=[0:axisMax];
line(refX,refY,'Color','k')
%    fd=TimeCell{1}
%   firstDay=cell2mat(fd)
% titlestring=['y=',num2str(P(1)),'x+',num2str(P(2)),' R^2=',num2str(R(1,2))];
% title(titlestring);
line1 ='Prediction History 10% Storm Sample Corresponding WRF';
%['Station ID:  ',(STelim{j,1}),' ','Storm:  ', firstDay(1:8)]
%     line2 =['UK RMSE (m/s)=',num2str(rmse)];
%     line3=['UK Mean Bias (m/s)=',num2str(meanBias)];
%     line4=['UK R^2=',num2str(R(1,2))];
%  line2 =['WRF RMSE (m/s)=',num2str(rmseWRF)];
%     line3=['WRF Mean Bias(m/s)=',num2str(meanBiasWRF)];
%     line4=['WRF R^2=',num2str(RWRF(1,2))];
%     lines ={line1,line2,line3,line4};
%
title(line1);
axis([0 (axisMax+1) 0 (axisMax+1)]);
xlabel('Individiual Station Strom Average Wind Speed (m/s)');
ylabel('Storm Average Wind Speed Estimate (m/s)');

%gcf=.pdf';
%pname=[ statname{1,plottick +2}, '.pdf' ];



theString = sprintf('y = %.2f x + %.2f', P(1),P(2));
theWRFString = sprintf('y = %.2f x + %.2f', PWRF(1),PWRF(2));
%text((1),axisMax, theString, 'FontSize', 10);
legend('WRF Estimate',theWRFString,'1:1 Reference Line','Location','southeast');


hold off;

NEUS=['loikf3.png'];
%NEUSFo=fullfile(BySTatFo,NEUS)
saveas(fig,NEUS);



