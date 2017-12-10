function IV = IV_search(V,S,K,r,t,method)

    if strcmp(method,'bisection')
        IV = IV_bisection(V,S,K,r,t);
    elseif strcmp(method,'newton')
        IV = IV_Newton(V,S,K,r,t);
    end
end

%% ===== Private functions =====
function IV = IV_bisection(V,S,K,r,t)
    
    dim_K = size(K,1);
    IV = zeros(dim_K,1);
    for k = 1:dim_K
        % Initialize search parameters
        x_a = 0.001; x_b = 10.0;
        xdiff = 1.0; tol = 1E-5;
        
        % Search IV
        while xdiff>tol
            x_mid = 0.5*(x_a+x_b);
            F_a = BSM_EU(S,K(k),r,t,x_a) - V(k);
            F_mid = BSM_EU(S,K(k),r,t,x_mid) - V(k);
        
            if F_a*F_mid < 0
                x_b = x_mid;
            else
                x_a = x_mid;
            end
            xdiff = x_b-x_a;
        end
        IV(k) = 0.5*(x_a+x_b);
    end
end

function IV = IV_Newton(V,S,K,r,t)
    
    dim_K = size(K,1);
    IV = zeros(dim_K,1);
    x0 = sqrt(2*abs((log(S./K)+r*t)/t));
    
    for k = 1:dim_K
        % Initialize search parameters
        xdiff = 1; tol = 1E-5;
        s = 1; sMax = 500;
        x = x0(k);
        
        % Search IV
        while (xdiff>tol && s<=sMax)
            d1 = (log(S/K(k))+(r+0.5*x^2)*t) / (x*sqrt(t));
            Fval = BSM_EU(S,K(k),r,t,x)-V(k);
            Fprime = S*sqrt(t)*exp(-0.5*d1^2)/sqrt(2*pi);
            increment = Fval/Fprime;
            x = x - increment;
        
            xdiff = abs(increment);
            s = s+1;
        end
        IV(k) = x;
    end
end