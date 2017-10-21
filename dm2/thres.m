function imgt = thres(imgmag, hthres)

[imax, jmax] = size(imgmag);
imgt = imgmag;
for i=1:imax
    for j=1:jmax
        if imgmag(i, j) < hthres
            imgt(i, j) = 0;
        else
            imgt(i, j) = 1;
        end
    end
end