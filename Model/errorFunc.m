function [ error ] = errorFunc( x_train, y_train, x_test, y_test )

fprintf('sequential feature selection - error calculation\n');
opts = statset( 'MaxIter', 1000000);

trainedModel = svmtrain(x_train, y_train, 'kernel_function', 'rbf', 'options',opts);
[TP, TN, FP, FN]=confusionMatrix(x_test, y_test, trainedModel);

sensitivity = (TP/(TP + FN))*100;
specificity = (TN/(FP + TN))*100;

error = 100 - (0.3*specificity + 0.7*sensitivity);

fprintf('error =  %7.3f\n\n', error);
end

