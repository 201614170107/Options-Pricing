function [C,P] = BSM_EU(S,K,r,t,sigma)
% Black/Scholes call and put price for European option
%
% The function accepts vectors as input as long as they ...
% ... have the same dimension. Scalars can be combined ...
% ... with vectors of same length.
%
% INPUT   S ...... Nx1      column-vector of stock price
%         K ...... Nx1      column-vector of strike price
%         r ...... Nx1      column-vector of interest rate
%         t ...... Nx1      column-vector of time to expiry
%         sigma .. Nx1      column-vector of volatility
%
% OUTPUT [C, P] .. Nx2
%         C ...... Nx1     call price
%         P ...... Nx1     put price
%
% danilo.zocco@gmail.com, 2017-12-03
    
    d1 = (log(S./K)+(r+0.5*sigma.^2).*t) ./ (sigma.*sqrt(t));
    d2 = d1 - sigma.*sqrt(t);
    N1 = 0.5*(1+erf(d1/sqrt(2)));
    N2 = 0.5*(1+erf(d2/sqrt(2)));
    
    C = S.*N1 - K.*exp(-r.*t).*N2;
    P = K.*exp(-r.*t).*(1-N2)-S.*(1-N1);
end