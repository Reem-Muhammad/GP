function classout = testCriterionFunction(XTRAIN, YTRAIN, XTEST, sigma, C)

opts = statset('MaxIter',1000000, 'Display', 'iter');
model = svmtrain(XTRAIN, YTRAIN, 'kernel_function','rbf',...
                'rbf_sigma', sigma, 'boxconstraint', C,...
                'options', opts);
classout = svmclassify(model, XTEST);

%performance analysis
%CP = classperf(YTEST, classout);

%extract the error rate for later optimization
%testval = CP.ErrorRate;

end