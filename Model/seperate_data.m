function[trainingdata,testingdata,traininglabels,testinglabels]= seperate_data(data,labels,train_per)

truein   =[data(labels==1,:), labels(labels==1)];
falsein  =[data(labels==0,:), labels(labels==0)];

true_len=length(truein);

split_vec=zeros(true_len,1);
split_vec(1:round(train_per*true_len))=ones(round(train_per*true_len),1);
split_vec=split_vec((randperm(true_len)));

trainingdata_withlabels =    truein( logical(split_vec),:);
testingdata_withlabels  =    truein(~logical(split_vec),:);

false_len=length(falsein);

split_vec=zeros(false_len,1);
split_vec(1:round(train_per*false_len))=ones(round(train_per*false_len),1);
split_vec=split_vec((randperm(false_len)));

trainingdata_withlabels =    [trainingdata_withlabels; falsein( logical(split_vec),:)];
testingdata_withlabels  =    [testingdata_withlabels; falsein(~logical(split_vec),:)];

trainingdata=trainingdata_withlabels(:,1:size(trainingdata_withlabels,2)-1);
testingdata=testingdata_withlabels(:,1:size(testingdata_withlabels,2)-1);
traininglabels=trainingdata_withlabels(:,size(trainingdata_withlabels,2));
testinglabels=testingdata_withlabels(:,size(testingdata_withlabels,2));

end