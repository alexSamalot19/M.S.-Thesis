%FILE PREVIEW

%coment>copy/paste style code
clear
clc

cd ..

ti=0;
tism=0;
Bigtism=0;
%Read Stormlist%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
filename='Stormlist.csv';
FID=fopen(fullfile('Meth34nBase',filename),'r');

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


filename='MetMad.csv';
FID=fopen(fullfile('Meth34nBase',filename),'r');

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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DriveInfo='Meth34Diff';
for st=70:109 %36:69  %3:35    %1:(Stnum-1)
    %     COMP=CompArray(st,:);
    BySTatFo=['WindBStat',num2str(st)];
    BySTW=['m1m2111',num2str(st),'.mat'];
    DiffFo=['BiasBStDiff',num2str(st)];
    
     AdjFo111=['BiasCO111',num2str(st)];
    BySTatFo111=['BiasBS111',num2str(st)];
    ZfFo111=['BiasZfKri111',num2str(st)];
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
        pkmad=exist(fullfile('Meth34nBase',BySTatFo111,JKO));
        if pkmad>0
            ti=ti+1;
            
            %Obs
            ObsMV=dlmread(fullfile('Meth34nBase',BySTatFo111,JKO));
            % %
            
            %WRF
            WRFMV=dlmread(fullfile('Meth34nBase',BySTatFo111,JKW));
            
            % %
            
            %KAL
            KALMV=dlmread(fullfile('Meth34nBase',BySTatFo111,JKK));
            % %
            
%             sidk=size(KALMV)
%                     siomv=size(ObsMV)
%                     
%                     if sidk(1)<siomv(1)
% %                         error('is WRF too big too?')
%                     ObsMV(25:48)=[]
%                     end
%             
%             %Differences
%             DKal=KALMV-ObsMV;
%             DWRF=WRFMV-ObsMV;
%             DsqKal=(KALMV-ObsMV).^2;
%             DsqWRF=(WRFMV-ObsMV).^2;
%             %Means
%             mbKal(ti,1)=mean(DKal);
%             mbWRF(ti,1)=mean(DWRF);
%             RMSEkal(ti,1)=sqrt(mean(DsqKal));
%             RMSEwrf(ti,1)=sqrt(mean(DsqWRF));
            latFFArray(ti,1)=mean(ObsMV);
            PredArray(ti,1)=mean(KALMV);
            PWRFArray(ti,1)=mean(WRFMV);
            
            
            
        else
            pkmet=exist(fullfile('Meth34nBase',BySTatFo111,METJKO));
            if pkmet>1
                ti=ti+1;
                ObsMV=dlmread(fullfile('Meth34nBase',BySTatFo111,METJKO));
                
                %WRF
                WRFMV=dlmread(fullfile('Meth34nBase',BySTatFo111,METJKW));
                % %
                
                %KAL
                METKALMV=dlmread(fullfile('Meth34nBase',BySTatFo111,METJKK));
                % %
                
%                 %Differences
%                 DKal= METKALMV- ObsMV;
%                 DWRF= WRFMV- ObsMV;
%                 DsqKal=( METKALMV- ObsMV).^2;
%                 DsqWRF=( WRFMV- ObsMV).^2;
%                 %Means
%                 mbKal(ti,1)=mean( DKal);
%                 mbWRF(ti,1)=mean( DWRF);
%                 RMSEkal(ti,1)=sqrt(mean(DsqKal));
%                 RMSEwrf(ti,1)=sqrt(mean(DsqWRF));
                latFFArray(ti,1)=mean( ObsMV);
                PredArray(ti,1)=mean( METKALMV);
                PWRFArray(ti,1)=mean( WRFMV);
                
                
            end
            
            
            
        end
        % %
        tinew=ti;
        
        pkdrive=exist(fullfile(DriveInfo,DiffFo,FFname));
        pkdrivec=exist(fullfile(DriveInfo,BySTatFo111,['KP111FFa',lname,'.csv']));
        %%%%%%%%%Original Comparison (BiasBSCVDiff)%%%%%%%%%%%%%%%%%%%
        if tinew>tiold
