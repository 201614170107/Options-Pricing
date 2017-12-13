%% List of pricing functions
% ===== European vanilla options =====
% BS for European vanilla put -> BS_EU_std : Doc and comment
% BT for European vanilla put -> BT_EU_std : Doc and comment
% MC for European vanilla put -> MC_EU_std :

% ===== American vanilla options =====
% BT for American vanilla put -> BT_AM_std : Doc and comment
% MC for American vanilla put -> MC_AM_std :

% ===== European binary options (cash) =====
% BS for European binary put -> BS_EU_bin : Doc and comment
% BT for European binary put -> BT_EU_bin : Doc and comment
% MC for European binary put -> MC_EU_bin :

% ===== American binary options (cash) =====
% BT for American binary put -> BT_AM_bin : Doc and comment
% MC for American binary put -> MC_AM_bin :


%% ===== Ideas and thoughts =====
% Modify binaries for A (qty)
% Add Greeks !
% Add Asian options
% Make a live script version and publish HTML to GitHub
%
%

%% ===== Test parameters =====
% General
S = 100;        % Initial stock price
K = 100;        % Strike price
r = 0.05;       % Risk-free interest rate
T = 1;          % Life-span of the option (Not time-to-expiry!)
sigma = 0.2 ;   % Annual volatility of the stock
n = 10;         % Steps in BT
N = 3;          % Steps in MC/LSM
M = 3;          % Asset paths in MC/LSM