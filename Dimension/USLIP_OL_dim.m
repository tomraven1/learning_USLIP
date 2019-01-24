function [nstep,y_tot,y_punt,t_punt,t_event,xt_tot,y_event,epsilon,conv]=USLIP_dim(Pin,Cin,IC,epsilon)
%function descrpition goes here: ... %

% ---------------------- Variables extraction and initialization ---------
% global variables
global m M k rhow g V r0 drmax Ax Ay cdx cdy rs alfa r P
% global additional variables 
global xt t0e current_e

%Pin=[m,M,k,rhow,g,V,r0,drmax,Ax,Ay,cdx,cdy];
m=Pin(1); M=Pin(2); k=Pin(3); rhow=Pin(4); g=Pin(5); V=Pin(6); r0=Pin(7); drmax=Pin(8); Ax=Pin(9); Ay=Pin(10); cdx=Pin(11); cdy=Pin(12);
%Cin=[rs,alfa];
rs=Cin(1); alfa=Cin(2); P=Cin(3);
% ------------------------------------------------------------------------
if IC(2)<r0*sin(alfa)
    warning('y initial condition changed to match a suitable value');
    IC(2)=r0*sin(alfa)+0.01;
end
y0=[0; IC(1); IC(2); IC(3);];
TE2=0;
t_tot=[];
y_tot=[];
y_punt=[];
t_punt=[];
xt_tot=[];
t_event=[];
y_event=[];
prev_YE=[0 0 0];
conv=0;
cont = 0;

maxstep=length(epsilon);  

    for nstep=1:maxstep

        tspan=TE2:0.001:TE2+5; %time
        options = odeset('RelTol',1e-9,'AbsTol',1e-9,'Events',@eventsTDdisturbed);
        current_e=epsilon(nstep);
        [T,Y,TE,YE,IE]=ode113(@SwimPhaseDim_OL,tspan,y0,options,epsilon(nstep));
        t_tot=[t_tot T'];
        y_tot=[y_tot Y'];
        y_event=[y_event YE']; 

        if numel(IE)==0 || numel(IE)>=2 || IE==2 %*read below note on events
            break;
        end

        t0e=TE;
        t_event=[t_event TE];
        YE; %novel initial conditions
        xt=YE(1)-(r0+r)*cos(alfa); % xt adimensionale dividendo per r0

        tspan2=TE:0.001:tspan(length(tspan))+5;
        options = odeset('RelTol',1e-9,'AbsTol',1e-9,'Events',@eventsLOdisturbed);
        [T2,Y2,TE2,YE2,IE2]=ode113(@PuntPhaseDim_OL,tspan2,YE,options,epsilon(nstep));
        cont = cont + length(Y2(:,1));
        %size(Y2)
%         Y2pol = [];
%         for i=1:length(Y2(:,1)) %Converto i dati in coordinate cartesiane
%             Y2pol(i,:) = car2pol(Y2(i,:),xt);
%         end
%         if length(Y2pol(:,1)) - length(Y2(:,1)) == 0
%         else
%             diff = length(Y2pol(:,1)) - length(Y2(:,1))
%             xt
%         end
        y_punt=[y_punt Y2'];
        length(y_punt(1,:));
        t_punt=[t_punt T2'];
        y0=YE2;
        t0e=0;
        t_event=[t_event TE2'];
        t_tot=[t_tot T2'];
        y_tot=[y_tot Y2'];
        xt_tot=[xt_tot xt];
        y_event=[y_event YE2'];

        if numel(IE2)==0 || numel(IE2)>=2 || IE2==2
            break;
        end

        %checcko la condizione di convergenza, per stoppare la simulazione
        if norm(prev_YE-YE(2:4))<=10^(-6)
                conv=1;
                break;
        end
        prev_YE=YE(2:4);
    end

% ------------------------------------------------------------------------
% ------------------------------------------------------------------------
y_tot=[y_tot' t_tot'];
xt_tot=xt_tot';
y_event=y_event';
% ------------------------------------------------------------------------
% ------------------------------------------------------------------------

end

% ------------------ event functions with disturbances -------------------
function [value,isterminal,direction] = eventsTDdisturbed(t,y,err) 
global r0 alfa r
value = [y(3)-(r0+r)*sin(alfa)+err,y(3)];     % detect height = 0
isterminal = [1,1];   % stop the integration
direction = [-1,-1];   % negative direction
end

function [value,isterminal,direction] = eventsLOdisturbed(t,y,err) 
global r0 drmax xt r
value = [sqrt( y(3)^2+ (y(1)-xt)^2 ) - (r0+r),y(3)];     % detect height = 0
isterminal = [1,1];   % stop the integration
direction = [1,0];   % positive direction
end
% ------------------------------------------------------------------------

%*event functions (eventsTDdisturbed or eventsLOdisturbed) are providing
%information if the td or lo conditions are somehow verified. The value
%that should be verified are two, in this case: value =
%[y(3)+r0*cos(alfa)/r0-current_e,y(3)]; IE is outputing which one happened: the
%first IE=1, the second IE=2. The main program breaks if numel(IE)=0,
%so no events happened, IE=2, so the body touched the ground, of
%numel(IE>2)