%             if pkdrive>0
%                 %             FFname=['WMFFArr',lname,'.csv'];
%                 %             FFUKname=['WMFFUKArr',lname,'.csv'];
%                 
%                 %Obs
%                 DRIObsMV=dlmread(fullfile(DriveInfo,DiffFo,FFname));
%                 % %
%                 %KAL
%                 DRIKALMV=dlmread(fullfile(DriveInfo,DiffFo,FFUKname));
%                 % %
%                 
%                 %Differences
%                 DRIDKal=DRIKALMV-ObsMV;
%                 DRIDobs=DRIObsMV-ObsMV;
%                 DRIDsqKal=(DRIKALMV-ObsMV).^2;
%                 DRIDsqobs=(DRIObsMV-ObsMV).^2;
%                 %Means
%                 DRImbKal(ti,1)=mean(DRIDKal);
%                 DRImbobs(ti,1)=mean(DRIDobs);
%                 DRIRMSEkal(ti,1)=sqrt(mean(DRIDsqKal));
%                 DRIRMSEobs(ti,1)=sqrt(mean(DRIDsqobs));
%                 DRIlatFFArray(ti,1)=mean(DRIObsMV);
%                 DRIPredArray(ti,1)=mean(DRIKALMV);
%                 
                
                %%%%%%%%%Grid cell Comparison (GCKM3)%%%%%%%%%%%%%%%%%%%
                if pkdrivec>0
                    
                    tism=tism+1
                    Bigtism=Bigtism+1;
                    %KALcompare
                    DRIKALC=dlmread(fullfile('Meth34nBase',BySTatFo111,['fin111kal', ...
                        lname,'.csv']));
%                     dlmread(fullfile(DriveInfo,BySTatFo111,['Kal111FFa', ...
%                         lname,'.csv']));
                    DRIPKALC=dlmread((fullfile(DriveInfo,BySTatFo111,['KP111FFa',lname,'.csv'])));
                    disp(tism)
        disp(st)
                    
                      sidk=size(DRIKALC);
                    siomv=size(WRFMV);
                    
                    if sidk(1)>siomv(1);
%                        error('is WRF too big too?')
                    DRIKALC(25:48)=[];
                    DRIPKALC(25:48)=[];
                    ObsMV(25:48)=[];
                    
                    end
                    
                    DRIkal=DRIKALC;%+WRFMV;
                    DRIpkal=DRIPKALC+WRFMV;
                    DRIk=DRIKALC;%just residuals
                    DRIpk=DRIPKALC;%just residuals
                    DRIkalC=PredArray;%Equivalent BiasCVDiff Kal
                    DRIplatFFArray=latFFArray;%Eqiuivalent BiasCV Obs
                    DRIwrf=WRFMV;%Equivalent BiasCV wrf
                    itju=size(DRIPKALC);
                    itjump=itju(1)-1;
                    
                    
                    
                    %Differences
                    DDKal=DRIkal-ObsMV;
                    DDwrf= DRIwrf-ObsMV;
                    DDpKal=DRIpkal-ObsMV;
                    DDsqKal=(DRIkal-ObsMV).^2;
                    DDsqwrf=(DRIwrf-ObsMV).^2;
                    DDsqpKal=(DRIpkal-ObsMV).^2;
                    %Means
                    DRDKal(tism,1)=mean(DDKal);
                    DRDwrf(tism,1)= mean(DDwrf);
                    DRDpKal(tism,1)=mean(DDpKal);
                    DRDsqKal(tism,1)=sqrt(mean(DDsqKal));
                    DRDsqwrf(tism,1)=sqrt(mean(DDsqwrf));
                    DRDsqpKal(tism,1)=sqrt(mean(DDsqpKal));
                    
                    BTKal(Bigtism:Bigtism+itjump,1)=DDKal;
%                     if Bigtism>48
%                     error('check placement')
%                     end
                    BTwrf(Bigtism:Bigtism+itjump,1)=DDwrf;
                    BTpKal(Bigtism:Bigtism+itjump,1)=DDpKal;
                    BTsqKal(Bigtism:Bigtism+itjump,1)=DDsqKal;
                    BTsqwrf(Bigtism:Bigtism+itjump,1)=DDsqwrf;
                    BTsqpKal(Bigtism:Bigtism+itjump,1)=DDsqpKal;
                    
                    Bigtism=Bigtism+itjump;
                    
                    DRKal(tism,1)=mean(DRIkal);
                    DRwrf(tism,1)= mean(DRIwrf);
                    DRpKal(tism,1)=mean(DRIpkal);
                    DRlatFFArray(tism,1)=mean(ObsMV);
%                 end
            else
                
                ti=ti-1;
                
            end
            
        end
        %%%%%scrap%%%%%%%%%%
        
        
        
        
    end
    save(BySTW)
end

