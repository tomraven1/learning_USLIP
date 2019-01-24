% file of model's parameter [Dimension version]
%% Order of parameters, the same as Pin=[...]
% mass
% % m
% added mass
% % M
% stiffness
% % k
% water density
% % rhow
% gravity
% % g
% body volume
% % V
% leg length
% % r0
% maximum elongation
% % drmax
% frontal area [horizontal]
% % Ax
% frontal area [vertical]
% % Ay
% drag coefficient [horizontal]
% % cdx
% drag coefficient [vertical]
% % cdy
%%
%PinDim=[m,M,k,rhow,g,V,r0,drmax,Ax,Ay,cdx,cdy];
% per il box-bot
%PinDim=[4,0.4,900,1000,9.81,0.0039,0.3,0.01,0.024,0.0456,1.05,1.05];
%IPOTESI CORPO SFERICO di raggio 0.1m : Area frontale sfera =
%pi*r^2(wiki), cdx=cdy = 0.47 (smooth sphere)
%PinDim=[4,0.4,900,1000,9.81,0.0042,0.3,0.01,0.0314,0.0314,0.67,0.67];

%Parametri originali con Ay=Ax <------------
%PinDim=[4,0.4,900,1000,9.81,0.0039,0.3,0.01,0.024,0.024,1.05,1.05];

%PinDim=[4,0.4,900,1000,9.81,0.0039,0.3,0.03,0.024,0.0456,1.05,1.05];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parametri SILVER 4 gambe
%PinDim=[8.95,0.5,4*3700,1000,9.81,0.0086,0.26,0.04,0.15,0.15,1.05,1.1];
% Parametri SILVER 2 gambe
% PinDim=[8.95,0.5,2*3700,1000,9.81,0.0086,0.26,0.04,0.15,0.15,1.05,1.1];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% per un robot sferico (ha usato wiki! ma come mai divide il volume per 5?)
% PinDim=[8,0.8,3700,1000,9.81,1/5*4/3*pi*(0.2)^3,0.3,0.03,pi*(0.2)^2,pi*(0.2)^2,0.47,0.47];
%PinDim=[8,0.8,3700,1000,9.81,1/5*4/3*pi*(0.2)^3,0.3,0.03,pi*(0.2)^2,pi*(0.2)^2,0,0]; 
% per l'human-size
PinDim=[80,8,20000,1000,9.81,0.0624,1,0.2,0.1925,0.105,1.05,1.05];

%per SLIP
% PinDim=[80,0,20000,0,9.81,0.0624,1,0.3,0,0,0,0];