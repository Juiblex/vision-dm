function imgb = bump(img)

[imax, jmax] = size(img);
imgb = zeros(imax, jmax);
for i=1:imax
    for j=1:jmax
        if img(i, j) > 0
            imgb(i, j) = 1;
        end
    end
end
