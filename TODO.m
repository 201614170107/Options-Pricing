%% List of pricing functions
%
% Checks for functions: comments, doc(description, inputs, outputs, sources, name, date),
% indents
%
% ===== European vanilla options =====
% BS for European vanilla put -> BS_EU_std : Doc and comment
% BT for European vanilla put -> BT_EU_std : Doc and comment
% MC for European vanilla put -> MC_EU_std : Refine, doc and comment

% ===== American vanilla options =====
% BT for American vanilla put -> BT_AM_std : Doc and comment
% MC for American vanilla put -> MC_AM_std : Refine, doc and comment + Add Laguerre poly

% ===== European binary options (cash) =====
% BS for European binary put -> BS_EU_bin : Doc and comment
% BT for European binary put -> BT_EU_bin : Doc and comment
% MC for European binary put -> MC_EU_bin : Doc and comment

% ===== American binary options (cash) =====
% BT for American binary put -> BT_AM_bin : Doc and comment
% MC for American binary put -> MC_AM_bin :


%% ===== Notes =====
% S     : Initial stock price
% K     : Strike
% B     : Barrier
% r     : Continuously-compunded risk-free rate
% t     : Time-to-expiry
% sigma : Annual volatility
% n     : Number of steps for binomial methods
% N     : Number of steps for Monte Carlo methods
% M     : Number of paths for Monte Carlo methods


%% ===== Ideas and thoughts =====
% Modify binaries for A (qty)
% Add Greeks !
% Make a live script version and publish to HTML
% Check coherence across variables S,K,r,T,t,sigma,etc.
% Check use of seed
% Decide about tolerance and precision across different methods (?)
% Add section about improvements (var reduc, etc.)