
k=0;mydata=[];
function [meanvec covarvec sizevec] = EM(k,mydata)
  
  N = size(mydata)(1);
  
  meanvec = [];
  [ignore1 tempmeans] = kmeans(mydata(:,[1 2]),k);
  covarvec = [];
  sizevec = zeros(1,k);
  for tempIndex = 1:k
    meanvec(:,:,tempIndex) = tempmeans(tempIndex,:);
    covarvec(:,:,tempIndex) = covarianceEstimate(mydata,meanvec(:,:,tempIndex));
    sizevec(1,tempIndex) = 1/k;
  end
  
  
  for EM_turn = 1:100
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

# --------------------------------------------------
# knn -- downwards

mydata=[]; mypoint=[];
function result = distListOfPointsToPoint(mydata, mypoint)
  result = (mydata(:,[1:2]) - mypoint').^2;
  result = realsqrt(abs(result(:,1)-result(:,2)));
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

