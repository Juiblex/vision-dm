function [segmIm, peakIm] = segment_meanshift(I, r, c)

[lins, cols] = size(I(:, :, 1));
for i=1:3
    Im(i, :) = reshape(I(:,:,i), [1, lins*cols]);
end
Im = double(Im)/256.0;
Im = rgb2luv(Im);

[labels, peaks] = meanshift_opt(Im, r, c);

for i=1:lins*cols
    Im(:, i) = peaks(:, labels(i));
end

segmIm = reshape(labels, [lins, cols]);

Im = luv2rgb(Im);
Im = uint8(Im*256);
for i=1:3
    peakIm(:, :, i) = reshape(Im(i, :), [lins, cols]);
end
