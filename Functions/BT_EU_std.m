function P = BT_EU_std(S,K,r,T,sigma,n)
% Binomial methods for European standard put

%S = 110; K = 115; T = 0.25; r = 0.05; sigma = 0.2; n = 100;

dt = T/n;
u = exp(sigma*sqrt(dt));
d = 1/u;
p = (exp(r*dt)-d)/(u-d);

% Option prices at time T
P = max(K - S*u.^([0:n].').*d.^([n:-1:0].'), 0);

% Iterate backwards
for stp = n:-1:1
    P = exp(-r*dt) * ((1-p)*P(1:stp) + (p*P(2:stp+1)));
end
end