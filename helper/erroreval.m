function err = erroreval(Ypred, Y, metric)
% ===================================================
% Compute the error
% INPUT     :
%             Ypred: (n x 1) the predicted labels
%             Y: (n x 1) the true labels
%             metric: the metric used
% OUTPUT    :
% Created by: Bac Nguyen (Bac.NguyenCong@ugent.be)
% Date      : November 6, 2016
% ===================================================
    switch (metric)
        case 'MZE'
            err = sum(Ypred ~= Y)/length(Y);
        case 'MAE'
            err = sum(abs(Ypred - Y))/length(Y);
        case 'C-index'
            err = 0;
            tol = 0;
            l = sort(unique(Y));
            for i=1:length(l)-1                
                A   = Ypred(Y == l(i));
                nl  = length(A);                
                for j=i+1:length(l)
                    B   = Ypred(Y == l(j));    
                    nk  = length(B);
                    I   = vec(repmat(1:nl, nk, 1));
                    J   = vec(repmat(1:nk, 1, nl));
                    err = err + sum(A(I) < B(J)) + 0.5*sum(A(I) == B(J));
                    tol = tol + nl * nk;
                end
            end
            err = err/tol;
        case 'VUS'
            [~, ind] = sort(Y);
            labels   = unique(Y);
            Ypred    = Ypred(ind);
            L        = zeros(length(labels),1);

            for i=1:length(labels)
                L(i) = sum(Y == labels(i));
            end

            err = solve(Ypred, L, 1, [], 0, 1)/prod(L);
        otherwise
            error('Sorry! Evaluation metric is not implemented yet!'); 
    end
end

function ret = solve(Ypred, L, i, last, act, rep)    
    if i > length(L)
        ret = 1/factorial(rep);
    else
        ret = 0;
        labels = unique(Ypred(act+1:act+L(i)));
        for j=1:length(labels)
            cnt = sum(Ypred(act+1:act+L(i)) == labels(j));
            if i == 1 || labels(j) >= last
                if i > 1 && labels(j) == last
                    ret = ret + cnt*solve(Ypred, L, i+1, labels(j),...
                          act+L(i), rep+1);
                else
                    ret = ret + cnt*(1/factorial(rep))*...
                          solve(Ypred, L, i+1, labels(j), act+L(i), 1);
                end
            end
        end
    end    
end