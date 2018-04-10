% clear
% clc
% %%%%%%%%%%%%%%%%%%%%%%%%%%%
% RN=96%Rand #
% string=num2str(RN);
% 
% starTime=RN
% STstring='96'
% %%%%%%%%%%%%%%%%%%%%%%%%%%%
% MetarFo=['BiasMetOut',STstring]
% MadisFo=['BiasMadOut',STstring]
% AdjFo=['BiasCombOut',STstring]
% BySTatFo=['BiasBStat',STstring];
% ZfFo=['BiasZfKrig',STstring];
% 
% mkdir(ZfFo)
% 
% FiMetIn = ['20010305';'20031214';'20040701';'20040820';'20040908'; ...
%     '20040917';'20040928';'20041104';'20041130';'20041225';'20050401'; ...
%     '20050628';'20050718';'20050721';'20050727';'20050804';'20050811'; ...
%     '20050916';'20050929';'20051007';'20051015';'20051024';'20060102'; ...
%     '20060114';'20060117';'20060216';'20060531';'20060606';'20060710'; ...
%     '20060716';'20060727';'20060801';'20060901';'20061027';'20061130'; ...
%     '20070301';'20070414';'20070515';'20070531';'20070709';'20070714'; ...
%     '20070729';'20070816';'20071202';'20080113';'20080212';'20080308'; ...
%     '20080320';'20080526';'20080608';'20080610';'20080613';'20080622'; ...
%     '20080717';'20080722';'20080726';'20080805';'20080906';'20081025'; ...
%     '20081210';'20081230';'20090107';'20090509';'20090625';'20090706'; ...
%     '20090723';'20090729';'20090731';'20090821';'20091006';'20091127'; ...
%     '20100223';'20100313';'20100428';'20100503';'20100504';'20100507'; ...
%     '20100525';'20100602';'20100604';'20100605';'20100705';'20100721'; ...
%     '20100929';'20101225';'20110111';'20110117';'20110201';'20110601'; ...
%     '20110608';'20110828';'20111028';'20120622';'20121028';'20121107'; ...
%     '20121228';'20130130';'20130208';'20130511';'20130523';'20130525'; ...
%     '20130529';'20130607';'20130613';'20130901';'20131031';'20131118'; ...
%     '20131126';'20140106';'20140110';'20140204'];
% 
% %Read the Storms time list
% filebeg  = (FiMetIn(RN,:));
% STCVname=[filebeg,'SC24.txt'];
% STCVID=fopen(fullfile('storm',STCVname),'r');
% timnam = 1;
% while(~feof(STCVID));
%     
%     InputText =textscan(STCVID, '%s',1,'delimiter', ',');
%     TimeCell{timnam,1} = InputText{1};
%     timnam = timnam+1;
%     
% end
% 
% fclose(STCVID);
% 
% % 
% 
% % %
% % % % %
% filend2='.txt';
% 
% 
% %new = 0;
% ile=0;
% for t = 1:(timnam-2)
%     %:24
%     %new = new+1;
% 
%     filebeg  = cell2mat(TimeCell{t,1});
% 
%     filnCtr = ['HtrC',filebeg,filend2];
%     filnRtr = ['HtrR',filebeg,filend2];
%     filnFFtr= ['HtrFF',filebeg,filend2];
% 
%     Ctr = dlmread(fullfile(AdjFo,filnCtr));
%     Rtr = dlmread(fullfile(AdjFo,filnRtr));
%     FFtr = dlmread(fullfile(AdjFo,filnFFtr));
%     
%     %Also read TT files
%  filnCtr = ['TTtrC',filebeg,filend2];
%     filnRtr = ['TTtrR',filebeg,filend2];
%     filnFFtr= ['TTtrFFF',filebeg,filend2];
%     TTCtr = dlmread(fullfile(AdjFo,filnCtr));
%     TTRtr = dlmread(fullfile(AdjFo,filnRtr));
%     TTFFtr = dlmread(fullfile(AdjFo,filnFFtr));
%     
%      %   [wind str] = xlsread(filename1, t);
%    % filenum = num2str(new);
% 
%     sizeS = size(Ctr);
%     sizeSS = sizeS(1);
% 
%     for i = 1:sizeSS;
%         %
%         ile = ile+1;
%         clearvars NewCtr NewRtr NewFFtr
% 
%         ilenum = num2str(ile);
% 
%         elimarray = [1:sizeSS];
%         elimarray(i) = 0;
% %         fprintf('loop = ; elimarray=')
% %         disp(i)
% %         disp(elimarray)
% 
%         b = 0;
%         for a = 1:sizeSS;
%             kill = elimarray(a);
% 
%             if kill >0;
%                 b = b+1;
%                 NewCtr(b,1)=Ctr(a,1);
%                 NewRtr(b,1)=Rtr(a,1);
%                 NewFFtr(b,1)=FFtr(a,1);
% 
% 
% %                 NewS{b,1} = S(a,1);
% %                 NewS{b,2} = S(a,2);
% %                 %NewS{b,3} = station{a,1};
% %                 NewY(b,1) = wind(a,1);
% 
%             end
% 
% 
%         end
% 
%         %%%%Add TTtr files
%          sizeTT = size(TTCtr);
%     sizeTTtr = sizeTT(1);
%         for TTtr=1:sizeTTtr
%             b=b+1
%             NewCtr(b,1)=TTCtr(TTtr,1);
%             NewRtr(b,1)=TTRtr(TTtr,1);
%             NewFFtr(b,1)=TTFFtr(TTtr,1);
%         end
%         
% 
%     fCtr = ['trC',ilenum,filend2];
%     fRtr = ['trR',ilenum,filend2];
%     fFFtr= ['trFF',ilenum,filend2];
% 
%     dlmwrite(fullfile(ZfFo,fCtr),NewCtr);
%     dlmwrite(fullfile(ZfFo,fRtr),NewRtr);
%     dlmwrite(fullfile(ZfFo,fFFtr),NewFFtr);
% 
% 
% 
%     end
% end
% 
% 
% 
% 
% 
% 
% 
% fprintf('NEED TO WRITE DOWN ILE \n')
% disp(ile)
% 







