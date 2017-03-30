cList = [1 2 3];
kList = [1 10 40];


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


# CALCULATE ERROR WITH TEST SET
classificationList = zeros(); # UPDATE
for ki = kList
  ki;
    
  errorCountForK = 0;
  for ci = cList
    ci;
    
    for vi = validationList(:,:,ci)'
    
      estimation = knnVoteResult(cList,ki,trainingList,vi([1 2]));  
      for cj = cList
        if estimation != (cj-1)
          classificationList() +=1; # UPDATE
        end
      end
      
      
  
    end 
  end
  
end
