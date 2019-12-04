
%directory where the features matrix and the corresponding labels are stored%
featureMatrixDir = 'G:\FeatureMatrix\chb03.mat';

load(featureMatrixDir);


%%%%% Normalization of features %%%%%
feature_matrix_case = normalize(feature_matrix_case)




C_range = [];
gamma_renge = [];

%partitioning the data for cross-validation
partition = cvpartition(label_vector_case, 'KFold',k_fold);