% % % 
% % % % % %After the Kriging%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear
% clc
% %%%%%%%%%%%%%%%%%%%%%%%%%%%
% RN=96%Rand #
% string=num2str(RN);
% 
% starTime=RN
% STstring='96'
% %%%%%%%%%%%%%%%%%%%%%%%%%%%
% MetarFo=['BiasMetOut',STstring]
% MadisFo=['BiasMadOut',STstring]
% AdjFo=['BiasCombOut',STstring]
% BySTatFo=['BiasBStat',STstring];
% ZfFo=['BiasZfKrig',STstring];
% wkspn=['BWksp',STstring,'.mat'];
% mkdir(ZfFo)
% 
% FiMetIn = ['20010305';'20031214';'20040701';'20040820';'20040908'; ...
%     '20040917';'20040928';'20041104';'20041130';'20041225';'20050401'; ...
%     '20050628';'20050718';'20050721';'20050727';'20050804';'20050811'; ...
%     '20050916';'20050929';'20051007';'20051015';'20051024';'20060102'; ...
%     '20060114';'20060117';'20060216';'20060531';'20060606';'20060710'; ...
%     '20060716';'20060727';'20060801';'20060901';'20061027';'20061130'; ...
%     '20070301';'20070414';'20070515';'20070531';'20070709';'20070714'; ...
%     '20070729';'20070816';'20071202';'20080113';'20080212';'20080308'; ...
%     '20080320';'20080526';'20080608';'20080610';'20080613';'20080622'; ...
%     '20080717';'20080722';'20080726';'20080805';'20080906';'20081025'; ...
%     '20081210';'20081230';'20090107';'20090509';'20090625';'20090706'; ...
%     '20090723';'20090729';'20090731';'20090821';'20091006';'20091127'; ...
%     '20100223';'20100313';'20100428';'20100503';'20100504';'20100507'; ...
%     '20100525';'20100602';'20100604';'20100605';'20100705';'20100721'; ...
%     '20100929';'20101225';'20110111';'20110117';'20110201';'20110601'; ...
%     '20110608';'20110828';'20111028';'20120622';'20121028';'20121107'; ...
%     '20121228';'20130130';'20130208';'20130511';'20130523';'20130525'; ...
%     '20130529';'20130607';'20130613';'20130901';'20131031';'20131118'; ...
%     '20131126';'20140106';'20140110';'20140204'];
% 
% %Read the Storms time list
% filebeg  = (FiMetIn(RN,:));
% STCVname=[filebeg,'SC24.txt'];
% STCVID=fopen(fullfile('storm',STCVname),'r');
% timnam = 1;
% while(~feof(STCVID));
%     
%     InputText =textscan(STCVID, '%s',1,'delimiter', ',');
%     TimeCell{timnam,1} = InputText{1};
%     timnam = timnam+1;
%     
% end
% 
% fclose(STCVID);
% 
% 
% filend2='.txt'
% latot=0
% 
% 
% matcheck=0;
% totiter = 0;
% ileticks=0;
% for t = 1:(timnam-2)
%     %:24
%     %new = new+1;
% 
%     filebeg  = cell2mat(TimeCell{t,1});
% 
%     %:ticou;
%     matcheck=matcheck+1;
%     %Read original files
%     filebeg  = cell2mat(TimeCell{t,1});
%     filnSTtr=['HtrST',filebeg,filend2];
%     filnCtr = ['HtrC',filebeg,filend2];
%     filnRtr = ['HtrR',filebeg,filend2];
%     filnFFtr= ['HtrFF',filebeg,filend2];
% %     nm=['res',filebeg,filend2];
% %     nm2=['pB',filebeg,filend2];
%     
%     %    STID=fopen(fullfile(AdjFo,(filnSTtr)),'r');
%     CID = fopen(fullfile(AdjFo,(filnCtr)), 'r');
%     RID = fopen(fullfile(AdjFo,(filnRtr)), 'r');
%     ffID = fopen(fullfile(AdjFo,(filnFFtr)), 'r');
%     
%     Cit=1;
%     Rit=1;
%     ffit=1;
%     %STit=1;
%     
%     %%%%ElimArray
%     ElimName=['HElim',STstring,'.csv'];
%     MaxName= ['MaxReps',STstring,'.csv'];
%     
%     ElimFo = fullfile(BySTatFo,ElimName);
%     Reps=dlmread(fullfile(BySTatFo,MaxName));
%     RMval=(Reps(1,1));
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
%     end
%     fclose(ElimID)
%   
%     
%     while(~feof(CID));
%         
%         ColMad =textscan(CID, '%f',1,'delimiter', '\t');
%         sizeCMAD = size(ColMad{1});
%         if sizeCMAD(1)>0;
%             C{Cit,1} = ColMad{1};
%             Cit = Cit+1;
%         end
%     end
%     
%     while(~feof(RID));
%         
%         RowMad =textscan(RID, '%f',1,'delimiter', '\t');
%         sizeRMAD = size(RowMad{1});
%         if sizeRMAD(1)>0;
%             R{Rit,1} = RowMad{1};
%             Rit = Rit+1;
%         end
%     end
%     
%     while(~feof(ffID));
%         
%         ffMad =textscan(ffID, '%f',1,'delimiter', '\t');
%         sizeffMAD = size(ffMad{1});
%         if sizeffMAD(1)>0;
%             ff{ffit,1} = ffMad{1};
%             ffit = ffit+1;
%         end
%     end
% 
%     fclose(CID);
%     fclose(RID);
%     fclose(ffID);
% 
%     
%     sizeC = size(C);
%     sizefi=sizeC(1);
% 
%     %Compare to Kriging Field%%%%%%%%%%%%%%%%%%%%%
%     
%     disp(Cit-2)
%     lif = (Cit-2)
%     if latot==0
%         PredB=zeros(lif,1);
%         latFF=zeros(lif,1);
%         Bsquared=zeros(lif,1);
%         Bias=zeros(lif,1);
%         
%     end
%     
%     
%     
%     for iiiii = 1:lif
%         
%         ileticks=ileticks+1;
%         ileit = num2str(ileticks);
%         
%         
%         
%         %%%
%         %WRFname = [filebeg,'WRF',filend2];
%     
%         %WRFtot = dlmread(fullfile('WRFnew',(WRFname)));
% 
%         YX =dlmread(fullfile(ZfFo,[ileit,'yx.txt']));
%         S = dlmread(fullfile(ZfFo,[ileit,'CR.txt']));
%         disp(lif)
%         
%         
%         %load (wkspc);
%         
%         clearvars sizess sizes ;
%         sizes = size(S);
%         sizess = sizes(1);
%         
%         %%%
%         Rnum=R{iiiii,1};
%         Cnum=C{iiiii,1};
%         Rclose = round(Rnum);
%         Cclose = round(Cnum);
%         LocClose = (Cclose-1)*330 + Rclose;
%         KriBclose = YX(LocClose);
%         %WRFclose = WRFtot(LocClose,1);
%         latot = latot+1;
%     
%         Bsquared(iiiii,matcheck)=(KriBclose-ff{iiiii,1})^2;
%         Bias(iiiii,matcheck)=(KriBclose-ff{iiiii,1});
%         PredB(iiiii,matcheck)=KriBclose;
%         latFF(iiiii,matcheck)=ff{iiiii,1};
%         
%         
% %         BsqWRF(iiiii,matcheck)=(WRFclose-ff{iiiii,1})^2;
% %         BiasWRF(iiiii,matcheck)=(WRFclose-ff{iiiii,1});
% %         PredBWRF(iiiii,matcheck)=WRFclose;
%        
%         % fprintf('is it adding \n')
%         % disp(PredB(iiiii,1))
%         % disp(KriBclose)
%         % disp(iiiii)
%         
%         %fprintf(wriID, '%f\n', BIWRF);
%         %fprintf(BIASID, '%f\n', BIAS);
%         
%     end
%     %clearvars iiiii Cit
%     
%     
%     
%     
%     
%     
%     %dlmwrite(fullfile('Evaluation',nm),BIAS);
%     %dlmwrite(fullfile('Evaluation',nm2),PredB);
%     
% end
% disp(latFF)
% 
% 
%   for y=1:(Cit-1)
%     for dim=1:(RMval+1)
%        
%             %How does the change in dimension size
%             %affect read
%             placehold{1,1}=STelim2{1,dim};
%             ph2=placehold{1,1}
%             STelim{y,dim}=ph2{y,1};
%         end
%         
%     end
%   
for j=1:lif
    for t=1:(timnam-2)
        
        PredArray(t,1)=PredB(j,t);
        latFFArray(t,1)=latFF(j,t);
        
        BsqArray(t,1)= Bsquared(j,t);
        BiasArray(t,1)=Bias(j,t);
        
        
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
   % AvgFFWRF=mean(PWRFArray)
    
