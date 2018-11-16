clear;
install;

pars.k = 3;
pars.v = 6;
pars.alpha  = 0.001;
pars.sigma  = 0.1;
pars.metric = 'MAE';
pars.maxit  = 500;
pars.kernel = 0;
pars.stepsize=0.1;

load('data/data.mat');
[Xtr, Xte] = normalize(Xtr', Xte');
Xtr = Xtr'; Xte = Xte';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ypred = knnClassifier(Xtr, Ytr, pars.k, Xte);
err1  = erroreval(Yte, Ypred, pars.metric);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[M, pars] = ODML(Xtr, Ytr, pars);
Ypred     = knnClassifier(Xtr, Ytr, pars.k, Xte, M);
err2      = erroreval(Yte, Ypred, pars.metric);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pars.kernel = 1;
[M, pars]   = ODML(Xtr, Ytr, pars);
Xte         = kernelmatrix('rbf', Xtr, Xte, pars.sigma);  
Xtr         = kernelmatrix('rbf', Xtr, [], pars.sigma);
Ypred       = knnClassifier(Xtr, Ytr, pars.k, Xte, M);
err3        = erroreval(Yte, Ypred, pars.metric);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('-------------------------------------------------------------\n');
fprintf('Mean Absolute Errors of 3-NN using\n');
fprintf('Euclidean = %.4f, \nLODML     = %.4f, \nKODML     = %.4f\n', err1, err2, err3);
