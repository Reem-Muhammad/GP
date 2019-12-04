%{
this script generates the records on which feature extraction will be
applied.

- Selects the channels that will be subjected to further processing

notes:
- change 'dataDir' to the directory where the dataset is stored
- change 'processedDataDir' to the directory where the processed data will
be stored
%}

commonChannels = {'P4-O2', 'FP2-F4', 'P7-O1', 'C4-P4', 'F7-T7', 'C3-P3', 'FP1-F7', 'F8-T8', 'FZ-CZ', 'CZ-PZ', 'F3-C3', 'T7-P7', 'P8-O2', 'FP1-F3', 'F4-C4', 'FP2-F8', 'P3-O1'};

%directory where the dataset is stored
dataDir = 'G:\MIT_MAT';
%directory where the processed dataset is to be stored
processedDataDir = 'G:\MIT_MAT_Processed';



%extract the names of all cases in the data directory(chb01 to chb24)
cases = dir(dataDir);
cases = {cases.name};   %convert the names into string cells
cases = cases([3:length(cases)]); %execlude the directories '.' and '..' 

%loop through the cases
for case_iter = cases
    
    if ( isdir( [dataDir '\' char(case_iter)] ) ) %check if it's a directory
        
        %extract the names of all the records of the specified case
        records = dir([dataDir '\' char(case_iter) '\*.mat']);
        records = {records.name};

      %loop through the records of the specified case
        for rec = records
            dummy = rec{1};
            load([dataDir '\' char(case_iter) '\' dummy]);
            
            validCh_idx = [];
            for ch_name = commonChannels
                %construct a vector that contains the indices of the common
                %channels
                validCh_idx = [validCh_idx ; find(ismember(header.labels, ch_name))];
            end
            
            %extract the common channels from the records
            data = data(:, validCh_idx);
            save([processedDataDir '\' char(case_iter) '\' dummy], 'data','header');
        end
    end
    
end