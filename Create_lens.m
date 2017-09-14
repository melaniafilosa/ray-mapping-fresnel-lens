function [surfaces] = Create_lens();

h = 5;
l = 10;
d = 0.5;
r = sqrt((l-d)^2+h^2);

n = 1.5;
L = r + n*d;
za = -h:2*h/10^7:h;
A = (1-n^2);
B = 2*n*(n*l-L);
C = za.^2-L^2+2*n*L*l-n^2*l^2;
xa = (-B-sqrt(B^2-4*A*C))/(2*A);
figure(3)
% A1 = (1-4*n^2);
% B1 = 4*n*(2*n*l-L);
% C1 = za.^2-L^2+4*n*L*l-4*n^2*l^2;

%plot(xa, za, '* r')
% xa = -2:2/1000:0;
% za = sqrt(b^2*(1-xa.^2./(a^2)));
xa1 = -(-B-sqrt(B^2-4*A*C))/(2*A)+2*l;
n1= 1; n2= 1.5;

%plot([l l],[-h h], 'm')

k = 1;
surfaces(k).name='source';
surfaces(k).xmin = 0;
surfaces(k).xmax = 0;
surfaces(k).zmin = -h-1;
surfaces(k).zmax = h+1;
surfaces(k).x=[0; 0];
surfaces(k).z=[-h-1; h+1];
surfaces(k).n1=n1;
surfaces(k).n2=n1;
surfaces(k).intersection=@line_intersection;
surfaces(k).action=@empty1;
hold on
%plot(surfaces(k).x, surfaces(k).z, ' r ', 'Linewidth',2)
plot([0 0],[-2 2], 'r', 'Linewidth', 2)
k = 2;
surfaces(k).name='left lens';
surfaces(k).xmin = min(xa);
surfaces(k).xmax = max(xa);
surfaces(k).zmin = -h;
surfaces(k).zmax = h; 
surfaces(k).x=xa;
surfaces(k).z=za;
% surfaces(k).axis = [a, b];
surfaces(k).n1=n1;
surfaces(k).n2=n2;
surfaces(k).intersection=@ellipse_intersection;
surfaces(k).action=@refract;
plot(surfaces(k).x, surfaces(k).z, '  b', 'Linewidth',2)
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
%surfaces(k).axis = [a,b];
surfaces(k).intersection=@ellipse_intersection;
surfaces(k).action=@refract;
plot(surfaces(k).x, surfaces(k).z, 'b', 'Linewidth',2)
k = 4;
surfaces(k).name='top lens';
surfaces(k).xmin = surfaces(2).xmax;
surfaces(k).xmax = surfaces(3).xmin;
surfaces(k).zmin = h;
surfaces(k).zmax = h; 
surfaces(k).x=[surfaces(k).xmin; surfaces(k).xmax];
surfaces(k).z=[h; h];
surfaces(k).n1=n1;
surfaces(k).n2=n2;
surfaces(k).intersection=@line_intersection;
surfaces(k).action=@refract;
plot(surfaces(k).x, surfaces(k).z, '  b', 'Linewidth',2)
k = 5;
surfaces(k).name='bottom lens';
surfaces(k).xmin = surfaces(2).xmax;
surfaces(k).xmax = surfaces(3).xmin;
surfaces(k).zmin = -h;
surfaces(k).zmax = -h;
surfaces(k).x=[surfaces(k).xmin; surfaces(k).xmax];
surfaces(k).z=[-h; -h];
surfaces(k).n1=n1;
surfaces(k).n2=n2;
surfaces(k).intersection=@line_intersection;
surfaces(k).action=@refract;
plot(surfaces(k).x, surfaces(k).z, ' b', 'Linewidth',2)

k = 6;
surfaces(k).name='target';
surfaces(k).xmin = 2*l;
surfaces(k).xmax = 2*l;
surfaces(k).zmin = -h-1;
surfaces(k).zmax = h+1;
surfaces(k).x=[2*l; 2*l];
surfaces(k).z=[-h-1; h+1];
surfaces(k).n1=n1;
surfaces(k).n2=n1;
surfaces(k).intersection=@line_intersection;
surfaces(k).action=@empty1;
plot(surfaces(k).x, surfaces(k).z, 'r', 'Linewidth',2)
k = 7;
surfaces(k).name='detector bottom';
surfaces(k).xmin = 0;
surfaces(k).xmax = 2*l;
surfaces(k).zmin = -h-0;
surfaces(k).zmax = -h-0;
surfaces(k).x=[0; 2*l];
surfaces(k).z=[-h-0; -h-0];
surfaces(k).n1=n1;
surfaces(k).n2=n1;
surfaces(k).intersection=@line_intersection;
surfaces(k).action=@empty1;
plot(surfaces(k).x, surfaces(k).z, 'g', 'Linewidth',2)
k = 8;
surfaces(k).name='detector top';
surfaces(k).xmin = 0;
surfaces(k).xmax = 2*l;
surfaces(k).zmin = h+0;
surfaces(k).zmax = h+0;
surfaces(k).x=[0; 2*l];
surfaces(k).z=[h+0; h];
surfaces(k).n1=n1;
surfaces(k).n2=n1;
surfaces(k).intersection=@line_intersection;
surfaces(k).action=@empty1;
plot(surfaces(k).x, surfaces(k).z, 'g', 'Linewidth',2)

