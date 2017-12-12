%% General Info
% main_realData.m
% danilo.zocco@gmail.com, 2017-12-10

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

%% Constants
data = 'AAPL.mat';

%% Load and convert data
ticker = load(data);

% General parameters
r = ticker.libor_3M_USD(end,1);     % Risk-free rate (annualized)
rf = 4*log(1+r/4);                  % Continuously-comp. risk-free rate
t0 = ticker.obs_date;               % Current date

% Stock
S = ticker.stock_price(1:end-1,1);  % Historical adj. prices
S0 = ticker.stock_price(end,1);     % Current stock price

% Option-Chain
%K = ticker.strike(3:4,1);          % Problematic strikes
%C = ticker.call(3:4,1);            % Problematic call prices
K = ticker.strike(5:end,1);         % Strikes
C = ticker.call(5:end,1);           % Call prices
P = ticker.put;                     % Put prices
T = ticker.expiry;                  % Expiry date
tau = days(T-t0)/365;               % Time-to-expiry (in years)

%% Get realistic volatility estimates
% From historical prices
vola = hist_vola(S,'daily');
%disp(vola)

% Implied volatilities
IV_N = IV_search(C,S0,K,rf,tau,'newton');    % Newton's method
IV_B = IV_search(C,S0,K,rf,tau,'bisection'); % Bisection method
%disp(IV_N)
%disp(IV_B)
%plot(K,IV_N)

%% Restore search path
manage_path('restore')