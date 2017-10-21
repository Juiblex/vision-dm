function imgs = scale(img)

[imax, jmax] = size(img);
maxI = max(max(img));
minI = min(min(img));
imgs = zeros(imax, jmax);

for i=1:imax
    for j=1:jmax
        imgs(i, j) = (img(i, j) - minI)/(maxI-minI);
    end
end