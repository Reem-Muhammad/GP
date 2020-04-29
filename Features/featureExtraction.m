function [  ] = featureExtraction(  )

dataDir = '.\Data';   %path to the directory where the data is stored
%NOTE: dataDir should be '..\Data' in case the script will reun while
%MATLAB is in .\preprocessing.
windowSize = 1024;

%extract the names of all cases in the data directory(chb01 to chb24)
cases = dir(dataDir);
cases = {cases.name};   %convert the names into string cells
cases = cases([3:length(cases)]); %execlude the directories '.' and '..' 

%loop through the cases
for case_iter = cases
     if ( isdir( [dataDir '\' char(case_iter)] ) ) %check if it's a directory
         
        %extract the names of all the records for the specified case
        records = dir([dataDir '\' char(case_iter) '\ch*.mat']);
        records = {records.name};
        
        
        %loop through the records of the specified case
        for rec = [1:length(records)]
            
            fprintf('Feature Extraction case: %s record: %d  %s\n',char(case_iter), rec, char(records(rec)));
            
            %load the record
            load([dataDir '\' char(case_iter) '\' char(records(rec))])
            features_str = {'SD','FD', 'Hurst','Kurtosis', 'Skew', 'FI', 'Mobility', 'Mean Ab Val', 'Max Ab Val', 'Min Ab Val',...
                'RMS', 'Spec Centroid', 'Var Coeff'};
            
            features = [stdDev(filtered_data, windowSize), fractalDim(filtered_data, windowSize), hurstExp(filtered_data, windowSize),...
                    kurt(filtered_data, windowSize), skew(filtered_data, windowSize), FI(filtered_data, windowSize), hjorthMobility(filtered_data, windowSize),...
                    meanAbs(filtered_data, windowSize), maxAbs(filtered_data, windowSize), minAbs(filtered_data, windowSize),...
                    rootMeanSq(filtered_data, windowSize), SC(filtered_data, windowSize), varCoeff(filtered_data, windowSize)];
            
            %save the features
            save([dataDir '\' char(case_iter) '\' char(records(rec))],'features','-append');
            %save the features namess
            save([dataDir '\' char(case_iter) '\' char(records(rec))],'features_str','-append');
        end
     end
end

end

