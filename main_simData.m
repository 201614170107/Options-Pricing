% Updates
% Add input parameter for frequency in hist_vola
% CI for hist vola
% Try EWMA for hist_vola w/ real data and compare with IV from real data.
% Upgrade BS for more than calls
% Check constistance bewtween T and t
% T = Length of simulation
% t = time to maturity for option

%% Set search path
manage_path('set')

%% Initial parameters
S0 = 100.0; mu = 0.05; sigma = 0.3; % Stock
K = [110;115]; t = 0.4; r = 0.02;         % Option
T = 3; N = 252*T;                   % Path

%% Simulated data
S = generate_path(S0,mu,sigma,T,N); % Simulate one stock path
C = BSM_EU(S0,K,r,t,sigma);         % Get option price from BS

%% Volatility estimation
% Get volatility from historical prices
vola = hist_vola(S,'daily');

% Get implied volatility from option prices
%IV_N = IV_Newton(C,S0,K,r,t);    % Newton's method
%IV_B = IV_bisection(C,S0,K,r,t); % Bisection method

% Do the same with IV_search
IV_N2 = IV_search(C,S0,K,r,t,'newton');
IV_B2 = IV_search(C,S0,K,r,t,'bisection');

disp(vola.estimate)
%disp(IV_N)
%disp(IV_B)
disp(IV_N2)
disp(IV_B2)

%% European vanilla options
[BSM_EU_call, BSM_EU_put] = BSM_EU(S0,K,r,t,sigma);
[BSM_EU_bin_call, BSM_EU_bin_put] = BSM_BinaryEU(S0,K,r,t,sigma);

disp([BSM_EU_call, BSM_EU_put])
disp([BSM_EU_bin_call, BSM_EU_bin_put])


%% Restore search path
manage_path('restore')