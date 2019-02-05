rng(6626) 
global test_check
test_check=0;

ini=zeros(1,1);
 ini(1)=pi/2;

ub(1)=pi/1.1;
lb(1)=pi/20;

for kk=110:10000
    tic
%  dens=abs(1-abs(randn/5));
if kk<2000
  %dens=0.3+rand/3;
  dens=rand;
elseif kk<4000
     dens=0.5+rand/2;
else
    
    dens=rand;
end
velx=randn;
posy=1+abs(randn);

steps=5;


%options = gaoptimset('UseParallel',true,'FitnessLimit',0.0001);
f = @(x)evalu(x,velx,posy,dens,steps);
%options = gaoptimset('display','diagnose','Generations',10,'InitialPopulation',x(1:5),'UseParallel',true);
%[x,fval] = ga(f,1,[],[],[],[],lb,ub,[],options);


 options = optimoptions('patternsearch','Display','none','UseParallel',true,'MaxIterations',30);
 [x,fval] = patternsearch(f,ini,[],[],[],[],lb,ub,[],options);
fval
toc
[a,ydim]=evalu(x,velx,posy,dens,steps);
velxall(kk)=velx;
posyall(kk)=posy;
densall(kk)=dens;
xall(kk)=x;
fvalall(kk)=fval;
len=length(ydim);
kk
% ydimall(1:len,1,kk)=ydim(:,1)';
% ydimall(1:len,2,kk)=ydim(:,3)';
end
% y=@(v) 8.58*v.^5-1.6*v.^4-6.1*v.^3+3.8*v.^2-4.8*v.^1-2.03*v.^0.1+7.1*v.^0.5+9.3;
% v1=0:0.001:1;
% plot(v1,y(v1))

save data_human_Ro.mat


