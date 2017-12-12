function P = BT_EU_bin(S,K,r,T,sigma,n)
% Binomial methods for European cash-or-nothing put

%S = 100; K = 100; T = 0.25; r = 0.05; sigma = 0.2; n = 3;
tol = 0.005; % Tolerance for payoff when S = K
dt = T/n;
u = exp(sigma*sqrt(dt));
d = 1/u;
p = (exp(r*dt)-d)/(u-d);

% Option prices at time T
% We have to take error for zeros into account and set an interval.
% By setting (-0.005 > K-S_T > 0.005) = 0,
% we ensure that 99.99 and 100.01 ~= 100
% but 99.995 and 100.005 == 0.
% This seems reasonable since options are quoted with 2 decimals.
S_T = S*u.^([0:n].').*d.^([n:-1:0].');
P = S_T;
P(K-S_T > tol)  = 1;
P(K-S_T < -tol)  = 0;
P(K-S_T < tol & K-S_T > -tol) = 0.5;

% Iterate backwards
for stp = n:-1:1
    P = exp(-r*dt) * ((1-p)*P(1:stp) + (p*P(2:stp+1)));
end
end