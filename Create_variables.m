
% This function defines the parameters that caracterize the equation of the Lens 
function [variables] = Create_variables();
variables.h = 5;
variables.l = 10;
variables.d = 0.5;
variables.r = sqrt((variables.l-variables.d)^2+variables.h^2);
% index of refraction
variables.n = 1.5;
variables.L = variables.r + variables.n*variables.d;