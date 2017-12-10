function S = generate_path(S0,mu,sigma,T,N)
%S0 = 1; mu = 0.05; sigma = 0.1;
%T = 3; N = 1000;
dt = T/N;
dW = randn(N-1,1);
dS = exp((mu-0.5*sigma^2)*dt + sigma*sqrt(dt)*dW);
S  = [S0; S0*cumprod(dS)];
end