% simNLMS.m --- Designed by linmh0130@stu.xjtu.edu.cn
%
% Description
%   function [y,e,W] = simNLMS(x,d,mu,W0)
%   function [y,e,W] = simNLMS(x,d,mu,W0,v)
%       A simple NLMS Adaptive Filter
% Update equation
%       e(i) = d(i) - y(i);
% or    e(i) = d(i) + v(i) - y(i);
%
%       W(next) = W(now) + (mu*e(i)/(u*u')).*u;
% Parameters
%   x:          Input signal
%   d:          Desired output
%   mu:         Normalized stepsize, 0 < mu < 2
%   W0:         Initial value of weights
% Return
%   y:          Output signal
%   e:          Error
%   W:          Weights

function [y,e,W] = simNLMS(x,d,mu,W0,varargin)
% 0 < mu < 2
error(nargchk(4,5,nargin));
if (nargin == 5)
    v = varargin{1};
else
    v = zeros(1,length(x));
end
W = W0;
L = length(W);
y = zeros(1,length(x));
e = zeros(1,length(x));
u = zeros(1,L); % input_sav vector
for i = 1 : length(x)
    u(2:L) = u(1:L-1);
    u(1) = x(i);
    y(i) = W * u';
    e(i) = d(i) +v(i) - y(i);
    W = W + (mu*e(i)/(u*u')).*u;
end
