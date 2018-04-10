clear
clc

list=dlmread('totalKri.txt')
sili=size(list)
% error('51 exists?')
for storm=51%3:sili;
if list(storm,1)==0
        fclose('all')
clearvars -except storm list
stoArray=[6,16,29,39,44,57,64,69,81,96,105];%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
RN=storm%list(storm,1);
STstring=num2str(RN);
string=STstring;
starTime=RN;
% COMP=CompArray(storm,:);
%%%%%%%%%%%%%%%%%%%%%%%%%%
MetarFo='KrInMetDiff';
MadisFo='KrInMadDiff';
 AdjFo=['BiasCO111',STstring];
        BySTatFo=['BiasBS111',STstring];
 MetarM1='WindMetOut';
    MadisM1='WindMadOut';
mkdir(BySTatFo)

mkdir(AdjFo)

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
% %


s0=' ';

fprintf('storm \n')
disp(storm)
endTime=(timnam-2);
new = 0;
for t =1:endTime
    disp(t)
    %:(starTime+23)
    new = new+1;
    
    filebeg  = cell2mat(TimeCell{t,1});
    clearvars ColMad C RowMad R ffMad ff METColMad MetRowMad ffMETY Wind
    clearvars S colrow Cmm Rmm FFmm Cmit Cm Cfm Rfm Rm Wfm FFm distance
    clearvars used takeout newY newS Ycv Ccv Rcv
    clearvars FF C R
    
    
    spot = 0;
    
    
    filename = fullfile( MadisFo, ['HMadST',filebeg,'.txt']);
    fileID = fopen((filename), 'r');
    MAnam = 1;
    while(~feof(fileID));
        
        InputText =textscan(fileID, '%s',1,'delimiter', ',');
        STMA{MAnam,1} = InputText{1};
        MAnam = MAnam+1;
        
    end
    
    fclose(fileID);
    
    
    
    
    filename = fullfile( MetarFo, ['HMetST',filebeg,'.txt']);
    fileID = fopen((filename), 'r');
    MEnam = 1;
    while(~feof(fileID));
        
        InputText =textscan(fileID, '%s',1,'delimiter', ',');
        STME{MEnam,1} = InputText{1};
        MEnam = MEnam+1;
        
    end
    
    fclose(fileID);
    
    %Initial reads for sizing
    FFMA = dlmread(fullfile( MadisFo, ['HMadff',filebeg,'.txt']));
    FFME = dlmread(fullfile( MetarFo, ['HMetff',filebeg,'.txt']));
    
    CMA = dlmread(fullfile( MadisFo, ['HMadC',filebeg,'.txt']));
    RMA= dlmread(fullfile( MadisFo, ['HMadR',filebeg,'.txt']));
    
    CME = dlmread(fullfile( MetarFo, ['HMetC',filebeg,'.txt']));
    RME = dlmread(fullfile( MetarFo, ['HMetR',filebeg,'.txt']));
    
    % OMA = dlmread(fullfile(MadisFo, 'om.txt'));
    % OME = dlmread(fullfile(MetarFo, 'om.txt'));
    %
    % omSMA=size(OMA)
    % omSME=size(OME)
    
    
    
    SizMA = size(FFMA);
    SizME = size(FFME);
    testMA = size(CMA);
    testME = size(CME);
    
    filend2 = '.txt';
    % %
    
    
    
    
    
    
    % for stoma=1:omSMA
    %     test=OMA(stoma)
    for stati=1:SizMA(1)
        %     if stati==test
        spot = spot+1;
        ff(spot,1) = FFMA(stati,1);
        ffmat(t,spot)=FFMA(stati,1);
        % st(spot,1) = STMA(new,stati)
        C(spot,1) = CMA(stati,1);
        R(spot,1) = RMA(stati,1);
        st{spot,1}=strtrim(cell2mat(STMA{stati,1}));
        %     end
        %
    end
    % end
    %Line 152 Edit<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    MMswitch=spot;
    %<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    
    %Line 154 Edit<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    MetPlus=['MetPlu',STstring,'.txt'];
    MPlusID=fopen(fullfile( MetPlus), 'w');
    
    for stati=1:SizME(1)
        badtick=0;
        for qqq=1:MMswitch
            
            
            testqqq=st{qqq,1};
            check=strtrim(cell2mat(STME{stati,1}));
            siMEnew=size(check);
            siMAold=size(testqqq);
            if siMEnew==siMAold
                if check==testqqq
                    badtick=badtick+1;
                end
            end
            
        end
        
        if badtick<1
            spot = spot+1;
            
            ff(spot,1) = FFME(stati,1);
            ffmat(t,spot)=FFME(stati,1);
           
            %  st(spot,1) = STME(new,stati)
            C(spot,1) = CME(stati,1);
            R(spot,1) = RME(stati,1);
            st{spot,1}=strtrim(cell2mat(STME{stati,1}));
            
        else
            fprintf(MPlusID,'%s\n',strtrim(cell2mat(STME{stati,1})))
            
        end
        
        
        
    end
    fclose(MPlusID)
    %build the matrix of full values
    
    
    
    
    
    
    
    % fprintf('C,R \n')
    % size(C)
    % size(R)
    
    
    
    %     ffit = 1;
    %     Cit = 1;
    %     Rit = 1;
    %     tinam = 1;
    %
    %     %:timnam-1
    
    %     disp(u)
    
    
    
    sizeWind = size(ff);
    %Remove zeros%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    nzit = 0;
    for q = 1:sizeWind(1);
        test = (ff(q,1));
        % if test > 0
        nzit = nzit+1;
        
        Y(nzit,1) = (ff(q,1));
        Wind(nzit,1) = (ff(q,1));
        S(nzit,1) = (C(q,1));
        S(nzit,2) = (R(q,1));
        
        
        Rnum=R(q,1);
        Cnum= C(q,1);
        Rclose = round(Rnum);
        Cclose = round(Cnum);
        GCorig(nzit,1)= (Cclose-1)*330 + Rclose;
        
        
        
        
        colrow(nzit,1) =(C(q,1));
        colrow(nzit,2) =(R(q,1));
        % end
        
    end
    
    
    sizeS = size(S);
    %     disp(nzit)
    %     disp(ffit)
    sizeSS = sizeS(1);
    
    
    for i = 1:sizeSS;
        
        elimarray = [1:sizeSS];
        elimarray(i) = 0;
        
        b = 0;
        
        n = num2str(i);
        
        for a = 1:sizeSS;
            kill = elimarray(a);
            
            if kill >0;
                b = b+1;
                
                Cmm = num2str(S(a,1));
                Rmm = num2str(S(a,2));
                FFmm = num2str(Y(a,1));
                stmm=st{a,1};
                
                %
                %                 fprintf(CmID, '%s\n', Cmm);
                %                 fprintf(RmID, '%s\n', Rmm);
                %                 fprintf(ffmID, '%s\n', FFmm);
                %
                Ccv(b,i) = S(a,1);
                Rcv(b,i) = S(a,2);
                Ycv(b,i) = Wind(a,1);
                STcv{b,i}=st{a,1};
                
                Rnum=S(a,2);
                Cnum= S(a,1);
                Rclose = round(Rnum);
                Cclose = round(Cnum);
                GCcv(b,i)= (Cclose-1)*330 + Rclose;
                
            end
            
            
        end
        
        
    end
    
    clearvars i
    
    
    sizeYS = size(Ycv);
    distArray = zeros(1,sizeYS(1));
    for orig = 1:nzit;
        for compare = 1:sizeYS(1);
            distance(orig,compare) = sqrt((S(orig,1) - Ccv(compare,orig))^2 + (S(orig,2) - Rcv(compare,orig))^2)/2;
            
        end
    end
    
    used = zeros(nzit,1);
    for orig=1:nzit
        linkstring{orig,1}='ISO';
    end
    
    
    for orig=1:nzit
        link2{orig,1}='ISO';
    end
    
    for orig=1:nzit
        link{orig,1}=10^5;
    end
    
    %    used = zeros(nzit,1);
    %     for orig=1:nzit
    %     linkstring{orig,1}='ISO';
    %     end
    %
    %
    
    %     save('rb4.mat')
    %     error('Experiment!!!')
    
    build  = 0;
    for orig = 1:nzit;
        if used(orig,1) == 0;
            build = build + 1;
            for compare = 1:sizeYS(1);
                thresh = distance(orig,compare);
                
                n = 1;
                if thresh<1; %do several trials until correct threshold found
                    
                    if GCorig(orig,1)==GCcv(compare,orig)
                        
                        takeout = compare;
                        if compare>=orig;
                            takeout = compare +1;
                        end
                        used(takeout,1)= used(takeout,1) + 1;
                        place=used(takeout,1);
                        %Line290 Edit<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                        %                      if takeout==186
                        %                          disp(newST)
                        %                          disp(link)
                        %                          error('did anything exist before?')
                        %                      end
                        link{build,place}=takeout;
                        %                    if build==4
                        %                        error('whyisitacell')
                        %                    end98
                        linkstring{build,place}=st{takeout,1};
                        if takeout>MMswitch
                            link2{build,place}=MetarM1;
                        else
                            link2{build,place}=MadisM1;
                        end
                        %<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                        %link{build,place}=cell2mat(st{takeout,1})
                        n = n+1;
                        
                        if n == 2;
                            sumWind = Wind(orig,1) + Ycv(compare,orig);
                            sumC = colrow(orig,1) + Ccv(compare,orig);
                            sumR = colrow(orig,2) + Rcv(compare,orig);
                            sumST=STcv{compare,orig};
                        else
                            sumWind = sumWind + Ycv(compare,orig);
                            sumC = sumC + Ccv(compare,orig);
                            sumR = sumR + Rcv(compare,orig);
                            sumST=STcv{compare,orig};
                        end
                        newY(build,1) = sumWind/n;
                        newS(build,1) = sumC/n;
                        newS(build,2) = sumR/n;
                        %                     newST{build,1}=sumST;
                        
                        %309 Edit<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                        newST{build,1}=takeout;
                        newstring{build,1}=st{takeout,1};
                        if takeout>MMswitch
                            newST2{build,1}=MetarM1;
                        else
                            newST2{build,1}=MadisM1;
                        end
                        %<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                        
                        
                        
                    else
                        
                        
                        takeout = compare;
                        if compare>=orig;
                            takeout = compare +1;
                        end
                        used(takeout,1)= used(takeout,1) + 1;
                        
                    end
                    
                    
                    
                    
                    
                    
                else
                    newY(build,1) =  Wind(orig,1);
                    newS(build,1) = colrow(orig,1);
                    newS(build,2) = colrow(orig,2);
                    takeout = compare;
                    %316 Edit<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                    newST{build,1}=orig;
                    newstring{build,1}=st{orig,1};
                    if orig>MMswitch
                        newST2{build,1}=MetarM1;
                    else
                        newST2{build,1}=MadisM1;
                    end
                    %<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                    
                    % newST{build,1}=st{orig,1};
                    %newom(build1,1)=om(orig,1);
                    
                    
                end
            end
            
            
        end
        
        
    end
    
    
    fprintf('build')
    disp(build)
    
    %loop over the size of each and build in its owl section
    filnCtr = ['GCHtrC',filebeg,filend2];
    filnRtr = ['GCHtrR',filebeg,filend2];
    filnFFtr= ['GCHtrFF',filebeg,filend2];
    filnSTtr=['GCHtrST',filebeg,filend2];
    Elim=['GCHElim',STstring,'.csv'];
    % Line 388 Edit<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    Elim2=['GCElimMM',STstring,'.csv'];
    Elimnum=['GCHElNum',STstring,'.csv'];
    %<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    %    filnCco = ['coC',filebeg,filend2];
    %     filnRco = ['coR',filebeg,filend2];
    %     filnFFco= ['coFF',filebeg,filend2];
    %     filnSTco=['coST',filebeg,filend2];
    
    CmIDtr = fopen(fullfile( AdjFo,filnCtr), 'w');
    RmIDtr = fopen(fullfile( AdjFo,filnRtr), 'w');
    FFmIDtr = fopen(fullfile( AdjFo,filnFFtr), 'w');
    STmIDtr=fopen(fullfile( AdjFo,filnSTtr),'w');
    ElimID=fopen(fullfile( BySTatFo,Elim),'w');
    %Line 349 Edit<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    ElimID2=fopen(fullfile( BySTatFo,Elim2),'w');
    ElimnumID=fopen(fullfile( BySTatFo,Elimnum),'w');
    %<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    
    
    %      CmIDco = fopen(fullfile(AdjFo,filnCco), 'w');
    %     RmIDco = fopen(fullfile(AdjFo,filnRco), 'w');
    %     FFmIDco = fopen(fullfile(AdjFo,filnFFco), 'w');
    %     STmIDco=fopen(fullfile(AdjFo,filnSTco),'w');
    
    
    for h = 1:build
        fprintf(CmIDtr, '%f\n', newS(h,1));
        fprintf(RmIDtr, '%f\n', newS(h,2));
        fprintf(FFmIDtr, '%f\n', newY(h,1));
        fprintf(STmIDtr, '%f\n', newST{h,1});
    end
    
    
     fclose(CmIDtr);
    fclose(RmIDtr);
    fclose(FFmIDtr);
    fclose(STmIDtr);
    
    %
    %      for h = 1:spot
    %         fprintf(CmIDco, '%f\n', C(h,1));
    %         fprintf(RmIDco, '%f\n', R(h,1));
    %         fprintf(FFmIDco, '%f\n', ff(h,1));
    %         fprintf(STmIDco, '%s\n', cell2mat(st{h,1}));
    %     end
    %
    if t==endTime
        save('ElimInv.mat')
        %fprintf(ElimID, '%s,', 'Station')
        %fprintf(ElimID, '%s\n', 'RepStatus')
        for x=1:build
            
            
            %xx=x+1;
            tick=1;
            %Line 377 Edit<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
            fprintf(ElimID2, '%s,',(newST2{x,1}))
            fprintf(ElimID, '%s,', (newstring{x,1}))
            %<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
            fprintf(ElimnumID, '%f,', (newST{x,1}))
            if used(x,1)>1;
                        used(x,1)=1;
                    end
            while tick<used(x,1)
                fprintf(ElimnumID, '%f,', (link{x,tick}))
                fprintf(ElimID, '%s,', (linkstring{x,tick}))
                %Line 380 Edit<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                fprintf(ElimID2, '%s,', (link2{x,tick}))
                %<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                
                tick=tick+1;
            end
            fprintf(ElimnumID, '%f\n',link{x,1})
            fprintf(ElimID2, '%s\n', (link2{x,1}))
            fprintf(ElimID, '%s\n',(linkstring{x,1}))
            %<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        end
        matcheck=ones(2,2).*tick;
        MRname=['GCMaxReps',STstring,'.csv'];
        MRFo=fullfile(BySTatFo,MRname);
        dlmwrite(MRFo,matcheck);
        
          %Line 394 Edit<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    fclose(ElimID2)
    fclose(ElimID)
    fclose(ElimnumID)
    %<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        
    end
   
  
    
    %     fclose(CmIDco);
    %     fclose(RmIDco);
    %     fclose(FFmIDco);
    
    % fileID = fopen((filename), 'r');
    
    
    
    
    
    
    
    
    
    %         %xx=x+1;
    %         tick=1;
    %        fprintf(ElimID, '%s,', cell2mat(newST{x,1}))
    %        while tick<used(x,1)
    %            fprintf(ElimID, '%s,', (link{x,tick}))
    %            tick=tick+1;
    %
    %        end
    %         fprintf(ElimID, '%s\n',link{x,1})
    %     end
    %     matcheck=ones(2,2).*tick
    %      MRname=['MaxReps',STstring,'.csv']
    %     MRFo=fullfile(BySTatFo,MRname)
    %     dlmwrite(MRFo,matcheck);
    %
    %     end
    %     fclose(CmIDtr);
    %     fclose(RmIDtr);
    %     fclose(FFmIDtr);
    %     fclose(STmIDtr);
    %
    %
    % %     fclose(CmIDco);
    % %     fclose(RmIDco);
    % %     fclose(FFmIDco);
    %
    % fileID = fopen((filename), 'r');
    %
    %
    
    
