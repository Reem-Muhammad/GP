horizon = 23*60; %seconds
dataDir = 'G:\MIT_MAT';   %path to the directory where the data is stored
storeDir = 'G:\MIT_MAT_Processed';

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
            
            clear_data = nanremove(data);
            preictalSignal = zeros(size(clear_data)); %to store class 1 (preictal + ictal) of a record
            inerictalSignal = zeros(size(clear_data)); %to store class 2 (interictal) of a record
           
            %loop through all the occurences of seizure
            for event = 1:length(header.annotation.starttime)
                preictalSignal_temp = zeros(size(clear_data));
                preictalStart = header.annotation.starttime(event) - horizon;
                
                if(preictalStart >= 0) %preictal starts in the same record
                    preictalSignal_temp(preictalStart:header.annotation.endtime(event)*256, : ) = clear_data(preictalStart:header.annotation.endtime(event)*256, : );
                    preictalSignal = preictalSignal + preictalSignal_temp;
                    
                else
                    if(rec ~=1 )
                       
                        preictalSignal_temp(1:header.annotation.endtime(event)*256, : )=clear_data(1:header.annotation.endtime(event)*256, :);
                        preictalSignal = preictalSignal + preictalSignal_temp;
                        save([storeDir '\' char(case_iter) '\' char(records(rec))],'preictalSignal','-append')
                        
                        %load the previous record
                        load([dataDir '\' char(case_iter) '\' char(records(rec-1))]);
                        clear_data = nanremove(data);
                        preictalSignal_temp = zeros(size(clear_data)); %
                        preictalSignal_temp(end+preictalStart*256:end,:)=clear_data(end+preictalStart*256:end,:);
                        preictalSignal = preictalSignal + preictalSignal_temp;
                        save([storeDir '\' char(case_iter) '\' char(records(rec-1))],'preictalSignal','-append')
                        
                         %Update the surrogate channel, since the preictal
                         %and interictal signals have changed
                        [W, lambda, A] = csp(preictalSignal', interictalSignal');
                        surrogateSpace = W' * clear_data';
                        surrogateChannel = surrogateSpace(find(lambda == max(lambda),1), : );
                        save([storeDir '\' char(case_iter) '\' char(records(rec))],'surrogateChannel','-append');
                        
                        %load the current record again to preceed with the
                        %other events (otherwise, this previous record will be processed instead)
                        load([dataDir '\' char(case_iter) '\' char(records(rec))])
                        clear_data = nanremove(data);
                        
                    else
                        preictalSignal_temp = zeros(size(clear_data));
                        preictalSignal_temp(1:header.annotation.endtime(event)*256, : )=clear_data(1:header.annotation.endtime(event)*256, :);
                        preictalSignal = preictalSignal + preictalSignal_temp;
                        interictalSignal = clear_data - preictalSignal;
                        save([storeDir '\' char(case_iter) '\' char(records(rec))],'preictalSignal','-append');
                        save([storeDir '\' char(case_iter) '\' char(records(rec))],'interictalSignal','-append');
                    end
                end
               
            end
            save([storeDir '\' char(case_iter) '\' char(records(rec))],'interictalSignal','-append');
            
            %Find the surrogate channel using CSP
            [W, lambda, A] = csp(preictalSignal', interictalSignal');
            surrogateSpace = W' * clear_data';
            surrogateChannel = surrogateSpace(find(lambda == max(lambda),1), : );
            save([storeDir '\' char(case_iter) '\' char(records(rec))],'surrogateChannel','-append');
        end
        
     end
end
