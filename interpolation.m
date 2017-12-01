% This function does an interpolation between targetA and targetB

function intensity = interpolation(intensity, targetA, targetB, ....
                                   pathA, A, B,variables, surfaces, action)

for z = targetA.z+0.01:(targetB.z-targetA.z-0.02)/500:targetB.z-0.01
    % trace the rays with z coordinates = i
    % and tau coordinates = target.sz

    i = 1;
    targetC.z = z;
    targetC.x = surfaces(4).xmax;
    targetC.sx = targetA.sx;
    targetC.sz = targetA.sz;
    targetC.n = 1;
    targetC.surface = -1;
    targetC.I = 1;
    C = targetC;
    pathC = 4;
    % Trace one ray
    while (i <=length(pathA)) 
        Cr = C;
        Ct = C;
        % Do ray tracing for target M
        [Cr,Ct, RC, TC] = raytracing(C, surfaces, variables);
        
        K = length(pathC);
        if(action(K)==1)
            C = Ct;
            if(C.surface~=1)
               C.I = Ct.T;
            end
            if(Cr.n==1)
                C.n = 1.5;
            else
                C.n = 1;
            end
       
        else
            C = Cr;
            if(C.surface~=1)
              C.I = Cr.R;
            end
            if(Cr.n==1)
                C.n = 1;
            else
                C.n = 1.5;
            end
       
        end
         if(isempty(C))
            i = length(pathA);
        else
            if((C.surface==1) || (C.surface==4) ...
                || (C.surface==5)|| (C.surface==6) || (C.surface==7))
                pathC = [pathC, C.surface];
                i = length(pathC);
%                 if(C.surface~=1)
%                  intensity = [intensity, C.I];
%                 end
%                 figure(1)
%                 hold on
%                 plot(targetC.z, targetC.sz, '. r')
                figure(2)
                hold on
                plot(targetC.z, C.I, '. b')
                drawnow
            else
               pathC = [pathC, C.surface];
            end
             i = i+1;
            
        end
    end
     intensity = [intensity, C.I];
end