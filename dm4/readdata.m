function [points1,points2,edges]=readdata()
% Lifia data, including points and images
[datamat,points3d,edges]=readlifiamult(1);
% Choice of frames: 2 and 5
frame1=2;
frame2=5;
% Setting up the points
points1=datamat(2*frame1-1:2*frame1,:);
points2=datamat(2*frame2-1:2*frame2,:);



%% Reads lifia data, asking for the source directory, and returning either
%% a dense (i=1 or 2) or a sparse (different value of i) data matrix with point
%% indices in the top row and successive u v coordinates in the following
%% rows, as well as the corresponding 3d points. If i=1, the data matrix is
%% formed by the 6 first images of the 38 first points, and if i=2 it is
%% formed by eliminating non-full columns. For the time being, if i=1, we also
%% strip the first row of indices from the 3d points and data matrix.
function [datamat,pts3d,edges]=readlifiamult(i);
%% Reads the 3D points.
pts3d=rlf3dpts('pt_3D');
s=size(pts3d);
n=s(2);
mat=zeros(18,n);
mat=[];
for j=1:9
  mat=[mat;rlf2dpts(n,sprintf('pt_2D%i',j))];
  end;
if i==1
  % datamat=[1:38;mat(1:12,1:38)];
  % pts3d=pts3d(:,1:38);
  datamat=mat(1:12,1:38);
  pts3d=pts3d(2:4,1:38);
  elseif i==2
  removenonfullcols(mat);
  else
  datamat=[1:n;mat];
  end;
s=size(datamat);
n=s(2);
%% Reads the edges
edges=rlfedges('edges',n);


function datamat=removenonfullrows(mat)
s=size(mat);
n=s(1);
datamat=1:n;
for i=1:n
  s=size(find(mat(i,:)==0));
  if s(2)==0
     datamat=[datamat;mat(i,:)];
     end;
  end;

function datamat=removenonfullcols(mat)
s=size(mat);
n=s(2);
datamat=[];
for i=1:n
  s=size(find(mat(:,i)==0));
  if s(1)==0
     datamat=[datamat [i; mat(:,i)]];
     end;
  end;

function mat=rlf2dpts(size,filename)
fid=fopen(filename);
n=fscanf(fid,'%3d',1);
pts=fscanf(fid,'%i%f%f',[3,n]);
mat=zeros(2,size);
for i=1:n
mat(:,pts(1,i))=[pts(3,i);513-pts(2,i)];
    end;
fclose(fid);

function pts=rlf3dpts(filename)
fid=fopen(filename);
n=fscanf(fid,'%3d',1)
pts=fscanf(fid,'%i%f%f%f',[4,n]);

function edges=rlfedges(filename,npts)
fid=fopen(filename);
[edges,nedges]=fscanf(fid,'%f',[2,inf]);
nedges=nedges/2
size(edges)
nedges
fclose(fid);

