%% Input
lena = im2double(imread('lena.jpg'));
cat = im2double(rgb2gray(imread('cat.jpg')));

%% Constants
sigma = 3;
fsize = 20;
hthres = 0.15;
lthres = 0;

%% 1D filters
x = linspace(-fsize / 2, fsize / 2, fsize);
gx = exp(-x .^ 2 / (2 * sigma ^ 2));
gy = gx';
dgx = -x .* exp(-x .^ 2 / (2 * sigma ^ 2));
dgy = dgx';

%% Magnitude
lenadx = imfilter(imfilter(lena, gy), dgx);
lenady = imfilter(imfilter(lena, gx), dgy);
lenamag = scale(sqrt(lenadx .* lenadx + lenady .* lenady));
catdx = imfilter(imfilter(cat, gy), dgx);
catdy = imfilter(imfilter(cat, gx), dgy);
catmag = scale(sqrt(catdx .* catdx + catdy .* catdy));


%% Simple thresholding (cf. thres.m)
lenast = thres(lenamag, hthres);
catst = thres(catmag, hthres);

%% Non-maximum thresholding (cf. nonmax.m)
lenanon = nonmax(lenadx, lenady, lenamag);
lenanont = thres(lenanon, hthres);
lenanon = bump(lenanon);
catnon = nonmax(catdx, catdy, catmag);
catnont = thres(catnon, hthres);
catnon = bump(catnon);

%% Hysteresis thresholding (cf hyster.m)
lenahys = hyster(lenadx, lenady, lenamag, hthres, lthres);
cathys = hyster(catdx, catdy, catmag, hthres, lthres);

%% Output
path = strcat('~/Work/ENS/1617/Vision/dm2/img/sigma', num2str(sigma), '/');
ext = '.png';
%imwrite(lenadx, strcat(path, 'lenadx', ext));
%imwrite(lenady, strcat(path, 'lenady', ext));
%imwrite(lenamag, strcat(path, 'lenamag', ext));
%imwrite(lenast, strcat(path, 'lenast', ext));
%imwrite(lenanon, strcat(path, 'lenanon', ext));
%imwrite(lenanont, strcat(path, 'lenanont', ext));
imwrite(lenahys, strcat(path, 'lenahys0', ext));
%imwrite(catdx, strcat(path, 'catdx', ext));
%imwrite(catdy, strcat(path, 'catdy', ext));
%imwrite(catmag, strcat(path, 'catmag', ext));
%imwrite(catst, strcat(path, 'catst', ext));
%imwrite(catnon, strcat(path, 'catnon', ext));
%imwrite(catnont, strcat(path, 'catnont', ext));
imwrite(cathys, strcat(path, 'cathys0', ext));