function P = BT_AM_std(S,K,r,T,sigma,n)
% Binomial methods for American standard put
%
% Say something about source

%S = 110; K = 115; T = 0.25; r = 0.05; sigma = 0.2; n = 100;

dt = T/n;
u = exp(sigma*sqrt(dt));
d = 1/u;
p = (exp(r*dt)-d)/(u-d);

% option prices at time T
P = max(K - S*u.^([0:n].').*d.^([n:-1:0].'), 0);

% iterate backwards
for stp = n:-1:1
    exercise_now = max(K - S*u.^([0:stp-1].').*d.^([stp-1:-1:0].'), 0);
    P = exp(-r*dt) * ((1-p)*P(1:stp) + (p*P(2:stp+1)));
    P = max(P, exercise_now);
end
end