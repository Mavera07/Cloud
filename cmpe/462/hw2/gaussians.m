cList = [1 2 3];
cN = size(cList)(2);
kList = [1 2 3];
kN = size(kList)(2);

# OBTAIN MEANS AND COVARIANCES
clusterMeans = [];
clusterCovars =[];
for ci = cList
  
  for ki = kList
    [means covars] = EM(ki,trainingList(:,:,ci));
    
    for kj = 1:ki
      clusterMeans(end+1,:) = means(:,:,kj);
      clusterCovars([end+1 end+2],:) = covars(:,:,kj);
    end
  end
  
end
 
# SELECT BEST k WITH VALIDATION SET
  
clusterErrors = zeros(cN,kN);

for ci = cList  
  for ki = kList
    for vi = validationList(:,:,ci)'
      likelihoods = zeros(cN,1);
      for cj = cList
        if ci == cj
          # normalized likelihoods of k gaussians
          for kj = 1:ki
            likelihoods(cj,1) += mgLikelihood(vi,clusterMeans(sum(kList)*(cj-1)+sum(1:ki-1)+kj,:),clusterCovars(2*sum(kList)*(cj-1)+2*sum(1:ki-1)+2*(kj-1)+[1 2],:));
          end
          
        elseif
          likelihoods(cj,1) = mgLikelihood(vi,clusterMeans(sum(kList)*(cj-1)+1,:),clusterCovars(2*sum(kList)*(cj-1)+[1 2],:));
        end
      end 
      [ignore1 estimation] = max(likelihoods);
      
      if estimation != ci 
        clusterErrors(ci,ki) += 1;
      end
    end
  end
end