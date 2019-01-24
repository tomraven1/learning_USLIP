function [ rho,rhodot ] = FbRadiusPuntPhaseDim( t,YE )
global m M k r0 drmax rs r
rho = zeros(length(t),1);
rhodot = zeros(length(t),1);

omega = sqrt(k/(m+M));
tc = drmax/rs; %time at maximum displacement
beta1 = atan2(-(YE(2)-rs)/omega,YE(1)-r0);
a1 = (YE(1)-r0)/cos(beta1);
rho_tc = r0 + drmax + a1*cos(omega*tc + beta1);
rhodot_tc = rs - omega*a1*sin(omega*tc + beta1);
beta2 = atan2(-rhodot_tc/omega,rho_tc-r0-drmax);
a2 = (rho_tc-r0-drmax)/cos(beta2);

% radial dynamics solution with perfect fb linearization
for i=1:length(t)
    r = rs*(t(i)-t(1));
    if r <= drmax
        rho(i) = r0 + r + a1*cos(omega*(t(i)-t(1))+beta1);
        rhodot(i) = rs - omega*a1*sin(omega*(t(i)-t(1))+beta1);
    else
        r = drmax;
        rho(i) = r0 + r + a2*cos(omega*(t(i)-t(1)-tc)+beta2);
        rhodot(i) = - omega*a2*sin(omega*(t(i)-t(1)-tc)+beta2);
    end
end
end