end

ffMatFI=['FFMAT',STstring,'csv'];
dlmwrite(fullfile( BySTatFo,ffMatFI),ffmat)


  
   
   


%Tail Trim%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clearvars -except RN string starTime STstring AdjFo BySTatFo list
Tailtest=0;
MetarFo='KrInMetHT';
MadisFo='KrInMadHT';
% =['BiasCombOutM3',STstring];
% =['BiasBStM3',STstring];

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
% %


s0=' ';

new = 0;

endTime=timnam-2;

for t =1:endTime
    %:(starTime+23)
    new = new+1;
      
    filebeg  = cell2mat(TimeCell{t,1});
    clearvars ColMad C RowMad R ffMad ff METColMad MetRowMad ffMETY Wind
    clearvars S colrow Cmm Rmm FFmm Cmit Cm Cfm Rfm Rm Wfm FFm distance
    clearvars used takeout newY newS Ycv Ccv Rcv
    clearvars FF C R


spot = 0;


TMEx=exist(fullfile(MadisFo, ['TMadST',filebeg,'.txt']));
if TMEx > 0
filename = fullfile(MadisFo, ['TMadST',filebeg,'.txt']);
fileID = fopen((filename), 'r');
MAnam = 1;
while(~feof(fileID));
    
    InputText =textscan(fileID, '%s',1,'delimiter', ',');
    STMA{MAnam,1} = InputText{1};
    MAnam = MAnam+1;
    
