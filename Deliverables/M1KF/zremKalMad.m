clear
clc



series = ['20031214';'20040701';'20040820';'20040908'; ...
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
 numvals=size(series);

filename = 'MadisCRno.csv';
fileID = fopen((fullfile(filename)), 'r');
RefLis=1;

    while(~feof(fileID));
            
            InputText =textscan(fileID, '%s',5,'delimiter', ',');
            Irene{RefLis,1} = InputText{1};
            if size(InputText{1}) > 0;
            RefLis = RefLis+1;
            end
    end
        
    fclose(fileID);

%You left off Here Look up!!!!!!%%%%%%%%%%%%%%%%%fix MadCR

for notu=92:numvals(1)
   clearvars -except notu series RefLis Irene 
stormbeg  = (series(notu,:));


    stormname=[stormbeg,'F24.txt']
    
% %    
%numWRF= dlmread(fullfile(AdjFo,'WRF24.txt'));
%MadName=[filebeg,'ff.txt'];
numIrene = dlmread(fullfile('wfnFFST',stormname));
% %

stormbeg  = (series(notu,:));
fiATout1 = [stormbeg,'SC24.txt'];

fileID = fopen(fullfile('storm',fiATout1), 'r');
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




% for storm = 1:2
%     clearvars variable zerodetect J j zero;
%     if storm ==1;
%         %post = 53;
        q = numIrene;
        %qWRF = numWRF;
         
%     end
    numbs = size(q);
    %Iend = size(numIrene);
    iend=(timnam-1);
    %jendt = size(statname);
    %jend = jendt(2);
    ifin = iend+1;
    j = 1;
    g = 0;
%     oo=0
    for J = 1:(RefLis-1)
        
        %variable{1,j} = statname{1,J};
        
        %ifin
        for ii = 2:ifin;
            i = ii-1;
%             fprintf('basic looping')
%             disp(i)
%             disp(ii)
            variable(i,j) = q(i,J);
            statname{i,j} = Irene{J,1};
            %filled = fullfile(AdjFo,'Fn024.txt');
            
            
            
            bef1 = i-1;
            bef2 = i-2;
            bef3 = i-3;
            bef4 = i-4;
            bef5 = i-5;
            
            if bef1<1;
                bef1=1;
            end
            
            if bef2<1;
                bef2 = bef1;
            end
            
            if bef3<1;
                bef3 = bef2;
            end
            
            if bef4<1;
                bef4 = bef3;
            end
            
            if bef5<1;
                bef5 = bef4;
            end
            
            aft1 = i+1;
            aft2 = i+2;
            aft3 = i+3;
            aft4 = i+4;
            aft5 = i+5;
            
            if aft1>iend;
                aft1=iend;
            end
            
            if aft2>iend;
                aft2 = aft1;
            end
            
            if aft3>iend;
                aft3 = aft2;
            end
            
            if aft4>iend;
                aft4 = aft3;
            end
            
            if aft5>iend;
                aft5 = aft4;
            end
            
            if q(i,J) == 0;%initial condition
%                 fprintf('zero @:')
%                 disp(i)
                if i == 1;%if 1st = 0%%%%%%%%%%%%%%%%%%%%%%
                    
                    if q(aft5,j)>0;
                        variable(i,j) = q(aft5,J);
%                         fprintf('filled: ')
%                         disp(i)
                    end
                    
                    
                    if q(aft4,j)>0;
                        variable(i,j) = q(aft4,J);
%                         fprintf('filled: ')
%                         disp(i)
                    end
                    
                    if q(aft3,j)>0;
                        variable(i,j) = q(aft3,J);
%                         fprintf('filled: ')
%                         disp(i)
                    end
                    
                    if q(aft2,j)>0;
                        variable(i,j) = q(aft2,J);
%                         fprintf('filled: ')
%                         disp(i)
                    end
                    
                    if q(aft1,j)>0;
                        variable(i,j) = q(aft1,J);
%                         fprintf('filled: ')
%                         disp(i)
                    end
                    
                end%endif 1st = 0%%%%%%%%%%%%%%%%%%%%%%%%%
                
                
                if i>1% if Middle = 0%%%%%%%%%%%%%%%%%%%
                    
                    
                    if q(aft5,J)>0;
                        if q(bef5,J)>0;
                            variable(i,j) = (q(bef5,J) + q(aft5,J))/2;
%                             fprintf('filled: ')
%                             disp(i)
                        end
                        if q(bef4,J)>0;
                            variable(i,j) = (q(bef4,J) + q(aft5,J))/2;
%                             fprintf('filled: ')
%                             disp(i)
                        end
                        if q(bef3,J)>0;
                            variable(i,j) = (q(bef3,J) + q(aft5,J))/2;
%                             fprintf('filled: ')
%                             disp(i)
                        end
                        if q(bef2,J)>0;
                            variable(i,j) = (q(bef2,J) + q(aft5,J))/2;
%                             fprintf('filled: ')
%                             disp(i)
                        end
                        if q(bef1,J)>0;
                            variable(i,j) = (q(bef1,J) + q(aft5,J))/2;
%                             fprintf('filled: ')
%                             disp(i)
                        end
                    end
                    
                    
                    if q(aft4,J)>0;
                        if q(bef5,J)>0;
                            variable(i,j) = (q(bef5,J) + q(aft4,J))/2;
%                             fprintf('filled: ')
%                             disp(i)
                        end
                        if q(bef4,J)>0;
                            variable(i,j) = (q(bef4,J) + q(aft4,J))/2;
%                             fprintf('filled: ')
%                             disp(i)
                        end
                        
                        if q(bef3,J)>0
                            variable(i,j) = (q(bef3,J) + q(aft4,J))/2;
%                             fprintf('filled: ')
%                             disp(i)
                        end
                        if q(bef2,J)>0
                            variable(i,j) = (q(bef2,J) + q(aft4,J))/2;
%                             fprintf('filled: ')
%                             disp(i)
                        end
                        if q(bef1,J)>0
                            variable(i,j) = (q(bef1,J) + q(aft4,J))/2;
%                             fprintf('filled: ')
%                             disp(i)
                        end
                    end
                    
                    
                    
                    
                    if q(aft3,J)>0
                        if q(bef5,J)>0
                            variable(i,j) = (q(bef5,J) + q(aft3,J))/2;
%                             fprintf('filled: ')
%                             disp(i)
                        end
                        if q(bef4,J)>0
                            variable(i,j) = (q(bef4,J) + q(aft3,J))/2;
%                             fprintf('filled: ')
%                             disp(i)
                        end
                        if q(bef3,J)>0
                            variable(i,j) = (q(bef3,J) + q(aft3,J))/2;
%                             fprintf('filled: ')
%                             disp(i)
                        end
                        
                        if q(bef2,j)>0
                            variable(i,j) = (q(bef2,J) + q(aft3,J))/2;
%                             fprintf('filled: ')
%                             disp(i)
                        end
                        if q(bef1,j)>0
                            variable(i,j) = (q(bef1,J) + q(aft3,J))/2;
%                             fprintf('filled: ')
%                             disp(i)
                        end
                    end
                    
                    
                    
                    
                    if q(aft2,J)>0
                        if q(bef5,J)>0
                            variable(i,j) = (q(bef5,J) + q(aft2,J))/2;
%                             fprintf('filled: ')
%                             disp(i)
                        end
                        if q(bef4,J)>0
                            variable(i,j) = (q(bef4,J) + q(aft2,J))/2;
%                             fprintf('filled: ')
%                             disp(i)
                        end
                        if q(bef3,J)>0
                            variable(i,j) = (q(bef3,J) + q(aft2,J))/2;
%                             fprintf('filled: ')
%                             disp(i)
                        end
                        if q(bef2,J)>0
                            variable(i,j) = (q(bef2,J) + q(aft2,J))/2;
%                             fprintf('filled: ')
%                             disp(i)
                        end
                        if q(bef1,J)>0
                            variable(i,j) = (q(bef1,J) + q(aft2,J))/2;
%                             fprintf('filled: ')
%                             disp(i)
                        end
                    end
                    
                    
                    
                    if q(aft1,J)>0
                        if q(bef5,J)>0
                            variable(i,j) = (q(bef5,J) + q(aft1,J))/2;
%                             fprintf('filled: ')
%                             disp(i)
                        end
                        if q(bef4,J)>0
                            variable(i,j) = (q(bef4,J) + q(aft1,J))/2;
%                             fprintf('filled: ')
%                             disp(i)
                        end
                        if q(bef3,J)>0
                            variable(i,j) = (q(bef3,J) + q(aft1,J))/2;
%                             fprintf('filled: ')
%                             disp(i)
                        end
                        if q(bef2,J)>0
                            variable(i,j) = (q(bef2,J) + q(aft1,J))/2;
%                             fprintf('filled: ')
%                             disp(i)
                        end
                        if q(bef1,J)>0
                            variable(i,j) = (q(bef1,J) + q(aft1,J))/2;
%                             fprintf('filled: ')
%                             disp(i)
                        end
                    end
                    
                    
                    
                end%end middle%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                if i ==iend %if last = 0%%%%%%%%%%%%%%%%%%%%%%
                    
                    if q(bef5,J)>0
                        variable(i,j) = q(bef5,J);
%                         fprintf('filled: ')
%                         disp(i)
                    end
                    
                    
                    if q(bef4,J)>0
                        variable(i,j) = q(bef4,J);
%                         fprintf('filled: ')
%                         disp(i)
                    end
                    
                    if q(bef3,J)>0
                        variable(i,j) = q(bef3,J);
%                         fprintf('filled: ')
%                         disp(i)
                    end
                    
                    if q(bef2,J)>0
                        variable(i,j) = q(bef2,J);
%                         fprintf('filled: ')
%                         disp(i)
                    end
                    
                    if q(bef1,J)>0
                        variable(i,j) = q(bef1,J);
%                         fprintf('filled: ')
%                         disp(i)
                    end
                    
                end%endif last = 0%%%%%%%%%%%%%%%%%%%%%%%%%
                
                
                
                
            end
        end
%         fprintf('done with conventional loop')
%         disp(i)
%         disp(q(bef5,J))
%         disp(q(bef4,J))
%         disp(q(bef3,J))
%         disp(q(bef2,J))
%         disp(q(bef1,J))
%         disp(variable{ifin, j})
        
        endnum = variable((ifin-1), j);
%         disp(endnum)
        
        if q(bef5,J) == 0 && endnum  > 0;
            variable(((ifin-1)-5), j) = endnum ;
        end
        if q(bef4,J) == 0 && endnum  > 0;
             variable(((ifin-1)-4), j) = endnum ;
        end
        if q(bef3,J) == 0 && endnum > 0;
             variable(((ifin-1)-3), j) = endnum ;
        end
        if q(bef2,J) == 0 && endnum  > 0;
             variable(((ifin-1)-2), j) = endnum ;
        end
        if q(bef1,j) == 0 && endnum  > 0;
             variable(((ifin-1)-1), j) = endnum ;
        end
        
        for o = 1:iend;
            %oo = o+1;
            
            d = variable(o,j);
            %             dd = str2num(d);
            zerodetect(o)= d;
            zero = min(zerodetect);
        end
%         fprintf('zerodetect')
%         disp(zerodetect)
        
%         if zero>0
            j = j+1;
            
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %WRF
            
            %station=J!!!!!!!  
            %that is preselected           
            
           
            
            %time=1:24
            %does this file exist
            
%             
%             
%             for w=1:24
%                 %this is where the location should happen
%                 
%                     WRFmat(w,j)=qWRF(w,J)
%                 
%             end
%             
            
            
            
            
                        
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            %notidisk=statname{1,J};
            
           
      
            
%             
%         else
%             g = g+1;
%             discardlist{g} = statname{1,1};
%         end
    end

%     
%     for w=1:24
%         for ww=1:(j-1)
%     writemat(w,ww)=WRFmat(w,ww)-variable(w,ww)
%         end
%     end
%     
%     
%     dlmwrite(filled, writemat)
%     
    
%end
howmany=0;
for inner=1:iend
    %:iend
    %1:iend

filebeg  = cell2mat(TimeCell{inner,1});
CoutName=[filebeg,'Cn0.txt'];
RoutName=[filebeg,'Rn0.txt'];
SToutName=[filebeg,'STn0.txt'];
FFoutName=[filebeg,'FFn0.txt'];


ST24ID = fopen(fullfile('wfnFFST',SToutName), 'w');
C24ID = fopen(fullfile('wfNCR',CoutName), 'w');
R24ID = fopen(fullfile('wfNCR',RoutName),'w');
FF24ID=fopen(fullfile('wfnFFST',FFoutName),'w');
  
    
    for stats=1:(RefLis-1);
        
        if variable(inner,stats)>0;
            howmany=howmany+1;
            cel=statname{inner,stats};
            Cn0=cel(4);
            Rn0=cel(5);
            STn0=cel(1);
            fprintf('writing')
            disp(notu)
            disp(filebeg)
            
            fprintf(ST24ID, '%s\n', cell2mat(STn0));
            fprintf(C24ID, '%s\n', cell2mat(Cn0));
            fprintf(R24ID, '%s\n', cell2mat(Rn0));
            fprintf(FF24ID, '%f\n', variable(inner,stats));
        end
    end
    fclose(ST24ID);
fclose(C24ID);
fclose(R24ID);
  
end




end








