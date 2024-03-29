function [ staff_lines ] = staff_line_identification( bw_image )
% STAFF LINE IDENTIFICATION 
%   Inputs, binary image
%   Outputs, positions and cluster of the staff lines
    % Erosion of horizontal lines 
    se_line = strel('line', length(bw_image)*0.005, 0);
    bw_image = imerode(bw_image, se_line);

    %figure
    %imshow(bw_image)
    % Plot the horizontal projection
    %figure
    %plot(sum(bw_image,2), fliplr(1:size(bw_image,1)));
    
    % Find locations using Horizontal projection
    [pks, locs] = findpeaks(sum(bw_image,2));

    % Remove all unrelevant peaks based on threshold
    % Can be improved by using cluster classification
    % median(diff())
    tresh = pks > max(pks)/5;
    locs = locs .* tresh;
    pks = pks .* tresh;

    pks_tresh = pks(pks~=0);
    locs_tresh = locs(locs~=0);
    staff_lines = [];
    
    % Classification of stafflines clusters
    if mod(length(locs_tresh), 5) == 0
        staff_lines = locs_tresh;
    else
        staff_lines = locs_tresh; 
        
        % Remove shortest line until the systems consist of 5 lines
        while ~ mod(length(staff_lines), 5) == 0
            index = find(pks_tresh == min(pks_tresh));
            pks_tresh(index) = [];
            staff_lines(index) = [];
            
            pks_tresh = pks_tresh(pks_tresh~=0);
            staff_lines = staff_lines(staff_lines~=0);
        end
    end
end



