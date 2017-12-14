function CI = MC_EU_bin(S0,K,r,T,sigma,n)
% Monte Carlo methods for European standard put
%
% Doc and comment
%
% danilo.zocco@gmail.com, 2017-12-12

    %S0 = 100; K = 100; sigma = 0.4; r = 0.04; T = 1; n = 10000;
    
    tol = 0.01;

    espilon = randn(n,1);
    S_T = S0 * exp((r-0.5*sigma^2)*T + sigma*sqrt(T)*espilon);    
    P = S_T;
    P(K-S_T > tol)  = 1;
    P(K-S_T < -tol)  = 0;
    P(K-S_T < tol & K-S_T > -tol) = 0.5;
    P = P * exp(-r*T);


    %n = ceil((2*1.96*std(P)/tol)^2);
    %espilon = randn(n,1);
    %S_T     = S_0 * exp((r-0.5*sigma^2)*T + sigma*sqrt(T)*espilon);
    %P     = exp(-r*T) * max(K-S_T,0);

    aM = mean(P);
    bM = std(P);
    CI = [aM-1.96*bM/sqrt(n), aM, aM+1.96*bM/sqrt(n)];
end