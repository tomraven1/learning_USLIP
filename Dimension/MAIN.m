clear all
addpath('./params')
% %% --- dim params
% paramsInDim;
% controlsInDim;
% % PinDim=[m,M,k,rhow,g,V,r0,drmax,Ax,Ay,cdx,cdy];
% % CinDim=[rs,alfa];
% % --- dimless params
% % Pin=[a,b,c,d,g,r0,drmax];
% % Cin=[rs,alfa];
% % Creating the dimensionless parameters from the dimensional quantities
% a=PinDim(9)*PinDim(4)*PinDim(11)*PinDim(7)*1/2*1/(PinDim(1)+PinDim(2));
% b=PinDim(10)*PinDim(4)*PinDim(12)*PinDim(7)*1/2*1/(PinDim(1)+PinDim(2));
% c=(PinDim(1)-PinDim(4)*PinDim(6))*1/(PinDim(1)+PinDim(2));
% d=PinDim(3)*PinDim(7)*1/(PinDim(1)+PinDim(2))*1/PinDim(5);
% drmax=PinDim(8)/PinDim(7);
% r0=PinDim(7);
% g=PinDim(5);
% rs=CinDim(1)/sqrt(PinDim(7)*PinDim(5));
% alfa=CinDim(2);
% % launch the dimensional simulation
% % small-size robot dimension
% IC=[0 0.35 0.1];
% % human-size robot dimension
% %IC=[0 1.1 0.5];
%
% addpath('./Dimension')
% [n,ydim,tedim,xtdim,yevdim]=USLIP_dim(PinDim,CinDim,IC,zeros(1,25));
% plot(ydim(:,1),ydim(:,3))
% hold on
% xlabel('x'); ylabel('y');

%% launch the dimensionless simulation
addpath('./Dimensionless')
controlsInDimless;
paramsInDimless;
IC=[0,0.35,0.1];
% Pin=[a,b,c,d,g,r0,drmax];
% Cin=[rs,alfa];
g=Pin(5);
r0=Pin(6);
drmax=Pin(7);
rs=Cin(1);
alfa=Cin(2);
[n,y,te,xt,ye]=USLIP_dimless(Pin,Cin,[IC(1)/sqrt(g*r0) IC(2)/r0 IC(3)/sqrt(g*r0)],zeros(1,25));

%% Plots
%plot(y(:,1),y(:,3),'r--')
plot(y(:,1)*r0,y(:,3)*r0,'r')
plot(y(:,1)*r0,r0*sin(alfa),'k--')
% plot(yevdim(1:2:end,1),yevdim(1:2:end,3),'v')
% plot(yevdim(2:2:end,1),yevdim(2:2:end,3),'^')
plot(ye(1:2:end,1)*r0,ye(1:2:end,3)*r0,'rv')
plot(ye(2:2:end,1)*r0,ye(2:2:end,3)*r0,'r^')
legend('Dimension','Dimensionless','DimLes2Dim')
hold off

figure()
plot(y(:,5),y(:,3))
hold on
%plot(y(:,5),y(:,3),'r--')
plot(y(:,5)*sqrt(r0/g),y(:,3)*r0,'r')
xlabel('t'); ylabel('y');
hold off

figure()
plot(y(:,5),y(:,1))
hold on
%plot(y(:,5),y(:,1),'r--')
plot(y(:,5)*sqrt(r0/g),y(:,1)*r0,'r')
xlabel('t'); ylabel('x');
hold off
