%% This function plots 2D points, and if opt=1, edges as well.
%% All arguments except for points have default values.
function plot2dedges(points,edges,pcolor,ecolor,thickness)
if nargin<5, thickness=2; end;
if nargin<4, ecolor='b'; end;
if nargin<3, pcolor='r'; end;
hold on
axis xy
axis square
axis off
rectangle('position',[1 1 512 512])
s=size(edges);
for i=1:s(2) %s(2)
     p1=edges(1,i);
     p2=edges(2,i);
     h=plot(points(1,[p1 p2]),points(2,[p1 p2]),ecolor);
     set(h,'LineWidth',thickness);
end;
h=plot(points(1,:),points(2,:), sprintf('o%s',pcolor));
set(h,'LineWidth',thickness);
hold off
