%% Comparison of option pricing techniques
% Monte Carlo simulations and binomial methods

%% Set search path
%manage_path('set')

% Main program
clear

%% ===== Program parameters =====
S = 100;            % Initial stock price
K = 120;            % Strike price
r = 0.05;           % Risk-free interest rate
T = 1;              % Life-span of the option (Not time-to-expiry!)
sigma = 0.2 ;       % Annual volatility of the stock
% Add seed here ...

% ===== Charts parameters =====
fnt_size = 15;

N = 3;              % Steps in MC/LSM
M = 3;              % Asset paths in MC/LSM
%tol = 0.005;       % Required tolerance for option price

%% European path-independent
n_start = 100; n_end = 400;      % Steps in BT
n = n_start:1:n_end;

BS = BS_EU_std(S,K,r,T,sigma) * ones(size(n)); % Black/Scholes price
BT = zeros(size(n));
%MC = repmat(zeros(M,1),1,3);

for s = 1:size(n,2)
    BT(s) = BT_EU_std(S,K,r,T,sigma,n(s));
end

% Plots for binomial method convergence
% ==================================================
figure
subplot(2,1,1)       % add first plot in 2 x 1 grid
plot(n,BT,'b*')
hold on
plot(n,BS,'r-')
xlim([n_start-1 n_end+1])
grid on
xlabel('Steps','Fontsize',fnt_size)
ylabel('European put price','Fontsize',fnt_size)
legend('Binomial methods', 'Black/Scholes price')
title('Convergence of binomial methods','Fontsize',fnt_size)

subplot(2,1,2)       % add second plot in 2 x 1 grid
loglog(n, abs(BT-BS))
hold on
loglog(n, 4./n,'r-')
xlim([n_start n_end])
grid on
xlabel('Log Steps','Fontsize',fnt_size)
ylabel('Log \mid \epsilon \mid','Fontsize',fnt_size)
legend('Abs. error', 'Error bound')
title('Error in binomial methods','Fontsize',fnt_size)
% ====================================================

%% BT_convergence_plot(n,BT)

for s = 1:M
    MC(s,:) = MC_EU_std(S,K,r,T,sigma,2^(4+s));
end


plot(2.^(1:3),MC(:,2),'r*')
hold on
line 
%% American path-independent
BT_AM_std(S,K,r,T,sigma,n)


%% Restore search path
%manage_path('restore')