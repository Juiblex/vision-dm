%% Hysteresis thresholding -- simpler algorithm

function imghys = hyster(imgdx, imgdy, imgmag, hthres, lthres)

imgnonmax = nonmax(imgdx, imgdy, imgmag);
[imax, jmax] = size(imgmag);
decals = [[-1, -1]', [-1, 0]', [-1, 1]', [0, -1]', [0, 1]', [1, -1]', [1, 0]', [1, 1]']';
ok = false(imax, jmax);

for i=1:imax
    for j=1:jmax
        if imgnonmax(i, j) > hthres
            ok(i, j) = true;
        end
    end
end

changed = true;
while changed
   changed = false;
   for i=1:imax
       for j=1:jmax
           if imgnonmax(i, j) > lthres && ok(i, j) == false
              for d=1:8
                 i1 = i+decals(d, 1);
                 j1 = j+decals(d, 2);
                 if i1 > 0 && i1 <= imax && j1 > 0 && j1 <= jmax && ok(i1, j1)
                     ok(i, j) = true;
                     changed = true;
                 end
              end
           end
       end
   end
end

imghys = zeros(imax, jmax);
for i=1:imax
    for j=1:jmax
        if ok(i, j)
            imghys(i, j) = 1;
        end
    end
end