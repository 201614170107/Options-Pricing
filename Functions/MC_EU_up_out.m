function CI = MC_EU_up_out(S0,K,B,r,T,sigma,N,M)
% Monte Carlo methods for European standard put
%
% Doc and comment
%
% danilo.zocco@gmail.com, 2017-12-12

    dt = T/N;
    
    P = zeros(M,1);
    for i = 1:M
        Svals = S0*cumprod(exp((r-0.5*sigma^2)*dt+sigma*sqrt(dt)*randn(N,1)));
        Smax = max(Svals);
        if Smax < B 
            P(i) = exp(-r*T)*max(K-Svals(end),0);
        end
    end

    aM = mean(P);
    bM = std(P);
    CI = [aM-1.96*bM/sqrt(N), aM, aM+1.96*bM/sqrt(N)];
end