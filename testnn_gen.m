

global net
global dens vel grav


load('data_human_grav_nn.mat')

global test_check
test_check=1;


ang=pi/2;

conv=1;
%  while conv==1
dens=0.002; % density coefficient - 1 is water 0 is air 0 doesnt work -try 0.001 or 0.01
vel=2;  % desired velocity in x - NOW IT CAN GO WOTH HGHER VELOCITIES ALSO
grav=0.6;
velx=0;
%velx=(count-1)/50;   % initial velocity
posy=1;  %initial position y
steps=50; % number of steps

ang=net([posy;velx-vel;grav]); % first step

[a,ydim,junk,tedim,xtdim,yevdim,conv,c_step]=evalu_gen(ang,velx,posy,dens,grav,steps);
%res(jj)=a;
%plot(ydim(:,1),ydim(:,3))
if conv==1 || c_step==50
    conv=1;
    % stab(count,floor(count_dens*10))=1;
else
    % stab(count,floor(count_dens*10))=0;
    stab(floor(count_dens*100))=count;
end
% count=count+5;

%   end
%end
plotEvo(ydim,yevdim,xtdim)


%     if jj>1
%     [pks,locs] = findpeaks(ydim(:,3));
%     ang= net([ydim(locs(jj-1),3);ydim(locs(jj-1),2);(ydim(locs(jj-1),3)-ydim(locs(jj-1)+1,3))]);
%     else
%    ang= net([ydim(1,3);ydim(1,2);dens]);
%     end






