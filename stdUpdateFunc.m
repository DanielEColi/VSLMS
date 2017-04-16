function stepsize = stdUpdateFunc(u,W,n,y,e,mu,varargin)
% u:         Filter input memory
% W:         last weights
% n:         current time
% y:         output array
% e:         error array
% mu:        stepsize array
% varargin:  more parameters user wants to input
userpar = varargin{1};
a = userpar(1);
p = userpar(2);
stepsize = a*abs(e(n))^p/(u*u');
