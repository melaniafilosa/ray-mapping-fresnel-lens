% This function computes the ray tracing given the position and the
% direction of the ray and the optical system

function [zout, thetaout,last_surface] = ...
           mc_raytracing(surfaces, z , tau, variables)

graf = 0;

a = 2;
k = -1;
% (x,z) = coordinates of the initial position 
ray.x = surfaces(1).x(1);  
ray.z = z;  
ray.n = 1;
% Initial angle with respect to the optical axis
% Ray direction
ray.sz = tau;
ray.sx = sqrt(1-tau^2);
% store initial conditions for debugging
% ray.n=1;                           % we start in air
ray_source = ray;
s = zeros(length(surfaces) ,1);                        
% s = parameter for the ray parameterization
xn = zeros(length(surfaces) ,1);                  % xn(i) = x-s(i)*sin(theta)
zn = zeros(length(surfaces) ,1);                  % zn(i) = z+s(i)*cos(theta)

surfaces_hit = 0;

while( k~=4 && k~=5 && k~=6  && k~=1 && k~=7 && surfaces_hit<100)
    surfaces_hit = surfaces_hit+1;
    x0 = ray.x;                            
    z0 = ray.z;
    for  i=1:length(surfaces)
          [xn(i),zn(i),s(i), valid(i)] = ...
              surfaces(i).intersection(ray, surfaces(i), variables);
    end
  
    [k] = distances(xn,zn,ray,s,valid);    
    %  disp([' closest intersection from surface ',num2str(k),' ',surfaces(k).name]);
    % (x,z) = coordinates of the closer intersection
    if(k~=7)
        ray.x = xn(k);                        
        ray.z = zn(k);

       % plot([x0, xn(k)], [z0, zn(k)], ' g', 'linewidth', 1.2); 
        a = a+1;
        % plot the path of the rays

        [ray1, ray2,ray,check, energy] = surfaces(k).action(ray,surfaces(k), ...
                                                  k, x0, z0, variables, 1);
    end
    if ( graf)
         figure(3)
         hold on
         if(check)
             plot([x0, xn(k)], [z0, zn(k)], ' m', 'linewidth', 1.2); 
             % plot([ray1.x, xn(k)], [ray1.z, zn(k)], ' -- g', 'linewidth', 1.2);
         else
             plot([x0, xn(k)], [z0, zn(k)], ' g', 'linewidth', 1.2);
             % plot([ray2.x, xn(k)], [ray2.z, zn(k)], '-- m', 'linewidth', 1.2);
         end
        % plot([x0, xn(k)], [z0, zn(k)], '* m', 'linewidth', 1.2);
     end
%     if(k==2 || k==3)
%         for  i=1:length(surfaces)
%               [xn1(i),zn1(i),s1(i), valid1(i)] = ...
%                   surfaces(i).intersection(ray1, surfaces(i), variables);
%               [xn2(i),zn2(i),s2(i), valid2(i)] = ...
%                   surfaces(i).intersection(ray2, surfaces(i), variables);
% 
%         end

%         [k1] = distances(xn1,zn1,ray1,s1,valid1);
%         [k2] = distances(xn2,zn2,ray2, s2,valid2);
%         plot([ray1.x, xn1(k1)], [ray1.z, zn1(k1)], '-- c')
%         plot([ray2.x, xn2(k2)], [ray2.z, zn2(k2)], '-- b')
%    end
%       if(R == 1)
%        figure(1)
%        hold on
%        plot([x0, xn(k)], [z0, zn(k)], ' m', 'linewidth', 1.2);
%        end
 end   % end while


 % xout = xn(k);
 if(k~=7)
     zout = zn(k);
     thetaout = ray.sz;
     last_surface =  k;
 else
     xout= 0;                        
     zout = 0;
     thetaout = tau;
     last_surface = k;
 end