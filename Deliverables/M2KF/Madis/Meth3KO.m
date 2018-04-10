clear
clc

folder = 'M03d2MadFin'
folder2='ForCVFin'
mkdir(folder2)

  firstArray=dlmread('firstarray2.txt')
    lastArray=dlmread('lastarray2.txt')
    
 STCVname='FC24JS.txt';
STCVID=fopen(STCVname,'r');
timnam = 1;
while(~feof(STCVID));
    
    InputText =textscan(STCVID, '%s',1,'delimiter', ',');
    TimeCell{timnam,1} = InputText{1};
    timnam = timnam+1;
    
end

fclose(STCVID);   
    
stoArray=[6,16,29,39,44,57,64,69,81,96,105];%
%note you are only doing one hour of the storm bc looking
%at what the head staions are
for storm =1:11
    
    conv1 = firstArray(storm,1);
    conv2=lastArray(storm,1);
    diff=conv2-conv1;
    storm2=stoArray(storm);
     filebeg  = cell2mat(TimeCell{conv1,1});
    
    tich=0;
    dudstick=0;
    clearvars Obsarr KFarr
    
    
   %Need to adjust names to stoArray style
    HMadCRLoc2=dlmread(['HMadLoc',num2str(storm2),'.txt'])
    HMadCRLoc=unique(HMadCRLoc2);
    

    sizeHMad=size(HMadCRLoc)
    
    for headloop=1:sizeHMad
        
%         Rnum=R{headloop,1};
%         Cnum=C{headloop,1};
%         Rclose = round(Rnum);
%         Cclose = round(Cnum);
%         LocClose = (Cclose-1)*330 + Rclose;
        
LocClose=HMadCRLoc(headloop,1);


        %Read locclose file
        test=exist(fullfile(folder,['LocOut',num2str(LocClose),'.txt']));
        %test2=exists(fullfile(folder,['LocOut',num2str(LocClose),'.txt']));
        if test>1
            
            times=dlmread(fullfile(folder,['LocOut',num2str(LocClose),'.txt']));
            sizetimes=size(times)
        for checks=1:sizetimes(1)
            
                
            if times(checks)==conv1
            if checks>24   
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
                    Obsar(tich,1)=Obs(obsit,1);
                    WRFar(tich,1)=WRF(obsit,1);
                    %Note Obs is the Kalman input on the same history
                    KFarr(tich,1)=Kal((obsit-24),1);
                   
                    Loarr(tich,1)=LocClose;
                    else
                        error('not historying well')
                    end
                    
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
    %%%%%%%%%%%%%%%%%%%%%%
    dlmwrite(fullfile(folder2,['Obsar',num2str(storm2),'.txt']),Obsar);
    dlmwrite(fullfile(folder2,['WRFar',num2str(storm2),'.txt']),WRFar);
    dlmwrite(fullfile(folder2,['KFarr',num2str(storm2),'.txt']),KFarr);
    dlmwrite(fullfile(folder2,['Loarr',num2str(storm2),'.txt']),Loarr);
    
    
    if dudstick>0
        dlmwrite(fullfile(folder2,['Duds',num2str(storm2),'.txt']),Duds);
    end
    clearvars Duds Obsar KFarr Loarr
    
    %%%%%%%%%%%%%%%%%%%%%
end

                    
                
    
        
        
        
        
        
        
    
    
    