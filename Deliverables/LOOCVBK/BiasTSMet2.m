clear
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%
RN=96%Rand #
string=num2str(RN);
starTime=RN
STstring='96'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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


%This Code needs to be edited to not have the values
filename = 'MetCRno.csv';
fileID = fopen(filename, 'r');
RefLis=1;

    while(~feof(fileID));
            
            InputText =textscan(fileID, '%s',5,'delimiter', ',');
            CRlist{RefLis,1} = InputText{1};
            if size(InputText{1}) > 0;
            RefLis = RefLis+1;
            end
    end
        
    fclose(fileID);
% %
    

filend = '.csv';
filend2 = '.txt';
it = 0;
tl = 0;

AdjFo=['BiasMetOut',STstring]
mkdir(AdjFo)

CID=fopen(fullfile(AdjFo,'C24.txt'), 'w');
RID=fopen(fullfile(AdjFo,'R24.txt'), 'w');
SID=fopen(fullfile(AdjFo,'ST24.txt'), 'w');

%WRFtot = dlmread(fullfile('WRFnew',(WRFname)));

%Initialize Station x Time matrix (consistent with original file)
 StaByTimM = zeros((RefLis-1), (timnam-1));
StaByTimO = zeros((RefLis-1), (timnam-1));

%SBTit = ones((Reflis-1));
new=0;
endTime=timnam-2

for u =1:endTime
    %3710:(timnam-1)
    new =new+1;
   % disp(u)
    
    filebeg  = cell2mat(TimeCell{u,1})
    
    filename = [filebeg,'ST',filend2];
    OBSname = [filebeg,'FF',filend2];
    
    WRFname = [filebeg,'WRF',filend2];    
    WRFtot = dlmread(fullfile('WRFnew',(WRFname)));
    
    sizefin = size(filename);% is there a date in the spot?
    
    
    
    
    fileID = fopen(fullfile('Metar',filename), 'r');
    OBSID = fopen(fullfile('Metar',OBSname), 'r');
    %WRFID = fopen(fullfile('Metar',WRFname), 'r');
    
  %  StaByTimO = zeros((RefLis-1),24)
    
    
    
    %Cname = [filebeg,'C',filend2];
    %Rname = [filebeg,'R',filend2];
    %CID = fopen((Cname), 'w');
    %RID = fopen((Rname), 'w');  minimize clutter
    
    
    
    if sizefin(2) >11
        
        iter = 0;
        errorit = 1;
        
        while(~feof(fileID));%currently inside the 2001234_00.csv
            iter = iter+1 ;
            
            Station =textscan(fileID, '%s',1,'delimiter', ',');
           % WRF =textscan(WRFID, '%f',1,'delimiter', ',');
            OBS =textscan(OBSID, '%f',1,'delimiter', ',');
            
            
            
            sist = size(Station{1});
            
            if sist(1)>0;
                finStation = cell2mat(Station{1});
                ssta = cell2mat(Station{1});
                sta = strtrim(ssta);
                ss=size(sta) ;
            %fprintf(SID, '%s\n', sta)
%             fprintf(CID, '%s\n', check{4});
%             fprintf(RID, '%s\n', check{5});
                
                
                
                
                for j = 1:(RefLis-1);
                    check = CRlist{j,1};
                    
                    Rclose = round(str2num(check{5,1}));
                    Cclose = round(str2num(check{4,1}));
                    LocClose = (Cclose-1)*330 + Rclose;
                    
                    WRFclose = WRFtot(LocClose,1);
                    
                    
                    StaByTimM(j,new) =(WRFclose);
                    
                    y= size(strtrim(check{1}));
                    
                    if y(1)>0
%                         
%                                    fprintf('check{1} \n')
%                                    disp(check{1})

                        sc = size(strtrim(check{1}));
                        if ss ==sc;
                            if strtrim(check{1}) == sta;
%                                             disp(strtrim(check{1}))
%                                             disp(j)


                                errorit = errorit + 1;
                                
                                
                                
                                
                                StaByTimO(j,new) = cell2mat(OBS);
%                                 Stalist{j,1} = sta
%                                Stalist{j,u} = check{4}
%                                  Stalist{j,u} = check{5}
%                                 
                                
                                %if u==1
                                 
                                
                            %end
                        end
                    end
                    
                    
                    
                end
%                 if errorit < iter
%                     error('missed station')
%                 end
                end
            end
        end
        

    end
end
    
%         
%         fclose(CID);
%         fclose(RID);
%         fclose(SID);

convenience=StaByTimO.'

dlmwrite(fullfile(AdjFo,'F24.txt'),convenience)


convenience2=StaByTimM.'

dlmwrite(fullfile(AdjFo,'WRF24.txt'),convenience2)

