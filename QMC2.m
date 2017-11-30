tic
plotpoints = 0;    % if 1 we plot points of triangles during calculations;
% give random number generator the same starting point
rng(7);

% Store the information in the vector

global mc_vector
mc_vector.wavelenght=1000;
mc_vector.zin=[];
mc_vector.tauin=[];
mc_vector.zout=[];
mc_vector.tauout=[];
mc_vector.path=[];
mc_vector.energy =[];

global mc_vector1
mc_vector1.wavelenght=1000;
mc_vector1.zin=[];
mc_vector1.tauin=[];
mc_vector1.zout=[];
mc_vector1.tauout=[];
mc_vector1.path=[];
mc_vector1.energy =[];

variables = Create_variables();
surfaces = Create_lens_fresnel(variables);
delta = 0.02;
range = -1: delta: 1;
Nr = 10^3;
% z_mc = input('z ');
% tau_mc = input('tau ');

% Chose the middle of each bin
for i = 1:(length(range)-1)
    xrange(i) = range(i)+(range(i+1)-range(i))/2;
end
mc_min_tau = -1+0.1;
mc_max_tau = 1-0.1; 
% global mc_intensity;
qmc_intensity = zeros(length(range)-1,  1);
 
 for i=1:Nr
   % z_mc = 0;
    z_mc = surfaces(1).zmin+2*surfaces(1).zmax*x(i,1);
    tau_mc = -1+2*x(i,2);
   %  z_mc = input('z ');   
     [z_mc_out, tau_mc_out,path, energy] = ...
         mc_raytracing_paths(surfaces,z_mc, tau_mc, variables, 1);
     f = find(path);
 
      if (path(f(end))==4 && z_mc_out>=surfaces(4).zmin+0.01 ...
             && z_mc_out<=surfaces(4).zmax-0.01 ...
             && tau_mc_out>=-1+0.01 && tau_mc_out<=1-0.01)
        mc_fill_vector(z_mc, tau_mc, z_mc_out, tau_mc_out, path, energy);
        mc_intensity = mc_fill_bins(tau_mc_out, qmc_intensity, delta);
      else
          mc_fill_vector1(z_mc, tau_mc, z_mc_out, tau_mc_out, path, energy);
      end
     if (mod(i,500)==0),
        disp(['Traced ',num2str(i),' rays']);
     end
     

 end
% save exact_intensity mc_intensity
toc
