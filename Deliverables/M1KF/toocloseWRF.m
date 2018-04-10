%%Creating the new dacewind and artificial coordinates missing values
%creating the read matrix
clear
clc

mkdir('wNMtr');

series = ['20031214';'20040701';'20040820';'20040908'; ...
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

numvals=size(series)


filend = '.txt';
filend2 = '.txt';
it = 0;
tl = 0;

for notu=28:numvals(1)
    clearvars -except notu series filend2
stormbeg  = (series(notu,:));


%     stormname=[stormbeg,'F24.txt'];
    
    
    
  
    fiATout1 = [stormbeg,'SC24.txt'];

fileID = fopen(fullfile('storm',fiATout1), 'r');
timnam = 1;

while(~feof(fileID));
    
    InputText =textscan(fileID, '%s',1,'delimiter', '\t');
    sizeT = size(InputText{1});
    if sizeT(1)>0;
        TimeCell{timnam,1} = InputText{1};
        timnam = timnam+1;
    end
end

fclose(fileID);
    
    %:timnam-1
    for tcell=1:(timnam-1)
        %
        
        clearvars -except TimeCell tcell filend2 series
          ffit = 1;
    Cit = 1;
    Rit = 1;
    tinam = 1;
    
%         clearvars ColMad C RowMad R ffMad ff METColMad MetRowMad ffMETY Wind
%     clearvars S colrow Cmm Rmm FFmm Cmit Cm Cfm Rfm Rm Wfm FFm distance
%     clearvars used takeout newY newS Ycv Ccv Rcv
        
    filebeg  = cell2mat(TimeCell{tcell,1})
    %Madis%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    CoutName=[filebeg,'Cn0.txt'];
RoutName=[filebeg,'Rn0.txt'];
FFoutName=[filebeg,'FFn0.txt'];


FF24ID = fopen(fullfile('wfnFFST',FFoutName), 'r');
C24ID = fopen(fullfile('wfNCR',CoutName), 'r');
R24ID = fopen(fullfile('wfNCR',RoutName),'r');
    
    
    
    while(~feof(C24ID));
        
        ColMad =textscan(C24ID, '%s',1,'delimiter', '\t');
        sizeCMAD = size(ColMad{1});
        if sizeCMAD(1)>0;
            C{Cit,1} = ColMad{1};
            Cit = Cit+1;
        end
    end
    
    while(~feof(R24ID));
        
        RowMad =textscan(R24ID, '%s',1,'delimiter', '\t');
        sizeRMAD = size(RowMad{1});
        if sizeRMAD(1)>0;
            R{Rit,1} = RowMad{1};
            Rit = Rit+1;
        end
    end
    
    while(~feof(FF24ID));
        
        ffMad =textscan(FF24ID, '%s',1,'delimiter', '\t');
        sizeffMAD = size(ffMad{1});
        if sizeffMAD(1)>0;
            ff{ffit,1} = ffMad{1};
            ffit = ffit+1;
        end
    end
    
    fclose(C24ID);
    fclose(R24ID);
    fclose(FF24ID);
    
    
    
    %METAR%%%%%%%%%%%%%%%%%%
MCoutName=[filebeg,'MCn0.txt'];
MRoutName=[filebeg,'MRn0.txt'];
MFFoutName=[filebeg,'MFFn0.txt'];


FF24ID = fopen(fullfile('wfMFFST',MFFoutName), 'r');
C24ID = fopen(fullfile('wfMCR',MCoutName), 'r');
R24ID = fopen(fullfile('wfMCR',MRoutName),'r');
    
    while(~feof(C24ID));
        
        METColMad =textscan(C24ID, '%s',1,'delimiter', '\t');
        METsizeCMAD = size(METColMad{1});
        if METsizeCMAD(1)>0;
            C{Cit,1} = METColMad{1};
            Cit = Cit+1;
        end
    end
    
    while(~feof(R24ID));
        
        METRowMad =textscan(R24ID, '%s',1,'delimiter', '\t');
        METsizeRMAD = size(METRowMad{1});
        if METsizeRMAD(1)>0;
            R{Rit,1} = METRowMad{1};
            Rit = Rit+1;
        end
    end
    
    while(~feof(FF24ID));
        
        ffMET =textscan(FF24ID, '%s',1,'delimiter', '\t');
        sizeffMET = size(ffMET{1});
        if sizeffMET(1)>0;
            ff{ffit,1} = ffMET{1};
            ffit = ffit+1;
        end
    end
    
    fclose(C24ID);
    fclose(R24ID);
    fclose(FF24ID);
    
    nrCR = size(C);
    NRcr = nrCR(1)
    
    
    
    
    %%Marking function%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    % filebeg = 'Dace';
    % fileend = 'WindMadis.xlsx';
    % filename1 = [filebeg, fileend];
    % sfilebeg = 'S';
    % sfileend = 'forDACE.xlsx';
    
    
    
    sizeWind = NRcr;
    %Remove zeros%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    nzit = 0;
    for q = 1:sizeWind(1);
        %test = str2num(cell2mat(ff{q,1}));
         test=size(str2num(cell2mat(ff{q,1})));
        if test > 0
            nzit = nzit+1;
            
            Y(nzit,1) = str2num(cell2mat(ff{q,1}));
            Wind(nzit,1) = str2num(cell2mat(ff{q,1}));
            S(nzit,1) = str2num(cell2mat(C{q,1}));
            S(nzit,2) = str2num(cell2mat(R{q,1}));
            
            colrow(nzit,1) =str2num(cell2mat(C{q,1}));
            colrow(nzit,2) = str2num(cell2mat(R{q,1}));
        end
        
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
%                 
%                 fprintf(CmID, '%s\n', Cmm);
%                 fprintf(RmID, '%s\n', Rmm);
%                 fprintf(ffmID, '%s\n', FFmm);
%                 
               Ccv(b,i) = S(a,1);
               Rcv(b,i) = S(a,2);
               Ycv(b,i) = Wind(a,1);
                
                
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
    build  = 0;
    for orig = 1:nzit;
        if used(orig,1) == 0;
            build = build + 1;
            for compare = 1:sizeYS(1);
                thresh = distance(orig,compare);
                
                n = 1;
                if thresh<0.5; %do several trials until correct threshold found
                    takeout = compare;
                    if compare>=orig;
                        takeout = compare +1;
                    end
                    used(takeout,1)= used(takeout,1) + 1;
                    n = n+1;
                    
                    if n == 2;
                        sumWind = Wind(orig,1) + Ycv(compare,orig);
                        sumC = colrow(orig,1) + Ccv(compare,orig);
                        sumR = colrow(orig,2) + Rcv(compare,orig);
                    else
                        sumWind = sumWind + Ycv(compare,orig);
                        sumC = sumC + Ccv(compare,orig);
                        sumR = sumR + Rcv(compare,orig);
                        
                    end
                    newY(build,1) = sumWind/n;
                    newS(build,1) = sumC/n;
                    newS(build,2) = sumR/n;
                    
                else
                    newY(build,1) =  Wind(orig,1);
                    newS(build,1) = colrow(orig,1);
                    newS(build,2) = colrow(orig,2);
                end
            end
            
            
        end
        
        
    end
    fprintf('build')
    disp(build)
    
    %loop over the size of each and build in its owl section
    filnCtr = ['trC',filebeg,filend2];
    filnRtr = ['trR',filebeg,filend2];
    filnFFtr= ['trFF',filebeg,filend2];
    
    CmIDtr = fopen(fullfile('wNMtr',(filnCtr)), 'w');
    RmIDtr = fopen(fullfile('wNMtr',(filnRtr)), 'w');
    FFmIDtr = fopen(fullfile('wNMtr',(filnFFtr)), 'w');
    
    
    
    
    for h = 1:build
        fprintf(CmIDtr, '%f\n', newS(h,1));
        fprintf(RmIDtr, '%f\n', newS(h,2));
        fprintf(FFmIDtr, '%f\n', newY(h,1));
    end
    
    fclose(CmIDtr);
    fclose(RmIDtr);
    fclose(FFmIDtr);
    
    
    
    
end
% load Handel
% sound(y,Fs)

end
