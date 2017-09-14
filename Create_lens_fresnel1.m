function [surfaces] = Create_lens_fresnel1(variables)
% Define the parameters to construct the lens
eps = 0;
h = variables.h;
l = variables.l;
n = variables.n;
L = variables.L;
za = -h:2*h/10^7:h;
A = (1-variables.n^2);
B = 2*variables.n*(variables.n*l-variables.L);
C = za.^2-variables.L^2+2*variables.n*variables.L*l ...
    -variables.n^2*l^2;
% x coordinates for the left lens
xa = (-B-sqrt(B^2-4*A*C))/(2*A);
% x coordinates for the right lens
xa1 = -xa+2*l;
n1= 1; n2= 1.5;

graf = 1;
k = 1;
surfaces(k).name='source';
surfaces(k).xmin = 0;
surfaces(k).xmax = 0;
surfaces(k).zmin = -h;
surfaces(k).zmax = h;
surfaces(k).x=[0; 0];
surfaces(k).z=[-h; h];
surfaces(k).n1=n1;
surfaces(k).n2=n1;
surfaces(k).intersection=@line_intersection;
surfaces(k).action=@empty1;


k = 2;
surfaces(k).name='left lens';
surfaces(k).xmin = min(xa);
surfaces(k).xmax = max(xa);
surfaces(k).zmin = -h;
surfaces(k).zmax = h; 
surfaces(k).x=xa;
surfaces(k).z=za;
surfaces(k).n1=n1;
surfaces(k).n2=n2;
surfaces(k).intersection=@ellipse_intersection;
surfaces(k).action=@fresnel1;

k = 3;
surfaces(k).name='right lens';
surfaces(k).xmin = min(xa1);
surfaces(k).xmax = max(xa1);
surfaces(k).zmin = -h;
surfaces(k).zmax = h;
surfaces(k).x=xa1;
surfaces(k).z=za;
surfaces(k).n1=n1;
surfaces(k).n2=n2;
surfaces(k).intersection=@ellipse_intersection;
surfaces(k).action=@fresnel1;


k = 4;
surfaces(k).name='target';
surfaces(k).xmin = 2*l;
surfaces(k).xmax = 2*l;
surfaces(k).zmin = -h-eps;
surfaces(k).zmax = h+eps;
surfaces(k).x=[2*l; 2*l];
surfaces(k).z=[-h-eps; h+eps];
surfaces(k).n1=n1;
surfaces(k).n2=n1;
surfaces(k).intersection=@line_intersection;
surfaces(k).action=@empty1;

k = 5;
surfaces(k).name='detector bottom';
surfaces(k).xmin = 0;
surfaces(k).xmax = 2*l;
surfaces(k).zmin = -h-eps;
surfaces(k).zmax = -h-eps;
surfaces(k).x=[0; 2*l];
surfaces(k).z=[-h-eps; -h-eps];
surfaces(k).n1=n1;
surfaces(k).n2=n1;
surfaces(k).intersection=@line_intersection;
surfaces(k).action=@empty1;

k = 6;
surfaces(k).name='detector top';
surfaces(k).xmin = 0;
surfaces(k).xmax = 2*l;
surfaces(k).zmin = h+eps;
surfaces(k).zmax = h+eps;
surfaces(k).x=[0; 2*l];
surfaces(k).z=[h+eps; h+eps];
surfaces(k).n1=n1;
surfaces(k).n2=n1;
surfaces(k).intersection=@line_intersection;
surfaces(k).action=@empty1;

if(graf)
    figure(4)
    for k = 1:6
        hold on
        if(k==1 ||k==4)
            plot(surfaces(k).x, surfaces(k).z, 'r', 'Linewidth',2.5)
        elseif(k==2 || k==3)
            plot(surfaces(k).x, surfaces(k).z, 'b', 'Linewidth',2.5)
        else
            plot(surfaces(k).x, surfaces(k).z, 'g', 'Linewidth',2.5)
        end
        axis([0 20 -h-eps h+eps])
    end
end
