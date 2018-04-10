clear
clc

        
     Timebeg = 'T';
    Stationbeg = 'ST';
    Latbeg = 'LA';
    Lonbeg = 'LO';
    Obsbeg = 'FF';
series = ['20050804']
% series = ['20040917';'20031214';'20040701';'20040820';'20040908'; ...
%      '20040917';'20040928';'20041104';'20041130';'20041225';'20050401'; ...
%      '20050628';'20050718';'20050721';'20050727';'20050804';'20050811'; ...
%      '20050916';'20050929';'20051007';'20051015';'20051024';'20060102'; ...
%      '20060114';'20060117';'20060216';'20060531';'20060606';'20060710'; ...
%      '20060716';'20060727';'20060801';'20060901';'20061027';'20061130'; ...
%      '20070301';'20070414';'20070515';'20070531';'20070709';'20070714'; ...
%      '20070729';'20070816';'20071202';'20080113';'20080212';'20080308'; ...
%      '20080320';'20080526';'20080608';'20080610';'20080613';'20080622'; ...
%      '20080717';'20080722';'20080726';'20080805';'20080906';'20081025'; ...
%      '20081210';'20081230';'20090107';'20090509';'20090625';'20090706'; ...
%     '20090723';'20090729';'20090731';'20090821';'20091006';'20091127'; ...
%      '20100223';'20100313';'20100428';'20100503';'20100504';'20100507'; ...
%      '20100525';'20100602';'20100604';'20100605';'20100705';'20100721'; ...     
%      '20100929';'20101225';'20110111';'20110117';'20110201';'20110601'; ...
%      '20110608';'20110828';'20111028';'20120622';'20121028';'20121107'; ...
%      '20121228';'20130130';'20130208';'20130511';'20130523';'20130525'; ...
%      '20130529';'20130607';'20130613';'20130901';'20131031';'20131118'; ...
%      '20131126';'20140106';'20140110';'20140204'];
filend = '.csv';
filendwrite = '.txt';
it = 0;
sizeSeries = size(series);
tl = 0;





for u =1% [57,64,69,81,96,105];%6,16,29,39,44,
    disp(u)
     % num = num2str(j-1) Probably not relevant
    %filename = [filebeg,num,filend]
    
    filebeg  = (series(u,:));
    filename = [filebeg,filend];
    fileID = fopen((filename), 'r');
    
    
   % headers =textscan(fileID, '%s',13,'delimiter', '\t');
   %There are no headers in the first file (check 10)
   %disp(values{1});
    
    
    %clearvars InputText Data


    iter = 0;
    
    while(~feof(fileID));
      iter = iter+1 ;
   
