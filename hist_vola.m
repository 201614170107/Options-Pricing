function sigma = hist_vola(p,freq)
%
% TODO: Add period for estimation
%


% /!\ Output is a structure /!\
% OUTPUT Annualized volatility
%
%
u = diff(log(p));
M = size(u,1);

if strcmp(freq,'daily')
    sigma.estimate = std(u)*sqrt(252);
elseif strcmp(freq,'weekly')
    sigma.estimate = std(u)*sqrt(52);
elseif strcmp(freq,'monthly')
    sigma.estimate = std(u)*sqrt(12);
elseif strcmp(freq,'yearly')
    sigma.estimate = std(u);
end
    
CI = 1.96*sigma.estimate/sqrt(2*M);
sigma.CI = [sigma.estimate-CI, sigma.estimate, sigma.estimate+CI];

% In case we are nota allowed to use Toolboxes
% (Maybe split sigma below in more lines)
% sigma = sqrt(252*sum(u.^2)/(M-1)); % With mean = 0
% sigma = sqrt(252*(sum(u.^2)/(M-1) - sum(u)^2/(M*(M-1))));
end