end

fclose(fileID);
end



TMAx=exist(fullfile(MetarFo, ['TMetST',filebeg,'.txt']));
if TMAx >0
filename = fullfile(MetarFo, ['TMetST',filebeg,'.txt']);
fileID = fopen((filename), 'r');
MEnam = 1;
while(~feof(fileID));
    
    InputText =textscan(fileID, '%s',1,'delimiter', ',');
    STME{MEnam,1} = InputText{1};
    MEnam = MEnam+1;
    
end
end

if TMEx+TMAx>0
Tailtest=Tailtest+1;
fclose(fileID);

%Initial reads for sizing
FFMA = dlmread(fullfile(MadisFo, ['TMadff',filebeg,'.txt']));
FFME = dlmread(fullfile(MetarFo, ['TMetff',filebeg,'.txt']));

CMA = dlmread(fullfile(MadisFo, ['TMadC',filebeg,'.txt']));
RMA= dlmread(fullfile(MadisFo, ['TMadR',filebeg,'.txt']));

CME = dlmread(fullfile(MetarFo, ['TMetC',filebeg,'.txt']));
RME = dlmread(fullfile(MetarFo, ['TMetR',filebeg,'.txt']));

% OMA = dlmread(fullfile(MadisFo, 'om.txt'));
% OME = dlmread(fullfile(MetarFo, 'om.txt'));

