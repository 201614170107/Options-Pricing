function P = BT_AM_bin(S,K,r,T,sigma,n)
% Binomial methods for American cash-or-nothing put
%
% Say something about source
%S = 100; K = 100; T = 0.25; r = 0.05; sigma = 0.2; n = 3;
tol = 0.005; % Tolerance for payoff when S = K
dt = T/n;
u = exp(sigma*sqrt(dt));
d = 1/u;
p = (exp(r*dt)-d)/(u-d);

% Payoffs at time T
S_T = S*u.^([0:n].').*d.^([n:-1:0].');
P = S_T;
P(K-S_T > tol)  = 1;
P(K-S_T < -tol)  = 0;
P(K-S_T < tol & K-S_T > -tol) = 0.5;

% iterate backwards
for stp = n:-1:1
    S_t = S*u.^([0:stp-1].').*d.^([stp-1:-1:0].');
    exercise_now = S_t;
    exercise_now(K-S_t > tol)  = 1;
    exercise_now(K-S_t < -tol)  = 0;
    exercise_now(K-S_t < tol & K-S_t > -tol) = 0.5;
    P = exp(-r*dt) * ((1-p)*P(1:stp) + (p*P(2:stp+1)));
    P = max(P, exercise_now);
end
end