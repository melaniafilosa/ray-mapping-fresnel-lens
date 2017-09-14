function [ray]=refract(ray,surface, k)
% ray ends at a point on surface
% implement vector law of snell's
% and assign correct index of refraction to ray (n1=1, n2=1.5)->if ray.n=1
% we get ray.n=1.5 after reflection
h = 5;
l = 10;
d = 0.5;
r = sqrt((l-d)^2+h^2);
if(k==2|| k==3)
    n = 1.5;
    L = r + n*d;
    A = (1-n^2);
    B = 2*n*(n*l-L);
    C = ray.z^2-L^2+2*n*L*l-n^2*l^2;
    rad = sqrt(B^2-4*A*C);
    if( rad~=0)
      if(surface.xmin<l)
        der = (2*ray.z)/rad;
      else
        der = -(2*ray.z)/rad;
      end
      normal = [-der 1]./sqrt(der^2+1);
    else
        normal = [0 1];
    end
else
    normal = [0 1];
end
% check if material of ray is consistent with surface and take care n1 is
% the index of incoming ray (which is consistent with formulas below)
if (ray.n==surface.n1)
n1 = surface.n1;
n2 = surface.n2;
else
    if (ray.n==surface.n2)
        n1=surface.n2;
        n2=surface.n1;
    else
        error(['index of ray ',num2str(ray.n),...
            ' does not match index of surfaces ',...
            num2str(surface.n1),num2str(surface.n2),...
            '  on surface: ',surface.name]);
    end;
end;
rays = [ray.sz ray.sx];
%   hold on
%   plot([ray.x ,normal(1)+ray.x], [ray.z,normal(2)+ray.z],'m','LineWidth',2);
%   plot(ray.x, ray.z, '.')
%   
% if (norm(rays)>1+1e-6 || norm(rays)<1-1e-6)
%    % disp(['rays not normalize ',num2str(norm(rays))]);
% end;
if (dot(normal,rays)<0)
     normal = -normal;
end;
 ray.normal = normal;
 % Check for tir
   if(n2^2-n1^2+dot(normal*n1,rays)^2 <=0)  %&& (n1>n2 && asin(ray.sx)>asin(n2/n1))
        alpha = 1;
        beta = -2*dot(normal,rays);
        ray.n=abs(n1);
       % disp('TIR')
        R = 1;
        
   else
        alpha = n1/n2;
        beta = (sqrt(n2^2-n1^2+dot(normal*n1,rays)^2)-dot(normal*n1,rays))/n2;
        ray.n = abs(n2);
        R = 0;
   end
% end;
% calculate new direction
sznew = alpha*ray.sz+beta*normal(1);
sxnew = alpha*ray.sx+beta*normal(2);
ray.sx = sxnew;
ray.sz = sznew;
% finally asign right index of refraction to ray


end

