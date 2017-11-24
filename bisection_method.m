% This function uses the bisection method top find the rays with
% the same number of reflections of A

function [C1, targetC1,pathC1, C2, targetC2, pathC2] = ...
         bisection_method(A, B, targetA,targetB, pathA, surfaces, ...
                          action, variables)
%pathA = [pathA, A.surface];                                                  
toll = 1e-12;
pathB = 4;
while(abs(targetA.z-targetB.z)>toll)
    % Consider the middle point between targetA.x and targetB.x
    pathM = 4;
    K = 0;
    targetM.z = (targetA.z + targetB.z)/2;
    targetM.x = targetA.x;
    targetM.sx = targetA.sx;
    targetM.sz = targetA.sz;
    targetM.n = 1;
    targetM.surface = -1;
    targetM.I = 1;
    M = targetM;
    M.I = 1;
  
    i = 2;
    while (i <=length(pathA)) 
        Mr = M;
        Mt = M;
        % Do ray tracing for target M
        [Mr,Mt, RM, TM] = raytracing(M, surfaces, variables);
        
        K = length(pathM);
        if(action(K)==1)
            M = Mt;
            M.I = Mt.T;
            if(Mr.n==1)
                M.n = 1.5;
            else
                M.n = 1;
            end
       
        else
            M = Mr;
            M.I = Mr.R;
            if(Mr.n==1)
                M.n = 1;
            else
                M.n = 1.5;
            end
       
        end
            
        if(isempty(M))
            i = length(pathA);
        else
            if((M.surface==1) || (M.surface==4) ...
                || (M.surface==5)|| (M.surface==6) || (M.surface==7))
                pathM = [pathM, M.surface];
                i = length(pathA);
            else
               pathM = [pathM, M.surface];
            end
             i = i+1;
            
        end
    end
  
   if(isequal(pathA,pathM))
            A = M;
            targetA = targetM;
            pathA = pathM;
            RA = RM;
            TA = TM;
   else
        % if(A.surface~=M.surface)
        B = M;   
        targetB = targetM;
        RB = RM;
        TB = TM;
        pathB = pathM;
   end
% figure(2)
% hold on
% plot(targetA.x, targetA.sx, '*', targetB.x, targetB.sx, '*')
% drawnow
end
C2 = B;
targetC2 = targetB;
pathC2 = pathB;
C1 = A;
targetC1 = targetA;
pathC1 = pathA;
