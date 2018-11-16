function preds = knnClassifier(xTr, labels, k, xTe, M)
%%=========================================================================
% Do k nearest neighbors classifier
% INPUT:
%       xTr     : training examples by columns   
%       labels  : class label of input examples by column vector
%       k       : number of nearest neighbors
%       xTe     : testing examples by columns
%       M       : the Mahalanobis matrix (default: I)
% OUPUT:
%       preds   :  predicted label for each instance in xTe by colums
%==========================================================================
% Created by: Bac Nguyen (Bac.NguyenCong@ugent.be)
% Date      : November 6, 2016
% =========================================================================

    if exist('M', 'var')
        L   = factorize(M);
        xTr = L'*xTr;
        xTe = L'*xTe;
    end
    ind   = kNearestNeighbors(xTr, xTe, k);
    preds = labels(ind);
    if size(ind, 1) > 1  %check if is 1 nearest neighbor classifier
        preds = mode(preds, 1);
    end
    preds = preds(:);
end