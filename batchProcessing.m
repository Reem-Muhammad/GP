function batchProcessing(dataDir)
addpath('.\Preprocessing');
%dataDir = '';

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
            
            
        end
     end
end
end