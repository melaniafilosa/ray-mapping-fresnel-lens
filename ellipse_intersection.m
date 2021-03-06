% This function computes the intersection between the ray and the ellips 
% with axis a and b where a<b
function [xn,zn, s, valid] = ellipse_intersection(ray, surface, variables)
graph = 0;
s = 0;
% Plot the ray on the surface
if graph
%  figure(7)
%  hold on
%  plot(ray.x, ray.z , ' * y')
end
valid = 0;
% Parameters of the lens
% h = 5;
% l = 10;
% d = 0.5;
% r = sqrt((l-d)^2+h^2);
% n = 1.5;
% L = r + n*d;
n = variables.n;
l = variables.l;
L = variables.L;

% Coefficients of the second order equation of the left reflector
A =(1-n^2)*ray.sx^2+ray.sz^2;
B = 2*(1-n^2)*ray.x*ray.sx+2*n*(n*l-L)*ray.sx+2*ray.z*ray.sz;
C = (1-n^2)*ray.x^2+2*n*(n*l-L)*ray.x+ray.z^2-L^2+2*n*l*L-n^2*l^2;
% Coefficients for the second order equation of the right reflector
A1 = (1-n^2)*ray.sx^2+ray.sz^2;
B1 = 2*(1-n^2)*ray.x*ray.sx-4*l*(1-n^2)*ray.sx-2*n*(n*l-L)*ray.sx+2*ray.sz*ray.z;
C1 = (1-n^2)*ray.x^2-4*l*(1-n^2)*ray.x+4*l^2*(1-n^2)-2*n*(n*l-L)*ray.x+...
    4*n*l*(n*l-L)+ray.z^2-L^2+2*n*l*L-n^2*l^2;


if(surface.xmin<l)
    % Arc length of the left reflector
    s1 = (-B+sqrt(B^2-4*A*C))/(2*A);
    s2 = (-B-sqrt(B^2-4*A*C))/(2*A);
    xn1 = ray.x+s1*ray.sx;
    zn1 = ray.z+s1*ray.sz;
    xn2 = ray.x+s2*ray.sx;
    zn2 = ray.z+s2*ray.sz;
else

    % Arc length of the right reflector
%     if(B1^2-4*A1*C1<0)
%         disp('Error')
%     end
    s1 = (-B1+sqrt(B1^2-4*A1*C1))/(2*A1);
    s2 = (-B1-sqrt(B1^2-4*A1*C1))/(2*A1);
    xn1 = ray.x+s1*ray.sx;
    zn1 = ray.z+s1*ray.sz;
    xn2 = ray.x+s2*ray.sx;
    zn2 = ray.z+s2*ray.sz;
end

 eps = 10^-8;
    %if((xn1-surface.xmin>=-eps)&& (xn1-surface.xmax<=eps)) && ...
     if((zn1-surface.zmin>=-eps) && (zn1-surface.zmax<=eps)) 
            % && ...
       % sqrt((xn-ray.x)^2+(zn-ray.z)^2)>=0)
%     if ((xn-cpc.xmin>=0) || (xn-cpc.xmin>=-eps && xn-cpc.xmin<=0)) && ...
%             ((xn-cpc.xmax<=0)||(xn-cpc.xmax<=eps && xn-cpc.xmax>=0)) 
        if(surface.xmin<l)
            A1 = (1-n^2);
            B1 = 2*n*(n*l-L);
            C1 = zn1.^2-L^2+2*n*L*l-n^2*l^2;
            x1 = (-B1-sqrt(B1^2-4*A1*C1))/(2*A1);
        else
            A1 = (1-n^2);
            B1 = 2*n*(n*l-L);
            C1 = zn1.^2-L^2+2*n*L*l-n^2*l^2;
            x1 = -(-B1-sqrt(B1^2-4*A1*C1))/(2*A1)+2*l;
        end
        if (abs(x1-xn1)<=10^-6)
           valid1 = 1;
           xn1 = x1;
        else
           valid1 = 0;
          
        end
    else
        valid1=0;
    end;
if(valid1==1)
    s = s1;
    xn = xn1;
    zn = zn1;
end

    %if((xn2-surface.xmin>=-eps)&& (xn2-surface.xmax<=eps)) % && ...
     if((zn2-surface.zmin>=-eps) && (zn2-surface.zmax<=eps)) % && ...
        % sqrt((xn1-ray.x)^2+(zn1-ray.z)^2)>=0)
%      if ((xn1-cpc.xmin>=0) || (xn1-cpc.xmin>=-eps && xn1-cpc.xmin<=0)) && ...
%             ((xn1-cpc.xmax<=0)||(xn1-cpc.xmax<=eps && xn1-cpc.xmax>=0)) 
        if(surface.xmin<l)
            A1 = (1-n^2);
            B1 = 2*n*(n*l-L);
            C1 = zn2^2-L^2+2*n*L*l-n^2*l^2;
            x2 = (-B1-sqrt(B1^2-4*A1*C1))/(2*A1);
        else
            A1 = (1-n^2);
            B1 = 2*n*(n*l-L);
            C1 = zn2^2-L^2+2*n*L*l-n^2*l^2;
            x2 = -(-B1-sqrt(B1^2-4*A1*C1))/(2*A1)+2*l;
        end
        if (abs(x2-xn2)<=10^-6)
           valid2 = 1;
           xn2 = x2;
        else
           valid2 = 0;
           
        end
    else
        valid2=0;
    end;

if(valid1==1 && valid2 ==1)
    if(xn1-ray.x==0 && zn1-ray.z==0)
%      if ((xn-ray.x>=0) || (xn-ray.x>=-eps && xn-ray.x<=0)) && ...
%              ((xn-ray.x<=0)||(xn-ray.x<=eps && xn-ray.x>=0)) 
        xn = xn2;
        zn = zn2;
        s = s2;
        valid = 1;
    else
        xn = xn1;
        zn = zn1;
        s = s1;
        valid = 1;
    end
elseif(valid1==1 && valid2==0)
    xn = xn1;
    zn = zn1;
    s = s1;
    valid = 1;
 elseif(valid1==0 && valid2==1)
    xn = xn2;
    zn = zn2;
    s = s2;
    valid = 1;
 elseif(valid1==0 && valid2==0)
    xn = ray.x;
    zn = ray.z;
    s = -1;
    valid = 0;
end


