addpath('.\Features');


dataDir = '';
windowSize = 256;
FEATURE_MATRIX = []; %feature matrix for all records
LABELS = [];
%surrogateChannel_Extract();
%labelling();

%extract the names of all cases in the data directory(chb01 to chb24)
cases = dir(dataDir);
cases = {cases.name};   %convert the names into string cells
cases = cases([3:length(cases)]); %execlude the directories '.' and '..' 

%loop through the cases
for case_iter = cases
     if ( isdir( [dataDir '\' char(case_iter)] ) ) %check if it's a directory
         
        %extract the names of all the records for the specified case
        records = dir([dataDir '\' char(case_iter) '\*.mat']);
        records = {records.name};
        
        
        %loop through the records of the specified case
        for rec = [1:length(records)]
            %load the header file of each record to extract the annotations
            load([dataDir '\' char(case_iter) '\' char(records(rec))]);
            
            combinedIMF = channel_Decompose(surrogateChannel);
            save([dataDir '\' char(case_iter) '\' char(records(rec))], 'combinedIMF', '-append');
            
            featureMatrix_record= featureMatrix_Construct(combinedIMF, windowSize);
            FEATURE_MATRIX = [FEATURE_MATRIX; featureMatrix_record];
            LABELS = [LABELS; record_labels];
        end
     end
end

N_trainingWindows = 0.8 * length(FEATURE_MATRIX);
N_testingWindows = 0.2 * length(FEATURE_MATRIX);

train_idx = randperm(size(FEATURE_MATRIX,1), N_trainingWindows);
test_idx = ~ismember([1:size(FEATURE_MATRIX,1)], train_idx);

x_train = FEATURE_MATRIX(train_idx, :);  % 80% of the feature matrix
y_train = LABELS(train_idx);             % 80% of label matrix

x_test = FEATURE_MATRIX(test_idx,:);   % 20% of the feature matrix
y_test = LABELS(test_idx);             % 20% of label matrix


model = svmtrain(x_train, y_train, 'kernel_function', 'rbf');
results = svmclassify(model, x_test);

%Classification performance

TP = 0;
TN = 0;
FP = 0;
FN = 0;

for idx = [1:length(y_test)]
    if(y_test(idx) == results(idx) && y_test(idx) == 1)
        TP = TP + 1;
    end
    if(y_test(idx) == results(idx) && y_test(idx) == 0)
        TN = TN + 1;
    end
    if(y_test(idx) == 1 && results(idx) == 0)
        FN = FN + 1;
    end
    if(y_test(idx) == 0 && results(idx) == 01)
        FP = FP + 1;
    end
end

sensitivity = TP/(TP + FN);
specificity = TN/(FP + TN);
accuracy = ((TP+TN)/length(y_test))*100;