% omSMA=size(OMA)
% omSME=size(OME)
% 


SizMA = size(FFMA);
SizME = size(FFME);
testMA = size(CMA);
testME = size(CME);

filend2 = '.txt';
% %





 for stati=1:SizMA(1)
%     
%     for stoma=1:omSMA
%     test>OMA(stoma) | test<OMA(stoma)
%     
%     
%     
%     if stati==test
   spot = spot+1;
   ff(spot,1) = FFMA(stati,1);
  % st(spot,1) = STMA(new,stati)
   C(spot,1) = CMA(stati,1);
   R(spot,1) = RMA(stati,1);
   st{spot,1}=STMA{stati,1};
%     end
%    
 end
% end


% for stome=1:omSME
%     test2=OME(stoma)
%    
 for stati=1:SizME(1)
%    test>OME(stoma) | test<OME(stoma)
   spot = spot+1;
   
   ff(spot,1) = FFME(stati,1); 
 %  st(spot,1) = STME(new,stati)
   C(spot,1) = CME(stati,1);
   R(spot,1) = RME(stati,1);
   st{spot,1}=STME{stati,1};
% end
 end
% end



%build the matrix of full values

    





% fprintf('C,R \n')
% size(C)
% size(R)


    
%     ffit = 1;
%     Cit = 1;
%     Rit = 1;
%     tinam = 1;
%     
%     %:timnam-1
    
