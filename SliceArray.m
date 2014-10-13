function [ slice ] = SliceArray( array, x, y )

% @TODO: add description

[M, N] = size(array);
left = 1:ceil(M/2);
right = ceil(M/2)+1:M;
top = 1:ceil(N/2);
bottom = ceil(N/2)+1:N;

if x <= M/2
    if y <= N/2
        slice = array(left, top);   % top_left
    else
        slice = array(left, bottom);    % bottom_left
    end
else
    if y <= N/2
        slice = array(right, top);  % top_right
    else
        slice = array(right, bottom);   % bottom_right
    end
end

end

