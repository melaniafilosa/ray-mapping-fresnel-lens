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
N_tau_bins = 1;
delta2 = delta1/N_tau_bins;
eps_target_angle = 0.2;
eta2 = -1+eps_target_angle:delta2:1-eps_target_angle;
count  = 0;
%  k = 1;
%  eta2=input('eta ');
int2 = zeros(1, length(eta2));
number_target = 4;
ray1.z = surfaces(4).zmin+0.2;
ray2.z = surfaces(4).zmax-0.2;
N_z_bins = 1;
step = (ray2.z-ray1.z)/1;

for t = ray1.z:step:ray2.z-step
  for k =1:length(eta2)
      j = number_target;
      max_iter = 0;
      path1 = [j];
      path2 = [j];
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
      i = 0;
      action = [1,0,1,1,1,1];
      [reflected1, transmitted1, R1, T1] = raytracing(ray1, surfaces, variables);
      [reflected2, transmitted2, R2, T2] = raytracing(ray2, surfaces, variables);
      path1 = [path1, transmitted1.surface];
      path2 = [path2, transmitted2.surface];
      while( path1(end)~=4 && path1(end)~=5 && path1(end)~=6  && path1(end)~=1 && i<100)
          i = i+1;
          if(action(i)==1)
              [reflected1, transmitted1, R1, T1] = raytracing(transmitted1, surfaces, variables);
              path1 = [path1, transmitted1.surface];        
          else
              [reflected1, transmitted1, R1, T1] = raytracing(reflected1, surfaces, variables);
              path1 = [path1, reflected1.surface];
          end
      end
      i = 0;
      while( path2(end)~=4 && path2(end)~=5 && path2(end)~=6  && path2(end)~=1 && i<100)
          i = i+1;
          if(action(i)==1)
              [reflected2, transmitted2, R2, T2] = raytracing(transmitted2, surfaces, variables);
              path2 = [path2, transmitted2.surface];        
          else
              [reflected2, transmitted2, R2, T2] = raytracing(reflected2, surfaces, variables);
              path2 = [path2, reflected2.surface];
          end
      end
      if(isequal(path1, path2) && (path1(end)==1))
          hold on
          plot(ray1.z, ray1.sz, 'o k')
          plot(ray2.z, ray2.sz, 'o k')
          path1
          path2
      else
          [C1, targetC1,pathC1, C2, targetC2, pathC2] = bisection_method(ray1, ray2, ray1,...
                                                      ray2, path1, surfaces, action, variables);
          plot([targetC1.z, ray1.z], [targetC1.sz, ray1.sz], 'o g');
          pathC1
          pathC2
      end
%          path1
%          path2
         
  end
end


