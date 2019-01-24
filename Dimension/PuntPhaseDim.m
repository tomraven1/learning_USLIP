function dydt=PuntPhaseDim(t,y,loff)

global m M k rhow g V r0 drmax Ax Ay cdx cdy rs xt t0e current_e r

% pushing function
%  rt=linspace(0,2,25);
%  r=rs*rt;
%  r=interp1(rt,r,(t-t0e)); % interpolo il valore di r all'istante t: nota che t e t0e dovrebbero già essere passati adimensionali
r=rs*(t-t0e);

if r>=drmax
   r=drmax; % massimo valore di allungamento ammissibile
end
loss=0; %% WANTED TO ADD NOISE OR OTHER FORM OF ENERGY LOSS - To be discussed
l=sqrt((y(1)-xt)^2+(y(3)-current_e)^2); %il parametro E=xt/r0 adimensionale
dydt=[ y(2);
       -1/(2*m+2*M)*Ax*rhow*cdx* y(2)*abs(y(2)) + 1/(m+M)*k*(y(1)-xt)/l* ( (r0+r)-l -loss*sign(y(2)));
       y(4);
       -1/(2*m+2*M)*Ay*rhow*cdy* y(4)*abs(y(4)) - m/(m+M)*g + rhow*V*g/(m+M) + 1/(m+M)*k*y(3)/l* ( (r0+r)-l  -loss*sign(y(2))) 
     ];
end