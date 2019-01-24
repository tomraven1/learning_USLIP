function [rew,ydim,para,tedim,xtdim,yevdim,conv,n]=evalu(vars,velx,posy,dens,steps)
addpath('./params')
paramsInDim;
controlsInDim;
%TE=zeros(20,20000);
%TW=zeros(20,20000);
global   alfa

para.count=1;




%global dens  %%uncomment for test



%PinDim(11)=0.2;

%PinDim(12)=0.2;

% --- dim params
% PinDim=[m,M,k,rhow,g,V,r0,drmax,Ax,Ay,cdx,cdy];
% CinDim=[rs,alfa];
% --- dimless params
% Pin=[a,b,c,d,g,r0,drmax];
% Cin=[rs,alfa];
% Creating the dimensionless parameters from the dimensional quantities
%PinDim(4)=0;

PinDim(4)=dens*PinDim(4);


a=PinDim(9)*PinDim(4)*PinDim(11)*PinDim(7)*1/2*1/(PinDim(1)+PinDim(2));
b=PinDim(10)*PinDim(4)*PinDim(12)*PinDim(7)*1/2*1/(PinDim(1)+PinDim(2));
c=(PinDim(1)-PinDim(4)*PinDim(6))*1/(PinDim(1)+PinDim(2));
d=PinDim(3)*PinDim(7)*1/(PinDim(1)+PinDim(2))*1/PinDim(5);
drmax=PinDim(8)/PinDim(7);
r0=PinDim(7);
g=PinDim(5);

%CinDim(1)=0;
rs=CinDim(1)/sqrt(PinDim(7)*PinDim(5));


% CinDim(2)=vars;%%%%%%%ALPHA
alfa=vars;
% launch the dimensional simulation
% small-size robot dimension
%IC=[0 0.35 0.1 ];
IC=[0 posy 0 velx];
% human-size robot dimension
%IC=[0 1.1 0.5];

%

%alfa=CinDim(2);
for ii=1
    %CinDim(2)=pi/2.5+(pi/2.5)*(ii/20);
    %spd=ii/10;
    %  spd=0;
    addpath('./Dimension')
    [n,ydim,tedim,xtdim,yevdim,junk,conv]=USLIP_dim(PinDim,CinDim,IC,zeros(1,steps));
    
   [a,b]=findpeaks(ydim(1:end,3));
    if length(b)>0
    rew=abs(ydim(b(1),2));
    else
        rew=1000;
    end
    % clear para
    
end

% X=para.x;
% for j=2:length(para.x)
%     %     TE_sum(j)=trapz(tim(1,1:j),(TE(1,1:j)-TE(1)));
%     TW_sum(j)=trapz(X(1,1:j),TW(1,1:j));
%
%     %   TE_sum(j)=sum((TE(1,1:j)-TE(1)));
%     %  TW_sum(j)=sum(TW(1,1:j));
% end

% plot(TW_sum)
% hold on

% plot(TE-TE(1))
% hold on
% plot(TW)

end