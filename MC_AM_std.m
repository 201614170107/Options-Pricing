function P = MC_AM_std(S0,K,r,T,sigma,N,M)
% Monte Carlo methods by LSM for American standard put
%
% Doc and comments
% Sources with debugging
%
% danilo.zocco@gmail.com, 2017-12-12

% Debug parameters
%S0 = 100; K = 100; T = 1; r = 0.05; sigma = 0.2; N = 50; M = 50;
dt = T/N;

% Sample paths
R = exp((r-sigma^2/2)*dt+sigma*sqrt(dt)*randn(N,M));
S = cumprod([S0*ones(1,M); R]);

% Initialize cash flow matrix
CF = zeros(size(S));
CF(end,:) = max(K-S(end,:),0);  % Payoffs at time T

for t = size(S,1)-1:-1:2
    Idx = find(S(t,:) < K); % Find paths that are in the money at time t
    
    X = S(t,Idx)';
    X1 = X/S0;
    Y = CF(t+1,Idx)'*exp(-r*dt); % Discounted cashflow
    R = [ones(size(X1)) (1-X1) 1/2*(2-4*X1-X1.^2)];
    %R = [ones(size(X)), X, X.^2];
    a = R\Y; % Linear regression step
    C = R*a; % Cash flows as predicted by the model
    
    Jdx = max(K-X,0) > C; % Immediate exercise better than predicted cashflow
    
    nIdx = setdiff((1:M),Idx(Jdx));
    CF(t,Idx(Jdx)) = max(K-X(Jdx),0);
    CF(t,nIdx) = exp(-r*dt)*CF(t+1,nIdx);
end
P = mean(CF(2,:))*exp(-r*dt);
end