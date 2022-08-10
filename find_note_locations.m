function [ locs_x, locs_y ] = find_note_locations( subimg, n )
% FIND NOTE LOCATIONS 
%   Inputs, binary images and number of subimages
%   Outputs, subimages stored in cells

    % Structuring elements that looks like note heads
    se_disk_small = strel('disk', 1);

    se_disk = strel('disk', 4);
    se_disk_large = strel('disk', 5);

    subimg_temp = [];

    for i_img=1:n

        % Filter out round objects i.e. note heads
        subimg_temp{i_img} = imerode(subimg{i_img},se_disk);

        % Get all objects areas
        L = bwlabel(subimg_temp{i_img});
        note_heads = regionprops(L, 'Area');
        m_area = median([note_heads.Area]);
        
        subimg_temp{i_img} = imerode(subimg_temp{i_img},se_disk_small);

        
        % Remove noise smaller than 40% of the maximal object
        %subimg_temp{i_img} = xor(bwareaopen(subimg_temp{i_img}, round(m_area*0.8)),...
         %   bwareaopen(subimg_temp{i_img}, round(m_area*1.2)));

        % Merge close objects
        subimg_temp{i_img} = imdilate(subimg_temp{i_img},se_disk_large);
        subimg_temp{i_img} = subimg_temp{i_img} > 0.01;
        
        % Print detected notes as an overlay on the image
        %overlay = imoverlay(subimg{i_img}, subimg_temp{i_img}, [.3 1 .3]);
        %figure;
        %imshow(overlay);
        
        % Find locations of the note head based on their centroids
        note_heads = regionprops(subimg_temp{i_img}, 'Centroid');
        centroids = cat(1, note_heads.Centroid);
        locs_x{i_img} = centroids(:,1);
        locs_y{i_img} = centroids(:,2);
    end 
end

