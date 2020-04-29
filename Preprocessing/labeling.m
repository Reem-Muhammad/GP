function []= labeling(header, data, records, recordNumber, case_iter, dataDir)

%{
This function creats a labels vector for each record, and appends it to the corresponding
mat file.
each loaded record should have a header file that contains the annotations

header -> contains the events start and end time
data -> data to be labelled
records -> cell array containing the names of the records in order
recordNumber -> record number that is currently being labeled
case_iter -> case name
dataDir -> path to the directory where all cases are stored
%}

Fs = 256;   %sampling frequency of the dataset
windowSize = 1024;  %window size in number of samples
horizon = floor((30*60*Fs)/windowSize); %horizon in number of windows
record_labels = zeros( floor(length(data)/windowSize), 1); %initialize the labels vector
save([dataDir '\' char(case_iter) '\' char(records(recordNumber))],'record_labels','-append');

%loop through all seizure events in the record (some records contain more than one event)
for annot_iter = [1: length(header.annotation.starttime)]

    if ( isempty(header.annotation.starttime)== 0 ) %if the record contains seizures
        preictal_start = floor( (header.annotation.starttime(annot_iter)*Fs)/windowSize ) - horizon;

        if ( preictal_start >= 0 )  %if the preictal event starts in the same record
            %assign the label '1' to preictal epochs
            record_labels(preictal_start:preictal_start+horizon) = 1;
            %append the variable to the mat file containing the record
            save([dataDir '\' char(case_iter) '\' char(records(recordNumber))],'record_labels','-append');

        else
            %if the preictal event starts in the previous
            %record

            %label the epochs from the beginning of the current record to the beginning of the seizure as preictal 
            record_labels(1: (preictal_start+horizon) )=1;
            save([dataDir '\' char(case_iter) '\' char(records(recordNumber))],'record_labels','-append');

            if(recordNumber ~= 1)
                %if the current record is not the first record

                %load the previous record
                load([dataDir '\' char(case_iter) '\' char(records(recordNumber-1))]);
                %label the epochs from the beginning of the
                %preictal event until the end of the record
                record_labels(end+preictal_start : end) = 1;
                save([dataDir '\' char(case_iter) '\' char(records(recordNumber-1))],'record_labels','-append');
            end
        end
    end
    load([dataDir '\' char(case_iter) '\' char(records(recordNumber))]);
end

end