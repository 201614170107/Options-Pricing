function CI = MC_EU_std(S0,K,r,T,sigma,n)
% Monte Carlo methods for European standard put
%
% Doc and comment
%
% danilo.zocco@gmail.com, 2017-12-12

    %S0 = 100; K = 100; sigma = 0.3; r = 0.04; T = 1; n = 10000; tol = 0.01;

    espilon = randn(n,1);
    S_T = S0 * exp((r-0.5*sigma^2)*T + sigma*sqrt(T)*espilon);
    P   = exp(-r*T) * max(K-S_T,0);


    %n = ceil((2*1.96*std(P)/tol)^2);
    %espilon = randn(n,1);
    %S_T     = S_0 * exp((r-0.5*sigma^2)*T + sigma*sqrt(T)*espilon);
    %P     = exp(-r*T) * max(K-S_T,0);

aM = mean(P);
bM = std(P);
CI = [aM-1.96*bM/sqrt(n), aM, aM+1.96*bM/sqrt(n)];
end