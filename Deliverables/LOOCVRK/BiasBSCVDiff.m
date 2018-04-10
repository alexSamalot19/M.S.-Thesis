clear
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%
RN=105%Rand #
string=num2str(RN);

starTime=RN
STstring='105'
%%%%%%%%%%%%%%%%%%%%%%%%%%%
MetarFo='KrInMetDiff';
MadisFo='KrInMadDiff';
AdjFo=['BiasCombOutDiff',STstring];
BySTatFo=['BiasBStDiff',STstring];
ZfFo=['BiasZfKrigDiff',STstring];

mkdir(ZfFo)

FiMetIn = ['20010305';'20031214';'20040701';'20040820';'20040908'; ...
    '20040917';'20040928';'20041104';'20041130';'20041225';'20050401'; ...
    '20050628';'20050718';'20050721';'20050727';'20050804';'20050811'; ...
    '20050916';'20050929';'20051007';'20051015';'20051024';'20060102'; ...
    '20060114';'20060117';'20060216';'20060531';'20060606';'20060710'; ...
    '20060716';'20060727';'20060801';'20060901';'20061027';'20061130'; ...
    '20070301';'20070414';'20070515';'20070531';'20070709';'20070714'; ...
    '20070729';'20070816';'20071202';'20080113';'20080212';'20080308'; ...
    '20080320';'20080526';'20080608';'20080610';'20080613';'20080622'; ...
    '20080717';'20080722';'20080726';'20080805';'20080906';'20081025'; ...
    '20081210';'20081230';'20090107';'20090509';'20090625';'20090706'; ...
    '20090723';'20090729';'20090731';'20090821';'20091006';'20091127'; ...
    '20100223';'20100313';'20100428';'20100503';'20100504';'20100507'; ...
    '20100525';'20100602';'20100604';'20100605';'20100705';'20100721'; ...
    '20100929';'20101225';'20110111';'20110117';'20110201';'20110601'; ...
    '20110608';'20110828';'20111028';'20120622';'20121028';'20121107'; ...
    '20121228';'20130130';'20130208';'20130511';'20130523';'20130525'; ...
    '20130529';'20130607';'20130613';'20130901';'20131031';'20131118'; ...
    '20131126';'20140106';'20140110';'20140204'];

%Read the Storms time list
filebeg  = (FiMetIn(RN,:));
STCVname=[filebeg,'SC24.txt'];
STCVID=fopen(fullfile('storm',STCVname),'r');
timnam = 1;
while(~feof(STCVID));
    
    InputText =textscan(STCVID, '%s',1,'delimiter', ',');
    TimeCell{timnam,1} = InputText{1};
    timnam = timnam+1;
    
end

fclose(STCVID);

% 

% %
% % % %
filend2='.txt';


%new = 0;
ile=0;
for t = 1:(timnam-2)
    %:24
    %new = new+1;
disp(t)
    filebeg  = cell2mat(TimeCell{t,1});

    filnCtr = ['GCHtrC',filebeg,filend2];
    filnRtr = ['GCHtrR',filebeg,filend2];
    filnFFtr= ['GCHtrFF',filebeg,filend2];

    Ctr = dlmread(fullfile(AdjFo,filnCtr));
    Rtr = dlmread(fullfile(AdjFo,filnRtr));
    FFtr = dlmread(fullfile(AdjFo,filnFFtr));

%     fprintf('Ctr size: \n')
%     disp(size(Ctr))
%     error('Look at H size=237?')
    
    
%     %Also read TT files
 filnCtr = ['TTtrC',filebeg,filend2];
    filnRtr = ['TTtrR',filebeg,filend2];
    filnFFtr= ['TTtrFFF',filebeg,filend2];
    TTtrEX(t)=exist(fullfile(AdjFo,filnCtr));
    if TTtrEX(t)>0
    TTCtr = dlmread(fullfile(AdjFo,filnCtr));
    TTRtr = dlmread(fullfile(AdjFo,filnRtr));
    TTFFtr = dlmread(fullfile(AdjFo,filnFFtr));
    end
    
     %   [wind str] = xlsread(filename1, t);
   % filenum = num2str(new);

    sizeS = size(Ctr);
    sizeSS = sizeS(1);

    for i = 1:sizeSS;
        %
        ile = ile+1;
        clearvars NewCtr NewRtr NewFFtr

        ilenum = num2str(ile);

        elimarray = [1:sizeSS];
        elimarray(i) = 0;
