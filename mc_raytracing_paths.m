function [zout, thetaout,path, energy]=mc_raytracing_paths(surfaces, z , tau,...
    variables, energy)

graf = 0;
p.wavelength=600;
M=10;                     % max lenght of the path
raypath.wavelength=600;
surface = zeros(M,1);
raypath.s = surface;
allraypath = [raypath]; 
a=2;
k = -1;
% (x,z) = coordinates of the initial position 
ray.z = z;  
ray.x = surfaces(1).x(1);       
% Initial angle with respect to the optical axis
% Ray direction
ray.sz = tau;
ray.sx = sqrt(1-tau^2);
% store initial conditions for debugging
ray.n=1;                           % we start in air
surface=zeros(M,1);
surface(1)=1;
s = zeros(8,1);                        
% s = parameter for the ray parameterization
xn = zeros(length(surfaces),1);                  % xn(i) = x- s(i)*sin(theta)
zn = zeros(length(surfaces),1);                  % zn(i) = z+ s(i)*cos(theta)
surfaces_hit = 0;
while( k~=4 && k~=5 && k~=6  && k~=1 && k~=7 && surfaces_hit<100 )
    surfaces_hit = surfaces_hit+1;
    x0 = ray.x;                            
    z0 = ray.z;
    for  i=1:length(surfaces)
         [xn(i),zn(i),s(i),valid(i)] = ...
             surfaces(i).intersection(ray, surfaces(i), variables);
         % mydisp(commentlevel,['crossing of surface ',num2str(i),' ',
         % num2str(xn(i)),' ',num2str(zn(i)),' valid: ',num2str(valid(i)),' s: ',num2str(s(i))]);
    end
    [k] = distances(xn,zn,ray,s,valid);
    if(k~=7)
        ray.x = xn(k);                        
        ray.z = zn(k);
        surface(a) = k;
        a = a+1;
    % plot the path of the rays
        if ( graf==1)

             hold on
             plot([x0, xn(k)], [z0, zn(k)], 'm', 'Linewidth', 2);
             hold on
             plot([x0, xn(k)], [z0, zn(k)], '. k');           
        end
        [ray1, ray2, ray, check, energy] = ...
            surfaces(k).action(ray,surfaces(k),k,x0,z0, variables, energy);
    end
        
 end    % end while

 
 
 
 raypath.s = surface(1:10);
 if(length(raypath.s)>10)
     disp('Error')
 end
 if(k~=7)
     allraypath = [allraypath,raypath];  
     zout = zn(k);
     thetaout = ray.sz;
     path =  allraypath(2).s;
 else
     allraypath = [allraypath,raypath];  
     zout = z;
     thetaout = tau;
     path =  allraypath(2).s;
 end
