function F = fundamental_hartley(points1, points2)

nbpoints = size(points1, 1);

%rescaling
mean1x = mean(points1(1, :));
mean1y = mean(points1(2, :));
mean2x = mean(points2(1, :));
mean2y = mean(points2(2, :));
points1(1, :) = points1(1, :) - mean1x;
points1(2, :) = points1(2, :) - mean1y;
points2(1, :) = points2(1, :) - mean2x;
points2(2, :) = points2(2, :) - mean2y;
var1 = sqrt(mean(sum(points1 .^ 2, 1)/2));
var2 = sqrt(mean(sum(points2 .^ 2, 1)/2));
points1 = points1 ./ var1;
points2 = points2 ./ var2;


for i=1:nbpoints
    M(i, 1) = points1(1,i)*points2(1,i);
    M(i, 2) = points1(1,i)*points2(2,i);
    M(i, 3) = points1(1,i);
    M(i, 4) = points1(2,i)*points2(1,i);
    M(i, 5) = points1(2,i)*points2(2,i);
    M(i, 6) = points1(2,i);
    M(i, 7) = points2(1,i);
    M(i, 8) = points2(2,i);
    M(i, 9) = 1;
end

[U, S, V] = svd(M);

f = V(:,9); %singular vector associated with the smallest singular value of M
F = reshape(f,3,3);
T1 = [[1 0; 0 1; 0 0] [-mean1x; -mean1y; var1]] ./ var1;
T2 = [[1 0; 0 1; 0 0] [-mean2x; -mean2y; var2]] ./ var2;
F = (T1') * F * T2;