%     disp(u)
  
    
    
   sizeWind = size(ff);
    %Remove zeros%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    nzit = 0;
    for q = 1:sizeWind(1);
        test = (ff(q,1));
       % if test > 0
            nzit = nzit+1;
            
            Y(nzit,1) = (ff(q,1));
            Wind(nzit,1) = (ff(q,1));
            S(nzit,1) = (C(q,1));
            S(nzit,2) = (R(q,1));
            
            colrow(nzit,1) =(C(q,1));
            colrow(nzit,2) =(R(q,1));
       % end
        
    end
    
   
    sizeS = size(S);
%     disp(nzit)
%     disp(ffit)
    sizeSS = sizeS(1);
    
    
    for i = 1:sizeSS;
        
         elimarray = [1:sizeSS];
         elimarray(i) = 0;
 
        b = 0;
        
        n = num2str(i);
               
        for a = 1:sizeSS;
            kill = elimarray(a);
            
            if kill >0;
                b = b+1;
                                
                Cmm = num2str(S(a,1));
                Rmm = num2str(S(a,2));
                FFmm = num2str(Y(a,1));
                stmm=st{a,1};
                
%                 
%                 fprintf(CmID, '%s\n', Cmm);
%                 fprintf(RmID, '%s\n', Rmm);
%                 fprintf(ffmID, '%s\n', FFmm);
%                 
               Ccv(b,i) = S(a,1);
               Rcv(b,i) = S(a,2);
               Ycv(b,i) = Wind(a,1);
               STcv{b,i}=st{a,1};
                
            end
            
            
        end
               
        
    end
    
    clearvars i
    

    sizeYS = size(Ycv);
    distArray = zeros(1,sizeYS(1));
    for orig = 1:nzit;
        for compare = 1:sizeYS(1);
            distance(orig,compare) = sqrt((S(orig,1) - Ccv(compare,orig))^2 + (S(orig,2) - Rcv(compare,orig))^2)/2;
            
        end
    end
    
    used = zeros(nzit,1);
    for orig=1:nzit
    link{orig,1}='ISO';
    end
    
    build  = 0;
    for orig = 1:nzit;
        if used(orig,1) == 0;
            build = build + 1;
            for compare = 1:sizeYS(1);
                thresh = distance(orig,compare);
                
                n = 1;
                if thresh<1; %do several trials until correct threshold found
                    takeout = compare;
                    if compare>=orig;
                        takeout = compare +1;
                    end
                    used(takeout,1)= used(takeout,1) + 1;
                    place=used(takeout,1);
                    link{build,place}=cell2mat(st{takeout,1});
                    n = n+1;
                    
                    if n == 2;
                        sumWind = Wind(orig,1) + Ycv(compare,orig);
                        sumC = colrow(orig,1) + Ccv(compare,orig);
                        sumR = colrow(orig,2) + Rcv(compare,orig);
                        sumST=STcv{compare,orig};
                    else
                        sumWind = sumWind + Ycv(compare,orig);
                        sumC = sumC + Ccv(compare,orig);
                        sumR = sumR + Rcv(compare,orig);
                         sumST=STcv{compare,orig};
                    end
                    newY(build,1) = sumWind/n;
                    newS(build,1) = sumC/n;
                    newS(build,2) = sumR/n;
                    newST{build,1}=sumST;
                else
                    newY(build,1) =  Wind(orig,1);
                    newS(build,1) = colrow(orig,1);
                    newS(build,2) = colrow(orig,2);
                     newST{build,1}=st{orig,1};
