clear
clc


   
filename = 'FC24Unique.txt';
fileID = fopen((filename), 'r');
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
    
    mkdir('wfnFFST');


fileend = 'mad.txt';
filend = 'MA.txt';
it = 0;

for t = 1:(timnam-1);
    disp(t)
%     tt = threeti(
    filebeg = cell2mat(TimeCell{t});
    
    filename = [filebeg,fileend];
    
fileID = fopen((fullfile('Madis',filename)), 'r');

values =textscan(fileID, '%s','delimiter', '\t');
sizevalues = size(values{1});

last = sizevalues(1)-1;

ffbeg = 'ff';
stabeg = 'sta';
timebeg = 'time';
latbeg = 'lat';
lonbeg = 'lon';


ffname = [filebeg,ffbeg, filend];
staname = [filebeg,stabeg,filend];
timename = [filebeg,timebeg,filend];
latname = [filebeg,latbeg,filend];
lonname = [filebeg,lonbeg,filend];

ffID = fopen(fullfile('wfnFFST',ffname), 'w');
staID = fopen(fullfile('wfnFFST',staname), 'w');
timeID = fopen(fullfile('wfnFFST',timename), 'w');
latID = fopen(fullfile('wfnFFST',latname), 'w');
lonID = fopen(fullfile('wfnFFST',lonname), 'w');
iter = 0;
for z = 4:last;
%     disp(z);
    iter = iter+1;
j =values{1,1};
jj = j{z};
sta{iter,1}= {jj(10:18)};
lat{iter,1} = {jj(31:37)};
lon{iter,1} = {jj(41:48)};
time{iter,1} = {jj(67:80)};
FF{iter,1} = {jj(96:105)};

ff = str2num(cell2mat(FF{iter}));
Lat = str2num(cell2mat(lat{iter}));
Lon = str2num(cell2mat(lon{iter}));
Station = cell2mat(sta{iter});

fprintf(ffID, '%f\n', ff);
fprintf(latID, '%.001f \n', Lat);
fprintf(lonID, '%.001f \n', Lon);
fprintf(staID, '%s\n', Station);

it = it+1;
stats{it,1} = Station;
stalist{it,1} = Station;%station
stalist{it,2} = Lat;%lat
stalist{it,3} = Lon;%lon

end

fclose(fileID);
fclose(ffID) ;
fclose(staID) ;
%fclose(timeID) 
fclose(latID) ;
fclose(lonID) ;


end
fprintf('next loop')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sizets = size(stalist);

stations = unique(stats);

numstats = size(stations);

for i = 1:numstats(1);
   
    test = stations{i,1};
    sizetest = size(test);
    strsiztest = sizetest(2);
    
    for j = 1:sizets(1)
        check = stalist{j,1};
        sizecheck = size(check);
        strsizcheck = sizecheck(2);
        
        if strsiztest == strsizcheck;
        if check == test;
            ii = i+1;
            mat{ii,1} = stalist{j,1};
            mat{ii,2} = stalist{j,2};
            mat{ii,3} = stalist{j,3};
        end
        end
    end
end



mat{1,1} = 'Stat'
mat{1,2} = 'Lat'
mat{1,3} =  'Lon'
%  disp(mat)   
 save('wksp.mat');
%xlswrite('LLaus.xls', mat)








