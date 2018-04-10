% % % % % %Creating the new dacewind and artificial coordinates missing values
% % % % %creating the read matrix

clear
clc
% tiLCA=0
firstArray=dlmread('firstarray2.txt')
lastArray=dlmread('lastarray2.txt')
    
   
for fixx=1:7;   
    fixarr= [2,4,5,6,7,8,11]
    storm=fixarr(fixx)
    %error('break')
clearvars -except storm firstArray lastArray tiLCA
CompArray=['CEELab20';'CEELab26';'CEELab27';'CEELab05';'CEELab22'; ...
'CEELab23';'CEELab06';'CEELab21';'CEELab24';'CEELab07';'CEELab25'];%
stoArray=[6,16,29,39,44,57,64,69,81,96,105];%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
RN=stoArray(storm)%Rand #
STstring=num2str(RN);
string=STstring
starTime=RN
CompFo=CompArray(storm,:);
%%%%%%%%%%%%%%%%%%%%%%%%%%

SStime=firstArray(storm,1);
SSend=lastArray(storm,1);
%clearvars -except RN string SStime starTime STstring FoStat CompFo

MetarFo=['WindMetOut',STstring]
MadisFo=['WindMadOut',STstring]
AdjFo=['WindCombOut',STstring]
BySTatFo=['WindBStat',STstring];
ZfFo=['ZfKrig',STstring];
Wkvar=['WkKal',STstring,'.mat'];

mkdir(BySTatFo)

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
 stobeg  = FiMetIn(RN,:);
 STCVname=[stobeg,'SC24.txt'];
STCVID=fopen(fullfile('storm',STCVname),'r');
timnam = 1;
while(~feof(STCVID));
    
    InputText =textscan(STCVID, '%s',1,'delimiter', ',');
    TimeCell{timnam,1} = InputText{1};
    timnam = timnam+1;
    
end

fclose(STCVID);


filend2='.txt'
latot=0


matcheck=0;
totiter = 0;
ileticks=0;
for t = 1:(timnam-2)
    %:ticou;
    matcheck=matcheck+1;
    %Read original files
    filebeg  = cell2mat(TimeCell{t,1});
    
    filnSTtr=['HtrST',filebeg,filend2];
    filnCtr = ['HtrC',filebeg,filend2];
    filnRtr = ['HtrR',filebeg,filend2];
    filnFFtr= ['HtrFF',filebeg,filend2];
%     nm=['res',filebeg,filend2];
%     nm2=['pB',filebeg,filend2];
%     
    %Read WRF
    WRFname=([filebeg,'WRF.txt'])    
    WRF=dlmread(fullfile('G:','WRF',WRFname))

%  CompArray=['CEELab20';'CEELab26';'CEELab27';'CEELab05';'CEELab22'; ...
% 'CEELab23';'CEELab06';'CEELab21';'CEELab24';'CEELab07';'CEELab25'];%   

% AdjFo=['WindCombOut',STstring]

    
    %    STID=fopen(fullfile(AdjFo,(filnSTtr)),'r');
    CID = fopen(fullfile('G:','CV62015Cast',CompFo,AdjFo,(filnCtr)), 'r');
    RID = fopen(fullfile('G:','CV62015Cast',CompFo,AdjFo,(filnRtr)), 'r');
    ffID = fopen(fullfile('G:','CV62015Cast',CompFo,AdjFo,(filnFFtr)), 'r');
    
    Cit=1;
    Rit=1;
    ffit=1;
    %STit=1;
    
    %%%%ElimArray
    ElimName=['HElim',STstring,'.csv'];
    MaxName= ['MaxReps',STstring,'.csv'];
    
    ElimFo = fullfile(BySTatFo,ElimName);
    Reps=dlmread(fullfile(BySTatFo,MaxName));
    RMval=(Reps(1,1));
    howmany=0;
    ElimID=fopen(ElimFo,'r');
    Elimnum = 1;
    while(~feof(ElimID));
        % %Test this before running main code
        if (RMval+1)==1
            STelim2 =textscan(ElimID, '%s',1,'delimiter', ',');
        end
        howmany=howmany+1
        
        if (RMval+1)==2
            STelim2 =textscan(ElimID, '%s %s','Delimiter',',');
        end
        
        if (RMval+1)==3
            STelim2 =textscan(ElimID, '%s %s %s',1,'delimiter', ',');
        end
        
        if (RMval+1)==3
            error('New Maximum >3')
        end
        
     
    end
    fclose(ElimID)
   % error('break for station evalation')

    while(~feof(CID));
        
        ColMad =textscan(CID, '%f',1,'delimiter', '\t');
        sizeCMAD = size(ColMad{1});
        if sizeCMAD(1)>0;
            C{Cit,1} = ColMad{1};
            Cit = Cit+1;
        end
    end
    
    while(~feof(RID));
        
        RowMad =textscan(RID, '%f',1,'delimiter', '\t');
        sizeRMAD = size(RowMad{1});
        if sizeRMAD(1)>0;
            R{Rit,1} = RowMad{1};
            Rit = Rit+1;
        end
    end
    
    while(~feof(ffID));
       
        ffMad =textscan(ffID, '%f',1,'delimiter', '\t');
        sizeffMAD = size(ffMad{1});
        if sizeffMAD(1)>0;
            ff{ffit,1} = ffMad{1};
            ffit = ffit+1;
        end
    end
    
    
    %
    %    while(~feof(STID));
    %
    %         STMad =textscan(STID, '%s',1,'delimiter', '\n');
    %         sizeSTMAD = size(STMad{1});
    %         if sizeSTMAD(1)>0;
    %            ST{STit,1} = STMad{1};
    %             STit = STit+1;
    %         end
    %     end
    %
    %     fclose(STID);
    fclose(CID);
    fclose(RID);
    fclose(ffID);
    
    sizeC = size(C);
    sizefi=sizeC(1);
    % BIAS = zeros(sizefi,1);
    % %
    
    %Compare to Kriging Field%%%%%%%%%%%%%%%%%%%%%
    
    disp(Cit-2)
    lif = (Cit-2)
    if latot==0
        PredB=zeros(lif,1);
        latFF=zeros(lif,1);
        Bsquared=zeros(lif,1);
        Bias=zeros(lif,1);
        
    end
    
    for iiiii = 1:lif
        
        ileticks=ileticks+1;
        ileit = num2str(ileticks);
       
        %%%
