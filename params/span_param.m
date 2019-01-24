clear all
close all
clc

%% DESIGN TANK-HOPPER
controlsInDimless;
stable_counter = 1;
table_stable = [];
%costanti
rho_w = 1000; %[Kg/m^3] densità acqua
mi_x = 0.5; %coefficiente di attrito idrodinamico per una sfera liscia a bassi numeri di reynold
g = 9.81; %[m/s^2] accelerazione di gravità

%parametri di progetto
r0 = linspace(0.045,0.11,10); %[m] raggio esterno hobermann
% m = linspace(0.3,1,5); %[Kg] massa
m = [0.74, 0.915];
l0 = 0.11; %[m] lunghezza gamba a riposo
dlmax = 0.02; %[m] displacement attuatore lineare massimo
V_buoy = 0.06^3;%linspace(0.02^3,0.05^3,5); %[m^3] volume schiuma galleggiante
k = 5570;%[1600, 5570, 10860]; %[N/m] costanti molla
alfa = 86*pi/180; %linspace(80*pi/180,89*pi/180,5); %[rad] angoli atterraggio

%condizioni iniziali
y0 = l0+0.01:0.025:0.22; %[m] altezza iniziale
ydot0 = -sqrt(l0*g)/2:sqrt(l0*g)/10:sqrt(l0*g)/2;
xdot0 = 0:sqrt(l0*g)/10:sqrt(l0*g);
N = length(r0)*length(m)*length(V_buoy)*length(k)*length(alfa)*length(y0)*length(ydot0)*length(xdot0);
%% iteration
for i=1:length(m)
    for j=1:length(r0)
        for k1=1:length(y0)
            for k2=1:length(ydot0)
                for k3=1:length(xdot0)
                    Ax = pi*r0(j)^2; %[m^2] area frontale
                    M = 2/3*pi*r0(j)^3*rho_w;%[Kg] massa aggiunta di una sfera di raggio r0
                    
                    a = Ax*rho_w*mi_x*l0/(2*(m(i)+M));
                    b = a;
                    c = (m(i)-rho_w*V_buoy)/(m(i)+M);
                    d = k*l0/g/(m(i)+M);
                    Pin = [a,b,c,d,g,l0,dlmax];
                    IC=[xdot0(k3),y0(k1),ydot0(k2)];
                    
                    [n,~,~,~,~,~,isconv,~]=USLIP_dimless(Pin,Cin,[IC(1)/sqrt(g*l0) IC(2)/l0 IC(3)/sqrt(g*l0)],zeros(1,25));
                   
                    if isconv == 1 || n == 25
                        table_stable(stable_counter,:) = [m(i),r0(j),y0(k1),ydot0(k2),xdot0(k3)];
                        stable_counter = stable_counter+1;
                        disp('stabile')
                    else
                        disp('non stabile')
                    end
                end
            end
        end
    end
end