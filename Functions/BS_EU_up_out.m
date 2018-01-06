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