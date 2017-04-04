# Given class and k value paramaters are stored in the following vectors
cList = [1 2 3];
cN = size(cList)(2);
kList = [1 2 3];
kN = size(kList)(2);


# OBTAIN MEANS, COVARIANCES AND SIZES BY USING EM ALGORITHM
# TRAINING SET IS USED IN THIS PART
# 
# For each class (1,2,3), 
# all k opitions(1,2 and 3 gaussians) are fit on the dataset.
# To do this expectation-maximization function is used.
# In the end, there are 9 cases of fits.
# Each fit has mean, covariance and size vectors. 
# All of them are indexed and saved.
clusterMeans = [];
clusterCovars =[];
clusterSizes = [];
for ci = cList
  
  for ki = kList
    [means covars sizes] = EM(ki,trainingList(:,:,ci));
    
    for kj = 1:ki
      clusterMeans(end+1,:) = means(:,:,kj);
      clusterCovars([end+1 end+2],:) = covars(:,:,kj);
      clusterSizes(end+1) = sizes(ki);
    end
  end
  
end

 
# SELECT BEST k WITH VALIDATION SET
    
  # CALCULATE ERRORS OF ALL CLUSTER COMBINATIONS
  # Each cluster might have 3 different fit options; 1,2,3 gaussians.
  # Since there are 3 classes, there are 3^3=27 cases.
  # These cases are encoded with numbers 1 to 27.
  #
  # In each case,validation sets of all classes are used and errors are counted.
  # Therefore, for each case, error count is obtained over 1500 points.
  # (Each class has a validation set with 500 points.)
  # For 27 cases, error value is saved in a vector.
  clusterValidationErrors = zeros(kN,kN,kN);

  for conf = 1:(kN^cN)
    confValues = num2str(base2dec(dec2base(conf-1, 3),10),'%03d');
    modelConf = zeros(1,cN);
    for ci = cList
      modelConf(1,ci) = str2num(confValues(ci))+1; 
    end
    
    for ci = cList  
      for vi = validationList(:,:,ci)'
      
        likelihoods = zeros(cN,1);
        for cj = cList
        
          ki = modelConf(1,cj);
          for kj = 1:ki
            likelihoods(cj,1) += clusterSizes(sum(kList)*(cj-1)+sum(1:ki-1)+kj)*mgLikelihood(vi'([1 2]),clusterMeans(sum(kList)*(cj-1)+sum(1:ki-1)+kj,:),clusterCovars(2*sum(kList)*(cj-1)+2*sum(1:ki-1)+2*(kj-1)+[1 2],:) );
          end
          
        end
       
        [ignore1 estimation] = max(likelihoods);
        if estimation != ci 
          clusterValidationErrors(modelConf(1,1),modelConf(1,2),modelConf(1,3)) += 1;
        end
      end
    end
  end

  clusterValidationErrors;
    
  # GET THE BEST MODEL BASED ON ERRORS OF ALL CLUSTER COMBINATIONS
  # We have the error counts of 27 cases. (For 3 class, there are 3 fit options)
  # Simply, the one that has the lowest error is the best model.
  # The best model configuration is saved in the bestModel vector.
  # An example of bestModel vector is [2 3 3] which means that class 0 should
  # have 2 gaussian fits, class 1 and class 2 should have 3 gaussian fits. 
  clusterValidationSumErrors = [];
  for conf = 1:(kN^cN)
    confValues = num2str(base2dec(dec2base(conf-1, 3),10),'%03d');
    modelConf = zeros(1,cN);
    for ci = cList
      modelConf(1,ci) = str2num(confValues(ci))+1; 
    end
    
    clusterValidationSumErrors(end+1) = clusterValidationErrors(modelConf(1,1),modelConf(1,2),modelConf(1,3));
  end
  [bestModelError bestModelConf] = min(clusterValidationSumErrors);

  confValues = num2str(base2dec(dec2base(bestModelConf-1, 3),10),'%03d');
  bestModel = zeros(1,cN);
  for ci = cList
    bestModel(1,ci) = str2num(confValues(ci))+1; 
  end

  


# CALCULATE ERROR WITH TEST SET
# The best model is obtained in the previous part.
# In this part error is calculated for this model.
# For test set of each class, the model is tested.
# For each point in test set, the estimated class is saved.
# There is one test set for each classes; class 0, class 1, class 2.
# The estimated class could be class 0, class 1, class 2.
# Therefore 3x3 matrix is obtained such that there is a row for each test set
# and there is a column for each class prediction.
# For example, the position (1,3) have the number of points that are coming
# from test set of class 0 but classified as coming from class 2.
#
# In the end of this script, this matrix is used for calculating 
# the prediction error and printing the confusion matrix.  
clusterTestErrors = zeros(cN,cN);

for ci = cList  
  for vi = testList(:,:,ci)'
  
    likelihoods = zeros(cN,1);
    for cj = cList
    
      ki = bestModel(1,cj);
      for kj = 1:ki
        likelihoods(cj,1) += clusterSizes(sum(kList)*(cj-1)+sum(1:ki-1)+kj)*mgLikelihood(vi'([1 2]),clusterMeans(sum(kList)*(cj-1)+sum(1:ki-1)+kj,:),clusterCovars(2*sum(kList)*(cj-1)+2*sum(1:ki-1)+2*(kj-1)+[1 2],:) );
      end
      
    end
   
    [ignore1 estimation] = max(likelihoods);
    
    clusterTestErrors(ci,estimation) += 1;
  end
end


printf("\tBest model\n");
printf("----------------------------------------\n");
printf("Number of gaussians for class 0 =>  %d\n",bestModel(1))
printf("Number of gaussians for class 1 =>  %d\n",bestModel(2))
printf("Number of gaussians for class 2 =>  %d\n",bestModel(3))
printf("----------------------------------------\n");
printf("\n\n");

printf("\tBest model prediction error\n");
printf("----------------------------------------\n");
printf("%d %%  \n",(sum(sum(clusterTestErrors))-sum(diag(clusterTestErrors)))/15);
printf("----------------------------------------\n");
printf("\n\n");

printf("\tBest model confusion matrix\n");
printf("----------------------------------------\n");
printf("\tPredicted\n"); printf("\tclass no -->  0    1    2\n\n");
printf("Class 0 test set :   %d   %d   %d\n",clusterTestErrors(1,1),clusterTestErrors(1,2),clusterTestErrors(1,3));
printf("Class 1 test set :   %d   %d   %d\n",clusterTestErrors(2,1),clusterTestErrors(2,2),clusterTestErrors(2,3));
printf("Class 2 test set :   %d   %d   %d\n",clusterTestErrors(3,1),clusterTestErrors(3,2),clusterTestErrors(3,3));
printf("----------------------------------------\n");
printf("\n\n");

# If you want to visualize gaussian result of the best model
# you can uncomment following code.

#{
figure;
hold;

plot(class0_training(:,1),class0_training(:,2),".b","markersize",4);
plot(class1_training(:,1),class1_training(:,2),".r","markersize",4)
plot(class2_training(:,1),class2_training(:,2),".g","markersize",4)


for cj = cList  

  ki = bestModel(1,cj);
  for kj = 1:ki
    tempMean1 = clusterMeans(sum(kList)*(cj-1)+sum(1:ki-1)+kj,:);
    plot(tempMean1(1,1),tempMean1(1,2),"k.","markersize",20)
  end
end

#} 