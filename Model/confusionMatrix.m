function [TP, TN, FP, FN]=confusionMatrix(x_test, y_test, model)
%{
Attempting to classify the testing set as a whole for model evaluation requires more memory than the available RAM

This script was used to partition the test set into subsets, calculate the
number of misscalssifications in each subset, then add them all together to calculate the accuracy 

x_test -> feature matrix to classify
y_test -> correct labels
%}

subset = 100;
TP = 0;
TN = 0;
FP = 0;
FN = 0;

for iter = 0:floor(length(x_test)/subset)-1
    res = svmclassify(model, x_test(iter*subset+1:iter*subset+subset, :));
    
    adder = y_test(iter*subset+1:iter*subset+subset) + res;
    TP = TP + length(find(adder == 2));
    TN = TN + length(find(adder == 0));
    
    subtr = y_test(iter*subset+1:iter*subset+subset) - res;
    FP = FP + length(find(subtr == -1));
    FN = FN + length(find(subtr == 1));
        
end

 res = svmclassify(model, x_test(iter*subset+subset+1:end, :));
 
 adder = y_test(iter*subset+subset+1:end, :) + res;
 TP = TP + length(find(adder == 2));
 TN = TN + length(find(adder == 0));
 
 subtr = y_test(iter*subset+subset+1:end, :) - res;
 FP = FP + length(find(subtr == -1));
 FN = FN + length(find(subtr == 1));
end 