%         fprintf('loop = ; elimarray=')
%         disp(i)
%         disp(elimarray)

        b = 0;
        for a = 1:sizeSS;
            kill = elimarray(a);

            if kill >0;
                b = b+1;
                NewCtr(b,1)=Ctr(a,1);
                NewRtr(b,1)=Rtr(a,1);
                NewFFtr(b,1)=FFtr(a,1);


%                 NewS{b,1} = S(a,1);
%                 NewS{b,2} = S(a,2);
%                 %NewS{b,3} = station{a,1};
%                 NewY(b,1) = wind(a,1);

            end


        end
if TTtrEX(t)>0
%         %%%%Add TTtr files
         sizeTT = size(TTCtr);
    sizeTTtr = sizeTT(1);
        for TTtr=1:sizeTTtr
            b=b+1
            NewCtr(b,1)=TTCtr(TTtr,1);
            NewRtr(b,1)=TTRtr(TTtr,1);
            NewFFtr(b,1)=TTFFtr(TTtr,1);
        end
        
end

    fCtr = ['trC',ilenum,filend2];
    fRtr = ['trR',ilenum,filend2];
    fFFtr= ['trFF',ilenum,filend2];

    dlmwrite(fullfile(ZfFo,fCtr),NewCtr);
    dlmwrite(fullfile(ZfFo,fRtr),NewRtr);
    dlmwrite(fullfile(ZfFo,fFFtr),NewFFtr);



    end
end







fprintf('NEED TO WRITE DOWN ILE \n')
disp(ile)

