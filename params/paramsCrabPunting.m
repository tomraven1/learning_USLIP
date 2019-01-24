m = 0.074; % mass, [Kg]
mapp = m/10; % apparent mass [Kg
rhow = 1000; % water density, [Kg/m^3]
g = 9.81; % gravity, [m/s^2]
V = (m - mapp)/rhow; %volume of the crab, [m^3]
Ca = 0.48; %added mass coefficient
M = V*rhow*Ca; %added mass, [Kg]
l0 = 0.04; % leg length, [m]
k_dimless = 7.8; %18.6%Blickhan 1993
k = k_dimless*m*g/l0;
dlmax = 0.005; % maximum elongation, [m]
Ax = 4e-4; % horizontal frontal area, see sketch for estimation, [m^2]
W_c = 0.054; % Carapace width, [m]
Ay = (W_c/2)^2*pi; % vertical frontal area, circle of diameter equal to carapace height, [m^2]
cdx = 0.47; % 0.1 % horizontal drag coefficient, depends on area taken into accont
cdy = 1; % vertical drag coefficient, very poor streamlined

PinDim=[m,M,k,rhow,g,V,l0,dlmax,Ax,Ay,cdx,cdy];

