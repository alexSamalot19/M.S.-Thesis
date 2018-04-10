% %Running DACE
% load 'NEMO SortWKSP.mat'
clear
clc
mkdir('wfNMIn')
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

filend = '.txt';
filend2 = '.txt';

for u = 1:(timnam-1)
    
    
    disp(u)
    
    clearvars ColMad C RowMad R ffMad ff S Y 
        
    Cit = 1;
    Rit = 1;
    ffit = 1;
        
    filebeg  = cell2mat(TimeCell{u,1});
    
   filnCtr = ['trC',filebeg,filend2];
   filnRtr = ['trR',filebeg,filend2];
   filnFFtr= ['trFF',filebeg,filend2];
  
   CmIDtr = fopen(fullfile('wNMtr',(filnCtr)), 'r');
   RmIDtr = fopen(fullfile('wNMtr',(filnRtr)), 'r');
   FFmIDtr = fopen(fullfile('wNMtr',(filnFFtr)), 'r'); 
        
    while(~feof(CmIDtr));
        
        ColMad =textscan(CmIDtr, '%s',1,'delimiter', '\t');
        sizeCMAD = size(ColMad{1});
        if sizeCMAD(1)>0;
            C{Cit,1} = ColMad{1};
            Cit = Cit+1;
        end
    end
    
   while(~feof(RmIDtr));
        
        RowMad =textscan(RmIDtr, '%s',1,'delimiter', '\t');
        sizeRMAD = size(RowMad{1});
        if sizeRMAD(1)>0;
            R{Rit,1} = RowMad{1};
            Rit = Rit+1;
        end
    end
    
    while(~feof(FFmIDtr));
        
        ffMad =textscan(FFmIDtr, '%s',1,'delimiter', '\t');
        sizeffMAD = size(ffMad{1});
        if sizeffMAD(1)>0;
            ff{ffit,1} = ffMad{1};
            ffit = ffit+1;
        end
    end 
  
fclose(CmIDtr);
fclose(RmIDtr);
fclose(FFmIDtr);

sw = ffit-1;

    for q = 1:sw;
        Y(q,1) = str2num(cell2mat(ff{q,1}));
    end  
    
    for i = 1:sw;
        
            S(i,1) = str2num(cell2mat(C{i,1}));
            S(i,2) = str2num(cell2mat(R{i,1}));
       
    end

 
      



theta = [10 10];
%lower boundary for theta guesses
lob = [1e-100 1e-100];
%Upper boundary for theta guesses
upb = [1000 1000];


% %%Running(comment this out when initializing, comment out initalization%
% %runs the model with 
[dmodel, perf] = ...
    dacefit(S, Y, @regpoly2, @correxp, theta, lob, upb);




%%Graph comment out the model run and initailization%%%%%%%%%%%%%%%%%%%%%%%%%%
%Pick bounds that would make an appropriate grid for the data you have

% Lower 2D to upper 2D, slightly above highest Y value
X = gridsamp([0, 0;330 330], 330);
[YX MSE] = predictor(X, dmodel);
X1 = reshape(X(:,1),330, 330);   
X2 = reshape(X(:,2),330, 330);
YX = reshape(YX, size(X1));



  figure(1),  mesh(X1, X2, YX)
% % hold on,
% % plot3(S(:,1),S(:,2),Y,'.k', 'MarkerSize',330)
% % hold off
% titl=[filebeg,'Kriged Obs']
% title(titl)
% xlabel('WRF Cell Location Row')
% ylabel('WRF Cell Location Column')
% zlabel('Observed Wind (m/s)')
% 
 wkspc = fullfile('wfNMIn',[filebeg,'Krig.mat']);
% gcf = [filebeg,'Obs.pdf']
% nMSE = [filebeg,'MSE.pdf']


% bias = [
% saveas(gcf, bias)

    

%Alternate model???
%[emodel perf] = dacefit(S, Y, @regpoly0, @correxp, 2)
    
%     % %MSE graph comment out rest and run%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MSEnew = reshape(MSE, size(X1));
% % 
% figure(2),  mesh(X1, X2, reshape(MSE, size(X1)))
% xlabel('WRF Cell Location Row')
% ylabel('WRF Cell Location Column')
% zlabel('Observed Wind MSE (m/s)')
% msetitles=[filebeg, 'MSE of Kriging']
% title(msetitles)
% 
% saveas(gcf, nMSE)
save(wkspc);
end


 
