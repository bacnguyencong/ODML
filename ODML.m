function [M, pars] = ODML(X, Y, pars)
% =========================================================================
% Ordinal distance metric learning
% INPUT 
%       X: (d x n) input examples
%       Y: (n x 1) input labels
%       pars. 
%            k: number of target neighbors
%            v: number of neighbors with different class lables
%            alpha: trade-off parameter
%            kernel: (0/1) use kernel or not
%            sigma:  kernel width
% OUTPUT 
%       M: the Mahalanobis matrix
%       pars: all parameters of the model
% 
% Created by: Bac Nguyen (Bac.NguyenCong@ugent.be)
% Date      : November 6, 2016
% =========================================================================
    if (~exist('pars', 'var'))
        pars = setDefaultParameters();
    end    
    if pars.kernel 
        X = kernelmatrix('rbf', X, [], pars.sigma);
    end
    pars.X = X;
    pars.T = getAllConstraints(X,Y,pars.k,pars.v);     
    x0     = vec(eye(size(X,1)));
    M      = mat(gradproj(x0,pars.maxit,@objfunction,pars));
end