%% Hysteresis thresholding

function imghys = hyster2(imgdx, imgdy, imgmag, hthres, lthres)

import java.util.ArrayDeque;

imgnonmax = nonmax(imgdx, imgdy, imgmag);
[imax, jmax] = size(imgmag);
imghys = zeros(imax, jmax);
seen = false(imax, jmax);
ok = false(imax, jmax);
nodes = ArrayDeque();
decals = [[-1, -1]', [-1, 0]', [-1, 1]', [0, -1]', [0, 1]', [1, -1]', [1, 0]', [1, 1]']';

for i=1:imax
    for j=1:jmax
        if imgnonmax(i, j) > hthres
            nodes.add([i, j]);
            ok(i, j) = true;
        end
    end
end

while nodes.isEmpty() == false
    n = nodes.remove();
    i = n(1);
    j = n(2);
    if seen(i, j) == false
       seen(i, j) = true;
       if ok(i, j) == true
           for dec=1:8
               i1 = i+decals(dec, 1);
               j1 = j+decals(dec, 2);
               if i1 > 0 && i1 <= imax && j1 > 0 && j1 <= jmax
                   if imgnonmax(i1, j1) > lthres
                       ok(i1, j1) = true;
                       nodes.add([i1, j1]);
                   end
               end
           end
       end
    end
end

for i=1:imax
    for j=1:jmax
        if ok(i, j)
            imghys(i, j) = imgnonmax(i, j);
        end
    end
end
            