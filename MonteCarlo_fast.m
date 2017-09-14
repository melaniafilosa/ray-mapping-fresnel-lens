% This script computes the Monte Carlo ray tracing
% Replace mc with mc_vector
% mc_vector = vector with rays information rays traced throught MC
tic
% surfaces = Create_surfaces();
% variables = Create_variables();
% Plot_surfaces(surfaces);
plotpoints = 0;              % if 1 we plot points of triangles during calculations;
global mc_vector
mc_vector.wavelenght=1000;
mc_vector.zin=[];
mc_vector.tauin=[];
mc_vector.zout=[];
mc_vector.tauout=[];
mc_vector.path=[];


% hold on

% Nr = input('Nr = ');
% Nr = variables.nr
% rays_mc_lost = 0;
% target_rays = 0;
% give random number generator the same starting point
tic
rng(7);
% global mc_intensity;
delta = 0.02;
range = -1: delta: 1;
Nr = 100;
graf = 1;
% if(graf)
%     figure(1)
%     hold on
%     Plot_cpc(surfaces);
% end
% Chose the middle of each bin
for i = 1:(length(range)-1)
    xrange(i) = range(i)+(range(i+1)-range(i))/2;
end

mc_intensity = zeros(length(range)-1,  1);
 for i=1:Nr
       z_mc = ((4)*rand(1)-2);
     %  tau_mc = ((2)*rand(1)-1);
      z_mc = 0;
      tau_mc = ((2*5/sqrt(9.5^2+25))*rand(1)-5/sqrt(9.5^2+25));
     % tau_mc = 0;
     % tau_mc =input('tau ');
     [z_mc_out, tau_mc_out, last_surface] = mc_raytracing1(surfaces,z_mc, tau_mc, variables); 
     % fill_vector(x(i),tau(i),xout(i),tauout(i),path,0);
     if (last_surface==6)
         %-0.01)
         mc_fill_vector(z_mc, tau_mc, z_mc_out, tau_mc_out, path);
         mc_intensity = mc_fill_bins(tau_mc_out, mc_intensity, delta);
     end
%      if(i==10^4)
%          mc_intensity104 = mc_intensity;
%          save mc_intensity104 mc_intensity104
%      end
%      if(i==10^5)
%          mc_intensity105 = mc_intensity;
%          save mc_intensity105 mc_intensity105
%      end
%      if(i==10^6)
%          mc_intensity106 = mc_intensity;
%          save mc_intensity106 mc_intensity106
%      end
%      if(i==10^7)
%          mc_intensity107 = mc_intensity;
%          save mc_intensity107 mc_intensity107
%      end
%      if(i==10^8)
%          mc_intensity108 = mc_intensity;
%          save mc_intensity108 mc_intensity108
%      end
%      if(i==10^9)
%          mc_intensity109 = mc_intensity;
%          save mc_intensity109 mc_intensity109
%      end
     if (mod(i,500)==0),
         disp(['Traced ',num2str(i),' rays']);
     end
 end

toc
