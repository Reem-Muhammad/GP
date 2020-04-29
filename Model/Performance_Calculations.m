function [TP,TN,FP,FN]=Performance_Calculations(Classification,seizure_true)
%Classification -> results of classifying using the model
%seizure_true -> Accurate Labels
TP=0;TN=0;FP=0;FN=0;

for i=1:length(Classification)
    if(Classification(i)==1)&&(seizure_true(i)==1)
        TP=TP+1;
    elseif(Classification(i)==0)&&(seizure_true(i)==0)
        TN=TN+1;
    elseif(Classification(i)==1)&&(seizure_true(i)==0)
        FP=FP+1;
    elseif(Classification(i)==0)&&(seizure_true(i)==1)
        FN=FN+1;
    end
end