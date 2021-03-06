% This script comptutes the output intensity for a two-faceted cup
% The algorithm makes use of the phase space representation of each
% surface that constitutes the optical system


variables = Create_variables();
surfaces = Create_lens_fresnel1(variables);
% cup = faceted_cup()
tic
fig = 0;
if(fig)
  figure(1)
  Plot_surfaces(surfaces);
  axis([-18 18 0 41])
end
delta1 = 0.02;
N_tau_bins = 10;
delta2 = delta1/N_tau_bins;
eps_target_angle = 0.01;
eta2 = -1+eps_target_angle:delta2:1-eps_target_angle;
count  = 0;
%  k = 1;
%  eta2=input('eta ');
int2 = zeros(1, length(eta2));
number_target = 4;
ray1.z = surfaces(4).zmin+0.01;
%ray1.z = input('targetA');
ray2.z = surfaces(4).zmax-0.01;
N_z_bins = 1;
step = (ray2.z-ray1.z)/1;
  k = 1;
 eta2(k) = 0.162;
for t = ray1.z:step:ray2.z-step
 %for k =1:length(eta2)

      j = number_target;
      max_iter = 0;
      path = [j];
      ray1.z = t;
      ray2.z = ray1.z+step;
      ray1.x = surfaces(4).xmax;
      ray2.x = surfaces(4).xmax;
      ray1.n = 1;
      ray2.n = 1;
      ray1.sz = eta2(k);
      ray2.sz = eta2(k);
      ray1.sx = -sqrt(1-eta2(k)^2);
      ray2.sx = ray1.sx;
      ray1.surface = -1;
      ray2.surface = -1;
      ray1.I = 1;
      ray2.I = 1;
      action = [1,1,1,1,1,1,1,1,1,1];
      intensity = [];
      intensity= intensity_computation(ray1, ray2, ray1, ray2, path, ...
                       path, surfaces,...
                       action, variables, intensity);
       
      
   %   int2(k) = int2(k)+intensity2(k);
  %end
end

% 
% H = -1+eps_target_angle:delta1:1-eps_target_angle;
% 
% k = 0;
% for i = 1:length(H)-1
%     delta2 = (H(2)-H(1))/N_tau_bins;
%     interval = (H(i)+(0:N_tau_bins)*delta2)';
%     intensity = int2(k+1:k+length(interval))';
%     % intensity = intensity2(k+1:k+length(interval))';
%     k = k+length(interval)-1;
%     average_intensity(i) = (1/(interval(end)-interval(1)))*trapz(interval, intensity);
%     area(i) = trapz(interval, 1/(interval(end)-interval(1))*intensity);
%     
% end
% 
% intensity = average_intensity./sum(area);
% etendue2 = trapz(H(1:end-1), average_intensity);
toc

