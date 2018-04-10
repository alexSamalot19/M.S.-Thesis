for storm=1:11;
    
clearvars -except storm
DriveInfo=fullfile('media','alex','My Passport')
CompArray=['CEELab20';'CEELab26';'CEELab27';'CEELab05';'CEELab22'; ...
'CEELab23';'CEELab06';'CEELab21';'CEELab24';'CEELab07';'CEELab25'];%
stoArray=[6,16,29,39,44,57,64,69,81,96,105];%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
RN=stoArray(storm)%Rand #
string=num2str(RN);
COMP=CompArray(storm,:);
starTime=RN
STstring=string
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AdjFo=['WindCombOut',STstring];
ZfFo=['ZfKrig',STstring];

FiMetIn = ['20010305';'20031214';'20040701';'20040820';'20040908'; ...
    '20040917';'20040928';'20041104';'20041130';'20041225';'20050401'; ...
    '20050628';'20050718';'20050721';'20050727';'20050804';'20050811'; ...
    '20050916';'20050929';'20051007';'20051015';'20051024';'20060102'; ...
    '20060114';'20060117';'20060216';'20060531';'20060606';'20060710'; ...
    '20060716';'20060727';'20060801';'20060901';'20061027';'20061130'; ...
    '20070301';'20070414';'20070515';'20070531';'20070709';'20070714'; ...
    '20070729';'20070816';'20071202';'20080113';'20080212';'20080308'; ...
    '20080320';'20080526';'20080608';'20080610';'20080613';'20080622'; ...
    '20080717';'20080722';'20080726';'20080805';'20080906';'20081025'; ...
    '20081210';'20081230';'20090107';'20090509';'20090625';'20090706'; ...
    '20090723';'20090729';'20090731';'20090821';'20091006';'20091127'; ...
    '20100223';'20100313';'20100428';'20100503';'20100504';'20100507'; ...
    '20100525';'20100602';'20100604';'20100605';'20100705';'20100721'; ...
    '20100929';'20101225';'20110111';'20110117';'20110201';'20110601'; ...
    '20110608';'20110828';'20111028';'20120622';'20121028';'20121107'; ...
    '20121228';'20130130';'20130208';'20130511';'20130523';'20130525'; ...
    '20130529';'20130607';'20130613';'20130901';'20131031';'20131118'; ...
    '20131126';'20140106';'20140110';'20140204'];

%Read the Storms time list
filebeg  = (FiMetIn(RN,:));
STCVname=[filebeg,'SC24.txt'];
STCVID=fopen(fullfile('CEELab05','storm',STCVname),'r');
timnam = 1;
while(~feof(STCVID));
    
    InputText =textscan(STCVID, '%s',1,'delimiter', ',');
    TimeCell{timnam,1} = InputText{1};
    timnam = timnam+1;
    
end

fclose(STCVID);
% %
filend = '.txt';
filend2 = '.txt';

for u = 1:(timnam-2)%ile
    %(timnam-1)
    
    
    disp(u)
    
    clearvars ColMad C RowMad R ffMad ff S Y 
        
    Cit = 1;
    Rit = 1;
    ffit = 1;
        
    filebeg  = cell2mat(TimeCell{u,1});
    
    ileit = num2str(u);
    
   filnCtr = ['HtrC',filebeg,filend2];
   filnRtr = ['HtrR',filebeg,filend2];
   filnFFtr= ['HtrFF',filebeg,filend2];
  
   CmIDtr = fopen(fullfile(COMP,AdjFo,(filnCtr)), 'r');
   RmIDtr = fopen(fullfile(COMP,AdjFo,(filnRtr)), 'r');
   FFmIDtr = fopen(fullfile(COMP,AdjFo,(filnFFtr)), 'r'); 
        
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
YX2 = YX;
YX = reshape(YX, size(X1));



  %figure(1),  mesh(X1, X2, YX);
% % hold on,
% % plot3(S(:,1),S(:,2),Y,'.k', 'MarkerSize',330)
% % hold off
% titl=[filebeg,'Kriged Obs']
% title(titl)
% xlabel('WRF Cell Location Row')
% ylabel('WRF Cell Location Column')
% zlabel('Observed Wind (m/s)')
% 
% clearvars -except YX
%  wkspc = fullfile('CVkrigs',[ileit,'Krig.mat']);
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
% save(wkspc);

yxn=[filebeg,'loiyx.txt'];
msee=[filebeg,'loimse.txt'];
locat=[filebeg,'loiCR.txt'];
orig=[filebeg,'loiff.txt'];


dlmwrite(fullfile(COMP,ZfFo,yxn),YX2);
dlmwrite(fullfile(COMP,ZfFo,msee),MSE);
dlmwrite(fullfile(COMP,ZfFo,locat),S);
dlmwrite(fullfile(COMP,ZfFo,orig),Y);


end
end

 
