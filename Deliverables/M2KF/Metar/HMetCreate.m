%Elim to MadCR conversion
filename = 'MetCRno.csv';
fileID = fopen(filename, 'r');
RefLis=1;
% folder='M03d2'
    while(~feof(fileID));
            
            InputText =textscan(fileID, '%s',5,'delimiter', ',');
            CRlist{RefLis,1} = InputText{1};
            if size(InputText{1}) > 0;
            RefLis = RefLis+1;
            end
    end
        
    fclose(fileID);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Loop By HElim
for storm = 1:11
     matchtick =0;
   stoArray=[6,16,29,39,44,57,64,69,81,96,105];%
   storm2=stoArray(storm)
    STstring=num2str(stoArray(storm));
    BySTatFo=['WindBStat',STstring];

ElimName=['HElim',STstring,'.csv'];
    MaxName= ['MaxReps',STstring,'.csv'];
    
    ElimFo = fullfile(BySTatFo,ElimName);
    Reps=dlmread(fullfile(BySTatFo,MaxName));
    RMval=(Reps(1,1));
    howmany=0;
    ElimID=fopen(ElimFo,'r');
    Elimnum = 1;
    while(~feof(ElimID));
        % %Test this before running main code
          howmany=howmany+1
        
        if (RMval+1)==1
            STelim2 =textscan(ElimID, '%s',1,'delimiter', ',');
        end
      
        
        if (RMval+1)==2
            STelim2 =textscan(ElimID, '%s %s','Delimiter',',');
        end
        
        if (RMval+1)==3
            STelim2 =textscan(ElimID, '%s %s %s',1,'delimiter', ',');
        end
        
        if (RMval+1)==3
            error('New Maximum >3')
        end
        
     
    end
    fclose(ElimID)
%Starting with 6.


endrows=size(STelim2{1,1})

for cols=1:(Reps+1)
    
    for rows=1:endrows
        hold=STelim2{1,cols};
        
        test = hold{rows,1}
        
        
        for madrows=1:(RefLis-1)
            
            %what about whitespace?
            check=CRlist{madrows,1};
            checkstat=cell2mat(check(1))
            
            testST=size(test)
            checkST=size(checkstat);
            if testST==checkST
            if test==checkstat
                matchtick = matchtick+1;
                HMadCRLoc(matchtick,1)=madrows
            end
            end
        end
    end
end

dlmwrite(['HMetLoc',num2str(storm2),'.txt'], HMadCRLoc)
clearvars HMadCRLoc

end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 
% filnSTtr=['HtrST',filebeg,filend2];
% filnCtr = ['HtrC',filebeg,filend2];
% filnRtr = ['HtrR',filebeg,filend2];
% filnFFtr= ['HtrFF',filebeg,filend2];
% 
% 
% 
% CID = fopen(fullfile('G:','CV62015Cast',CompFo,AdjFo,(filnCtr)), 'r');
% RID = fopen(fullfile('G:','CV62015Cast',CompFo,AdjFo,(filnRtr)), 'r');
% ffID = fopen(fullfile('G:','CV62015Cast',CompFo,AdjFo,(filnFFtr)), 'r');
% 
% 
% while(~feof(CID));
%         
%         ColMad =textscan(CID, '%f',1,'delimiter', '\t');
%         sizeCMAD = size(ColMad{1});
%         if sizeCMAD(1)>0;
%             C{Cit,1} = ColMad{1};
%             Cit = Cit+1;
%         end
%     end
%     
%     while(~feof(RID));
%         
%         RowMad =textscan(RID, '%f',1,'delimiter', '\t');
%         sizeRMAD = size(RowMad{1});
%         if sizeRMAD(1)>0;
%             R{Rit,1} = RowMad{1};
%             Rit = Rit+1;
%         end
%     end
%     
%     while(~feof(ffID));
%        
%         ffMad =textscan(ffID, '%f',1,'delimiter', '\t');
%         sizeffMAD = size(ffMad{1});
%         if sizeffMAD(1)>0;
%             ff{ffit,1} = ffMad{1};
%             ffit = ffit+1;
%         end
%     end
%     
%        fclose(CID);
%     fclose(RID);
%     fclose(ffID);

