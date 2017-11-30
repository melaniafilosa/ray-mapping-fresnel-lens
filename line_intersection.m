% This function compute the intersection point between the source and the
% rays

 % s = parameter for the ray parameterization
 % (x,z) = coordinates of the initial point
 % theta = initial angle with respect to the normal of the surface 
 % xn = x- s*sin(theta) := x-coordinate of the intersection point
 % zn = z+ s*cos(theta) := z-coordinate of the intersection point
 % i = index of the surface hit
 
function [xn,zn,s, valid] = line_intersection(ray,surfaces, variables)
 
num = (ray.z-surfaces.z(1))*(surfaces.x(2)-surfaces.x(1))- ...
      (ray.x-surfaces.x(1))*(surfaces.z(2)-surfaces.z(1));
den = ray.sx*(surfaces.z(2)-surfaces.z(1))- ...
      ray.sz*(surfaces.x(2)-surfaces.x(1));
s = num/den;
xn = ray.x+s*ray.sx;
zn = ray.z+s*ray.sz;
% check if valid crossing (between -2 and 2 in x direction)
if (surfaces.xmin~=surfaces.xmax)
    if (xn>surfaces.xmin && xn<surfaces.xmax)
        valid=1;
    else
        valid=0;
    end;
else
    if (zn>surfaces.zmin && zn<surfaces.zmax)
        valid=1;
    else
        valid=0;
    end;
end;