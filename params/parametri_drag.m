r0=0.09;
rho_w=1000;
m=0.5;
mu_x=0.5;
l0=0.11;

M = 2/3*pi*r0^3*rho_w;
Ax = pi*r0^2;

a = Ax*rho_w*mu_x*l0/2/(m+M);
figure
plot(r0,a)
figure
plot(r0,2*(m+M))
hold on
plot(r0, Ax*rho_w*mu_x*l0,'r')