%                     newom(build1,1)=om(orig,1);
                end
            end
            
            
        end
        
        
    end
    
    
    
    
    
    fprintf('build')
    disp(build)
    
    %loop over the size of each and build in its owl section
    filnCtr = ['TtrC',filebeg,filend2];
    filnRtr = ['TtrR',filebeg,filend2];
    filnFFtr= ['TtrFFF',filebeg,filend2];
    filnSTtr=['TtrST',filebeg,filend2];
    Elim=['TElim',STstring,'.csv'];
%     
%    filnCco = ['coC',filebeg,filend2];
%     filnRco = ['coR',filebeg,filend2];
%     filnFFco= ['coFF',filebeg,filend2];
%     filnSTco=['coST',filebeg,filend2];
    
    CmIDtr = fopen(fullfile(AdjFo,filnCtr), 'w');
    RmIDtr = fopen(fullfile(AdjFo,filnRtr), 'w');
    FFmIDtr = fopen(fullfile(AdjFo,filnFFtr), 'w');
    STmIDtr=fopen(fullfile(AdjFo,filnSTtr),'w');
    ElimID=fopen(fullfile(BySTatFo,Elim),'w');
    
    
%      CmIDco = fopen(fullfile(AdjFo,filnCco), 'w');
%     RmIDco = fopen(fullfile(AdjFo,filnRco), 'w');
%     FFmIDco = fopen(fullfile(AdjFo,filnFFco), 'w');
%     STmIDco=fopen(fullfile(AdjFo,filnSTco),'w');
    
    
    for h = 1:build
        fprintf(CmIDtr, '%f\n', newS(h,1));
        fprintf(RmIDtr, '%f\n', newS(h,2));
        fprintf(FFmIDtr, '%f\n', newY(h,1));
        fprintf(STmIDtr, '%s\n', cell2mat(newST{h,1}));
    end
%     
%      for h = 1:spot
%         fprintf(CmIDco, '%f\n', C(h,1));
%         fprintf(RmIDco, '%f\n', R(h,1));
%         fprintf(FFmIDco, '%f\n', ff(h,1));
%         fprintf(STmIDco, '%s\n', cell2mat(st{h,1}));
%     end
%     
    if t==1
       %fprintf(ElimID, '%s,', 'Station')
       %fprintf(ElimID, '%s\n', 'RepStatus')
    for x=1:build
        %xx=x+1;
        tick=1;
       fprintf(ElimID, '%s,', cell2mat(newST{x,1}))
       while tick<used(x,1)
           fprintf(ElimID, '%s,', (link{x,tick}))
           tick=tick+1;
       
       end
        fprintf(ElimID, '%s\n',link{x,1})
    end
    matcheck=ones(2,2).*tick;
     MRname=['TMaxReps',STstring,'.csv'];
    MRFo=fullfile(BySTatFo,MRname);
    dlmwrite(MRFo,matcheck);
    
    end
    fclose(CmIDtr);
    fclose(RmIDtr);
    fclose(FFmIDtr);
    fclose(STmIDtr);
   
    
%     fclose(CmIDco);
%     fclose(RmIDco);
%     fclose(FFmIDco); 
   
% fileID = fopen((filename), 'r');
% 

end
end

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clearvars -except RN string starTime STstring Tailtest AdjFo BySTatFo list

MetarFo='KrInMetHT';
MadisFo='KrInMadHT';
% =['BiasCombOutM3',STstring];
% =['BiasBStM3',STstring];


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
% %


s0=' ';




new = 0;

endTime=timnam-2;

