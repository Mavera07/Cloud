ciList = [1 2 3];
kList = [1 10 40];

for ci = ciList
  ci
  
  N = size(trainingList(:,:,ci))(1);
  
  for ki = kList
  
    
    probList = [];
  
    for vi = validationList(:,:,1)'
    
      dist = kthDist(ki,trainingList(:,:,ci),vi([1 2]));
      prob = ki/(2*N*dist);
      
      probList(end+1)=prob;
    end
    
    mean(probList)*1000
    
  end
end




# kthDist(40,class0_training,[class0_validation(1,1) class0_validation(1,2)])
# calculate error on validation set
# save the solution