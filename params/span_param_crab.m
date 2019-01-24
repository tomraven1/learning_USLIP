clear all
close all
clc

addpath('./params');
addpath('./Dimension');

paramsCrabPunting
rs = 0.1:0.05:0.4;
alfa = (80:1:89)*pi/180;
k = 100:50:350;
dlmax = 0.003:0.002:0.02;
cdx = 0.1:0.1:1.5;
cdy = 0.1:0.2:2;

IC=[0.76 0.041 0]; %initial conditions
c=1;
%% Launch simulations
for i=1:length(rs)
    for j=1:length(alfa)
        for ii=1:length(k)
            for jj=1:length(dlmax)
                for iii=1:length(cdx)
                    for jjj=1:length(cdy)
                        CinDim=[rs(i), alfa(j)];
                        PinDim(3) = k(ii); PinDim(8) = dlmax(jj);
                        PinDim(11) = cdx(iii); PinDim(12) = cdy(jjj);
                        [n,y,ypunt,tpunt,te,xtdim,ye,~,isconv]=...
                            USLIP_dim(PinDim,CinDim,IC,zeros(1,25));
                        if isconv == 1 || n ==25
                            f = 1/(te(end)-te(end-2));
                            dutyC = (te(end)-te(end-1))*f;
                            data(c,:) = [rs(i), alfa(j), k(ii), f, dutyC];
                            c=c+1;
                            disp(strcat(num2str(i),', ',num2str(j),', ',num2str(ii)))
                        end
                    end
                end
            end
        end
    end
end
