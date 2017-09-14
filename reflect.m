% This function computes the direction of the reflected ray

function [ray] = reflect(ray, surface, k)
 % Compute the normal to the surface "cup"
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
 % rays: ray direction
   rays = [ray.sz; ray.sx];
   if (dot(normal,rays)<0)
     normal = -normal;
   end;
   ray.normal = normal;
 % Consider always a normal directed inside the optical system
 %    if (dot(normal,rays)<0)
 %      normal=-normal;
 %    end;
 % Compute the reflection law to calculate the new direction
   alpha = 1;
   beta = -2*dot(normal,rays);
   ray.sz = alpha*ray.sz+beta*normal(1); 
   ray.sx = alpha*ray.sx+beta*normal(2);
   R = 1;
end