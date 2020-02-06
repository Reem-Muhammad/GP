%{
creats a labels vector for each record, and appends it to the corresponding
mat file.

each loaded record should have a header file that contains the annotations

after executing this script, each .mat file will contain: the record, and
the associated header and labels
%}

Fs = 256;   %sampling frequency of the dataset
windowSize = 1024;  %window size in number of samples
horizon = floor((30*60*Fs)/windowSize); %horizon in number of windows

dataDir = 'G:\MIT_MAT_Processed';   %path to the directory where the data is stored


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
            load([dataDir '\' char(case_iter) '\' char(records(rec))])
            %initialize the labels to 0
            record_labels = zeros( floor(length(data)/windowSize), 1);
            save([dataDir '\' char(case_iter) '\' char(records(rec))],'record_labels','-append');

            
            %loop through all seizure events in the record (some records contain more than one event)
            for annot_iter = [1: length(header.annotation.starttime)]
                
                if ( isempty(header.annotation.starttime(annot_iter))== 0 ) %if the record contains seizures
                    preictal_start = floor( (header.annotation.starttime(annot_iter)*Fs)/windowSize ) - horizon;
                    
                    if ( preictal_start >= 0 )  %if the preictal event starts in the same record
                        %assign the label '1' to preictal epochs
                        record_labels(preictal_start:preictal_start+horizon) = 1;
                        %append the variable to the mat file containing the record
                        save([dataDir '\' char(case_iter) '\' char(records(rec))],'record_labels','-append');
                        
                    else
                        %if the preictal event starts in the previous
                        %record
                        
                        %label the epochs from the beginning of the current record to the beginning of the seizure as preictal 
                        record_labels(1: (preictal_start+horizon) )=1;
                        save([dataDir '\' char(case_iter) '\' char(records(rec))],'record_labels','-append');
                        
                        if(rec ~= 1)
                            %if the current record is not the first record
                            
                            %load the previous record
                            load([dataDir '\' char(case_iter) '\' char(records(rec-1))]);
                            %label the epochs from the beginning of the
                            %preictal event until the end of the record
                            record_labels(end+preictal_start : end) = 1;
                            save([dataDir '\' char(case_iter) '\' char(records(rec-1))],'record_labels','-append');
                        end
                    end
                %else
                    %if the record doesn't contain seizures, save the zeros
                    %vector --> Doesn't save the lables !!
                    %save([dataDir '\' char(case_iter) '\' char(records(rec))],'record_labels','-append');
                end
            end
        end

     end
end