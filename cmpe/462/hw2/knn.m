cList = [1 2 3];
kList = [1 10 40];

#{
# SELECT BEST k WITH VALIDATION SET
errorList = [];
for ki = kList
  ki;
    
  errorCountForK = 0;
  for ci = cList
    ci;
    
    for vi = validationList(:,:,ci)'
    
      estimation = knnVoteResult(cList,ki,trainingList,vi([1 2]));  
      if estimation != (ci-1)
        errorCountForK +=1;
      end
  
    end 
  end
  
  errorList(end+1) = errorCountForK;
end

[MinK,IndexK] = min(errorList);
best_k = kList(IndexK);
#}

# CALCULATE ERROR WITH TEST SET
kSize = size(kList)(2);
cSize = size(cList)(2);
classificationList = zeros(kSize,cSize,cSize);
for ki = kList
    
  errorCountForK = 0;
  for ci = cList
    
    for vi = validationList(:,:,ci)'
    
      estimation = knnVoteResult(cList,ki,trainingList,vi([1 2]));  
      classificationList(estimation+1,ci,find(kList==ki)) +=1;
      
    end 
  end
end

classificationList