% 
% 
% % % %New Version: Updated CV no FFmat%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% for storm=11;
% 
%     clearvars -except storm
%     CompArray=['CEELab20';'CEELab26';'CEELab27';'CEELab05';'CEELab22'; ...
%         'CEELab23';'CEELab06';'CEELab21';'CEELab24';'CEELab07';'CEELab25'];%
%     stoArray=[6,16,29,39,44,57,64,69,81,96,105];%
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%
%     RN=stoArray(storm)%Rand #
%     STstring=num2str(RN);
%     string=STstring
%     starTime=RN
%     COMP=CompArray(storm,:);
%     %%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%     MetarFo='KrInMetFE';
%     MadisFo='KrInMadFE';
%     AdjFo=['BiasCombOutFE',STstring];
%     BySTatFo=['BiasBStFE',STstring];
%     ZfFo=['BiasZfKrig',STstring];
% 
%     mkdir(ZfFo)
% 
%     FiMetIn = ['20010305';'20031214';'20040701';'20040820';'20040908'; ...
%         '20040917';'20040928';'20041104';'20041130';'20041225';'20050401'; ...
%         '20050628';'20050718';'20050721';'20050727';'20050804';'20050811'; ...
%         '20050916';'20050929';'20051007';'20051015';'20051024';'20060102'; ...
%         '20060114';'20060117';'20060216';'20060531';'20060606';'20060710'; ...
%         '20060716';'20060727';'20060801';'20060901';'20061027';'20061130'; ...
%         '20070301';'20070414';'20070515';'20070531';'20070709';'20070714'; ...
%         '20070729';'20070816';'20071202';'20080113';'20080212';'20080308'; ...
%         '20080320';'20080526';'20080608';'20080610';'20080613';'20080622'; ...
%         '20080717';'20080722';'20080726';'20080805';'20080906';'20081025'; ...
%         '20081210';'20081230';'20090107';'20090509';'20090625';'20090706'; ...
%         '20090723';'20090729';'20090731';'20090821';'20091006';'20091127'; ...
%         '20100223';'20100313';'20100428';'20100503';'20100504';'20100507'; ...
%         '20100525';'20100602';'20100604';'20100605';'20100705';'20100721'; ...
%         '20100929';'20101225';'20110111';'20110117';'20110201';'20110601'; ...
%         '20110608';'20110828';'20111028';'20120622';'20121028';'20121107'; ...
%         '20121228';'20130130';'20130208';'20130511';'20130523';'20130525'; ...
%         '20130529';'20130607';'20130613';'20130901';'20131031';'20131118'; ...
%         '20131126';'20140106';'20140110';'20140204'];
% 
%     %Read the Storms time list
%     filebeg  = (FiMetIn(RN,:));
%     STCVname=[filebeg,'SC24.txt'];
%     STCVID=fopen(fullfile('storm',STCVname),'r');
%     timnam = 1;
%     while(~feof(STCVID));
% 
%         InputText =textscan(STCVID, '%s',1,'delimiter', ',');
%         TimeCell{timnam,1} = InputText{1};
%         timnam = timnam+1;
% 
%     end
% 
%     fclose(STCVID);
% 
% 
%     filend2='.txt'
%     latot=0
% 
% 
%     matcheck=0;
%     totiter = 0;
%     ileticks=0;
%     timeis1 = 1%:(timnam-2)
%     %:24
%     %new = new+1;
% 
%     filebeg  = cell2mat(TimeCell{timeis1,1});
% 
%     ffMatFI=['FFMAT',STstring,'csv'];
%     ffmat=dlmread(fullfile(BySTatFo,ffMatFI));
%     %:ticou;
%     matcheck=matcheck+1;
%     %Read original files
%     filebeg  = cell2mat(TimeCell{timeis1,1});
%     filnSTtr=['GCHtrST',filebeg,filend2];
%     filnCtr = ['GCHtrC',filebeg,filend2];
%     filnRtr = ['GCHtrR',filebeg,filend2];
%     filnFFtr= ['GCHtrFF',filebeg,filend2];
%     %     nm=['res',filebeg,filend2];
%     %     nm2=['pB',filebeg,filend2];
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
%     ElimName=['GCHElNum',STstring,'.csv'];
%     MaxName= ['GCMaxReps',STstring,'.csv'];
%     Elim2=['GCHElim',STstring,'.csv'];
% 
%     ElimFo = fullfile(BySTatFo,Elim2);
%     Reps=dlmread(fullfile(BySTatFo,MaxName));
%     FileLocation=dlmread(fullfile(BySTatFo, ElimName));
% 
% 
% 
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
%     Reps=dlmread(fullfile(BySTatFo,MaxName));
%     RMval=(Reps(1,1));
%     maxReps=RMval+1;
%     %Compare to Kriging Field%%%%%%%%%%%%%%%%%%%%%
% 
%     disp(Cit-1)
%     lif = (Cit-1)
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
%     for y=1:(Cit-1)
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
% 
% 
% 
%     ElimMM=['GCElimMM',STstring,'.csv'];
%     ElimMMFo=fullfile(BySTatFo,ElimMM);
%     ElimMMID=fopen(ElimMMFo,'r');
%     ElimMMnum = 1;
%     howMMmany=0;
%     while(~feof(ElimMMID));
%         % %Test this before running main code
%         if (RMval+1)==1
%             STelimMM2 =textscan(ElimMMID, '%s',1,'delimiter', ',');
%         end
%         howMMmany=howMMmany+1
% 
%         if (RMval+1)==2
%             STelimMM2 =textscan(ElimMMID, '%s %s','Delimiter',',');
%         end
% 
%         if (RMval+1)==3
%             STelimMM2 =textscan(ElimMMID, '%s %s %s',1,'delimiter', ',');
%         end
% 
%         if (RMval+1)==3
%             error('New Maximum >3')
%         end
% 
%     end
%     fclose(ElimMMID)
% 
% 
%     for y=1:(Cit-1)
%         for dim=1:(RMval+1)
% 
%             %How does the change in dimension size
%             %affect read
%             placeMMhold{1,1}=STelimMM2{1,dim};
%             ph2MM=placeMMhold{1,1}
%             FileFo{y,dim}=ph2MM{y,1};
%         end
% 
%     end
% 
% 
% 
% 
%     %Read HSTn0 ... doing this before the loop for obvious time save
%     filebeg  = cell2mat(TimeCell{1,1});
%     FiFo='WindMadOut'
%     FilFo=[FiFo,STstring]
% %     error('edit FiFo')
%     HSTn0FN=fullfile('G:','CV62015Cast',COMP, ...
%         FilFo,[filebeg,'HSTn0.txt']);
%     HSTn0ID=fopen(HSTn0FN,'r');
%     HSTn0m = 1;
%     while(~feof(HSTn0ID));
% 
%         InputText =textscan(HSTn0ID, '%s',1,'delimiter', ',');
%         HSTn0{HSTn0m,1} = InputText{1};
%         HSTn0m  = HSTn0m +1;
% 
%     end
% 
%     fclose(HSTn0ID);
% 
% 
%     filend2='.txt'
% 
% 
%     %Metar
%      filebeg  = cell2mat(TimeCell{1,1});
%     MetFiFo='WindMetOut'
%     MetFilFo=[MetFiFo,STstring]
% %     error('edit FiFo')
%     MetHSTn0FN=fullfile('G:','CV62015Cast',COMP, ...
%         MetFilFo,[filebeg,'HSTn0.txt']);
%     MetHSTn0ID=fopen(MetHSTn0FN,'r');
%     MetHSTn0m = 1;
%     while(~feof(MetHSTn0ID));
% 
%         InputText =textscan(MetHSTn0ID, '%s',1,'delimiter', ',');
%         MetHSTn0{MetHSTn0m,1} = InputText{1};
%         MetHSTn0m  = MetHSTn0m +1;
% 
%     end
% 
%     fclose(MetHSTn0ID);
% 
% 
% 
% 
% 
% 
% 
%     for t=1:(timnam-2)
% 
%         filebeg  = cell2mat(TimeCell{t,1});
%         WRFname = [filebeg,'WRF',filend2];
%         WRFtot = dlmread(fullfile('G:','WRF',(WRFname)));
% 
%         for iiiii = 1:lif
%             ileticks=ileticks+1;
%             ileit = num2str(ileticks);
% 
%             YX =dlmread(fullfile(ZfFo,[ileit,'yx.txt']));
%             S = dlmread(fullfile(ZfFo,[ileit,'CR.txt']));
%             disp(lif)
% 
%             Rnum=R{iiiii,1};
%             Cnum=C{iiiii,1};
%             Rclose = round(Rnum);
%             Cclose = round(Cnum);
%             LocClose = (Cclose-1)*330 + Rclose;
% 
%             KriBclose = YX(LocClose);
%             WRFclose = WRFtot(LocClose,1);
%             latot = latot+1;
% 
% 
%             CVyx(t,iiiii)=KriBclose;%WRFclose-KriBclose;
% 
%             WRF(t,iiiii)=WRFclose;
% 
% 
%         end
%     end
% end
% % clear
% % clc
% % load('Midsave.mat')
% 
% %Metar
% filebeg  = cell2mat(TimeCell{1,1});
% MetFiFo='WindMetOut'
% MetFilFo=[MetFiFo,STstring]
% %     error('edit FiFo')
% MetHSTn0FN=fullfile('G:','CV62015Cast',COMP, ...
%     MetFilFo,[filebeg,'HSTn0.txt']);
% MetHSTn0ID=fopen(MetHSTn0FN,'r');
% MetHSTn0m = 1;
% while(~feof(MetHSTn0ID));
%     
%     InputText =textscan(MetHSTn0ID, '%s',1,'delimiter', ',');
%     MetHSTn0{MetHSTn0m,1} = InputText{1};
%     MetHSTn0m  = MetHSTn0m +1;
%     
% end
% 
% fclose(MetHSTn0ID);
% 
% for storm=11
%     
%     
%     extra=0;
%     for iiiii = 1:lif
%         for qqq=1:maxReps
%             
%             if FileLocation(iiiii,qqq)<10^5
%                 extra=extra+1
%                 
%                 for t=1:(timnam-2)
%                     filebeg  = cell2mat(TimeCell{t,1});
%                     
%                     StCellEx{extra,t}=STelim{iiiii,qqq};
%                     Test=StCellEx{extra,t}
%                     siTest=size(Test)
%                     
%                     
%                     if t==1;
%                         failsf=0;
%                         
%                         if FileFo{iiiii,qqq}=='WindMadOut'
%                             
%                             for jjj=1:(HSTn0m-2)
%                                 checkMatch=cell2mat(HSTn0{jjj,1})
%                                 SiCM=size(checkMatch)
%                                 
%                                 if SiCM(2)==siTest(2)
%                                     
%                                     if Test==checkMatch
%                                         failsf=failsf+1;
%                                         for at=1:(timnam-2)
%                                             filebegAT = cell2mat(TimeCell{at,1})
%                                             FiFolder=[FileFo{iiiii,qqq},STstring]
%                                             HFFn0=dlmread(fullfile('G:','CV62015Cast',COMP, ...
%                                                 FiFolder,[filebegAT,'HFFn0.txt']));
%                                             Wnd(extra,at)=HFFn0(jjj,1);
%                                             stations{extra,1}=Test
%                                         end
%                                         
%                                     end
%                                 end
%                                 if jjj==(HSTn0m-2)
%                                     if failsf==0
%                                         error('it was this Test')
%                                     end
%                                 end
%                             end
%                             
%                         else
%                             for jjj=1:(MetHSTn0m-2)
%                                 checkMatch=cell2mat(MetHSTn0{jjj,1})
%                                 SiCM=size(checkMatch)
%                                 
%                                 if SiCM(2)==siTest(2)
%                                     
%                                     if Test==checkMatch
%                                         failsf=failsf+1;
%                                         for at=1:(timnam-2)
%                                             filebegAT = cell2mat(TimeCell{at,1})
%                                             FiFolder=[FileFo{iiiii,qqq},STstring]
%                                             HFFn0=dlmread(fullfile('G:','CV62015Cast',COMP, ...
%                                                 FiFolder,[filebegAT,'HFFn0.txt']));
%                                             Wnd(extra,at)=HFFn0(jjj,1);
%                                             stations{extra,1}=Test
%                                         end
%                                         
%                                     end
%                                 end
%                                 if jjj==(HSTn0m-2)
%                                     if failsf==0
%                                         error('it was this Test')
%                                     end
%                                 end
%                             end
%                         end
%                             
%                             
%                             
%                         end
%                         
%                         ff=ffmat(t,FileLocation(iiiii,qqq));
%                         KriBclose= CVyx(t,iiiii)
%                         %StCellEx{extra,t}=STelim{iiiii,qqq};
%                         WRFclose=WRF(t,iiiii)
%                         
%                         
%                         Bsquared(extra,t)=(KriBclose-ff)^2;
%                         Bias(extra,t)=(KriBclose-ff);
%                         PredB(extra,t)=KriBclose;
%                         latFF(extra,t)=ff;
%                         
%                         
%                         BsqWRF(extra,t)=(WRFclose-ff)^2;
%                         BiasWRF(extra,t)=(WRFclose-ff);
%                         PredBWRF(extra,t)=WRFclose;
%                         
%                     end
%                 end
%             end
%         end
%         disp(PredB)
%         
%         %      error('Compare stations and StCellEx')
%         for j=1:(extra)
%             for t=1:(timnam-2)
%                 
%                 WindArr(t,1)=Wnd(j,t);
%                 WindPr(t,1)=PredBWRF(j,t)+PredB(j,t);
%                 KalPr(t,1)=PredBWRF(j,t)+latFF(j,t);
%                 
%                 PredArray(t,1)=PredB(j,t);
%                 latFFArray(t,1)=latFF(j,t);
%                 
%                 BsqArray(t,1)= Bsquared(j,t);
%                 BiasArray(t,1)=Bias(j,t);
%                 
%                 
%                 PWRFArray(t,1)=PredBWRF(j,t);
%                 %latFFArray(t,1)=latFF(j,t);
%                 
%                 BsqWRFArray(t,1)= BsqWRF(j,t);
%                 BWRFArray(t,1)=BiasWRF(j,t);
%                 
%                 BsqWPray(t,1)= ((PredBWRF(j,t)+PredB(j,t))-Wnd(j,t))^2;
%                 BWPArray(t,1)=(PredBWRF(j,t)+PredB(j,t))-Wnd(j,t);
%                 
%                 BsqKalray(t,1)= ((PredBWRF(j,t)+latFF(j,t))-Wnd(j,t))^2;
%                 BKalArray(t,1)=(PredBWRF(j,t)+latFF(j,t))-Wnd(j,t);
%                 
%                 
%             end
%             
%             rmse=sqrt(mean(BsqArray));
%             meanBias=mean(BiasArray);
%             
%             AvgFF=mean(latFFArray)
%             AvgUKFF=mean(PredArray)
%             AvgFFWRF=mean(PWRFArray)
%             
%             rmseWRF=sqrt(mean(BsqWRFArray));
%             meanBiasWRF=mean(BWRFArray);
%             
%             maxData(1)=max(PredArray);
%             maxData(2)=max(latFFArray);
% %             maxData(3)=max(PWRFArray);
%             minData(1)=min(PredArray);
%             minData(2)=min(latFFArray);
% %             minDat(3)=min(PWRFArray);
%             
%             axisMax=(max(maxData));
%             axisMin=(min(minData));
%             % %%Automatic Plotting
%             
%             fig = figure;
%             R=corrcoef(latFFArray, PredArray);
%             scatter(latFFArray,PredArray,'g');
%             
%             RWRF=corrcoef(latFFArray, PWRFArray);
%             
%             hold on;
% %             scatter(latFFArray,PWRFArray,'c');
%              P=polyfit(latFFArray,PredArray,1);
%              yfit=P(1)*latFFArray+P(2);
% %             
% %             PWRF=polyfit(latFFArray,PWRFArray,1);
% %             yfitWRF=PWRF(1)*latFFArray+PWRF(2);
%             
%             hold on;
%             plot(latFFArray,yfit,'-g');
%             
% %             hold on;
% %             plot(latFFArray,yfitWRF,'-c');
%             hold on
%             hline = refline([1 0]);
%             hline.Color = 'r';
%             
%             fd=TimeCell{1}
%             firstDay=cell2mat(fd)
%             % titlestring=['y=',num2str(P(1)),'x+',num2str(P(2)),' R^2=',num2str(R(1,2))];
%             % title(titlestring);
%             line1 =['Station ID:  ',(StCellEx{j,1}),' ','Storm:  ', firstDay(1:8)];
%             line2 =['UK RMSE (m/s)=',num2str(rmse), '   ','WRF RMSE (m/s)=',num2str(rmseWRF)];
%             line3=['UK Mean Bias (m/s)=',num2str(meanBias),'   ','WRF Mean Bias(m/s)=',num2str(meanBiasWRF)];
%             line4=['UK R^2=',num2str(R(1,2)),'   ','WRF R^2=',num2str(RWRF(1,2))];
%             
%             lines ={line1,line2,line3,line4};
%             
%             title(lines);
%             axis([axisMin axisMax  axisMin axisMax]);
%             xlabel('Storm Average NE US Observed Wind Speed (m/s)');
%             ylabel('Storm Average Estimated Wind Speed (m/s)');
%             
%             %gcf=.pdf';
%             %pname=[ statname{1,plottick +2}, '.pdf' ];
%             
%             
%             theString = sprintf('y = %.2f x + %.2f', P(1),P(2));
% %             theWRFString = sprintf('y = %.2f x + %.2f', PWRF(1),PWRF(2));
%             %text((1),axisMax, theString, 'FontSize', 10);
%             legend('UK Estimate',theString, ...
%                 '1:1 Reference Line','Location','northwest');
%             
%             
%             hold off;
%             fprintf('THIS IS J!!!!!:')
%             disp(j)
%             %     for dim=1:(RMval+1)
%             %         %mkdir(BySTatFo,(STelim{j,dim}));
%             RMSEname=['BRMSE',(StCellEx{j,1}),'.csv']
%             RMSEFo=fullfile(BySTatFo,RMSEname);
%             blankmat=ones(2,2);
%             dlmwrite(RMSEFo,(rmse.*blankmat));
%             
%             
%             %         RMSEWRFname=['WMRMSEWRF',(StCellEx{j,1}),'.csv']
%             %         RMSEFo=fullfile(BySTatFo,RMSEWRFname);
%             %         blankmat=ones(2,2);
%             %         dlmwrite(RMSEFo,(rmseWRF.*blankmat));
%             %%%
%             FFname=['BFF',(StCellEx{j,1}),'.csv']
%             FFFo=fullfile(BySTatFo,FFname);
%             blankmat=ones(2,2);
%             dlmwrite(FFFo,(AvgFF.*blankmat));
%             
%             FFUKname=['BUK',(StCellEx{j,1}),'.csv']
%             FFUKFo=fullfile(BySTatFo,FFUKname);
%             blankmat=ones(2,2);
%             dlmwrite(FFUKFo,(AvgUKFF.*blankmat));
%             
%             
%             %         FFWRFname=['WMFFWRF',(StCellEx{j,1}),'.csv']
%             %         FFWRFFo=fullfile(BySTatFo,FFWRFname);
%             %         blankmat=ones(2,2);
%             %         dlmwrite(FFWRFFo,(AvgFFWRF.*blankmat));
%             %         %%%
%             
%             NEUS=['BWind',(StCellEx{j,1}),'.png'];
%             NEUSFo=fullfile(BySTatFo,NEUS)
%             saveas(fig,NEUSFo);
%             %     end
%             
%             
%             
%             
%             
%             %fn=num2str(j);
%             %mkdir(BySTatFo,cell2mat(STelim{j,1}));
%             %
%             % NEUS=['NEUS',cell2mat(STelim{j,1}),STstring,'.png'];
%             % NEUSFo=fullfile(BySTatFo,(STelim{j,1}),NEUS)
%             % saveas(fig,NEUSFo);
%             
%             
%             
% %             latFFArray=WindArr
% %             PredArray = WindPr
%             
%             
%             rmse=sqrt(mean(BsqWPray));
%             meanBias=mean(BWPArray);
%             
%             %KalPr:   is the actual Kal pred rep. as W.S.
%             %BsqKalray:   is the Bsq of the real Kalman estimate
%             %BKalArray:   is the bias
%             
%             
%             
%             AvgFF=mean(WindArr)
%             AvgUKFF=mean(WindPr)
%             AvgFFWRF=mean(PWRFArray)
%             AvgFFKal=mean(KalPr)
%             
%             rmseWRF=sqrt(mean(BsqWRFArray));
%             meanBiasWRF=mean(BWRFArray);
%             
%             rmseKal=sqrt(mean(BsqKalray));
%             meanBiasKal=mean(BKalArray);
%             
%             maxData(1)=max( WindPr);
%            % maxData(2)=max(WindArr);
%             maxData(2)=max(PWRFArray);
%             maxData(3)=max(KalPr);
%             minData(1)=min( WindPr);
%             %minData(2)=min(WindArr);
%             minData(2)=min(PWRFArray);
%             minData(3)=min(KalPr);
%             
%             axisMax=(max(maxData));
%             axisMin=(min(minData));
%             % %%Automatic Plotting
%             
%             fig = figure;
%             R=corrcoef(WindArr,WindPr);
%             scatter(WindArr, WindPr,'g');
%             
%             RWRF=corrcoef(WindArr, PWRFArray);
%             
%              
%             
%             PWRF=polyfit(WindArr,PWRFArray,1);
%             
%             hold on;
%             scatter(WindArr,PWRFArray,'c');
%             P=polyfit(WindArr,WindPr,1);
%             yfit=P(1)*WindArr+P(2);
%             
%             
%             PWRF=polyfit(WindArr,PWRFArray,1);
%             yfitWRF=PWRF(1)*WindArr+PWRF(2);
%             
%             hold on;
%             scatter(WindArr,KalPr,'r');
%             PKal=polyfit(WindArr,KalPr,1);
%             yfitKal=PKal(1)*WindArr+PKal(2);
%             hold on;
%             plot(WindArr,yfit,'-g');
%             
%             hold on;
%             plot(WindArr,yfitWRF,'-c');
%             hold on;
%             plot(WindArr,yfitKal,'-r');
%             hold on
%             hline = refline([1 0]);
%             hline.Color = 'r';
%             
%             fd=TimeCell{1}
%             firstDay=cell2mat(fd)
%             % titlestring=['y=',num2str(P(1)),'x+',num2str(P(2)),' R^2=',num2str(R(1,2))];
%             % title(titlestring);
%             line1 =['Station ID:  ',(StCellEx{j,1}),' ','Storm:  ', firstDay(1:8)];
%             line2 =['UK RMSE (m/s)=',num2str(rmse), '   ','WRF RMSE (m/s)=',num2str(rmseWRF)];
%             line3=['UK Mean Bias (m/s)=',num2str(meanBias),'   ','WRF Mean Bias(m/s)=',num2str(meanBiasWRF)];
%             line4=['UK R^2=',num2str(R(1,2)),'   ','WRF R^2=',num2str(RWRF(1,2))];
%             
%             lines ={line1,line2,line3,line4};
%             
%             title(lines);
%             axis([axisMin axisMax  axisMin axisMax]);
%             xlabel('Storm Average NE US Observed Wind Speed (m/s)');
%             ylabel('Storm Average Estimated Wind Speed (m/s)');
%             
%             %gcf=.pdf';
%             %pname=[ statname{1,plottick +2}, '.pdf' ];
%             
%             
%             theString = sprintf('y = %.2f x + %.2f', P(1),P(2));
%             theWRFString = sprintf('y = %.2f x + %.2f', PWRF(1),PWRF(2));
%             theKalString = sprintf('y = %.2f x + %.2f', PWRF(1),PWRF(2));
%             %text((1),axisMax, theString, 'FontSize', 10);
%             legend('UK Estimate','WRF Estimate','Kal Estimate',theString, ... 
%                 theWRFString,theKalString, '1:1 Reference Line','Location','northwest');
%             
%             
%             hold off;
%             fprintf('THIS IS J!!!!!:')
%             disp(j)
%             %     for dim=1:(RMval+1)
%             %         %mkdir(BySTatFo,(STelim{j,dim}));
%             RMSEname=['WMRMSE',(StCellEx{j,1}),'.csv']
%             RMSEFo=fullfile(BySTatFo,RMSEname);
%             blankmat=ones(2,2);
%             dlmwrite(RMSEFo,(rmse.*blankmat));
%             
%             
%             RMSEWRFname=['WMRMSEWRF',(StCellEx{j,1}),'.csv']
%             RMSEFo=fullfile(BySTatFo,RMSEWRFname);
%             blankmat=ones(2,2);
%             dlmwrite(RMSEFo,(rmseWRF.*blankmat));
%             %%%
%             FFname=['WMFF',(StCellEx{j,1}),'.csv']
%             FFFo=fullfile(BySTatFo,FFname);
%             blankmat=ones(2,2);
%             dlmwrite(FFFo,(AvgFF.*blankmat));
%             
%                 
%             RMSEKalname=['WMRMSEKal',(StCellEx{j,1}),'.csv']
%             RMSEFo=fullfile(BySTatFo,RMSEKalname);
%             blankmat=ones(2,2);
%             dlmwrite(RMSEFo,(rmseKal.*blankmat));
%             %%%
%             FFKalname=['WMKal',(StCellEx{j,1}),'.csv']
%             FFFo=fullfile(BySTatFo,FFKalname);
%             blankmat=ones(2,2);
%             dlmwrite(FFFo,(AvgFFKal.*blankmat));
%             
%             
%             FFUKname=['WMFFUK',(StCellEx{j,1}),'.csv']
%             FFUKFo=fullfile(BySTatFo,FFUKname);
%             blankmat=ones(2,2);
%             dlmwrite(FFUKFo,(AvgUKFF.*blankmat));
%             
%             
%             FFWRFname=['WMFFWRF',(StCellEx{j,1}),'.csv']
%             FFWRFFo=fullfile(BySTatFo,FFWRFname);
%             blankmat=ones(2,2);
%             dlmwrite(FFWRFFo,(AvgFFWRF.*blankmat));
%             %%%
%             
%             NEUS=['WMWind',(StCellEx{j,1}),'.png'];
%             NEUSFo=fullfile(BySTatFo,NEUS)
%             saveas(fig,NEUSFo);
%             %     end
%             
%             
%             
%             
%             
%             %fn=num2str(j);
%             %mkdir(BySTatFo,cell2mat(STelim{j,1}));
%             %
%             % NEUS=['NEUS',cell2mat(STelim{j,1}),STstring,'.png'];
%             % NEUSFo=fullfile(BySTatFo,(STelim{j,1}),NEUS)
%             % saveas(fig,NEUSFo);
%         end
%         % % %
%         
%         
%     end
%     
%     
% 
% 
% 
% 
% 
% 
