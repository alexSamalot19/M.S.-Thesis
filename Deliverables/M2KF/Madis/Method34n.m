clearvars -except Timesize

%Kalman Input Read
mkdir('M03d2')
%Read MadisCRno%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
filename = 'MadisCRno.csv';
fileID = fopen(filename, 'r');
RefLis=1;
folder='M03d2'
    while(~feof(fileID));
            
            InputText =textscan(fileID, '%s',5,'delimiter', ',');
            CRlist{RefLis,1} = InputText{1};
            if size(InputText{1}) > 0;
            RefLis = RefLis+1;
            end
    end
        
    fclose(fileID);
%     KalinMet=dlmread(fullfile('Meth3Met','KalinMetFin.txt'));
%Read Kalin %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  Kalin=dlmread(fullfile('Meth3Met','KalinFin.txt'));
  size(Kalin)
%Read the timeseries%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
STCVname='FC24JS.txt';
STCVID=fopen(STCVname,'r');
timnam = 1;
while(~feof(STCVID));
    
    InputText =textscan(STCVID, '%s',1,'delimiter', ',');
    TimeCell{timnam,1} = InputText{1};
    timnam = timnam+1;
    
end

fclose(STCVID);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for location=1:(RefLis-1)
    sumtime=0;
    zerotail=0;
     %Calculate Grid Cell Location
     holdd=CRlist{location,1}
       
        Cnum=holdd{4,1};
         Rnum=holdd{5,1};
        Rclose = round(str2num(Rnum));
        Cclose = round(str2num(Cnum));
        LocClose = (Cclose-1)*330 + Rclose;
     
    fileout1=fopen(fullfile(folder,['Obs',num2str(location),'.txt']),'w');
    fileout2=fopen(fullfile(folder,['LocOut',num2str(location),'.txt']),'w');
    fileout3=fopen(fullfile(folder,['ModYes',num2str(location),'.txt']),'w');
    fileout4=fopen(fullfile(folder,['ModTom',num2str(location),'.txt']),'w');
         
    for time=1:(timnam-2);
if Kalin(time,location)>0
    holder=cell2mat(TimeCell{time,1});
    %Read WRF at Time
    filMod = [holder,'WRF.txt'];   
    WRF=dlmread(fullfile('G:','WRF',filMod));
    sumtime=sumtime+1;
fprintf(fileout1,'%f\n',Kalin(time,location));
fprintf(fileout2,'%f\n',time);
fprintf(fileout3,'%f\n',WRF(LocClose,1));
if sumtime>24
    fprintf(fileout4,'%f\n',WRF(LocClose,1));
end
else
    zerotail=zerotail+1
end

    end
    
    Timesize(location,1)=sumtime-24;
    
    
    for tail=1:zerotail        
 fprintf(fileout1,'%f\n',0);
%fprintf(fileout2,'%s\n',holder);
fprintf(fileout3,'%f\n',0); 
   fprintf(fileout4,'%f\n',0);      
    end
    
    fclose(fileout1);
    fclose(fileout2);
     fclose(fileout3);
     fclose(fileout4);
end

dlmwrite('TPS2.txt',Timesize);