for t =1:endTime
    %:(starTime+23)
    new = new+1;
      
    filebeg  = cell2mat(TimeCell{t,1});
    clearvars ColMad C RowMad R ffMad ff METColMad MetRowMad ffMETY Wind
    clearvars S colrow Cmm Rmm FFmm Cmit Cm Cfm Rfm Rm Wfm FFm distance
    clearvars used takeout newY newS Ycv Ccv Rcv
    clearvars FF C R


spot = 0;








TtrEX=exist(fullfile(AdjFo, ['TtrST',filebeg,'.txt']));
if TtrEX > 0
filename = fullfile(AdjFo, ['TtrST',filebeg,'.txt']);
fileID = fopen((filename), 'r');
MEnam = 1;
while(~feof(fileID));
    
    InputText =textscan(fileID, '%s',1,'delimiter', ',');
    STMA{MEnam,1} = InputText{1};
    MEnam = MEnam+1;
    
end

fclose(fileID);

%Initial reads for sizing
FFMA = dlmread(fullfile(AdjFo, ['TtrFFF',filebeg,'.txt']));
%FFME = dlmread(fullfile(AdjFo, [filebeg,'TtrFF.txt']));

CMA = dlmread(fullfile(AdjFo, ['TtrC',filebeg,'.txt']));
RMA= dlmread(fullfile(AdjFo, ['TtrR',filebeg,'.txt']));

% CME = dlmread(fullfile(MetarFo, [filebeg,'TtrC.txt']));
% RME = dlmread(fullfile(MetarFo, [filebeg,'TtrR.txt']));

% OMA = dlmread(fullfile(MadisFo, 'om.txt'));
% OME = dlmread(fullfile(MetarFo, 'om.txt'));
% 
% omSMA=size(OMA)
% omSME=size(OME)



SizMA = size(FFMA);
% SizME = size(FFME)
testMA = size(CMA);
% testME = size(CME)

filend2 = '.txt';
% %

 for stati=1:SizMA(1)
%     
%     for stoma=1:omSMA
%     test>OMA(stoma) | test<OMA(stoma)
%     
%     
%     
%     if stati==test
   spot = spot+1;
   ff(spot,1) = FFMA(stati,1);
  % st(spot,1) = STMA(new,stati)
   C(spot,1) = CMA(stati,1);
   R(spot,1) = RMA(stati,1);
   st{spot,1}=STMA{stati,1};
%     end
%    
 end
% end


% for stome=1:omSME
%     test2=OME(stoma)
%    
%  for stati=1:SizME(1)
% %    test>OME(stoma) | test<OME(stoma)
%    spot = spot+1;
%    
%    ff(spot,1) = FFME(stati,1); 
%  %  st(spot,1) = STME(new,stati)
%    C(spot,1) = CME(stati,1);
%    R(spot,1) = RME(stati,1);
%    st{spot,1}=STME{stati,1};
% % end
%  end
% % end
% 
% 
% 
% %build the matrix of full values
% 
%     





% fprintf('C,R \n')
% size(C)
% size(R)


    
%     ffit = 1;
%     Cit = 1;
%     Rit = 1;
%     tinam = 1;
%     
%     %:timnam-1
    
%     disp(u)
  
    
    
   sizeWind = size(ff);
    %Remove zeros%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    nzit = 0;
    for q = 1:sizeWind(1);
        test = (ff(q,1));
       % if test > 0
            nzit = nzit+1;
            
            Y(nzit,1) = (ff(q,1));
            Wind(nzit,1) = (ff(q,1));
            S(nzit,1) = (C(q,1));
            S(nzit,2) = (R(q,1));
            
            colrow(nzit,1) =(C(q,1));
            colrow(nzit,2) =(R(q,1));
       % end
        
    end
    
   
    sizeS = size(S);
%     disp(nzit)
%     disp(ffit)
    sizeSS = sizeS(1);
    
    %Need to size adjust
    
     filnCtr = ['GCHtrC',filebeg,filend2];
    filnRtr = ['GCHtrR',filebeg,filend2];
    filnFFtr= ['GCHtrFF',filebeg,filend2];
    filnSTtr=['GCHtrST',filebeg,filend2];
                 
               Ccv =dlmread(fullfile(AdjFo,filnCtr));
               Rcv = dlmread( fullfile(AdjFo,filnRtr));
               Ycv = dlmread(fullfile(AdjFo,filnFFtr));
               
               
               %filename = fullfile(AdjFo, ['TtrST',filebeg,'.txt']);
