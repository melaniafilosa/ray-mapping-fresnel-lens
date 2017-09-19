function [ray1,ray2,ray, check, energy] = fresnel(ray, surface,k, x0, z0, ...
    variables, energy)
% Compute the direction of the reflected ray
ray1 = reflect(ray, surface, k);
% Compute the direction of the transmitted ray
ray2 = refract(ray, surface, k);
% plot([ray1.x, x0], [ray1.z, z0], 'r')
% plot([ray2.x, x0], [ray2.z, z0], 'g')
%input_angle = ray.sx;
graf = 0;
if (ray.n==surface.n1)
    n1 = surface.n1;
    n2 = surface.n2;
else
    if (ray.n==surface.n2)
        n1=surface.n2;
        n2=surface.n1;
    else
        error(['index of ray ',num2str(ray.n),...
               'does not match index of surfaces ',...
               num2str(surface.n1 ),num2str(surface.n2),...
               num2str(surface.name)]);
    end;
end;
% Compute the normals to the surfaces
% h = 5;
% l = 10;
% d = 0.5;
n = variables.n;
l = variables.l;

if(k==2|| k==3)
    L = variables.L;
    A = (1-n^2);
    B = 2*n*(n*l-L);
    C = ray.z^2-L^2+2*n*L*l-n^2*l^2;
    rad = sqrt(B^2-4*A*C);
    if( rad~=0)
      if(surface.xmin<l)
        der = (2*ray.z)/rad;
        der1 = (2*ray1.z)/rad;
        der2 = (2*ray2.z)/rad;
      else
        der =  -(2*ray.z)/rad;
        der1 = -(2*ray1.z)/rad;
        der2 = -(2*ray2.z)/rad;
      end
        surface.n = [-der 1]./sqrt(der^2+1);
        surface.normal1 = [-der1 1]./sqrt(der1^2+1);
        surface.normal2 = [-der2 1]./sqrt(der2^2+1);
    else
        surface.n = [0 1];
        surface.normal1 = [0 1];
        surface.normal2 = [0 1];
    end
else
    surface.n = [0 1];
    surface.normal1 = [0 1];
    surface.normal2 = [0 1];
end

% Compute the rays with respect to the normals

nray.sx = ray.sx*surface.n(2)-ray.sz*surface.n(1);
nray.sz = sqrt(1-nray.sx^2);
nray1.sx = ray1.sx*surface.normal1(2)-ray1.sz*surface.normal1(1);
nray1.sz = sqrt(1-nray1.sx^2);
nray2.sx = ray2.sx*surface.normal2(2)-ray2.sz*surface.normal2(1);
nray2.sz = sqrt(1-nray2.sx^2);
% If there is TIR
if (abs(nray1.sx-nray2.sx)<=1e-12)
    ray = ray1;
    R = 1;
    T = 0;
    if(abs(asin(nray.sx)*180/pi)>=asin(1/1.5))
         ray = ray1;
         check = 0;
    else
         check=1;
    end   
else
% Compute the angles with respect to the normal  of the surface  
    if(abs(asin(nray.sx)*180/pi)>=asin(1/1.5)*180/pi)
%         disp('Error: TIR should occur but it does not')
%         disp(['The angle of incidence is: ', num2str(asin(nray.sx)*180/pi)])
%         pause
%         rays = [ray.sx, ray.sz];  
%         rays = rays./norm(rays);
%         n2^2-n1^2+dot(surfaces.n*n1,rays)^2;
%         figure(1)
%         hold on
%         plot([x0, ray.x], [z0, ray.z], ' b');
%         hold on
%         plot([x0, ray.x], [z0, ray.z], '* y');
%         hold on
%         plot([x0, ray2.x], [z0, ray2.z], ' g');
%         hold on
%         plot([x0, ray2.x], [z0, ray2.z], '* g');
    else
%         disp('TIR does not occur, check whether the incident angle')
%         disp('is smaller than the critical angle')
%         disp(['Angle of incidence: ', num2str(asin(nray.sx)*180/pi)])
    end
    % Calculate the reflectance
    % Ro = Ortogonal component of R
    N1 = surface.n1*nray.sz-surface.n2*nray2.sz;
    D1 = surface.n1*nray.sz+surface.n2*nray2.sz;
    rs = N1/D1;
    % Rp = Parallel component of R
    N2 = surface.n2*nray.sz-surface.n1*nray2.sz;
    D2 = surface.n1*nray2.sz+surface.n2*nray.sz;
    rp = N2/D2;
    Rp = rp^2;
    Rs = rs^2;
    R = (Rp+Rs)/2;
    % 
    % Calculate the transmittance
    % to = Ortogonal component of T
    ts = 2*surface.n1*nray.sz/(surface.n1*nray.sz+surface.n2*nray2.sz);
    % tp = parallel component of T
    tp = 2*surface.n1*nray.sz/(surface.n1*nray2.sz+surface.n2*nray.sz);
    % T = transmittance
    Tp = (surface.n2*nray2.sz/(surface.n1*nray.sz))*tp^2;
    Ts = (surface.n2*nray2.sz/(surface.n1*nray.sz))*ts^2;
    T = (Tp+Ts)/2;
    if(abs(rp+1-surface.n2*tp/surface.n1)>1e-7)
      disp(['Tp*n2/n1; ', num2str(surfaces.n2*tp/surfaces.n1)])
      disp(['Rp+1: ', num2str(rp+1)])

    end
    if ((R+T)<=1-10^7 || (R+T)>= 1+10^-7)
        disp('Warning!!')
        format long
        disp(['R+T', num2str(R+T)]);  
    end
    if(R==0 || T==0)
        disp('R or T are 0')
    end
    action = input('action: ');
   %if (R>rand(1))
%C = rand(1)
   if(action == 0)
        ray = ray1;
        check = 0;
        energy = R*energy;
    else
       ray = ray2;
       check = 1;
       energy = T*energy;
       
       
   end

   
end
