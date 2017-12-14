%% Comparison of option pricing techniques
% Monte Carlo simulations and binomial methods

%% Set search path
manage_path('set')

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
%tol = 0.005;       % Required tolerance for option price

%% European path-independent
% ===== Black/Scholes ================================
BS = BS_EU_std(S,K,r,T,sigma);

% ====================================================

% ===== Binomial methods =============================
n_start = 100; n_end = 400;      % Steps in BT
n = n_start:1:n_end;
BT = zeros(size(n));

for s = 1:size(n,2)
    BT(s) = BT_EU_std(S,K,r,T,sigma,n(s));
end

% Plots for binomial method convergence
% ----------------------------------------------------
figure
subplot(2,1,1);     % Price convergence plot
plot(n,BT,'b*')
hold on
BS_line = refline([0 BS]); BS_line.Color = 'r';     % Add Black/Scholes price
xlim([n_start-1 n_end+1])
grid on
xlabel('Steps','Fontsize',fnt_size)
ylabel('European put price','Fontsize',fnt_size)
legend('Binomial methods', 'Black/Scholes price')
title('Convergence of binomial methods','Fontsize',fnt_size)

subplot(2,1,2)       % Error plot
loglog(n, abs(BT-BS))
hold on
loglog(n, 4./n,'r-')
xlim([n_start n_end])
grid on
xlabel('Log Steps','Fontsize',fnt_size)
ylabel('Log \mid \epsilon \mid','Fontsize',fnt_size)
legend('Abs. error', 'Error bound')
title('Error in binomial methods','Fontsize',fnt_size)
% ----------------------------------------------------
clear('n_start', 'n_end', 'n', 'BT', 's', 'BS_line') % Some housekeeping before moving on
% ====================================================

% ===== Monte Carlo methods ==========================
M_start = 5; M_end = 17;       % Asset paths in MC/LSM
M = zeros * [M_start:M_end];

for m = M_start:M_end
    M(m+1-M_start) = 2^m;     % Create vector of required samples
end

% Monte Carlo estimate with a 95% confidence interval
MC_CI = zeros(size(M,2),3);
for s = 1:size(M,2)
    MC_CI(s,:) = MC_EU_std(S,K,r,T,sigma,M(s));
end

CI_down = MC_CI(:,1);
CI_up = MC_CI(:,3);
P = MC_CI(:,2);

% Plot for Monte Carlo method convergence
% ----------------------------------------------------
figure
loglog(M,P,'b*')
hold on;
for idx = 1 : size(P,1)
    loglog([M(idx) M(idx)], [CI_down(idx) CI_up(idx)], 'k');
end
BS_line = refline([0 BS]); BS_line.Color = 'r';     % Add Black/Scholes price
ylim([min(CI_down)-1 max(CI_up)+1])
% ----------------------------------------------------
clear('M_start', 'M_end', 'M', 'm', 'MC_CI', ...     % Some housekeeping before moving on
      'CI_up', 'CI_down', 'P', 's', 'BS_line')                      
% ====================================================

%% American path-independent
%BT_AM_std(S,K,r,T,sigma,n)


%% Restore search path
manage_path('restore')