%         YX =dlmread(fullfile('G:','CV62015Cast',CompFo,ZfFo,[ileit,'yx.txt']));
%         S = dlmread(fullfile('G:','CV62015Cast',CompFo,ZfFo,[ileit,'CR.txt']));
%         disp(lif)
        %load (wkspc);
        
        clearvars sizess sizes ;
        sizes = lif;
        sizess = lif;
%          tiLCA = tiLCA+1
        %%%
        Rnum=R{iiiii,1};
        Cnum=C{iiiii,1};
        Rclose = round(Rnum);
        Cclose = round(Cnum);
        LocClose = (Cclose-1)*330 + Rclose;
%         LocCloseArray(tiLCA,1) = LocClose;
%         KriBclose = YX(LocClose);
  %      error('break231')
        
        
        WRFatLoc=WRF(LocClose,1)
      
        %Read Kalman
        gc=num2str(LocClose);
   Kalname=['modeltom_filt',gc,'.txt'];
   
   Kalread=dlmread(fullfile('GCKalman',Kalname));
    StartTime=(SStime-25);
    Kaltime=(StartTime+t);
    Kalman=Kalread(Kaltime,1)
        %error('break for value comparison')
        latot = latot+1;
 
        ObsG(iiiii,matcheck)=ff{iiiii,1};
        KalmanG(iiiii,matcheck)=Kalman;
        WRFG(iiiii,matcheck)=WRFatLoc;
               
        BsqKal(iiiii,matcheck)=(Kalman-ff{iiiii,1})^2;
        BsqWRF(iiiii,matcheck)=(WRFatLoc-ff{iiiii,1})^2;
                
        BiasKal(iiiii,matcheck)=(Kalman-ff{iiiii,1});
        BiasWRF(iiiii,matcheck)=(WRFatLoc-ff{iiiii,1});
 %error('break to look at values')
        
    end
 
    
end






  for y=1:(Cit-1)
    for dim=1:(RMval+1)
       
            %How does the change in dimension size
            %affect read
            placehold{1,1}=STelim2{1,dim};
            ph2=placehold{1,1}
            STelim{y,dim}=ph2{y,1};
        end
        
    end

for j=1:lif
    sstring=size((STelim{j,dim}))
%     if sstring(2)==4%size('KPYM')
%         %    disp('falsep')
%     
%     if (STelim{j,dim})=='KPYM'
%     
%    

        
    for t=1:(timnam-2)
        
        
        
        PredArray(t,1)=KalmanG(j,t);
        latFFArray(t,1)=ObsG(j,t);
        PWRFArray(t,1)=WRFG(j,t)
%         
        BsqArrayKal(t,1)= BsqKal(j,t);
        BsqArrayWRF(t,1)= BsqWRF(j,t);
        
        BiasArrayKal(t,1)=BiasKal(j,t);
        BiasArrayWRF(t,1)=BiasWRF(j,t);
        
        
    end
    %error('break')
    rmseKal=sqrt(mean(BsqArrayKal));
    rmseWRF=sqrt(mean(BsqArrayWRF));

    meanKal=mean(PredArray);
    meanWRF=mean(PWRFArray);
    
    meanBiasKal=mean(BiasArrayKal);
    meanBiasWRF=mean(BiasArrayWRF);
    

    
    for dim=1:(RMval+1)
   
        
        RMSEn=['KalRMSEwrf',(STelim{j,dim}),'.csv']
        RMSEF=fullfile(BySTatFo,RMSEn);
        blankmat=ones(2,2);
        dlmwrite(RMSEF,(rmseWRF.*blankmat));
        
        RMSEname=['RMSEkal',(STelim{j,dim}),'.csv']
        RMSEFo=fullfile(BySTatFo,RMSEname);
        blankmat=ones(2,2);
        dlmwrite(RMSEFo,(rmseKal.*blankmat));
        
        
        MEANn=['MEANwrf',(STelim{j,dim}),'.csv']
        RMSEF=fullfile(BySTatFo,MEANn);
        blankmat=ones(2,2);
        dlmwrite(RMSEF,(meanWRF.*blankmat));
        
        MEANname=['MEANkal',(STelim{j,dim}),'.csv']
        RMSEFo=fullfile(BySTatFo,MEANname);
        blankmat=ones(2,2);
        dlmwrite(RMSEFo,(meanKal.*blankmat));
        
%          MEANn2=['MEANwrf',(STelim{j,dim}),'.csv']
%                mwrf=dlmread(fullfile('C:', 'Users', 'alex', 'Desktop', 'Storm3Test', ...
%       BySTatFo,MEANn2));
%         if dim>1
%disp(location)
%        error('check the values')
%          %saveas(fig,NEUSFo);
%         end
%     end
%     end
    end
end
%save(Wkvar)
end


