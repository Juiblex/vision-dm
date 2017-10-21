function [data,labels,centers] = generatedata(NDIM,npeaks,npoints)
%generates data npeaks peaks
%Author: Tomasz Malisiewicz
%Last modified by Minh Hoai Nguyen on 13 Nov 08
% 

if ~exist('NDIM', 'var')
  NDIM = 3;
end

if ~exist('npeaks', 'var')
  npeaks = 3;
end

if ~exist('npoints', 'var')
  npoints = 500;
end

%factor controls how evenly spaced the clumps are
factor = npeaks*1;


centers = factor*randn(NDIM,npeaks);

data = [];
labels = [];

for i = 1:npeaks
  curdata = randn(NDIM,npoints);
  matty = randn(NDIM,NDIM);
  [u,w,v] = svd(matty);
  w = diag(randn(NDIM,1)*.5+1);
  matty = u*w*u';

  curdata = matty*curdata;
  curdata = curdata + repmat(centers(:,i),1,npoints);

  data = [data curdata];
  labels = [labels i*ones(npoints,1)];
end
