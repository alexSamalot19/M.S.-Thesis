clear
clc


load(fullfile('season','fin111grv3.mat'))

dlmwrite('matDRDKalv3.txt',matDRDKal);
dlmwrite('matDRDpKalv3.txt',matDRDpKal);
dlmwrite('matDRDsqKalv3.txt',matDRDsqKal);
dlmwrite('matDRDsqpKalv3.txt',matDRDsqpKal);
dlmwrite('matDRDWRFv3.txt',matDRDwrf);
dlmwrite('matDRDsqWRFv3.txt',matDRDsqwrf);