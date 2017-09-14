% This functions calculates the number of the  
% next surface that the ray hit

function [k] = new_distances(xn,zn,ray,s,valid)
    N=length(xn);
    % d = vector with the distances between the ray
    % and all the intersection points of the ray
    % with the optical lines
    d = sqrt((xn-ray.x).^2+(zn-ray.z).^2);
    t = 1;
    % valid distances is a vector with the following components:
    % 1. the distance between the ray and the line that it leaves (around 0)
    % 2. the distance between the ray and the next line it hits
    % 3. -1 for the others intersections
    for j = 1:N
        if(valid(j)==1 && s(j)>=0)
            valid_distances(t) = d(j);
        else
            valid_distances(t) = -1;
    
        end
            t = t+1;
    end
%     d
%     valid_distances
    
    [dmax,k] = max(valid_distances);
    if(dmax~=-1)
        k=k;
    else
        k=4;
    end
    
%     count = 0;
%     distances = valid_distances;
%     y = find(valid_distances==-1);
%     distances(y) = [];
%     for i = 1:length(valid_distances)
%         if(valid_distances(i) ~= -1 && i~=ray.surface && ray.surface~=-1)
%             count = count+1;
%         end
%     end
%     if(count==1)
%       [dmax,k] = max(valid_distances);
%     else
%       [dmax, k] = min(distances);
%       k = find(valid_distances==dmax);
%     end
   