function [zout, thetaout,last_surface]=mc_raytracing1(surfaces, z , tau, variables)

graf = 0;

a=2;
k = -1;
% k0 = 1;
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

s = zeros(length(surfaces) ,1);                        
% s = parameter for the ray parameterization
xn = zeros(length(surfaces) ,1);                  % xn(i) = x- s(i)*sin(theta)
zn = zeros(length(surfaces) ,1);                  % zn(i) = z+ s(i)*cos(theta)

surfaces_hit = 0;

while( k~=6 && k~=7 && k~=8 && k~=1 && surfaces_hit<100)
    surfaces_hit = surfaces_hit+1;
    if(graf)
      x0 = ray.x;                            
      z0 = ray.z;
    end
    for  i=1:length(surfaces)
          [xn(i),zn(i),s(i), valid(i)] = surfaces(i).intersection(ray, surfaces(i), variables);
    end
    
    [k] = distances(xn,zn,ray,s,valid);
%     if(k==6 && abs(zn(6))>10^-5)
%         k
%         plot([x0, xn(k)], [z0, zn(k)], ' g', 'linewidth', 1.2);
%     end
%     if(k==-1)
%         hold on
%         plot(xn, zn, '* r')
%     end
    %  disp([' closest intersection from surface ',num2str(k),' ',surfaces(k).name]);
    % (x,z) = coordinates of the closer intersection
    ray.x = xn(k);                        
    ray.z = zn(k);
    % plot([x0, xn(k)], [z0, zn(k)], ' g', 'linewidth', 1.2); 
    a = a+1;
    % plot the path of the rays
    if ( graf)
         figure(3)
         hold on
         plot([x0, xn(k)], [z0, zn(k)], ' m', 'linewidth', 1.2); 
         % plot([x0, xn(k)], [z0, zn(k)], '* m', 'linewidth', 1.2);
    end
    ray = surfaces(k).action(ray,surfaces(k), k);
%     [xn(6),zn(6),s(6), valid(6)] = surfaces(6).intersection(ray, surfaces(6));
%  
%      k=6;
%      ray.x = xn(k);
%      ray.z = zn(k);
%     
%     plot([xn(2) xn(6)], [zn(2) zn(6)], 'g')
 end   % end while


 zout = zn(k);
 thetaout = ray.sz;
 last_surface =  k;