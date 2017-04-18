function stepsize = testFunc(u,W,n,y,e,mu,varargin)
userpar = varargin{1};	% 用户自定义参数用varagin传递
a = userpar(1);
p = userpar(2);
stepsize = a*abs(e(n))^p;
