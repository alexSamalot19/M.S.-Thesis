% % %1-35 Comment out first section>>
% dlmwrite('fihaBTKal.txt',BTKal);
% dlmwrite('fihaBTwrfL.txt',BTwrf);
% dlmwrite('fihaBTpKal.txt',BTpKal);
% 
% dlmwrite('fihaBTsqKal.txt',BTsqKal);
% dlmwrite('fihaBTsqwrf.txt',BTsqwrf);
% dlmwrite('fihaBTsqpKal.txt',BTsqpKal);
% 
% dlmwrite('fihaDRDsqKal.txt',DRDsqKal);
% dlmwrite('fihaDRDsqpKal.txt',DRDsqpKal);
% dlmwrite('fihaDRDsqwrf.txt',DRDsqwrf);
% 
% dlmwrite('fihaDRDKal.txt',DRDKal);
% dlmwrite('fihaDRDpKal.txt',DRDpKal);
% dlmwrite('fihaDRDwrf.txt',DRDwrf);
% 
% dlmwrite('fihaDRKal.txt',DRKal);
% dlmwrite('fihaDRwrf.txt',DRwrf);
% dlmwrite('fihaDRpKal.txt',DRpKal);
% dlmwrite('fihaDRlatFFArray.txt',DRlatFFArray);
% 
% 
% save('fiha111.mat')
% fprintf('ran first')
% 
% % % % %<<
% % 



% % %36:69 Comment out other section>>
% dlmwrite('sechaBTKal.txt',BTKal);
% dlmwrite('sechaBTwrf.txt',BTwrf);
% dlmwrite('sechaBTpKal.txt',BTpKal);
% 
% dlmwrite('sechaBTsqKal.txt',BTsqKal);
% dlmwrite('sechaBTsqwrf.txt',BTsqwrf);
% dlmwrite('sechaBTsqpKal.txt',BTsqpKal);
% 
% dlmwrite('sechaDRDsqKal.txt',DRDsqKal);
% dlmwrite('sechaDRDsqpKal.txt',DRDsqpKal);
% dlmwrite('sechaDRDsqwrf.txt',DRDsqwrf);
% 
% dlmwrite('sechaDRDKal.txt',DRDKal);
% dlmwrite('sechaDRDpKal.txt',DRDpKal);
% dlmwrite('sechaDRDwrf.txt',DRDwrf);
% 
% dlmwrite('sechaDRKal.txt',DRKal);
% dlmwrite('sechaDRwrf.txt',DRwrf);
% dlmwrite('sechaDRpKal.txt',DRpKal);
% dlmwrite('sechaDRlatFFArray.txt',DRlatFFArray);
% 
% save('secha111.mat')
% fprintf('ran second')
% % %>>

% % 
% % %70-109 Comment out other section>>
dlmwrite('thrhaBTKal.txt',BTKal);
dlmwrite('thrhaBTwrf.txt',BTwrf);
dlmwrite('thrhaBTpKal.txt',BTpKal);

dlmwrite('thrhaBTsqKal.txt',BTsqKal);
dlmwrite('thrhaBTsqwrf.txt',BTsqwrf);
dlmwrite('thrhaBTsqpKal.txt',BTsqpKal);

dlmwrite('thrhaDRDsqKal.txt',DRDsqKal);
dlmwrite('thrhaDRDsqpKal.txt',DRDsqpKal);
dlmwrite('thrhaDRDsqwrf.txt',DRDsqwrf);

dlmwrite('thrhaDRDKal.txt',DRDKal);
dlmwrite('thrhaDRDpKal.txt',DRDpKal);
dlmwrite('thrhaDRDwrf.txt',DRDwrf);

dlmwrite('thrhaDRKal.txt',DRKal);
dlmwrite('thrhaDRwrf.txt',DRwrf);
dlmwrite('thrhaDRpKal.txt',DRpKal);
dlmwrite('thrhaDRlatFFArray.txt',DRlatFFArray);
save('thrha111.mat')
fprintf('ran third')
% % % %>>
% 
% 



% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
clc

%Read files>>
BTKal4=dlmread('thrhaBTKal.txt');
BTwrf4=dlmread('thrhaBTwrf.txt');
BTpKal4=dlmread('thrhaBTpKal.txt');

BTsqKal4=dlmread('thrhaBTsqKal.txt');
BTsqwrf4=dlmread('thrhaBTsqwrf.txt');
BTsqpKal4=dlmread('thrhaBTsqpKal.txt');

DRDsqKal4=dlmread('thrhaDRDsqKal.txt');
DRDsqpKal4=dlmread('thrhaDRDsqpKal.txt');
DRDsqwrf4=dlmread('thrhaDRDsqwrf.txt');

