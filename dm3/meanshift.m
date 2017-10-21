%% Mean-shifting main algorithm

function [labels, peaks] = meanshift(data, r)

[dims, nbpts] = size(data);

%We give the first point its peak for initialization
peaks(:,1) = findpeak(data, 1, r);
labels(1) = 1;
nbpeaks = 1;

for i=2:nbpts
    closepeaks = find(ml_sqrDist(data(:,i),peaks)<r*r);
    if size(closepeaks) > 0
        label = closepeaks(1);
    else
        newpeak = findpeak(data, i, r);
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
        nbpeaks = nbpeaks+1;
    end
end