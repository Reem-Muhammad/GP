function [LABELS]=preprocessingMain()
%{
main function that does all the preprocessing upon calling.

It returns only the whole labels vector, since everything else is saved
within the record
%}

dataDir = '.\Data';   %path to the directory where the data is stored
%NOTE: dataDir should be '..\Data' in case the script will reun while
%MATLAB is in .\preprocessing.
Fs = 256; %sampling frequency

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
            fprintf('Preprocessing case: %s record: %s\n',char(case_iter), char(records(rec)));
            %load the record
            load([dataDir '\' char(case_iter) '\' char(records(rec))])
            %label the data
            labeling(header, data, records, rec, case_iter, dataDir);

            %remove bad channels (EOG, NaN)
            chPreprocess_data = badChannels_Remove(data, header);
            %save the record without bad channels
            save([dataDir '\' char(case_iter) '\' char(records(rec))],'chPreprocess_data','-append');
            %filter the data
            filtered_data = bandPassFilter( chPreprocess_data , 0.5, 30, Fs);
            %save the filtered data
            save([dataDir '\' char(case_iter) '\' char(records(rec))],'filtered_data','-append');
        end
     end
end


 LABELS  = labelsVector_Construct();
end