%  [Version,WRF,non,Time1,Time2,Time3,Time4,nons,z10,nons2,z102,ADPS,d03, ...
%      Bilin,p4,na1,na2,na3,na4,mpr,v,w,skip,Station,Lat,Lon,na5,Mod,Obs, ...
%      na6]
% fmt = '%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s','%s',...
%      '%s','%s','%s','%s','%s','%s','%s','%s';
%  D= textscan(fileID, fmt, 
% 
    Version =textscan(fileID, '%s',1,'delimiter', ',');
    WRF = textscan(fileID, '%s',1,'delimiter', ',');
    non = textscan(fileID, '%s',1,'delimiter', ',');
    Time1 = textscan(fileID, '%s',1,'delimiter', ',');
     Time2 = textscan(fileID, '%s',1,'delimiter', ',');
    Time3 = textscan(fileID, '%s',1,'delimiter', ',');
    Time4 = textscan(fileID, '%s',1,'delimiter', ',');
    nons = textscan(fileID, '%s',1,'delimiter', ',');
    z10 = textscan(fileID, '%s',1,'delimiter', ',');
    nons2 = textscan(fileID, '%s',1,'delimiter', ',');
     z102 = textscan(fileID, '%s',1,'delimiter', ',');
    ADPS = textscan(fileID, '%s',1,'delimiter', ',');
    d03 = textscan(fileID, '%s',1,'delimiter', ',');
    Bilin = textscan(fileID, '%s',1,'delimiter', ',');
    p4= textscan(fileID, '%s',1,'delimiter', ',');
    na1 = textscan(fileID, '%s',1,'delimiter', ',');
    na2 = textscan(fileID, '%s',1,'delimiter', ',');
     na3 = textscan(fileID, '%s',1,'delimiter', ',');
    na4 = textscan(fileID, '%s',1,'delimiter', ',');
    mpr = textscan(fileID, '%s',1,'delimiter', ',');
    v = textscan(fileID, '%s',1,'delimiter', ',');
    w = textscan(fileID, '%s',1,'delimiter', ',');
    skip = textscan(fileID, '%s',1,'delimiter', ',');
     Station = textscan(fileID, '%s',1,'delimiter', ',');
    Lat = textscan(fileID, '%s',1,'delimiter', ',');
    Lon = textscan(fileID, '%s',1,'delimiter', ',');
    idk = textscan(fileID, '%s',1,'delimiter', ',');
    na5 = textscan(fileID, '%s',1,'delimiter', ',');
    Mod = textscan(fileID, '%s',1,'delimiter', ',');
    Obs = textscan(fileID, '%s',1,'delimiter', ',');
    na6= textscan(fileID, '%s',1,'delimiter', ',');
    
    
    
    yesTime = size(Time1{1});
    yesStation = size(Station{1});
    yesLat = size(Lat{1});
    yesLon = size(Lon{1});
    yesObs = size(Obs{1});
   
    
    yesall = yesTime(1)+yesStation(1)+yesLat(1)+yesLon(1)+yesObs(1);
    
    
    if yesall == 5;
     dblchObs = size(str2num(cell2mat(Obs{1})));
        
        finTime = cell2mat(Time1{1});        
        finStation = cell2mat(Station{1});
        finLat = str2num(cell2mat(Lat{1}));
        finLon = str2num(cell2mat(Lon{1}));
        
        if dblchObs(2) > 1
            dblhold = str2num(cell2mat(Obs{1}));
        finObs = dblhold(1,2);
        else
        finObs = str2num(cell2mat(Obs{1}));
        end
        

    filebeg2 = [finTime(1:11)]
 
    
       if iter ==1;
          
    %Timename = [filebeg2,Timebeg, filendwrite];
     Stationname = [filebeg2,Stationbeg,filendwrite];
    %Latname = [filebeg2,Latbeg,filendwrite];
    %Lonname = [filebeg2,Lonbeg,filendwrite];
    Obsname = [filebeg2,Obsbeg,filendwrite];
     tl = tl+1;
    timlis{tl,1} = filebeg2;
           
           
       prev = '30010305_00' ;
       
    %TimeID = fopen((Timename), 'w');
     StationID = fopen((Stationname), 'w');
    %LatID = fopen((Latname), 'w');
    %LonID = fopen((Lonname), 'w');
    ObsID = fopen((Obsname), 'w');
       
        
        %fprintf(TimeID, '%s\n', finTime);
         fprintf(StationID, '%s\n', finStation);
        %fprintf(LatID, '%.001f \n', finLat);
        %fprintf(LonID, '%.001f \n', finLon);
        fprintf(ObsID, '%.001f \n', finObs);
        prev = filebeg2;
       else
        if filebeg2 ==prev;
            
            
           
        %fprintf(TimeID, '%s\n', finTime);
        fprintf(StationID, '%s\n', finStation);
        %fprintf(LatID, '%.001f \n', finLat);
        %fprintf(LonID, '%.001f \n', finLon);
        fprintf(ObsID, '%.001f \n', finObs);
         prev = filebeg2;
        else
             tl = tl+1;
           timlis{tl,1} = filebeg2
          
        %fclose(TimeID);
         fclose(StationID);
        %fclose(LatID);
        fclose(ObsID);
        
        
       %  Timename = [filebeg2,Timebeg, filendwrite];
     Stationname = [filebeg2,Stationbeg,filendwrite];
    %Latname = [filebeg2,Latbeg,filendwrite];
    %Lonname = [filebeg2,Lonbeg,filendwrite];
    Obsname = [filebeg2,Obsbeg,filendwrite];
            
         % TimeID = fopen((Timename), 'w');
     StationID = fopen((Stationname), 'w');
    %LatID = fopen((Latname), 'w');
    %LonID = fopen((Lonname), 'w');
    ObsID = fopen((Obsname), 'w');
       
        
        %fprintf(TimeID, '%s\n', finTime);
         fprintf(StationID, '%s\n', finStation);
        %fprintf(LatID, '%.001f \n', finLat);
        %fprintf(LonID, '%.001f \n', finLon);
        fprintf(ObsID, '%.001f \n', finObs);   
        prev = filebeg2;
        end
      
       end
    end
        
  
   
    end
    %fclose(TimeID)
%     fclose(StationID)
    %fclose(LatID)
    %fclose(LonID)
    fclose(ObsID)
    fclose(fileID)
   
    
  
end
%      save('hist.mat', 'timlis');
    
% %     %Build the station location index%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear
% clc
%     
%     series = ['20031214';'20040701';'20040820';'20040908'; ...
%      '20040917';'20040928';'20041104';'20041130';'20041225';'20050401'; ...
%      '20050628';'20050718';'20050721';'20050727';'20050804';'20050811'; ...
%      '20050916';'20050929';'20051007';'20051015';'20051024';'20060102'; ...
%      '20060114';'20060117';'20060216';'20060531';'20060606';'20060710'; ...
%      '20060716';'20060727';'20060801';'20060901';'20061027';'20061130'; ...
%      '20070301';'20070414';'20070515';'20070531';'20070709';'20070714'; ...
%      '20070729';'20070816';'20071202';'20080113';'20080212';'20080308'; ...
%      '20080320';'20080526';'20080608';'20080610';'20080613';'20080622'; ...
%      '20080717';'20080722';'20080726';'20080805';'20080906';'20081025'; ...
%      '20081210';'20081230';'20090107';'20090509';'20090625';'20090706'; ...
%     '20090723';'20090729';'20090731';'20090821';'20091006';'20091127'; ...
%      '20100223';'20100313';'20100428';'20100503';'20100504';'20100507'; ...
%      '20100525';'20100602';'20100604';'20100605';'20100705';'20100721'; ...     
%      '20100929';'20101225';'20110111';'20110117';'20110201';'20110601'; ...
%      '20110608';'20110828';'20111028';'20120622';'20121028';'20121107'; ...
%      '20121228';'20130130';'20130208';'20130511';'20130523';'20130525'; ...
%      '20130529';'20130607';'20130613';'20130901';'20131031';'20131118'; ...
%      '20131126';'20140106';'20140110';'20140204'];
% 
% filend = '.csv';
% filendwrite = '.txt';
% it = 0;
% sizeSeries = size(series);
% 
% for u = 1:sizeSeries(1);
%      % num = num2str(j-1) Probably not relevant
%     %filename = [filebeg,num,filend]
%     
%     filebeg  = (series(u,:));
%     filename = [filebeg,filend];
%     fileID = fopen((filename), 'r');
%     
%     
%    % headers =textscan(fileID, '%s',13,'delimiter', '\t');
%    %There are no headers in the first file (check 10)
%    %disp(values{1});
%     
%     
%     %clearvars InputText Data
% 
% Block = 1;
%     iter = 0;
%     while(~feof(fileID));
%             
%             InputText =textscan(fileID, '%s',31,'delimiter', ',');
%             Data{Block,1} = InputText{1};
%             Block = Block+1;
%             
%         end
%         fclose(fileID);
%         clearvars sizeData;
%         sizeData = size(Data);
%         
%         
%         for i = 1:sizeData(1);
%             it = it+1;
%             allatt = Data{i,1};
%             tito = size(allatt);
%             
%             if tito(1)>0
%             sizeaa = size(allatt{24});
%             %disp(allatt{24})
%             if sizeaa(1)>0;
%                 test = char({allatt{24,1}});
%                 sizetest = size(test);
%                 stats(it,1) = {allatt{24,1}};
%                 stalist{it,1} = allatt{24,1};%station
%                 stalist{it,2} = allatt{25,1};%lat
%                 stalist{it,3} = allatt{26,1};%lon
%             end
%             end
%             sisst = size(stats);
%             if it > 1
%             for j = (sisst(1)-1):-1:1
%                 sizeinit = size(char(stats(j,1)));
%                 if sizetest(2) == sizeinit(2);
%                 if test == char(stats(j,1));
% %                     disp(test)
% %                     disp(char(stats(j,1)))
%                     it = it-1;
%                 end
%                 end
%             end
%             end
%                 
%             
%             
%         end
%         
% end
%     mat = stalist
%     sizets = size(stalist);
%     
%     stations =stats;
%     %= unique(stats);
%     
%     numstats = size(stations);
%     
%     for i = 1:numstats(1)
%         
%         test = stations{i,1};
%         sizetest = size(test);
%         strsiztest = sizetest(2);
%         
%         for j = 1:sizets(1);
%             check = stalist{j,1};
%             sizecheck = size(check);
%             strsizcheck = sizecheck(2);
%             
%             if strsiztest == strsizcheck;
%                 if check == test;
%                     ii = i+1;
%                     mat{ii,1} = stalist{j,1};
%                     mat{ii,2} = stalist{j,2};
%                     mat{ii,3} = stalist{j,3};
%                 end
%             end
%         end
%     end
%     
%     mat{1,1} = 'Stat';
%     mat{1,2} = 'Lat';
%     mat{1,3} =  'Lon';
%     
%     save('index.mat', 'mat');
%     
%     
%     
%     
