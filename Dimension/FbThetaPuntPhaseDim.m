function dydt=FbThetaPuntPhaseDim(t,y,rho,rhodot,tspan)
global Ax rhow cdx m M g V
rho = interp1(tspan, rho, t); % Interpolate the data set (ft, f) at times t
rhodot = interp1(tspan, rhodot, t); % Interpolate the data set (gt, g) at times t

X = Ax*rhow*cdx/2;
xdot = cos(y(1)).*rhodot-y(2).*rho*sin(y(1));
ydot = sin(y(1)).*rhodot+y(2).*rho*cos(y(1));
% angular dynamics
dydt=[ y(2);
       1/(m+M)*(X*xdot*abs(xdot)*sin(y(1))-X*ydot*abs(ydot)*cos(y(1)))./rho - (m*g-rhow*V*g)/(m+M)./rho*cos(y(1)) - 2.*rhodot*y(2)./rho
     ];
end
