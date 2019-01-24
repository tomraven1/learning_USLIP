clear all
%close all
clc
addpath('./params')
addpath('./functions')
addpath('./Dimension')
%load model parameters, control parameters, initial conditions
paramsInDim; % PinDim=[m,M,k,rhow,g,V,r0,drmax,Ax,Ay,cdx,cdy];
controlsInDim; % CinDim=[rs,alfa];
IC=[0 0.4 0.1]; % IC=[xdot,y,ydot]
%IC=[0 0.35 -2];

%simulate USLIP with POLAR coords punting phase
[n,ydimpol,ypuntpol,tpuntpol,tedimpol,xtdimpol,yevdimpol]=PolUSLIP_dim(PinDim,CinDim,IC,zeros(1,25));

figure
plot(ydimpol(:,1),ydimpol(:,3))
hold on
xlabel('x'); ylabel('y');
plot(yevdimpol(1:2:end,1),yevdimpol(1:2:end,3),'v')
plot(yevdimpol(2:2:end,1),yevdimpol(2:2:end,3),'^')

%simulate USLIP with CARTESIAN coordinates punting phase
[n,ydim,ypunt,tpunt,tedim,xtdim,yevdim]=USLIP_dim(PinDim,CinDim,IC,zeros(1,25));

plot(ydim(:,1),ydim(:,3))
xlabel('x'); ylabel('y');
plot(yevdim(1:2:end,1),yevdim(1:2:end,3),'v')
plot(yevdim(2:2:end,1),yevdim(2:2:end,3),'^')
plot(xtdimpol,zeros(size(xtdimpol,1)),'s');
plot(xtdim,zeros(size(xtdim,1)),'ks');
legend('polar punting','TD polar','TO polar','cartesian punting','TD cartesian','TO cartesian','TDgroundpol','TDgroundcart');
grid on
% figure
% plot(ydimpol(:,5),ydimpol(:,2))
% hold on
% plot(ydim(:,5),ydim(:,2))
% 
% figure
% plot(ydimpol(:,5),ydimpol(:,4))
% hold on
% plot(ydim(:,5),ydim(:,4))

%% CONFRONTO COORD POLARI
figure
subplot(2,1,1)
plot(tpunt,ypunt(1,:))
hold on
plot(tpuntpol,ypuntpol(1,:))
title('rho')
legend('cartesian','polar')
grid on

subplot(2,1,2)
plot(tpunt,ypunt(2,:))
hold on
plot(tpuntpol,ypuntpol(2,:))
title('rhodot')
grid on

figure
subplot(2,1,1)
plot(tpunt,180/pi*ypunt(3,:))
hold on
plot(tpuntpol,180/pi*ypuntpol(3,:))
title('theta')
legend('cartesian','polar')
grid on

subplot(2,1,2)
plot(tpunt,ypunt(4,:))
hold on
plot(tpuntpol,ypuntpol(4,:))
title('thetadot')
grid on