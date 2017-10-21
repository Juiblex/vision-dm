function m_gradeHW6(andrewID, surfix)

%submission directory:
baseDir = 'D:\Study\CV16720_TA\HWs\HW6_writeup\submission\hw6\';
dataDir = 'D:\Study\CV16720_TA\HWs\HW6\data\';
% surfix = '/';
fileExt = 'png';

try 
    % load 8 results images
    imNames = {'man', 'star', 'sheep', 'hat'};
    nR = 2; nC = 2;
    figure(1); clf;
    for i=1:length(imNames)
        try
            im = imread([baseDir, andrewID, '/', surfix, imNames{i}, '_labels.' fileExt]);
            subplot(nR, nC, i); imshow(im);
        catch ME
            fprintf('%s\n', ME.message);
        end;
    end;
    title(andrewID);

    figure(2); clf;
    for i=1:length(imNames)
        try
            im = imread([baseDir, andrewID, '/', surfix, imNames{i}, '_peaks.' fileExt]);
            subplot(nR, nC, i); imshow(im);
        catch ME
            fprintf('%s\n', ME.message);
        end;
    end;
    title(andrewID);
catch ME
    fprintf('%s\n', ME.message);
end

try
    figure(3); clf;
    for i=1:3
        load([dataDir, '/', sprintf('testdata%d.mat', i)]); 
        rslt = load([baseDir, andrewID, '/', surfix, ...
            sprintf('results%d.mat', i)]); 
        subplot(nR, nC, i); plot3dclusters(data, rslt.labels, rslt.peaks);
        title(sprintf('# clusters: %d\n', size(rslt.peaks,2)));
        fprintf('number of clusters for testdata%d.mat is %d\n', i, size(rslt.peaks,2));    
    end;
    subplot(nR,nC, 4); title(andrewID);
catch ME
    fprintf('%s\n', ME.message);
end    