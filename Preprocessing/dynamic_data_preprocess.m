%{
this script applies some preprocessing steps that are to be changed untill
the optimal settings are reached.

-applies band-pass filter
%}

%%%%%%%%filter parameters%%%%%%%
Fcl=0.5;
Fcu=30;
Fs=256;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%directory where the dataset is stored
dataDir = 'G:\MIT_MAT_Processed';
processedDataDir = 'G:\MIT_MAT_Changeable';
%extract the names of all cases (chb01 to chb24)
cases = dir(dataDir);
cases = {cases.name};   %convert the names into string cells
cases = cases([3:length(cases)]); %execlude the directories '.' and '..' 

%loop through the cases
for case_iter = cases
    
    if ( isdir( [dataDir '\' char(case_iter)] ) ) %check if it's a directory (a case that includes records)
        
        %extract the names of all the records of the specified case
        records = dir([dataDir '\' char(case_iter) '\*.mat']);
        records = {records.name};
        
        %create a directory for that case for later storage of the
        %processed records
        mkdir([processedDataDir '\' char(case_iter)]);
        
        %apply band-pass filter to the dataset
        for rec = records
            dummy = rec{1};
            load([dataDir '\' char(case_iter) '\' dummy]);
            data  = bandPass_filter( data , Fcl, Fcu, Fs );
            %save the processed data, along with its associated header and labels
            
            save([processedDataDir '\' char(case_iter) '\' dummy], 'data', 'header', 'record_labels');
        end
    end
    
end