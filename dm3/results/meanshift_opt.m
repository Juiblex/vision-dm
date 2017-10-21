%% Mean-shifting main algorithm

function [labels, peaks] = meanshift_opt(data, r, c)

[dims, nbpts] = size(data);

%We give the first point its peak for initialization
[peaks(:,1), cpts(1,:)] = findpeak_opt(data, 1, r, c);
labels(1) = 1;
nbpeaks = 1;

for i=2:nbpts
    cpeaks = find(cpts(:,i));
    if size(cpeaks) > 0
        label = cpeaks(1);
    else
        [newpeak, newcpts] = findpeak_opt(data, i, r, c);
        distpeaks = ml_sqrDist(newpeak, peaks);
        label = nbpeaks+1;
        for j=1:nbpeaks
            if distpeaks(j) < (r/2)*(r/2) % discard our new peak
                label = j;
            end
        end
    end
    labels(i) = label;
    if label == nbpeaks+1
        peaks(:, nbpeaks+1) = newpeak;
        cpts(nbpeaks+1, :) = newcpts;
        nbpeaks = nbpeaks+1;
    end
end