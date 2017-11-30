% This function computes the ray tracing given the position and the
% direction of the ray and the optical system

function [reflected, transmitted, R, T] = ...
           raytracing(ray, surfaces, variables)

k = -1;
x0 = ray.x;
z0 = ray.z;
% (x,z) = coordinates of the initial position 
% ray.x = surfaces(4).x(1);  
% ray.z = z;  
% ray.n = 1;
% % Initial angle with respect to the optical axis
% % Ray direction
% ray.sz = tau;
% ray.sx = -sqrt(1-ray.sz^2);
% store initial conditions for debugging
% ray.n=1;                           % we start in air
% s = parameter for the ray parameterization
s = zeros(length(surfaces) ,1);                        

xn = zeros(length(surfaces) ,1);          % xn(i) = x-s(i)*sin(theta)
zn = zeros(length(surfaces) ,1);          % zn(i) = z+s(i)*cos(theta)


for  i=1:length(surfaces)
      [xn(i),zn(i),s(i), valid(i)] = ...
          surfaces(i).intersection(ray, surfaces(i), variables);
end
plot(xn(k), zn(k), '*')
[k] = distances(xn,zn,ray,s,valid);    
if(k==-1)
   % disp('Error')
end
%  disp([' closest intersection from surface ',num2str(k),' ',surfaces(k).name]);
% (x,z) = coordinates of the closer intersection
if(k~=7)
    ray.x = xn(k);                        
    ray.z = zn(k);
    ray.surface = k;
    figure(4)
    hold on
    plot([x0, xn(k)], [z0, zn(k)], ' g', 'linewidth', 1.2);
    [reflected, transmitted, R, T] = surfaces(k).action(ray,surfaces(k),...
                                                        k,variables);
else
    ray.surface = k;
    R = 0;
    T = 0;
    reflected = ray;
    transmitted = ray;
    if(ray.n==1)
        transmitted.n=1.5;
    else
        transmitted.n=1;
    end
end
% if(R==0 || T==0)
%     disp('R or T is 0')
% end


