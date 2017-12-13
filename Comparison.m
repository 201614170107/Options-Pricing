%% Set search path
manage_path('set')

% Main program

%% ===== Test parameters =====
S = 100;        % Initial stock price
K = 100;        % Strike price
r = 0.05;       % Risk-free interest rate
T = 1;          % Life-span of the option (Not time-to-expiry!)
sigma = 0.2 ;   % Annual volatility of the stock
n = 10;         % Steps in BT
N = 3;          % Steps in MC/LSM
M = 3;          % Asset paths in MC/LSM


%% European path-independent
BS_EU_std(S,K,r,T,sigma)

%% American path-independent
BT_AM_std(S,K,r,T,sigma,n)


%% Restore search path
manage_path('restore')