% simVSLMS.m --- Designed by linmh0130@stu.xjtu.edu.cn
%
% Description
%   function [y,e,mu,W] = simVSLMS(handle,x,d,W0)
%   function [y,e,mu,W] = simVSLMS(handle,x,d,W0,v)
%   function [y,e,mu,W] = simVSLMS(handle,x,d,W0,'USERPAR',userpar)
%   function [y,e,mu,W] = simVSLMS(handle,x,d,W0,'USERPAR',userpar,v)
%       A simple VS-LMS Adaptive Filter
% Update equation
%       e(i) = d(i) - y(i);
% or    e(i) = d(i) + v(i) - y(i);
%
%       W(next) = W(now) + (mu*e(i)).*u;
% Parameters
%   handle:     The handle of the step-size update function
%   x:          Input signal
%   d:          Desired output
%   mu:         Stepsize
%   W0:         Initial value of weights
% Return
%   y:          Output signal
%   e:          Error
%   mu:         stepsize array
%   W:          Weights

function [y,e,mu,W] = simVSLMS(handle,x,d,W0,varargin)
error(nargchk(4,7,nargin));
v = zeros(1,length(x));
if (nargin > 4)
    if (nargin == 5)
        v = varargin{1};
    end
    if (varargin{1} == 'USERPAR')
        userpar = varargin{2};
        if (nargin == 7)
            v = varargin{3};
        end
    end
end
W = W0;
L = length(W);
y = zeros(1,length(x));
e = zeros(1,length(x));
mu = zeros(1,length(x));
u = zeros(1,L); % input_sav vector
for i = 1 : length(x)
    u(2:L) = u(1:L-1);
    u(1) = x(i);
    y(i) = W * u';
    e(i) = d(i) + v(i) - y(i);
    if (nargin>5)
        mu(i) = handle(u,W,i,y,e,mu,userpar);
    else
        mu(i) = handle(u,W,i,y,e,mu);
    end
    W = W + (mu(i)*e(i)).*u;
end
