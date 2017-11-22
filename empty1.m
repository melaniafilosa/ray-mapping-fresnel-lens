function [reflected, transmitted, R, T]=empty1(ray,surfaces, k, variables)
reflected = ray;
transmitted = ray;
R = 1;
T = 0;
reflected.R = R;
transmitted.T = T;
if(ray.n==1)
    reflected.n = 1;
    transmitted.n = 1.5;
else
    reflected.n = 1.5;
    transmitted.n = 1;
end
% does nothing ;-)
