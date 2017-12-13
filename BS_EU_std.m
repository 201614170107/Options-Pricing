function P = BS_EU_std(S,K,r,t,sigma)
% Black/Scholes for European standard put
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
% OUTPUT  P ...... Nx1      put price
%
% danilo.zocco@gmail.com, 2017-12-03
    
    if t > 0
        d1 = (log(S./K)+(r+0.5*sigma.^2).*t) ./ (sigma.*sqrt(t));
        d2 = d1 - sigma.*sqrt(t);
        N1 = 0.5*(1+erf(d1/sqrt(2)));
        N2 = 0.5*(1+erf(d2/sqrt(2)));    
        P = K.*exp(-r.*t).*(1-N2)-S.*(1-N1);
    elseif t == 0
        P = max(K-S,0);
    else
        disp('Time-to-expiry cannot be negative')
    end
end