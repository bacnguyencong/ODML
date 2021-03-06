function [best_x, best_C] = gradproj(x0, max_iter, f, pars)
% ==================================================================
% Perform projected gradient descent
%         
% INPUT 
%       x0: (d^2 x 1)the initial solution
%       max_iter: maximum number of iteration
%       f: the objective function [val, gradient] = f(x)
%       pars.
%            T: (3 x m) triplet constraints
%            X: (d x n) input examples
%            alpha: the hyper-parameter 
% OUTPUT 
%       best_x: (d^2 x 1) the optimal solution
%       best_C: the minimum value of objective function
% 
% Created by: Bac Nguyen (Bac.NguyenCong@ugent.be)
% Data      : November 6, 2016
% =================================================================
    beta = 1./size(pars.T,2);    
    L    = eye(size(pars.X,1));
    
    eta      = pars.stepsize;
    min_iter = 50;
    tol      = 1e-7;
    quiet    = 1;
    
    xc     = x0;
    iter   = 1;
    C      = Inf;
    prev_C = Inf;
    best_C = Inf;
    best_x = x0;
    
    if ~pars.kernel
        grad = vec(pars.alpha*eye(size(pars.X,1))); % gradient
    else
        grad = vec(pars.alpha*pars.X); % gradient
    end
    slack  = zeros(1, size(pars.T,2)); % slack variables   
    
    while ( abs(prev_C - C) > tol || iter < min_iter ) && (iter < max_iter)
        prev_C = C;
        [C, grad, slack] = feval(f, xc, pars, L'*pars.X, beta, grad, slack);
        if (~quiet) && (mod (iter, 50) == 0), 
            fprintf('#iter=%.0f, C=%.6f, Active=%d\n', iter, C, sum(slack>0)); 
        end
        if C < best_C
            best_C = C;
            best_x = xc;
        end
        [xc L] = kk_proj(xc - eta*grad);
        if isempty(L), break; end
        % Update learning rate
        if prev_C > C
            eta = eta * 1.01;
        else
            eta = eta * .5;
        end
        iter = iter + 1;
    end
end

function [xc, L] = kk_proj(xc)
    xc     = mat(xc);
    [L, D] = eig(xc); L = real(L); D = real(D);
    ind    = find(diag(D) > 0);
    xc     = vec(L(:,ind) * D(ind, ind) * L(:,ind)');    
    L      = L(:,ind) * sqrt(D(ind, ind)); clear('D', 'ind');
end