function F = fundamental(points1, points2)

nbpoints = size(points1, 1);

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