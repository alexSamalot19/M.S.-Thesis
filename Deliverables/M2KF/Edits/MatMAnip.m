clear
clc

STCVname='TotalTime.txt';
STCVID=fopen(STCVname,'r');
timnam = 1;
while(~feof(STCVID));
    
    InputText =textscan(STCVID, '%s',1,'delimiter', ',');
    TimeCell{timnam,1} = InputText{1};
    timnam = timnam+1;
    
end
fclose(STCVID); 

 STCVname2='FC24JS.txt';
STCVID2=fopen(STCVname2,'r');
timnam2 = 1;
while(~feof(STCVID2));
    
    InputText2 =textscan(STCVID, '%s',1,'delimiter', ',');
    TimeCell2{timnam2,1} = InputText2{1};
    timnam2 = timnam2+1;
    
end

fclose(STCVID);   
    

% 
% 
% TimeCell{3097,1}%20090731_00 Delete
% TimeCell{3120,1}%20090731_23 Delete
% TimeCell{3121,1}%20090731_00
% TimeCell{3144,1}%20090731_23
% 
% 
% TimeCell{3457,1}%20100504_00 Delete
% TimeCell{3504,1}%20100505_23 Delete
% TimeCell{3505,1}%20100504_00
% TimeCell{3552,1}%20100505_23
% 
TimeCell{3721,1}%20100606_00 Delete
TimeCell{3744,1}%20100606_23 Delete
TimeCell{3745,1}%20100606_00
TimeCell{3768,1}%20100606_23

TCarray=1:(timnam-2);

TCarray(3721:3744)=[];
TCarray(3457:3504)=[];
TCarray(3097:3120)=[];

for j = (3672-24):3673%1:(timnam2-2);
ticTC=TCarray(j);

test=cell2mat(TimeCell{ticTC,1})
ticTC
test2=cell2mat(TimeCell2{j,1})

if test==test2
    NewHist{j,1}=TimeCell{ticTC,1};
else
   error('error bad history')
end


end

%error('If it gets to this point use MatManip to remove files from Kalin &KalinMet')

% %Read Kalin
 Kalin=dlmread('Kalin.txt');
% %view old deletes and confirm
% temp(1:24,1)=Kalin(3097:3120,1);
% temp2(1:24,1)=Kalin(3697:3720,13);
% %Read Kalin Met
%  KalinMet=dlmread(fullfile('Meth3Met','KalinMet.txt'));
% size(KalinMet)
% temp3(1:48,1)=Kalin(4417:4464,72);

% %perform same deletes, lattermost first
% KalinMet(3721:3744,:)=[];
%  KalinMet(3457:3504,:)=[];
%  KalinMet(3097:3120,:)=[];
%  
 
  Kalin(3721:3744,:)=[]; 
  Kalin(3457:3504,:)=[];
 Kalin(3097:3120,:)=[];


% size(KalinMet)
% error('Break to test KalinMet')
% 
 dlmwrite(fullfile('Meth3Met','KalinFin.txt'),Kalin);
%  dlmwrite(fullfile('Meth3Met','KalinMetFin.txt'),KalinMet);
% %test 72 first, then do all(other code)