function [ out_image ] = remove_stafflines( in_image, staff_lines )
% REMOVE STAFFLINES
%   Inputs, binary image and location of staff lines
%   Outputs, binary image without staff lines
    out_image = in_image;
    for i=1:length(staff_lines(:))
        % Alternative method for removing staff line while without cutting
        % the notes where the staff lines are
        %for j=1:length(out_image(1,:))
            %if ~(out_image(staff_lines(i)-2, j) == 1 ...
                    %&& out_image(staff_lines(i)+2, j) == 1)
                %out_image(staff_lines(i)-1, j) = 0;
                %out_image(staff_lines(i), j) = 0;
                %out_image(staff_lines(i)+1, j) = 0;
            %end
        %end
        out_image(staff_lines(i)-1, :) = 0;
        out_image(staff_lines(i), :) = 0;
        out_image(staff_lines(i)+1, :) = 0;
    end
end

