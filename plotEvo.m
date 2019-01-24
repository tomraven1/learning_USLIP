function plotEvo(ydim,yevdim,xtdim)

plot(ydim(:,1),ydim(:,3))
hold on
grid on
 plot(xtdim(),0,'ks');
plot(yevdim(:,1),yevdim(:,3),'rs');


for i=1:length(xtdim)
line([xtdim(i) yevdim(2*i-1,1)],[0 yevdim(2*i-1,3)],'Color','red')
line([xtdim(i) yevdim(2*i,1)],[0 yevdim(2*i,3)],'Color','black')

end

end