function P = BS_EU_bin(S,K,r,t,sigma)
% Black/Scholes for European cash-or-nothing put
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
% danilo.zocco@gmail.com, 2017-12-10

    if t > 0
        d2 = (log(S./K)+(r-0.5*sigma.^2).*t) ./ (sigma.*sqrt(t));
        N2 = 0.5*(1+erf(d2/sqrt(2)));
        P = exp(-r.*t).*(1-N2);
    elseif t == 0
        if S > K
            P = 0.0;
        elseif S < K
            P = 1.0;
        elseif S == K
            P = 0.5;
        end
    else
        disp('Time-to-expiry cannot be negative')
    end
end