fileID = fopen(fullfile(AdjFo,filnSTtr), 'r');
MAnam = 1;
while(~feof(fileID));
    
    InputText =textscan(fileID, '%s',1,'delimiter', ',');
   STcv{MAnam,1} = InputText{1};
    MAnam = MAnam+1;
    
end

fclose(fileID);
%                =dlmread(fullfile(AdjFo,filnSTtr));
                
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    clearvars i
    

    sizeYS = size(Ycv);
    distArray = zeros(1,sizeYS(1));
    for orig = 1:nzit;
        for compare = 1:sizeYS(1);
            distance(orig,compare) = sqrt((S(orig,1) - Ccv(compare,1))^2 ...
                + (S(orig,2) - Rcv(compare,1))^2)/2;
            
        end
    end
    
    used = zeros(nzit,1);
    for orig=1:nzit
    link{orig,1}='ISO';
    end
    
    build  = 0;
    for orig = 1:nzit;
        % if used(orig,1) == 0;
%             build = build + 1;
            for compare = 1:sizeYS(1);
                thresh(compare,1) = distance(orig,compare);
                minthresh=min(thresh);
            end
                n = 1;
                if minthresh>1; %do several trials until correct threshold found
%                   
                build=build+1;
                    newY(build,1) =  Wind(orig,1);
                    newS(build,1) = colrow(orig,1);
                    newS(build,2) = colrow(orig,2);
                     newST{build,1}=st{orig,1};
%                     newom(build1,1)=om(orig,1);
                end
           % end
            
            
       % end
        
        
    end
    
    
    
    
    
    fprintf('build')
    disp(build)
    
    %loop over the size of each and build in its owl section
    filnCtr = ['TTtrC',filebeg,filend2];
    filnRtr = ['TTtrR',filebeg,filend2];
    filnFFtr= ['TTtrFFF',filebeg,filend2];
    filnSTtr=['TTtrST',filebeg,filend2];
    Elim=['TTElim',STstring,'.csv'];
%     
%    filnCco = ['coC',filebeg,filend2];
%     filnRco = ['coR',filebeg,filend2];
%     filnFFco= ['coFF',filebeg,filend2];
%     filnSTco=['coST',filebeg,filend2];
    
    CmIDtr = fopen(fullfile(AdjFo,filnCtr), 'w');
    RmIDtr = fopen(fullfile(AdjFo,filnRtr), 'w');
    FFmIDtr = fopen(fullfile(AdjFo,filnFFtr), 'w');
    STmIDtr=fopen(fullfile(AdjFo,filnSTtr),'w');
    ElimID=fopen(fullfile(BySTatFo,Elim),'w');
    
    
%      CmIDco = fopen(fullfile(AdjFo,filnCco), 'w');
%     RmIDco = fopen(fullfile(AdjFo,filnRco), 'w');
%     FFmIDco = fopen(fullfile(AdjFo,filnFFco), 'w');
%     STmIDco=fopen(fullfile(AdjFo,filnSTco),'w');
    
    
    for h = 1:build
        fprintf(CmIDtr, '%f\n', newS(h,1));
        fprintf(RmIDtr, '%f\n', newS(h,2));
        fprintf(FFmIDtr, '%f\n', newY(h,1));
        fprintf(STmIDtr, '%s\n', cell2mat(newST{h,1}));
    end
%     
%      for h = 1:spot
%         fprintf(CmIDco, '%f\n', C(h,1));
%         fprintf(RmIDco, '%f\n', R(h,1));
%         fprintf(FFmIDco, '%f\n', ff(h,1));
%         fprintf(STmIDco, '%s\n', cell2mat(st{h,1}));
%     end
%     
%     if t==starTime
%        %fprintf(ElimID, '%s,', 'Station')
%        %fprintf(ElimID, '%s\n', 'RepStatus')
%     for x=1:build
%         %xx=x+1;
%         tick=1;
%        fprintf(ElimID, '%s,', cell2mat(newST{x,1}))
%        while tick<used(x,1)
%            fprintf(ElimID, '%s,', (link{x,tick}))
%            tick=tick+1;
%        
%        end
%         fprintf(ElimID, '%s\n',link{x,1})
%     end
%     matcheck=ones(2,2).*tick
%      MRname=['TTMaxReps',STstring,'.csv']
%     MRFo=fullfile(BySTatFo,MRname)
%     dlmwrite(MRFo,matcheck);
%     
%     end
%     fclose(CmIDtr);
%     fclose(RmIDtr);
%     fclose(FFmIDtr);
%     fclose(STmIDtr);
%    
%     
% %     fclose(CmIDco);
% %     fclose(RmIDco);
% %     fclose(FFmIDco); 
%    
% fileID = fopen((filename), 'r');
end
end

end
end

