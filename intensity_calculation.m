% This function computes the intensity at the target 
% along a given direction it considers 
function intensity = intensity_calculation(A, B, targetA, targetB,...
                             pathA,pathB,surfaces, action, variables)
                        
  intensity = 0;
  
  max_number_of_reflections = 6;
  % If A and B are on the same line
  % (this is always true at the first step as both start from the target
  if(A.surface==B.surface)
      if(A.surface==1) 
             if(A.n==1.5)  
                % Compute the intensity
                % intensity = intensity + abs(targetA.x-targetB.x);    
                if(isequal(pathA, [4,3,2,3,2,1]))
                figure(7)
                plot([targetA.z, targetB.z],[targetA.sz, targetB.sz],'. r')            
                hold on
                drawnow
                disp(['pathA ', num2str(pathA)]);
                disp(['pathB ', num2str(pathB)]); 
                if(A.R ~=0 && A.R ~=1)
                A.R
                A.T
                B.R
                B.T
                end
%                 disp(['RA ', num2str(RA)]); disp(['TA ', num2str(TA)]);
%                 disp(['RA+TA ', num2str(RA+TA)]);
                
                
                end

               else
%                 % A not physical path is found
%                 % Discard those rays
                 intensity = intensity;
              end
      else % (if the source is not reached yet)
          % and if nether the target nor the reflectors are hit again
%           if(length(pathA)==6)
%           figure(1)
%           plot([targetA.z, targetB.z],[targetA.sz, targetB.sz],'. b')
%           end
          if((A.surface~=4) && (A.surface~=5)...
                  && (A.surface~=6) && (A.surface~=7))
              % If the maximum number of reflection is not reached
              if(length(pathA)<max_number_of_reflections)
                  % Trace back the rays A and B
                  % For both of them compute both the reflected and 
                  % the transmitted ray.
                  % Calculate the reflectance and the transmittance
                 if(A.surface~=1)                  
                      [Ar, At, RA, TA] = raytracing(A, surfaces, variables);
                      [Br, Bt, RB, TB] = raytracing(B, surfaces, variables);    
                      At.I = At.T;
                      Ar.I = Ar.R;
                      Br.I = Br.R;
                      Bt.I = Bt.T;
                      pathA = [pathA, At.surface];
                      pathB = [pathB, Bt.surface];
                      K = length(pathA)-1;

                 end
                 if(K>length(action))
                     disp('Error')
                    % K
                 end
                  if(action(K)==1)
                      
                      intensity = intensity+ intensity_calculation(At, Bt, targetA,...
                                         targetB, pathA,pathB, surfaces, action, ...
                                         variables); 
                                    
                  else
                      
                      intensity = intensity+ intensity_calculation(Ar, Br, targetA,...
                                         targetB, pathA,pathB,surfaces, action, ...
                                         variables); 
                                     
                  end
                                 
              else
                  % If the maximum number of reflection is reached 
                  % then the contribution to the intensity is negligible
                  intensity = intensity;
              end
          else   % if the ray hits either the target again or 
                 % one of the reflectors stop the procedure
                 intensity = intensity;
          end
      end
  % If A and B hit two different surfaces
  elseif(A.surface~=B.surface)
      % If the maximum number of reflection is not reached yet
      if(length(pathA)<=max_number_of_reflections)
          % Do bisection to find the ray C1 with the same path of A
          % The ray C2 has a different path
          % targetC1 and targetC2 are the coordinates of the found
          % rays at the target
          % C1 and C2 are the coordinates of the rays at the last surface
          % that they hit, for C1 this is equal to pathA(end) for C1
          [C1, targetC1,pathC1, C2, targetC2, pathC2] = ...
                        bisection_method(A, B, targetA,...
                         targetB, pathA, surfaces, action, variables);
            
          % If there is an interval at the left of ray A
          
        
          % If the target and the reflectors are not reache yet
          if((A.surface~=4) && (A.surface~=5)...
                  && (A.surface~=6) && (A.surface~=7) )
              if(~isequal(pathA, pathC1))
                     disp(['pathA ', num2str(pathA)]);
                     disp(['pathC1 ', num2str(pathC1)]);
                    
              end
              % Recall the function for the rays with the same path
              
                  intensity = intensity+intensity_calculation(A, C1, targetA,...
                                                targetC1, pathA,pathC1,surfaces, ...
                                                action, variables);
              
             
          else
              % If the rays hit either the target or the reflectors again
              % discard those rays
              intensity = intensity;      
          end
          
          % Recall the function for the rays with a different path
        
              intensity = intensity+intensity_calculation(C2, B, targetC2,...
                                               targetB, pathC2,pathB, surfaces, ...
                                               action, variables);
         
      else % (if the maximum number of reflection is reached)
          % The contribution to the intensity given by those rays is
          % negligible
          intensity = intensity;
      end
      
  end
  end

  
  
  