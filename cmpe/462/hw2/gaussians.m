cList = [1 2 3];
kList = [1 2 3];

# OBTAIN MEANS AND COVARIANCES
for ci = cList
  
  kthClusterMeans =[];
  kthClusterCovars =[];
  
  # OBTAIN MEANS AND COVARIANCES FOR GIVEN k CLUSTERS
  for ki = kList
    [means covars] = EM(ki,trainingList(:,:,ci));
    
    kthClusterMeans(:,:,:,ki,ci) = means;
    kthClusterCovars(:,:,:,ki,ci) = covars;
  end
  
end
 
# SELECT BEST k WITH VALIDATION SET
  
kthClusterErrors = [];

for ci = cList  
  for ki = kList
    for vi = validationList(:,:,ci)'
      for kj = kList
        
      end
    end
  end
end