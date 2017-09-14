for  i=1:length(surfaces)
          [xn(i),zn(i),s(i), valid(i)] = surfaces(i).intersection(ray, surfaces(i));
end
  
    [k] = distances(xn,zn,ray,s,valid);
    
    %  disp([' closest intersection from surface ',num2str(k),' ',surfaces(k).name]);
    % (x,z) = coordinates of the closer intersection
    out_ray.x = xn(k);                        
    out_ray.z = zn(k);
    