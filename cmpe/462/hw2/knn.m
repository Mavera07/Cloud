k=0; mydata=[];
function [] = kNN(k,mydata,mypoint)
  N = size(mydata)(1);
  distances = distList2d(N,mydata,mypoint);
  distances = sort(distances);
  
  disp(distances(1:40))
  
  # calculate error on validation set
  # save the solution
end

kNN(1,class0_training,[class0_validation(1,1) class0_validation(1,2)])