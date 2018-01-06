function P = BlackScholes(S,K,B,r,t,sigma,feature)
% Black/Scholes for specific put options used for Project Nr. 5
%
% INPUT   S ........ 1x1      stock price
%         K ........ 1x1      strike price
%         B ........ 1x1      barrier price (B > K, B > S)
%         r ........ 1x1      interest rate
%         t ........ 1x1      time to expiry
%         sigma .... 1x1      volatility
%         feature .. str      'EU_vanilla' for European vanilla put
%                             'EU_up_out'  for European up-and-out put
%                             'EU_binary'  for European binary put
%
% OUTPUT  P ........ 1x1      put price
%
% danilo.zocco@gmail.com, 2017-12-03

    switch feature
        case 'EU_vanilla'
            P = BS_EU_std(S,K,r,t,sigma);
        case 'EU_up_out'
            P = BS_EU_up_out(S,K,B,r,t,sigma);
        case 'EU_binary'
            P = BS_EU_bin(S,K,r,t,sigma);
    end

end

%==================================================================================================
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

function P = BS_EU_up_out(S,K,B,r,t,sigma)
% Black/Scholes for European up-and-out put
%
% INPUT   S ...... 1x1      stock price
%         K ...... 1x1      strike price
%         B ...... 1x1      barrier price
%         r ...... 1x1      interest rate
%         t ...... 1x1      time to expiry
%         sigma .. 1x1      volatility
%
% OUTPUT  P ...... 1x1      put price
%
% danilo.zocco@gmail.com, 2017-12-03
    
    alpha = 0.5*(1-2*r/sigma^2);
    P1 = BS_EU_std(S,K,r,t,sigma);
    P2 = BS_EU_std((B^2/S),K,r,t,sigma);
    P = P1 - (S/B)^(2*alpha)*P2;
    
end