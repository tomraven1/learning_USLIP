function dydt=SwimPhaseDim(t,y,tdown)

global  m M rhow g V Ax Ay cdx cdy

    dydt=[ y(2); 
           -1/(2*m+2*M)*Ax*rhow*cdx* y(2)*abs(y(2)); 
           y(4); 
           -1/(2*m+2*M)*Ay*rhow*cdy* y(4)*abs(y(4)) - m/(m+M)*g + rhow*V*g/(m+M) 
         ];
    
end