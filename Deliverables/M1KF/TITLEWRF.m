clear
clc


%%Initial time read

Dim = 'RFO2';
dim=2

mkdir(fullfile('KalWRF',Dim));
 mkdir('KalWRF')

%Hour=24 manipulation at bottom of code

filename = 'FC24JS.txt';
fileID = fopen(fullfile('KalmanTF',filename), 'r');
timnam = 1;

while(~feof(fileID));
    
    InputText =textscan(fileID, '%s',1,'delimiter', '\t');
    sizeT = size(InputText{1});
    if sizeT(1)>0;
        TimeCNew{timnam,1} = InputText{1};
        timnam = timnam+1;
    end
end

fclose(fileID);
% %
ticou = timnam-25;





%The number of hours of data have/want to read


%%Time loop
filend = '.txt';
filend2 = '.txt';
totit = 0;

for t = 1:ticou;
    
    filebeg  = cell2mat(TimeCNew{t,1});
    
    name = fullfile('wfNMIn',[filebeg,'Krig.mat'])
    
    %load (name);%Workspace read
    load (name);
    
    clearvars sizes sizess;
    sizes = size(S); %S may change sizes every hour
%     fprintf('Size of S -> hour -> verify obsmat at end')
    sizess = sizes(1);
%     disp(t)
    
    
    for b = 1:sizess;
        totit = totit+1;
        obs(totit,1) = Y(b,1);%Observation values col=hour
        
    end
    
    it = 0;
    for i = 1:267;
        
        for j = 1:330;
            it = it+1;
            Yinput(it,t) = YX(j,i);%Kriged Obs for Kalman
            
        end
        %disp(it)
    end
    
    
end
% %



%%Kriged Obs for Kalman Filewrite

beg = 'Obs';
ender='.txt';
% 
% fprintf('Size of Y input = 88110 x hours \n')
sizeobs=size(Yinput);

for i=1:sizeobs(1);%Should automatically equate to 88110
    
    number=num2str(i);
    filename=[beg,number,ender];
   
    WindID = fopen((fullfile('KalWRF',Dim,filename)), 'w');
    
    for j = 1:sizeobs(2)%Should be number of hours
        fprintf(WindID, '%f\n', Yinput(i,j));
    end
    fclose(WindID);
    
end
% %





%%Initial yV,X,xMat, for Kriging
clearvars -except ticou Dim name TimeCNew dim



hours=24;
Hours=hours+1;
fprintf('dim= \n')
disp(dim)

yv=ones(Hours,1);
fb1='yV';
x_matrix = ones(Hours, dim);
fb2='x_matrix';
p_matrix=ones(dim,dim);
fb3 = 'P_matrix';
x=ones(dim,dim);
fb4 = 'x';
fb5='P';
ender='.txt';
fb6='modeltom_filt';
%modtom=ones(hours,1);

%load (fullfile('CleanCombKrig','krig',name));
    

%make these proper fopen and close
for i = 1:88110;
    %88110;
    numbernew=  num2str(i);
    
    file1 = [fb1, numbernew, ender];
    dlmwrite(fullfile('KalWRF',Dim,file1), yv);
    
    file2 = [fb2, numbernew, ender];
    dlmwrite(fullfile('KalWRF',Dim,file2), x_matrix);
    
    file3 = [fb3, numbernew, ender];
    dlmwrite(fullfile('KalWRF',Dim,file3), p_matrix);
    
     file4 = [fb4, numbernew, ender];
    dlmwrite(fullfile('KalWRF',Dim,file4), x);
    
     file5 = [fb5, numbernew, ender];
    dlmwrite(fullfile('KalWRF',Dim,file5), p_matrix);
    
%     dlmwrite(fullfile(Dim,file6),modtom);    
%     
    
end

     


%%Model Data Note this is what is staggered
%Won't be able to deal with the names until get the files
%ticou=72;
begmod='ModYes';
begmod2 = 'ModTom';
 ender='.txt';

for i = 1:ticou;
    filebeg  = cell2mat(TimeCNew{i,1});
    %Target#.txt
    %modyes
     j = i-1;   
    numbernew=  num2str(j);
    filMod = [filebeg,'WRF.txt'];
   ModID = fopen(fullfile('WRFnew',filMod), 'r');
   modit = 1;

while(~feof(ModID));
    
    InputText =textscan(ModID, '%f',1,'delimiter', '\t');
    sizeT = size(InputText{1});
    if sizeT(1)>0;
        mod(modit,i) = InputText{1};
        modit = modit+1;
    end
end

fclose(ModID);

    
  
end

rowColM = size(mod);

 for stat = 1:88110
     
     %rowColM(1)
     numn = num2str(stat);
     fileyes = [begmod, numn, ender];
     filetom = [begmod2, numn, ender];
     file6 = [fb6, numn, ender];
     clearvars modyes modtom
     
   for yes=1:(ticou-24)
         modyes(yes,1)= mod(stat,yes);
   end

   %dlmwrite(fileyes, modyes)
   
    dlmwrite(fullfile('KalWRF',Dim,fileyes),modyes);
   
    for tom=25:ticou
        ITMT = tom-24;
         modtom(ITMT,1)= mod(stat,tom);
         
     end
     %dlmwrite(fullfile(Dim,filetom)    
    dlmwrite(fullfile('KalWRF',Dim,filetom), modtom);
    dlmwrite(fullfile('KalWRF',Dim,file6),modtom); 
    
 end
 
 Wksp=[Dim,'wksp.mat'];
 save(Wksp);


