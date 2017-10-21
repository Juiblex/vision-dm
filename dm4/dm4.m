[points1, points2, edges] = readdata();

fig = 1;
for normalize = [false true]
    
    if normalize
        F = fundamental_hartley(points1, points2);
    else
        F = fundamental(points1, points2);
    end
    
    points1hom = [points1; ones(1, size(points1, 2))];
    points2hom = [points2; ones(1, size(points2, 2))];
    
    %epipolar lines
    epilines1 = F' * points1hom;
    epilines2 = F * points2hom;
    
    %square distances
    dist1 = sum(points1hom .* epilines1, 1) .^ 2;
    dist1 = dist1 ./ sum(epilines1(1:2, :) .^ 2, 1);
    
    dist2 = sum(points2hom .* epilines2, 1) .^ 2;
    dist2 = dist2 ./ sum(epilines2(1:2, :) .^ 2, 1);
    
    %average distances to the epipolar lines
    avgdist = mean([sqrt(dist1) sqrt(dist2)])
    
    figure(fig)
    fig = fig+1;
    plot2dedges(points1,edges);
    
    lines1 = zeros(size(points1,2), 4); %each line is [x1, x2, y1, y2] where we want to
    %plot a line from (x1, y1) to (x2, y2)
    
    % x coordinates
    lines1(:, 1) = points1(1, :)' - 50;
    lines1(:, 2) = points1(1, :)' + 50;
    % y coordinates
    %lines1(:, 3:4) = - (lines1(:, 1:2) .* epilines1(1, :)' + epilines1(3, :)') ./ epilines1(2, :)';
    lines1(:, 3) = - (lines1(:, 1) .* epilines1(1, :)' + epilines1(3, :)') ./ epilines1(2, :)';
    lines1(:, 4) = - (lines1(:, 2) .* epilines1(1, :)' + epilines1(3, :)') ./ epilines1(2, :)';
    
    % ploting
    hold on
    for k = 1:size(lines1,1)
        plot(lines1(k, 1:2), lines1(k, 3:4), 'Color','g','LineWidth',1);
    end
    hold off
    
    if normalize
        saveas(gcf, 'epipolar_lines_Hartley1.png')
    else
        saveas(gcf, 'epipolar_lines1.png')
    end
    
    figure(fig)
    fig = fig+1;
    plot2dedges(points2,edges);
    
    lines2 = zeros(size(points2,2), 4);
    % x coordinates
    lines2(:, 1) = points2(1, :)' - 50;
    lines2(:, 2) = points2(1, :)' + 50;
    % y coordinates
    %lines2(:, 3:4) = - (lines2(:, 1:2) .* epipolar2(1, :)' + epipolar2(3, :)') ./ epipolar2(2, :)';
    lines2(:, 3) = - (lines2(:, 1) .* epilines2(1, :)' + epilines2(3, :)') ./ epilines2(2, :)';
    lines2(:, 4) = - (lines2(:, 2) .* epilines2(1, :)' + epilines2(3, :)') ./ epilines2(2, :)';
    
    hold on
    for k = 1:size(lines2,1)
        plot(lines2(k, 1:2), lines2(k, 3:4), 'Color','g','LineWidth',1);
    end
    hold off
    
    if normalize
        saveas(gcf, 'epipolar_lines_Hartley2.png')
    else
        saveas(gcf, 'epipolar_lines2.png')
    end
end
