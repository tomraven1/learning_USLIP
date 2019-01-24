function dydt=PolPuntPhaseDim(t,y,loff)
fb = 1; % 1 applico la fb linearization
global m M k rhow g V r0 drmax Ax Ay cdx cdy rs xt t0e current_e r

X = Ax*rhow*cdx/2;
xdot = y(2)*cos(y(3))-y(1)*y(4)*sin(y(3));
ydot = y(2)*sin(y(3))+y(1)*y(4)*cos(y(3));

% pushing function
r=rs*(t-t0e);
if r>=drmax
   r=drmax; % massimo valore di allungamento ammissibile
end
%feedback linearization r_act = r_nl + r
r_nl = (m+M)/k*(X/(m+M)*(xdot*abs(xdot)*cos(y(3))+ydot*abs(ydot)*sin(y(3))) - y(4)^2*y(1) + (m*g-rhow*V*g)/(m+M));
if fb == 1
    r_act = r_nl+r;
else
    r_act = r;
end
%Nota: Ax = Ay e cdx=cdy per ipotesi di corpo sferico
dydt=[ y(2);
       %-1/2/(m+M)*Ax*rhow*cdx* y(2)*abs(y(2)) - k/(m+M)*(y(1)-r0-r) + y(4)^2*y(1) - (m*g-rhow*V*g)/(m+M)*sin(y(3));
       1/(m+M)*(-X*xdot*abs(xdot)*cos(y(3))-X*ydot*abs(ydot)*sin(y(3))) - k/(m+M)*(y(1)-r0-r_act) + y(4)^2*y(1) - (m*g-rhow*V*g)/(m+M)*sin(y(3));
       y(4);
       %-1/2/(m+M)*Ay*rhow*cdy* y(1)*y(4)*abs(y(4)) - (m*g-rhow*V*g)/(m+M)/y(1)*cos(y(3)) - 2*y(2)*y(4)/y(1)
       1/(m+M)*(X*xdot*abs(xdot)*sin(y(3))-X*ydot*abs(ydot)*cos(y(3)))/y(1) - (m*g-rhow*V*g)/(m+M)/y(1)*cos(y(3)) - 2*y(2)*y(4)/y(1)
     ];
end
