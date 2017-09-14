function [ray, R]=refract_line(ray,surfaces,k)
% ray ends at a point on surface
% implement vector law of snell's
% and assign correct index of refraction to ray (n1=1, n2=1.5)->if ray.n=1
% we get ray.n=1.5 after reflection

normal = [0 1];
% check if material of ray is consistent with surface and take care n1 is
% the index of incoming ray (which is consistent with formulas below)
if (ray.n==surfaces.n1)
n1 = surfaces.n1;
n2 = surfaces.n2;
else
    if (ray.n==surfaces.n2)
        n1=surfaces.n2;
        n2=surfaces.n1;
    else
        error(['index of ray ',num2str(ray.n),...
            ' does not match index of surfaces ',...
            num2str(surfaces.n1),num2str(surfaces.n2),...
            '  on surface: ',surfaces.name]);
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
        
%         hold on
%         plot(ray.x, ray.z, '*')
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

end