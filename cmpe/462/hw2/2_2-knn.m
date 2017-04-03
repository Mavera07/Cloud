# Given class and k value paramaters are stored in the following vectors
cList = [1 2 3];
kList = [1 10 40];

kSize = size(kList)(2);
cSize = size(cList)(2);

# SELECT BEST k WITH VALIDATION SET
# 
# For each k value,
# it calculates the estimations of validation points of all classes
# it counts the wrong estimations and interpret this as error
# 
# At the end, each k value results an error value
# The one with the smallest error is the best k solution
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
#
# For each k value,
# it calculates the estimations of test points of all classes
# it records each estimation and which class the test point is coming from
# With this operation, size(class)-by-size(class) matrix is obtained
#
# For each k value, size(class)-by-size(class) matrix is obtained
#
# In the end, 3 dimensional array with
# size(kList-by-size(class)-by-size(class) dimensions is obtained
#
# With this 3-D array confusion matrices are obtained
#
# Then from using this 3-D array, prediction errors for each k option
# are calculated 
classificationList = zeros(kSize,cSize,cSize);
for ki = kList
    
  errorCountForK = 0;
  for ci = cList
    
    for vi = testList(:,:,ci)'
    
      estimation = knnVoteResult(cList,ki,trainingList,vi([1 2]));  
      classificationList(estimation+1,ci,find(kList==ki)) +=1;
      
    end 
  end
end

classificationError = zeros(kSize,cSize);
for ki = 1:kSize
  for ci = 1:cSize
    # Classification error with knn with kList(ki) on the ci_th class
    accuracy = classificationList(ci,ci,ki)/sum(classificationList(:,ci,ki));
    error = 1 - accuracy;
    classificationError(ki,ci) = error;
    
  end
end

best_k

classificationError

classificationList