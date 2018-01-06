function P = BinomialTree(S,K,B,r,t,sigma,n,feature)
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
            P = BT_EU_std(S,K,r,t,sigma,n);
        case 'EU_binary'
            P = BT_EU_bin(S,K,r,t,sigma,n);
        case 'AM_vanilla'
            P = BT_AM_std(S,K,r,t,sigma,n);
        case 'AM_binary'
            P = BT_AM_bin(S,K,r,t,sigma,n);
        case 'EU_up_out'
            P = BT_EU_up_out(S,K,B,r,t,sigma,n);
    end

end

%==================================================================================================
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
P(K-S_T > tol) = 1;
P(K-S_T < -tol) = 0;
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

function P = BT_EU_up_out(S,K,B,r,t,sigma,n)
% Binomial methods for European standard put

%S = 110; K = 115; T = 0.25; r = 0.05; sigma = 0.2; n = 100;

    dt = t/n;
    u = exp(sigma*sqrt(dt));
    d = 1/u;
    p = (exp(r*dt)-d)/(u-d);
    h = floor(log(B/S) / log(d));

    % Option prices at time T
    P = max(K - S*u.^([0:n].').*d.^([n:-1:0].'), 0);

    % Iterate backwards
    for stp = n:-1:1
        P = exp(-r*dt) * ((1-p)*P(1:stp) + (p*P(2:stp+1)));
        if (mod((stp-h),2) == 0) && ((stp-h)/2 >= 0) && ((stp-h)/2 <= stp)
            P((stp-h)/2) = 0;
        end
    end
end