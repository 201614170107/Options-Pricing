%% List of pricing functions
% ===== European vanilla options =====
% BS for European vanilla put -> BS_EU_std : Doc and comment
% BT for European vanilla put -> BT_EU_std : Doc and comment
% MC for European vanilla put -> MC_EU_std : Refine, doc and comment

% ===== American vanilla options =====
% BT for American vanilla put -> BT_AM_std : Doc and comment
% MC for American vanilla put -> MC_AM_std :

% ===== European binary options (cash) =====
% BS for European binary put -> BS_EU_bin : Doc and comment
% BT for European binary put -> BT_EU_bin : Doc and comment
% MC for European binary put -> MC_EU_bin : Refine, doc and comment + Add Laguerre poly

% ===== American binary options (cash) =====
% BT for American binary put -> BT_AM_bin : Doc and comment
% MC for American binary put -> MC_AM_bin :


%% ===== Notes =====
% S0 : Initial stock price
% K  : Strike
% r  : continuously-compunded risk-free rate

%% ===== Ideas and thoughts =====
% Modify binaries for A (qty)
% Add Greeks !
% Add Asian options
% Make a live script version and publish to HTML
% Check coherence across variables S,K,r,T,t,sigma,etc.
%  --> Coherence must be across models, not across functions
% Check use of seed
% Decide about tolerance and precision across diferent methods
% Add section about improvements (var reduc, etc.)
%