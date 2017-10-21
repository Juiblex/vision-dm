%% Non-local-maximum thresholding

function imgnon = nonmax(imgdx, imgdy, imgmag)

[imax, jmax] = size(imgmag);
imgdx = scale(imgdx);
imgdy = scale(imgdy);
imgnon = imgmag;
for i=2:imax-1
    for j=2:jmax-1
        p = 0;
        q = 0;
        theta = atan2(imgdy(i, j), imgdx(i, j));
        if theta < 0 %these cases are symmetric
            theta = theta + pi;
        end
        if theta < pi/4
            t = tan(theta);
            p = (1-t)*imgmag(i+1,j)+t*imgmag(i+1,j-1);
            q = (1-t)*imgmag(i-1,j)+t*imgmag(i-1,j+1);
        elseif theta < pi/2
            t = tan(pi/2-theta);
            p = (1-t)*imgmag(i,j-1)+t*imgmag(i+1,j-1);
            q = (1-t)*imgmag(i,j+1)+t*imgmag(i-1,j+1); 
        elseif theta < 3*pi/4
            t = tan(theta-pi/2);
            p = (1-t)*imgmag(i,j-1)+t*imgmag(i-1,j-1);
            q = (1-t)*imgmag(i,j+1)+t*imgmag(i+1,j+1);
        else
            t = tan(pi-theta);
            p = (1-t)*imgmag(i-1,j)+t*imgmag(i-1,j-1);
            q = (1-t)*imgmag(i+1,j)+t*imgmag(i+1,j+1);
        end
        if imgmag(i, j) < max(p, q)
            imgnon(i, j) = 0;
        end
    end
end
