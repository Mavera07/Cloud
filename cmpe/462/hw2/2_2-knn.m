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
      if estimation != ci
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
    
  for ci = cList
    
    for vi = testList(:,:,ci)'
    
      estimation = knnVoteResult(cList,ki,trainingList,vi([1 2]));  
      classificationList(estimation,ci,find(kList==ki)) +=1;
      
    end 
  end
end


printf("\tBest model\n");
printf("----------------------------------------\n");
printf("k Nearest Neighbour size = %d\n",best_k)
printf("----------------------------------------\n");
printf("\n\n");

printf("\tPrediction errors for\n");printf("\teach k option; 1,10,40\n");
printf("----------------------------------------\n");
printf("k Nearest Neighbour size = 1   -->  %d %%  \n",(sum(sum(classificationList(:,:,1)))-sum(diag(classificationList(:,:,1))))/15);
printf("k Nearest Neighbour size = 10  -->  %d %%  \n",(sum(sum(classificationList(:,:,2)))-sum(diag(classificationList(:,:,2))))/15);
printf("k Nearest Neighbour size = 40  -->  %d %%  \n",(sum(sum(classificationList(:,:,3)))-sum(diag(classificationList(:,:,3))))/15);
printf("----------------------------------------\n");
printf("\n\n");

printf("\tConfusion matrix for\n");printf("\teach k option; 1,10,40\n");
printf("----------------------------------------\n");
printf("k Nearest Neighbour size = 1\n\n");
printf("\tPredicted\n"); printf("\tclass no -->  0    1     2\n\n");
printf("Class 0 test set :   %d   %d   %d\n",classificationList(1,1,1),classificationList(2,1,1),classificationList(3,1,1));
printf("Class 1 test set :   %d   %d   %d\n",classificationList(1,2,1),classificationList(2,2,1),classificationList(3,2,1));
printf("Class 2 test set :   %d    %d   %d\n",classificationList(1,3,1),classificationList(2,3,1),classificationList(3,3,1));
printf("----------------------------------------\n");
printf("k Nearest Neighbour size = 10\n\n");
printf("\tPredicted\n"); printf("\tclass no -->  0    1     2\n\n");
printf("Class 0 test set :   %d   %d    %d\n",classificationList(1,1,2),classificationList(2,1,2),classificationList(3,1,2));
printf("Class 1 test set :   %d    %d   %d\n",classificationList(1,2,2),classificationList(2,2,2),classificationList(3,2,2));
printf("Class 2 test set :   %d    %d   %d\n",classificationList(1,3,2),classificationList(2,3,2),classificationList(3,3,2));
printf("----------------------------------------\n");
printf("k Nearest Neighbour size = 40\n\n");
printf("\tPredicted\n"); printf("\tclass no -->  0    1     2\n\n");
printf("Class 0 test set :   %d   %d   %d\n",classificationList(1,1,3),classificationList(2,1,3),classificationList(3,1,3));
printf("Class 1 test set :   %d    %d   %d\n",classificationList(1,2,3),classificationList(2,2,3),classificationList(3,2,3));
printf("Class 2 test set :   %d     %d   %d\n",classificationList(1,3,3),classificationList(2,3,3),classificationList(3,3,3));
printf("----------------------------------------\n");
printf("\n\n");
