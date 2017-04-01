cList = [1 2 3];
cN = size(cList)(2);
kList = [1 2 3];
kN = size(kList)(2);

#{
# OBTAIN MEANS, COVARIANCES AND SIZES
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

 
# SELECT BEST k WITH VALIDATION SET - METHOD 1 
  
clusterValidationErrors = zeros(cN,kN);

for ci = cList  
  for ki = kList
    for vi = validationList(:,:,ci)'
    
      likelihoods = zeros(cN,1);
      for cj = cList
      
        if ci == cj      
          for kj = 1:ki
            likelihoods(cj,1) += clusterSizes(sum(kList)*(cj-1)+sum(1:ki-1)+kj)*mgLikelihood(vi'([1 2]),clusterMeans(sum(kList)*(cj-1)+sum(1:ki-1)+kj,:),clusterCovars(2*sum(kList)*(cj-1)+2*sum(1:ki-1)+2*(kj-1)+[1 2],:) );
          end
      
      
        elseif
          likelihoods(cj,1) = mgLikelihood(vi'([1 2]),clusterMeans(sum(kList)*(cj-1)+1,:),clusterCovars(2*sum(kList)*(cj-1)+[1 2],:));
        end
        
      end
     
     
      [ignore1 estimation] = max(likelihoods);
      
      if estimation != ci 
        clusterValidationErrors(ci,ki) += 1;
      end
    end
  end
end

clusterValidationErrors


# SELECT BEST k WITH VALIDATION SET - METHOD 2

clusterVotes = zeros(cN,kN);

for ci = cList  
  for vi = validationList(:,:,ci)'
    likelihoods = zeros(kN,1);
    for ki = kList  

      for kj = 1:ki
        likelihoods(ki,1) += clusterSizes(sum(kList)*(cj-1)+sum(1:ki-1)+kj)*mgLikelihood(vi'([1 2]),clusterMeans(sum(kList)*(cj-1)+sum(1:ki-1)+kj,:),clusterCovars(2*sum(kList)*(cj-1)+2*sum(1:ki-1)+2*(kj-1)+[1 2],:) );
      end
           
    end
    [ignore1 estimation] = max(likelihoods);
    clusterVotes(ci,estimation) += 1;
      
  end
end

clusterVotes
#}

# MOCK RESULT LIST
bestModel = zeros(1,cN);
bestModel(1,1) = 1;
bestModel(1,2) = 2;
bestModel(1,3) = 1;

# CALCULATE ERROR WITH TEST SET

clusterTestErrors = zeros(cN,1);

for ci = cList  
  for vi = validationList(:,:,ci)'
  
    likelihoods = zeros(cN,1);
    for cj = cList
    
      ki = bestModel(1,cj);
      for kj = 1:ki
        likelihoods(cj,1) += clusterSizes(sum(kList)*(cj-1)+sum(1:ki-1)+kj)*mgLikelihood(vi'([1 2]),clusterMeans(sum(kList)*(cj-1)+sum(1:ki-1)+kj,:),clusterCovars(2*sum(kList)*(cj-1)+2*sum(1:ki-1)+2*(kj-1)+[1 2],:) );
      end
    
      
    end
   
   
    [ignore1 estimation] = max(likelihoods);
    
    if estimation != ci 
      clusterTestErrors(ci,1) += 1;
    end
  end
end

clusterTestErrors
