function [pts,pts3d]=readcalib(i)
   load cademo;
   pts = data3d(:,4:5)';
   pts3d = data3d(:,1:3)';
   s=size(pts);
   n=s(2);
   for i=1:n, pts(2,i)=576-pts(2,i); end;

