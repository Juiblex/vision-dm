hat = imread('data/hat.png');
star = imread('data/star.png');
man = imread('data/man.png');
sheep = imread('data/sheep.png');
r = [20, 10, 5];
c = [1, 2, 4];

for i=1:3
    for j=1:3
        [shat, phat] = segment_meanshift(hat, r(i), c(j));
        imwrite(phat, strcat('results/hat', int2str(r(i)), int2str(c(j)), '.png'));
        [sstar, pstar] = segment_meanshift(star, r(i), c(j));
        imwrite(pstar, strcat('results/star', int2str(r(i)), int2str(c(j)), '.png'));
        [sman, pman] = segment_meanshift(man, r(i), c(j));
        imwrite(pman, strcat('results/man', int2str(r(i)), int2str(c(j)), '.png'));
        [ssheep, psheep] = segment_meanshift(sheep, r(i), c(j));
        imwrite(psheep, strcat('results/sheep', int2str(r(i)), int2str(c(j)), '.png'));
    end
end

imshow(peakstar);