%10/29/2016: without last station construction using workspace
% clear
% clc
% load(fullfile('F:','CV62015Cast','CEELab20','CVnew6.mat'))
% %Note above is some sort of weird edit look up at end

% %Gettin that last value fix END
clear
clc
load('NewUKwrfPlot.mat')
% size(BWRFArray)

dlmwrite('MesoMapRMSEWRF.txt',RMSEWRFmat)

dlmwrite('MesoMapRMSEmatUK.txt',RMSEmatUK)

dlmwrite('MesoMapFF.txt',FFmat)%Observed Wind

dlmwrite('MesoMapFFUK.txt',FFmatUK)%Kriged WIND

dlmwrite('MesoMapWRF.txt',FFWRFmat)%WRF WIND


%Bias kriged maps%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CVnew6.mat
clear
clc

load('PlotBPWRF.mat')

dlmwrite('MesoMapObsK.txt',RMSEmatUK)%ObsKwind






% clear
% clc


%Better off combining in R after a manual rename and last row delete


%Note I do not Have a Mean Bias Calculator?






