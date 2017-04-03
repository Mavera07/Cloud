cList = [1 2 3];
cN = size(cList)(2);
kList = [1 2 3];
kN = size(kList)(2);


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
#}
 

 
# SELECT BEST k WITH VALIDATION SET
  
  
  # CALCULATE ERRORS OF ALL CLUSTER COMBINATIONS
  
  clusterValidationErrors = zeros(cN,kN,kN,kN);

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
          clusterValidationErrors(ci,modelConf(1,1),modelConf(1,2),modelConf(1,3)) += 1;
        end
      end
    end
  end

  clusterValidationErrors
  #}
  
  
  # GET THE BEST MODEL BASED ON ERRORS OF ALL CLUSTER COMBINATIONS
  
  clusterValidationSumErrors = [];
  for conf = 1:(kN^cN)
    confValues = num2str(base2dec(dec2base(conf-1, 3),10),'%03d');
    modelConf = zeros(1,cN);
    for ci = cList
      modelConf(1,ci) = str2num(confValues(ci))+1; 
    end
    
    clusterValidationSumErrors(end+1) = sum(clusterValidationErrors(:,modelConf(1,1),modelConf(1,2),modelConf(1,3)));
  end
  [bestModelError bestModelConf] = min(clusterValidationSumErrors);

  confValues = num2str(base2dec(dec2base(bestModelConf-1, 3),10),'%03d');
  bestModel = zeros(1,cN);
  for ci = cList
    bestModel(1,ci) = str2num(confValues(ci))+1; 
  end

  bestModel
  #}


# CALCULATE ERROR WITH TEST SET

clusterTestErrors = zeros(cN,1);

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
    
    if estimation != ci 
      clusterTestErrors(ci,1) += 1;
    end
  end
end

clusterTestErrors
#}