%     rmseWRF=sqrt(mean(BsqWRFArray));
%     meanBiasWRF=mean(BWRFArray);
%     
    maxData(1)=max(PredArray);
    maxData(2)=max(latFFArray);
%     maxData(3)=max(PWRFArray)
    minData(1)=min(PredArray);
    minData(2)=min(latFFArray);
%     minDat(3)=min(PWRFArray);
%     
    axisMax=(max(maxData));
    axisMin=(min(minData));
    % %%Automatic Plotting
    
    fig = figure;
    R=corrcoef(latFFArray, PredArray);
    scatter(latFFArray,PredArray,'g');
    
%     RWRF=corrcoef(latFFArray, PWRFArray);
%        
%      hold on;
%     scatter(latFFArray,PWRFArray,'c');
     P=polyfit(latFFArray,PredArray,1);
     yfit=P(1)*latFFArray+P(2);
%     
%     PWRF=polyfit(latFFArray,PWRFArray,1);
%     yfitWRF=PWRF(1)*latFFArray+PWRF(2);
    
    hold on;
    plot(latFFArray,yfit,'-g');
    
%      hold on;
%     plot(latFFArray,yfitWRF,'-c');
    hold on
    hline = refline([1 0]);
    hline.Color = 'r';
    
    fd=TimeCell{1}
    firstDay=cell2mat(fd)
    % titlestring=['y=',num2str(P(1)),'x+',num2str(P(2)),' R^2=',num2str(R(1,2))];
    % title(titlestring);
    line1 =['Station ID:  ',(STelim{j,1}),' ','Storm:  ', firstDay(1:8)];
    line2 =['UK WRF Bias Pred RMSE (m/s)=',num2str(rmse)];
    line3=['UK WRF Bias Pred Mean Bias (m/s)=',num2str(meanBias)];
    line4=['UK WRF Bias Pred R^2=',num2str(R(1,2))];
 
    lines ={line1,line2,line3,line4};
    
    title(lines);
    axis([axisMin axisMax axisMin axisMax]);
    xlabel('Point WRF Bias (m/s)');
    ylabel('Blind UK estimate of Bias (m/s)');
    
    %gcf=.pdf';
    %pname=[ statname{1,plottick +2}, '.pdf' ];
    
    
    theString = sprintf('y = %.2f x + %.2f', P(1),P(2));
     %theWRFString = sprintf('y = %.2f x + %.2f', PWRF(1),PWRF(2));
    %text((1),axisMax, theString, 'FontSize', 10);
    legend('UK Estimate',theString, ...
        '1:1 Reference Line','Location','northwest');
    
    
    hold off;
    
    
    for dim=1:(RMval+1)
        %mkdir(BySTatFo,(STelim{j,dim}));
         RMSEname=['BiasRMSE',(STelim{j,dim}),'.csv']
        RMSEFo=fullfile(BySTatFo,RMSEname);
        blankmat=ones(2,2);
        dlmwrite(RMSEFo,(rmse.*blankmat));
        
        
