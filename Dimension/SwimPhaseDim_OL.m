function dydt=SwimPhaseDim_OL(t,y,tdown)

global  m M rhow g V Ax Ay cdx cdy r drmax rs P

if rs*P >= drmax
    ceiling = drmax;
else
    ceiling = rs*P;
end

tau = mod(t,2*P);
if tau < P
    r = rs*tau;
    if r >= drmax
        r = drmax;
    end
end
if tau >= P
       r = ceiling - (rs*(tau-P));
        if r <= 0
            r = 0;
        end
end

    dydt=[ y(2); 
           -1/(2*m+2*M)*Ax*rhow*cdx* y(2)*abs(y(2)); 
           y(4); 
           -1/(2*m+2*M)*Ay*rhow*cdy* y(4)*abs(y(4)) - m/(m+M)*g + rhow*V*g/(m+M) 
         ];
    
end