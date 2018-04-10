clear
clc

Dim = 'M03d2';
dim=2

%%Initial time read
Timesize=dlmread(fullfile(Dim,'GClistM32.txt'));



% mkdir(fullfile('KalWRF',Dim));
%  mkdir('KalWRF')cds Documend/RF/KFRd/


Tsize=size(Timesize)
for numfiles=1:Tsize(1)
%%Initial yV,X,xMat, for Kriging
clearvars -except ticou Dim name TimeCNew dim numfiles Timesize
ticou=Timesize(numfiles,1)



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

    %88110;
    numbernew=  num2str(ticou)
    
    file1 = [fb1, numbernew, ender];
    dlmwrite(fullfile(Dim,file1), yv);
    
    file2 = [fb2, numbernew, ender];
    dlmwrite(fullfile(Dim,file2), x_matrix);
    
    file3 = [fb3, numbernew, ender];
    dlmwrite(fullfile(Dim,file3), p_matrix);
    
     file4 = [fb4, numbernew, ender];
    dlmwrite(fullfile(Dim,file4), x);
    
     file5 = [fb5, numbernew, ender];
    dlmwrite(fullfile(Dim,file5), p_matrix);
    
%     dlmwrite(fullfile(Dim,file6),modtom);    
%     
    


    
end
 Wksp=[Dim,'wksp.mat'];
 save(Wksp);


