% This function computes the distances between the initial position of
% the ray and all crossing points of the ray with the 10 surfaces of the
% TIR-collimator.
% It also computes the minimal distance 
% (without considering distances = 0 and negative directions)

% Meaning of the most important variables
% d(t) = distance from the initial surface to the surface t  (10x1 vector)
% dmin = minim distance
% s = parameter of the ray parameterization  (10x1 vector)
% k = index of the minimal distance


function [k] = distances(xn,zn,ray,s, valid)
    N=length(xn);
    d = sqrt((xn-ray.x).^2+(zn-ray.z).^2);
    epsilon_d = 1.0e-11;
   % epsilon = 1.0e-7;
    t = 1;
    k = -1;
    dmin = 0;
    epsilon_s = 10^-15;
   % first find a surface for which there is at least a relevant stepsize..
   while (dmin<epsilon_d && t<=N) 
        if (valid(t)==1 && s(t)>=epsilon_s)
            dmin=d(t);
            k=t;
        end;
        t=t+1;
   end
   if(k==7)
       dip('Error');
   end
   % give an error message if we are above the maximum number of surfaces
   if (t>N+1)
       error(['not a distance larger than ',num2str(epsilon_d),' found']);
   end;
   for j=t:N
      if (d(j)>epsilon_d &&  d(j)<dmin   && valid(j)==1 &&  s(j)>=epsilon_s)
         dmin = d(j);      
         k = j;
      end
   end
   
   if (k<0 && t>N)
       k = 7;
        disp(['no crossing found! number of surfaces ',num2str(t)]);
%        disp(['ray.x0 ',num2str(ray.x0),' ray.z0 ',num2str(ray.z0)]);
%        disp(['ray.sx0 ',num2str(ray.sx0),' ray.sz0 ',num2str(ray.sz0)]);
%        disp(['ray.n ',num2str(ray.n)]);
      % error('no crossing found!');

      % pause
      % plot([ray.x ,ray.normal(1)+ray.x], [ray.z,ray.normal(2)+ray.z],'m')
      % plot(x,z,'c')
      % plot([ray.x ray.x+ray.sx],[ray.z ray.z+ray.sz],'c');
   end;
   % level=1;
end