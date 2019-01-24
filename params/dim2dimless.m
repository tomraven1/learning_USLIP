%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Questo script prende in ingresso i parametri fisici del robot e li mappa
%   parametri adimensionali a, b, c, d usati nel modello simulink
%   NOTA: il passaggio dei parametri adesso avviene con il seguente
%   sofisticatissimo protocollo:
%   - Copiare i valori di a, b, c, d dopo aver eseguito questo script
%   - Incollarli nella matlab function del modello marc_p2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%DESIGN TANK-HOPPER
%costanti
rho_w = 1000; %[Kg/m^3] densità acqua
mi_x = 0.5; %coefficiente di attrito idrodinamico per una sfera liscia a bassi numeri di reynold
g = 9.81; %[m/s^2] accelerazione di gravità

%parametri di progetto
r0 = 0.045; %[m] raggio minimo sfera hobermann
l0 = 0.11; %[m] lunghezza gamba a riposo
dlmax = 0.02; %[m] displacement attuatore lineare massimo
m = 0.3;%+0.4; %[Kg] massa sfera
k = 5570;
V_buoy = 0.06^3;

%grandezze derivanti dai parametri e dalle costanti
Ax = pi*r0^2; %[m^2] area frontale
M = 2/3*pi*r0^3*rho_w;%[Kg] massa aggiunta di una sfera di raggio r0
V_sph = 4/3*pi*r0^2;
X = Ax*rho_w*mi_x/2;

%a,b,c,d
a = X*l0/(m+M);
b = a;
c = (m-rho_w*V_buoy)/(m+M);
d = k*l0/g/(m+M);

abcd = [0,a,b,c,d];
%Pin = [a,b,c,d,g,l0,dlmax];
params = [0, m, M, g, k];
clearvars -except abcd l0 params