%          RMSEWRFname=['RMSEWRF',(STelim{j,dim}),'.csv']
%         RMSEFo=fullfile(BySTatFo,RMSEWRFname);
%         blankmat=ones(2,2);
%         dlmwrite(RMSEFo,(rmseWRF.*blankmat));
        %%%
          FFname=['Bias',(STelim{j,dim}),'.csv']
        FFFo=fullfile(BySTatFo,FFname);
        blankmat=ones(2,2);
        dlmwrite(FFFo,(AvgFF.*blankmat));
        
         FFUKname=['BiasUK',(STelim{j,dim}),'.csv']
        FFUKFo=fullfile(BySTatFo,FFUKname);
        blankmat=ones(2,2);
        dlmwrite(FFUKFo,(AvgUKFF.*blankmat));
        
        
%          FFWRFname=['FFWRF',(STelim{j,dim}),'.csv']
%        FFWRFFo=fullfile(BySTatFo,FFWRFname);
%         blankmat=ones(2,2);
%         dlmwrite(FFWRFFo,(AvgFFWRF.*blankmat));
%         %%%
%         
        NEUS=['Bias',(STelim{j,dim}),'.png'];
        NEUSFo=fullfile(BySTatFo,NEUS)
        saveas(fig,NEUSFo);
    end
    
    
    
    
    
    %fn=num2str(j);
    %mkdir(BySTatFo,cell2mat(STelim{j,1}));
    %
    % NEUS=['NEUS',cell2mat(STelim{j,1}),STstring,'.png'];
    % NEUSFo=fullfile(BySTatFo,(STelim{j,1}),NEUS)
    % saveas(fig,NEUSFo);
end
% % %

%
save(wkspn)