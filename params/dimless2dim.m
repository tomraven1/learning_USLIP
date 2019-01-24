function [x,y,x_dot,y_dot,x_step,l,t] = dimless2dim( x_adim,y_adim,xdot_adim, ydot_adim, xstep_adim, l_adim, t_adim, l0, g)
% Questo script prende in ingresso i vettori con i risultati della
% simulazione e li dimensionalizza usando i parametri fisici specificati in
% dim2dimless.

x = l0*x_adim;
y = l0*y_adim;
x_step = l0*xstep_adim;
l = l0*l_adim;
x_dot = l0*sqrt(g/l0)*xdot_adim;
y_dot = l0*sqrt(g/l0)*ydot_adim;
t = sqrt(l0/g)*t_adim;

end