DRDKal4=dlmread('thrhaDRDKal.txt');
DRDpKal4=dlmread('thrhaDRDpKal.txt');
DRDwrf4=dlmread('thrhaDRDwrf.txt');

DRKal4=dlmread('thrhaDRKal.txt');
DRwrf4=dlmread('thrhaDRwrf.txt');
DRpKal4=dlmread('thrhaDRpKal.txt');
DRlatFFArray4=dlmread('thrhaDRlatFFArray.txt');




BTKal3=dlmread('sechaBTKal.txt');
BTwrf3=dlmread('sechaBTwrf.txt');
BTpKal3=dlmread('sechaBTpKal.txt');

BTsqKal3=dlmread('sechaBTsqKal.txt');
BTsqwrf3=dlmread('sechaBTsqwrf.txt');
BTsqpKal3=dlmread('sechaBTsqpKal.txt');

DRDsqKal3=dlmread('sechaDRDsqKal.txt');
DRDsqpKal3=dlmread('sechaDRDsqpKal.txt');
DRDsqwrf3=dlmread('sechaDRDsqwrf.txt');

DRDKal3=dlmread('sechaDRDKal.txt');
DRDpKal3=dlmread('sechaDRDpKal.txt');
DRDwrf3=dlmread('sechaDRDwrf.txt');

DRKal3=dlmread('sechaDRKal.txt');
DRwrf3=dlmread('sechaDRwrf.txt');
DRpKal3=dlmread('sechaDRpKal.txt');
DRlatFFArray3=dlmread('sechaDRlatFFArray.txt');



BTKal2=dlmread('fihaBTKal.txt');
BTwrf2=dlmread('fihaBTwrfL.txt');
BTpKal2=dlmread('fihaBTpKal.txt');

BTsqKal2=dlmread('fihaBTsqKal.txt');
BTsqwrf2=dlmread('fihaBTsqwrf.txt');
BTsqpKal2=dlmread('fihaBTsqpKal.txt');

DRDsqKal2=dlmread('fihaDRDsqKal.txt');
DRDsqpKal2=dlmread('fihaDRDsqpKal.txt');
DRDsqwrf2=dlmread('fihaDRDsqwrf.txt');

DRDKal2=dlmread('fihaDRDKal.txt');
DRDpKal2=dlmread('fihaDRDpKal.txt');
DRDwrf2=dlmread('fihaDRDwrf.txt');

DRKal2=dlmread('fihaDRKal.txt');
DRwrf2=dlmread('fihaDRwrf.txt');
DRpKal2=dlmread('fihaDRpKal.txt');
DRlatFFArray2=dlmread('fihaDRlatFFArray.txt');
% %<<


%Concatenate>>
BTKal=vertcat(BTKal2,BTKal3,BTKal4);
BTwrf=vertcat(BTwrf2,BTwrf3,BTwrf4);
BTpKal=vertcat(BTpKal2,BTpKal3,BTpKal4);

BTsqKal=vertcat(BTsqKal2,BTsqKal3,BTsqKal4);
BTsqwrf=vertcat(BTsqwrf2,BTsqwrf3,BTsqwrf4);
BTsqpKal=vertcat(BTsqpKal2,BTsqpKal3,BTsqpKal4);

DRDsqKal=vertcat(DRDsqKal2,DRDsqKal3,DRDsqKal4);
DRDsqpKal=vertcat(DRDsqpKal2,DRDsqpKal3,DRDsqpKal4);
DRDsqwrf=vertcat(DRDsqwrf2,DRDsqwrf3,DRDsqwrf4);

DRDKal=vertcat(DRDKal2,DRDKal3,DRDKal4);
DRDpKal=vertcat(DRDpKal2,DRDpKal3,DRDpKal4);
DRDwrf=vertcat(DRDwrf2,DRDwrf3,DRDwrf4);


%,
DRKal=vertcat(DRKal2,DRKal3,DRKal4);
%DRwrf2,DRwrf3,
DRwrf=vertcat(DRwrf2,DRwrf3,DRwrf4);
%DRpKal2,DRpKal3,
DRpKal=vertcat(DRpKal2,DRpKal3,DRpKal4);
%DRlatFFArray2,DRlatFFArray3,
DRlatFFArray=vertcat(DRlatFFArray2,DRlatFFArray3,DRlatFFArray4);

fprintf('ran final')
save('fin111grm1m2.mat')
% % 
% % 
% % % % %<<
% % % 
% % % %Now Run B3111->
% % % 
% % % 
% % % 
% % % 
% % % 
% % % 
% % % 
