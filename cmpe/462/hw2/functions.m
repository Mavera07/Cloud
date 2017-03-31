
k=0;mydata=[];
function [meanvec covarvec] = EM(k,mydata)
  N = size(mydata)(1);
  # sizevec
  # meanvec
  # varvec
  k = 3;
  sizevec = [0.33 0.33 0.33];
  meanvec = [];
  meanvec(:,:,1) =[-6 -3];
  meanvec(:,:,2) =[0 3.5];
  meanvec(:,:,3) =[6 8];
  covarvec = [];
  covarvec(:,:,1) = covarianceEstimate(mydata,meanvec(:,:,1)); 
  covarvec(:,:,2) = covarianceEstimate(mydata,meanvec(:,:,2)); 
  covarvec(:,:,3) = covarianceEstimate(mydata,meanvec(:,:,3)); 

  for EM_turn = 1:20
    # E-step

    ric_mat = zeros(N,k);
    for i = 1:N
      for c = 1:k 
          ric_mat(i,c) = sizevec(c)*mgLikelihood(mydata(i,1:2),meanvec(:,:,c),covarvec(:,:,c));
      end   
    end

    ric_mat_all = sum(ric_mat')';
    ric_mat_norm = ric_mat ./ ric_mat_all ;

    # M-step
    
    for c = 1:k
    
      mc = sum(ric_mat_norm(:,c));
      sizevec(c)= mc/sum(sum(ric_mat_norm));
      meanvec(:,:,c) = zeros(1,2);
      for i = 1:N
        meanvec(:,:,c) += (mydata(i,1:2) * ric_mat_norm(i,c) )/mc;
      end
      varvec(:,:,c) = zeros(2,2);
      for i = 1:N
        temp = mydata(i,1:2)-meanvec(:,:,c);
        varvec(:,:,c) += (ric_mat_norm(i,c)*(temp')*temp)/mc;
      end
    end
  end
  
end


xi=[]; mvec=[]; covar=[];
function result = mgLikelihood(xi,mvec,covar)


  d = size(xi)(2);
  temp1 = 1/( sqrt((2*pi)^d) );
  temp2 = 1/sqrt(det(covar));
  temp3 = xi-mvec;
   
  temp4 = (-1/2)*temp3*inv(covar)*(temp3');
  temp5 = exp(temp4);
  
  result = temp1*temp2*temp5;
end


function result = covarianceEstimate(mydata,mvec)
  N = size(mydata)(1);
  temp1 = mydata(:,1:2) - mvec ;
  result = (1/N)*(temp1')*temp1;
end

# gaussian -- upwards
# --------------------------------------------------
# knn -- downwards

mydata=[]; mypoint=[];
function result = distListOfPointsToPoint(mydata, mypoint)
  N = size(mydata)(1);
  result = zeros(N,1);
  for i = 1:N
    temp1 = mypoint(1)-mydata(i,1);
    temp2 = mypoint(2)-mydata(i,2);
    result(i) = sqrt(temp1^2+temp2^2);
  end
end


k=0; mydata=[]; mypoint=[]; cList=[];
function result = knnVoteResult(cList,k,mydata,mypoint)
 
  distances= [];
  for ci = cList
    distList_ci = distListOfPointsToPoint(mydata(:,:,ci),mypoint);
    distList_ci = sort(distList_ci);
    distList_ci = distList_ci(1:k);
    distList_ci = [distList_ci ones(k,1)*(ci-1)];
    distances = [distances ;distList_ci];
  end
  
  distances = sortrows(distances);
  distances = distances(1:k,:);
  result = mode(distances(:,2));
  
end

