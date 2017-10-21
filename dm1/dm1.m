[pts, pts3d] = readcalib(0);

%homogeneous coordinates of the 3D points
for i=1:length(pts3d)
    ptsHom(i, :) = [pts3d(:, i)', 1];
end

%the P matrix
P = [];
 for i=1:length(pts3d)
     line1 = [ptsHom(i, :), zeros(1, 4), -pts(1,i).*ptsHom(i, :)];
     line2 = [zeros(1, 4), ptsHom(i, :), -pts(2,i).*ptsHom(i, :)];
     P = [P; line1; line2];
 end

%the best fit wrt the linear least-square method is the unit eigenvector
%associated to the smallest eigenvalue of P'*P

[V, D] = eig(P'*P);

m = V(:, 1);

m1 = m(1:4);
m2 = m(5:8);
m3 = m(9:12);

M = [m1'; m2'; m3'];

a1 = M(1, 1:3);
a2 = M(2, 1:3);
a3 = M(3, 1:3);
b = M(:, 4);

%recovering the intrinsic parameters ?, ?, x0, y0 and ?

epsilon = -1;
rho = epsilon/norm(a3);
rho2 = rho*rho;
r3 = rho.*a3;
x0 = rho2*dot(a1,a3);
y0 = rho2*dot(a2,a3);
costheta = -dot(cross(a1, a3), cross(a2, a3))/(norm(cross(a1, a3))*norm(cross(a2,a3)));
theta = acos(costheta); %89.95 degrees
alpha = rho2*norm(cross(a1, a3))*sin(theta);
beta = rho2*norm(cross(a2, a3))*sin(theta);
r1 = cross(a2,a3)/norm(cross(a2,a3));
r2 = cross(r3, r1);
K = [alpha, -alpha/tan(theta), x0; 0, beta/sin(theta), y0; 0, 0, 1];
t = rho.*inv(K)*b; %t3 is negative, as intended

%the original points
%plot(pts(1,:), pts(2,:), 'o'); hold on;


for i=1:length(ptsHom)
    proj = M*ptsHom(i, :)';
    ptsProj(i, :) = [proj(1)/proj(3), proj(2)/proj(3)];
end

%plot(ptsProj(:, 1), ptsProj(:, 2), 'x');

msde = sqrt(sum((pts(1,:)'-ptsProj(:, 1)).^2 + (pts(2,:)'-ptsProj(:, 2)).^2)/length(pts))
