function [normalized]=normalize_feats(feat)
    normalized=[];
    for i=1:size(feat,2)
        max_val  =    max(feat(:,i));
        min_val  =    min(feat(:,i));
        mean_val =    mean(feat(:,i));
        normalized=[normalized, (feat(:,i)-mean_val)/(max_val-min_val)];
    end
end