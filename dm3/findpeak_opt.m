%% Mean-shifting
% The peak function returns the mean of all the points at distance less
% than r from the point idx
function [peak, cpts] = findpeak_opt(data, idx, r, c)

epsilon = 0.01;
epsilon2 = epsilon*epsilon;
r2 = r*r;
c2 = c*c;
pos = data(:, idx); %starting position
cpts = false(1, size(data,2));
move = true;

while move
    dists = ml_sqrDist(pos, data);
    close = data(:, dists < r2); %close enough elements to be averaged
    newcpts = dists < r2/c2; %elements "in the path"
    newpos = (sum(close, 2)/size(close,2));
    if sum((newpos-pos).^2) < epsilon2
        move = false;
    end
    pos = newpos;
    cpts = cpts | newcpts;
end

peak = pos;
cpts = cpts | ml_sqrDist(peak, data) < r2; % points at less than r of the peak