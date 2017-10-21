%% Mean-shifting
% The peak function returns the mean of all the points at distance less
% than r from the point idx
function peak = findpeak(data, idx, r)

epsilon = 0.01;
epsilon2 = epsilon*epsilon;
r2 = r*r;
pos = data(:, idx); %starting position
move = true;

while move
    dists = ml_sqrDist(pos, data);
    close = data(:, dists < r2); % close enough elements
    newpos = (sum(close, 2)/size(close,2));
    if sum((newpos-pos).^2) < epsilon2
        move = false;
    end
    pos = newpos;
end

peak = pos;