% %
% % load(11th workspace)
% %Everything is sequential so the 11th has all the data
% %1-10 are essentially just breakpoints in case of code faliure
% % clear
% % clc
% % load('sc3311.mat')
% 
% rmse=(mean(RMSEkal))
% rmseWRF=(mean(RMSEwrf))
% meanBias=mean(mbKal)
% meanBiasWRF=mean(mbWRF)
% 
% maxAx(1,1)=max(latFFArray)
% maxAx(2,1)=max(PredArray)
% maxAx(3,1)=max(PWRFArray)
% 
% 
% minAx(1,1)=min(latFFArray)
% minAx(2,1)=min(PredArray)
% minAx(3,1)=min(PWRFArray)
% 
% axisMin= min(minAx)
% axisMax= max(maxAx)
% scatter(DRIlatFFArray,latFFArray)
% scatter(DRIPredArray,latFFArray)
% scatter(DRIPredArray,PredArray)
% 
% fig = figure;
% R=corrcoef(latFFArray, PredArray);
% scatter(latFFArray,PWRFArray,'MarkerEdgeColor',[.8 .2 .2]);
% 
% RWRF=corrcoef(latFFArray, PWRFArray);
% 
% hold on;
% 
% scatter(latFFArray,PredArray,'MarkerEdgeColor',[0 0 0.3]);
% P=polyfit(latFFArray,PredArray,1);
% yfit=P(1)*latFFArray+P(2);
% 
% PWRF=polyfit(latFFArray,PWRFArray,1);
% yfitWRF=PWRF(1)*latFFArray+PWRF(2);
% 
% 
% hold on;
% plot(latFFArray,yfitWRF,'Color',[.8 .2 .2]);
% hold on;
% plot(latFFArray,yfit,'Color',[.0 0 0.3]);
% 
% hold on
% refX=[0:axisMax];
% refY=[0:axisMax];
% line(refX,refY,'Color','k')
% 
% %    fd=TimeCell{1}
% %   firstDay=cell2mat(fd)
% % titlestring=['y=',num2str(P(1)),'x+',num2str(P(2)),' R^2=',num2str(R(1,2))];
% % title(titlestring);
% line1 ='Kalman Filter (2D) Prediction History 10% Storm Sample';
% %['Station ID:  ',(STelim{j,1}),' ','Storm:  ', firstDay(1:8)]
% %     line2 =['UK RMSE (m/s)=',num2str(rmse)];
% %     line3=['UK Mean Bias (m/s)=',num2str(meanBias)];
% %     line4=['UK R^2=',num2str(R(1,2))];
% line2 ='Corresponding WRF predictions'
% %     line3=['Kalman Mean Bias (m/s)=',num2str(meanBias),'   ','WRF Mean Bias(m/s)=',num2str(meanBiasWRF)];
% %     line4=['Kalman R^2=',num2str(R(1,2)),'   ','WRF R^2=',num2str(RWRF(1,2))];
% lines ={line1,line2};
% 
% title(lines);
% axis([0 (axisMax +1) 0 (axisMax +1)]);
% xlabel('Individiual Station Strom Average Wind Speed (m/s)');
% ylabel('Storm Average Wind Speed Estimate (m/s)');
% 
% %gcf=.pdf';
% %pname=[ statname{1,plottick +2}, '.pdf' ];
% 
% 
% 
% theString = sprintf('y = %.2f x + %.2f', P(1),P(2));
% theWRFString = sprintf('y = %.2f x + %.2f', PWRF(1),PWRF(2));
% %text((1),axisMax, theString, 'FontSize', 10);
% legend('WRF Estimate','Kalman Estimate',theWRFString,theString, ...
%     '1:1 Reference Line','Location','southeast');
% 
% 
% hold off;
% 
% NEUS=['sc111v2.png'];
% %NEUSFo=fullfile(BySTatFo,NEUS)
% saveas(fig,NEUS);
% 
% 
% fig = figure;
% R=corrcoef(latFFArray, PredArray);
% scatter(latFFArray,PredArray,'MarkerEdgeColor',[0 0 0.3]);
% 
% %     RWRF=corrcoef(latFFArray, PWRFArray);
% 
% hold on;
% %      scatter(latFFArray,PWRFArray,'c');
% P=polyfit(latFFArray,PredArray,1);
% yfit=P(1)*latFFArray+P(2);
% 
% %     PWRF=polyfit(latFFArray,PWRFArray,1);
% %     yfitWRF=PWRF(1)*latFFArray+PWRF(2);
% %
% hold on;
% plot(latFFArray,yfit,'Color',[0 0 0.3]);
% %
% %      hold on;
% %     plot(latFFArray,yfitWRF,'-c');
% hold on
% refX=[0:axisMax];
% refY=[0:axisMax];
% line(refX,refY,'Color','k')
% %    fd=TimeCell{1}
% %   firstDay=cell2mat(fd)
% % titlestring=['y=',num2str(P(1)),'x+',num2str(P(2)),' R^2=',num2str(R(1,2))];
% % title(titlestring);
% line1 ='Kalman Filter (2D) Prediction History 10% Storm Sample';
% %['Station ID:  ',(STelim{j,1}),' ','Storm:  ', firstDay(1:8)]
% %     line2 =['UK RMSE (m/s)=',num2str(rmse)];
% %     line3=['UK Mean Bias (m/s)=',num2str(meanBias)];
% %     line4=['UK R^2=',num2str(R(1,2))];
% line2 =['Kalman RMSE (m/s)=',num2str(rmse)];
% %     line3=['Kalman Mean Bias (m/s)=',num2str(meanBias)];
% % %     line4=['Kalman R^2=',num2str(R(1,2))];
% %     lines ={line1,line2,line3,line4};
% %
% title(line1);
% axis([0 (maxAx(2,1)+1) 0 (maxAx(2,1)+1)]);
% xlabel('Individiual Station Strom Average Wind Speed (m/s)');
% ylabel('Storm Average Wind Speed Estimate (m/s)');
% 
% %gcf=.pdf';
% %pname=[ statname{1,plottick +2}, '.pdf' ];
% 
% 
% 
% theString = sprintf('y = %.2f x + %.2f', P(1),P(2));
% %theWRFString = sprintf('y = %.2f x + %.2f', PWRF(1),PWRF(2));
% %text((1),axisMax, theString, 'FontSize', 10);
% legend('Kalman Estimate',theString,'1:1 Reference Line','Location','southeast');
% 
% 
% hold off;
% 
% NEUS=['sc1112v2.png'];
% %NEUSFo=fullfile(BySTatFo,NEUS)
% saveas(fig,NEUS);
% 
% 
% 
% fig = figure;
% %     R=corrcoef(latFFArray, PredArray);
% %     scatter(latFFArray,PredArray,'g');
% %
% RWRF=corrcoef(latFFArray, PWRFArray);
% 
% %       hold on;
% scatter(latFFArray,PWRFArray,'MarkerEdgeColor',[.8 .2 .2]);
% %      P=polyfit(latFFArray,PredArray,1);
% %     yfit=P(1)*latFFArray+P(2);
% %
% PWRF=polyfit(latFFArray,PWRFArray,1);
% yfitWRF=PWRF(1)*latFFArray+PWRF(2);
% 
% %      hold on;
% %      plot(latFFArray,yfit,'-g');
% %
% hold on;
% plot(latFFArray,yfitWRF,'Color',[.8 .2 .2]);
% hold on
% refX=[0:axisMax];
% refY=[0:axisMax];
% line(refX,refY,'Color','k')
% %    fd=TimeCell{1}
% %   firstDay=cell2mat(fd)
% % titlestring=['y=',num2str(P(1)),'x+',num2str(P(2)),' R^2=',num2str(R(1,2))];
% % title(titlestring);
% line1 ='Prediction History 10% Storm Sample Corresponding WRF';
% %['Station ID:  ',(STelim{j,1}),' ','Storm:  ', firstDay(1:8)]
% %     line2 =['UK RMSE (m/s)=',num2str(rmse)];
% %     line3=['UK Mean Bias (m/s)=',num2str(meanBias)];
% %     line4=['UK R^2=',num2str(R(1,2))];
% %  line2 =['WRF RMSE (m/s)=',num2str(rmseWRF)];
% %     line3=['WRF Mean Bias(m/s)=',num2str(meanBiasWRF)];
% %     line4=['WRF R^2=',num2str(RWRF(1,2))];
% %     lines ={line1,line2,line3,line4};
% %
% title(line1);
% axis([0 (axisMax+1) 0 (axisMax+1)]);
% xlabel('Individiual Station Strom Average Wind Speed (m/s)');
% ylabel('Storm Average Wind Speed Estimate (m/s)');
% 
% %gcf=.pdf';
% %pname=[ statname{1,plottick +2}, '.pdf' ];
% 
% 
% 
% theString = sprintf('y = %.2f x + %.2f', P(1),P(2));
% theWRFString = sprintf('y = %.2f x + %.2f', PWRF(1),PWRF(2));
% %text((1),axisMax, theString, 'FontSize', 10);
% legend('WRF Estimate',theWRFString,'1:1 Reference Line','Location','southeast');
% 
% 
% hold off;
% 
% NEUS=['sc1113v2.png'];
% %NEUSFo=fullfile(BySTatFo,NEUS)
% saveas(fig,NEUS);
% 
% 
% 
