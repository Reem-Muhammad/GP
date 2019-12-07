function testval = testCriterionFunction(XTRAIN, YTRAIN, XTEST, YTEST)

opts = statset('MaxIter',30000, 'Display', 'iter');
model = svmtrain(XTRAIN, YTRAIN, 'kernel_function','rbf', 'options', opts);
classout = svmclassify(model, XTEST);

%performance analysis
CP = classperf(YTEST, classout);

%extract the error rate for later optimization
testval = CP.ErrorRate;

end