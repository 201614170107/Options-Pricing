function CI = MonteCarlo(S,K,B,r,t,sigma,N,M,feature)
% Binomial methods for specific put options used for Project Nr. 5
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
            CI = MC_EU_std(S,K,r,t,sigma,N);
        case 'EU_binary'
            CI = MC_EU_bin(S,K,r,t,sigma,N);
        case 'AM_vanilla'
            CI = MC_AM_std(S,K,r,t,sigma,N,M);
        case 'AM_binary'
            % TO BE ADDED
        case 'EU_up_out'
            CI = MC_EU_up_out(S,K,B,r,t,sigma,N,M);
    end

end

%==================================================================================================
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