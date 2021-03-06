clear
clc

folder ='M03d2Met'
folder2='ForCVTEST'
mkdir(folder2)

  firstArray=dlmread('firstarray111.txt');
    lastArray=dlmread('lastarray111.txt');
    
 STCVname='FC24JS.txt';
STCVID=fopen(STCVname,'r');
timnam = 1;
while(~feof(STCVID));
    
    InputText =textscan(STCVID, '%s',1,'delimiter', ',');
    TimeCell{timnam,1} = InputText{1};
    timnam = timnam+1;
    
end

fclose(STCVID);   

%Elim to MadCR conversion
filename = 'MetCRno.csv';
fileID = fopen(filename, 'r');
RefLis=1;
% folder='M03d2'
while(~feof(fileID));
    
    InputText2 =textscan(fileID, '%s',5,'delimiter', ',');
    CRlist{RefLis,1} = InputText2{1};
    if size(InputText2{1}) > 0;
        RefLis = RefLis+1;
    end
end

fclose(fileID);

    
stoArray=[6,16,29,39,44,57,64,69,81,96,105];%
%note you are only doing one hour of the storm bc looking
%at what the head staions are
for storm =67:111
    STstring=num2str(storm)
    BySTatFo2=['BiasBS111',STstring];
    conv1 = firstArray(storm,1);
    conv2=lastArray(storm,1);
    diff=conv2-conv1;
    storm2=storm;
     filebeg  = cell2mat(TimeCell{conv1,1});
    
    
    dudstick=0;
    
    
    
   %Need to adjust names to stoArray style
    HMadCRLocRep=dlmread(['HMetLoc',num2str(storm2),'.txt'])
    HMadCRLoc=unique(HMadCRLocRep)
    

    sizeHMad=size(HMadCRLoc)
    
    for headloop=1:sizeHMad
        tich=0;
        clearvars Obsarr KFarr WRFar

%         Rnum=R{headloop,1};
%         Cnum=C{headloop,1};
%         Rclose = round(Rnum);
%         Cclose = round(Cnum);
%         LocClose = (Cclose-1)*330 + Rclose;
        
LocClose=HMadCRLoc(headloop,1);

        %Read locclose file
        test=exist(fullfile(folder,['LocOut',num2str(LocClose),'.txt']))
        %error('break to see file')
        %test2=exists(fullfile(folder,['LocOut',num2str(LocClose),'.txt']));
        if test>1
%             error('analyze what is happening to the values')
            times=dlmread(fullfile(folder,['LocOut',num2str(LocClose),'.txt']));
            sizetimes=size(times)
        for checks=1:sizetimes(1)
            
                
            if times(checks)==conv1
            if checks>24   
                tich2=0;
                 Obs=dlmread(fullfile(folder,['Obs',num2str(LocClose),'.txt']));
                 WRF=dlmread(fullfile(folder,['ModYes',num2str(LocClose),'.txt']));
                 Kal=dlmread(fullfile(folder,['modeltom_filt',num2str(LocClose),'.txt']));
                 %code will error out if there are any stations that the
                 %head station is the first station in the Kalman history
                 %unlikely but possible and notified
                 
                   obsdone=conv1-1;
                for obsit=checks:(checks+diff)
                    kalit=times(obsit);
                    obsdone=obsdone+1;
                    if obsdone==kalit
                    tich=tich+1;
%                     tich2=tich2+1
%                     if tich2>48
%                         error('toobig')
%                     end
                    Obsar(tich,1)=Obs(obsit,1);
                    WRFar(tich,1)=WRF(obsit,1);
                    %Note Obs is the Kalman input on the same history
                    KFarr(tich,1)=Kal((obsit-24),1);
                  
                    Loarr(tich,1)=LocClose;
%                     else
%                         error('not historying well')
                    end
                    
                end
                if tich>0
%                             LName=CRlist(LocClose)
%                             lname=LName(1,1)
                           
                            check=CRlist{LocClose,1};
                            lname=cell2mat(check(1))

                            %filenames
                            JKO=['MetarrObs',lname,'.csv'];
                            JKW=['MetarrWRF',lname,'.csv'];
                            JKK=['MetarrKal',lname,'.csv'];
%                             error('look at outputs')
                            %write a matrix
                             dlmwrite(fullfile(BySTatFo2,JKO),Obsar)
                             dlmwrite(fullfile(BySTatFo2,JKW),WRFar)
                             dlmwrite(fullfile(BySTatFo2,JKK),KFarr)
%                                error('is lname correct?')                           
                            % %<<
                        end
                
                
                
                
            else
                dudstick=dudstick+1;
                Duds(dudstick,1)=LocClose %is the MadisCRno Location of the missed station
                %where to put the dlmwrite function????
                              
                
            end
        end
        end
    end
    end
    % error('Break to see values')
    %%%%%%%%%%%%%%%%%%%%%%
%     dlmwrite(fullfile(folder2,['ObsarT',num2str(storm2),'.txt']),Obsar);
%     dlmwrite(fullfile(folder2,['WRFarT',num2str(storm2),'.txt']),WRFar);
%     dlmwrite(fullfile(folder2,['KFarrT',num2str(storm2),'.txt']),KFarr);
%     dlmwrite(fullfile(folder2,['LoarrT',num2str(storm2),'.txt']),Loarr);
%     
%     
    if dudstick>0
        dlmwrite(fullfile(folder2,['Duds',num2str(storm2),'.txt']),Duds);
    end
    clearvars Duds Obsar KFarr Loarr
    
    %%%%%%%%%%%%%%%%%%%%%
end

                    
                
    
        
        
        
        
        
        
    
    
    