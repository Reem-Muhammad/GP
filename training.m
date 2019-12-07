addpath('E:\Odious hole\Major\Graduation Project\GP\ML\FeatureExtraction\HurstExponent\Scripts');
addpath('E:\Odious hole\Major\Graduation Project\GP\ML\FeatureExtraction\Kurtosis_Skewness\Scripts');
addpath('E:\Odious hole\Major\Graduation Project\GP\ML\FeatureExtraction\ApproximateEntropy\Scripts');
addpath('E:\Odious hole\Major\Graduation Project\GP\ML\FeatureExtraction\StandardDeviation');

load('G:\MIT_MAT_changeable\chb03\chb03_01'); %loading WS variable

%%%%%%%%%%%%%%%%% parameters %%%%%%%%%%%%%%%%%%
test_pct = 0.2;
train_pct = 0.8; %will be further divided into training set and cross validation set
windowSize = 1024;
k_fold = 5;   %number of folds for K-fold cross-validation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
PE_outputMatrix = PE_F(data);
FD_outputMatrix = FD_F(data);
HE_outputMatrix = HE_F(data);
kurt_outputMatrix = kurt_F(data);
ApEn_outputMatrix = ApEn_F(data);
STD_outputMatrix = STD_F(data);

n_windows = floor( (size(data,1))/windowSize ); %number of windows (columns) in the record (no. samples/ window size)

%concatenete the features of each window
feature_matrix = [kurt_outputMatrix(:)...
                  HE_outputMatrix(:)...
                  PE_outputMatrix(:)...
                  FD_outputMatrix(:)...
                  ApEn_outputMatrix(:)...
                  STD_outputMatrix(:)]; 

%labels
%repeat the labels for each channel
label_vector = repmat(record_labels, floor( size(feature_matrix, 1)/n_windows), 1 );
%}

%%%%%%%%%%%%%% Training%%%%%%%%%%%%%%%
%shuffle the data
rand_num = randperm(size(feature_matrix,1)); %permutate the numbers from 1 : no. observations to select random indices
x_train = feature_matrix( rand_num(1: floor(train_pct*size(rand_num,2)) ), : ); %select a percentage of the windows randomly for training and cross validation
y_train = label_vector(rand_num(1: floor(train_pct*size(rand_num,2)) ), : );  %select the labels corresponding to these windows

x_test = feature_matrix( rand_num( floor(train_pct*size(rand_num,2))+1  :end) , : ); %select the rest of the observations as a testing set
y_test = label_vector( rand_num( floor(train_pct*size(rand_num,2))+1  :end), : );

%Cross-validation
cv = cvpartition(y_train, 'KFold',k_fold); %divides the training set into k folds, each fold consists of test and training sets

opts = statset('MaxIter',30000, 'Display', 'iter');




classf = @(x_train, y_train, x_test, y_test)...
    sum(svmclassify(svmtrain(x_train, y_train,'kernel_function','rbf'), x_test) ~= y_test);

[fs, history] = sequentialfs(classf, x_train, y_train, 'cv', cv, 'options', opts, 'nfeatures',2);
% Best hyperparameter

X_train_w_best_feature = x_train(:,fs);

Md1 = svmtrain(X_train_w_best_feature,y_train,'kernel_function','rbf','showplot',true);
%model = svmtrain(x_train, y_train,'kernel_function', 'rbf','autoscale',true, 'options', opts)

%gscatter(x_train(:,1), x_train(:,2), y_train)

% Final test with test set
X_test_w_best_feature = x_test(:,fs);
test_accuracy_for_iter = sum((svmclassify(Md1,X_test_w_best_feature) == y_test))/length(y_test)*100;

%{
% hyperplane
figure;
hgscatter = gscatter(X_train_w_best_feature(:,1),X_train_w_best_feature(:,2),y_train);
hold on;
h_sv=plot(Md1.SupportVectors(:,1),Md1.SupportVectors(:,2),'ko','markersize',8);
%}


%{
% test set data
gscatter(X_test_w_best_feature(:,1),X_test_w_best_feature(:,2),y_test,'rb','xx')
%}






%{
% decision plane
XLIMs = get(gca,'xlim');
YLIMs = get(gca,'ylim');
[xi,yi] = meshgrid([XLIMs(1):0.01:XLIMs(2)],[YLIMs(1):0.01:YLIMs(2)]);
dd = [xi(:), yi(:)];
pred_mesh = svmclassify(Md1, dd);
redcolor = [1, 0.8, 0.8];
bluecolor = [0.8, 0.8, 1];
pos = find(pred_mesh == 1);
h1 = plot(dd(pos,1), dd(pos,2),'s','color',redcolor,'Markersize',5,'MarkerEdgeColor',redcolor,'MarkerFaceColor',redcolor);
pos = find(pred_mesh == 2);
h2 = plot(dd(pos,1), dd(pos,2),'s','color',bluecolor,'Markersize',5,'MarkerEdgeColor',bluecolor,'MarkerFaceColor',bluecolor);
uistack(h1,'bottom');
uistack(h2,'bottom');
legend([hgscatter;h_sv],{'setosa','versicolor','support vectors'})
%}