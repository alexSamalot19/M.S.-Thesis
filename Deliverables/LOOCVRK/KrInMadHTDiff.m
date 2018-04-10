% clear
% clc
% 
% folderin='M03d2MadFin';
% folderout='KrInMadFE';
% mkdir(folderout);
% 
% %GCRead%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GC=dlmread(fullfile(folderin,'GClistM32.txt'));
% 
% %Read MadisCRno%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% filename = 'MadisCRno.csv';
% fileID = fopen(filename, 'r');
% RefLis=1;
% folder='M03d2'
%     while(~feof(fileID));
%             
%             InputText =textscan(fileID, '%s',5,'delimiter', ',');
%             CRlist{RefLis,1} = InputText{1};
%             if size(InputText{1}) > 0;
%             RefLis = RefLis+1;
%             end
%     end
%         
%     fclose(fileID);
%     
% 
%   
% %Read the timeseries%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STCVname='FC24JS.txt';
% STCVID=fopen(STCVname,'r');
% timnam = 1;
% while(~feof(STCVID));
%     
%     InputText =textscan(STCVID, '%s',1,'delimiter', ',');
%     TimeCell{timnam,1} = InputText{1};
%     timnam = timnam+1;
%     
% end
% 
% fclose(STCVID);
% 
% 
% 
% matrix=ones((timnam-1),(RefLis-1)).*100000;
% tickloc=0;
% 
% sizeGC=size(GC);
% 
% for i=1:sizeGC(1);
%     WRFbeg='ModTom';
%     Locbeg='LocOut';
%     Kalbeg='modeltom_filt';
%     GCloc=num2str(GC(i));
%     ender='.txt';
%     fWRF=[WRFbeg,GCloc,ender];
%     floc=[Locbeg,GCloc,ender];
%     fkal=[Kalbeg,GCloc,ender];
%     
%     Location=dlmread(fullfile(folderin,floc));%this is a badly worded time
%     Kalman=dlmread(fullfile(folderin,fkal));
%    modelTom=dlmread(fullfile(folderin,fWRF));
%     sizekal=size(Location);
% %     error('test sizes')
%     tickKal=0;
%     
%     for j=1:sizekal(1)
%          SILO=size(Location)
%         if (j+24)<=SILO(1)
%          if Location(j+24)<4872
%         tickKal=tickKal+1;
%         tickloc=tickloc+1;
%         matrix((Location(j+24)),GC(i))=Kalman(tickKal,1)-modelTom(tickKal,1);
%        % disp(Kalman(tickKal,1))
%         LocMat(tickloc,1)=(Location(j)+24);
% %         if (Location(j)+24)==124
% %             error('break124')
% %         end
%          end
%         end
%     end
% end
%     
%      dlmwrite('KalMadisDiff.txt',matrix);
% % %      dlmwrite('LocMatMad.txt',LocMat);
% % % 
% % %     
% % %      error('break')
% %      
  clear
  clc
     ender='.txt';
     mkdir('KrInMadDiff')
     folderout='KrInMadDiff'
     
  % %Read the timeseries%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
STCVname='FC24JS.txt';
STCVID=fopen(STCVname,'r');
timnam = 1;
while(~feof(STCVID));
    
    InputText =textscan(STCVID, '%s',1,'delimiter', ',');
    TimeCell{timnam,1} = InputText{1};
    timnam = timnam+1;
    
end

fclose(STCVID);
         
     
     
%Read%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
matrix=dlmread(fullfile('OutTrimDiff','RemMaxMad.csv'));
% LocMad=dlmread(fullfile('OutTrimFE','LocMad.csv'));

%Read MadisCRno%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
filename = 'RemEdMad.csv';
fileID = fopen(fullfile('OutTrimDiff',filename), 'r');
RefLis=1;

    while(~feof(fileID));
            
            InputText =textscan(fileID, '%s',5,'delimiter', ',');
            CRlist{RefLis,1} = InputText{1};
            if size(InputText{1}) > 0;
            RefLis = RefLis+1;
            end
    end
        
    fclose(fileID);
    NoTail=zeros(timnam-1);
 % error('break and look at values')
  
%     LocSort=sort(LocMat);
%     LocUniq=unique(LocSort)
%     Locview=LocUniq(1:1000,1)
    NewSizeMad=size(matrix)


    for k=25:(timnam-1)
        
       filetime= cell2mat(TimeCell{k,1})
       
       fcname=['HMadC',filetime,ender];
       frname=['HMadR',filetime,ender];
       FFname=['HMadff',filetime,ender];
       STname=['HMadST',filetime,ender];
       
       CID=fopen(fullfile(folderout,fcname),'w');
       RID=fopen(fullfile(folderout,frname),'w');
       FFID=fopen(fullfile(folderout,FFname),'w');
       STID=fopen(fullfile(folderout,STname),'w');
       
       
%        fcname2=['TMadC',filetime,ender];
%        frname2=['TMadR',filetime,ender];
%        FFname2=['TMadff',filetime,ender];
%        STname2=['TMadST',filetime,ender];
%        
%        CID2=fopen(fullfile(folderout,fcname),'w');
%        RID2=fopen(fullfile(folderout,frname),'w');
%        FFID2=fopen(fullfile(folderout,FFname),'w');
%        STID2=fopen(fullfile(folderout,STname),'w');
       
       
       
       exi=0;
       exi2=0;
       for l=1:(NewSizeMad(2))
           
           if matrix(k,l)<100000
               
               
%                if LocMad(k,l)<100000
               exi=exi+1;
               %Madis doodles
               holdd=CRlist{l,1}
       
               Cnum=holdd{4,1}
               Rnum=holdd{5,1}
               Rkri = str2num(Rnum)
               Ckri = str2num(Cnum)
               sta=holdd{1,1}
               %%%%%%%%%%%%
               %fprintf('Its working?')
              % disp(matrix(k,l))
               %disp(Ckri)
               if matrix(k,1) < -1000
                   error('really high negative')
               end
               
%                error('what is the 1st value?')
               fprintf(CID,'%f\n', Ckri);
               fprintf(RID,'%f\n', Rkri);
               fprintf(FFID,'%f\n', matrix(k,l));
               fprintf(STID,'%s\n',sta);
%                else
%                    exi2=exi2+1;
%                    
%                    
%                     %Madis doodles
%                holdd=CRlist{l,1}
%        
%                Cnum=holdd{4,1}
%                Rnum=holdd{5,1}
%                Rkri = str2num(Rnum)
%                Ckri = str2num(Cnum)
%                sta=holdd{1,1}
%                %%%%%%%%%%%%
%                %fprintf('Its working?')
%               % disp(matrix(k,l))
%                %disp(Ckri)
%                
%                fprintf(CID2,'%f\n', Ckri);
%                fprintf(RID2,'%f\n', Rkri);
%                fprintf(FFID2,'%f\n', matrix(k,l));
%                fprintf(STID2,'%s\n',sta);
%                    
%                    
%                    
%                end
               
           end
       end
      
       if exi>0
       fclose(CID)
       fclose(RID)
       fclose(FFID)
       fclose(STID)
       else
           error('nodata')
       end
       
%           if exi2>0
%        fclose(CID2)
%        fclose(RID2)
%        fclose(FFID2)
%        fclose(STID2)
%        else
%           NoTail(k)=NoTail(k)+1;
%        end
       
    
    end
%     dlmwrite('NoTail.csv',NoTail)

%        disp('do you want to save NoTail?');

       
       
       
       
       
       
       
        
    
    
    
    
    
    
    
    



  
        
    
    
    
    
    
    
    
    



