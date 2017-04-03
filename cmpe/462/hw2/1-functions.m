# statistics package is needed
pkg load statistics;

# Functions used in gaussian -- downwards


# Expectation-Maximization function
#
# It takes two parameters k, mydata
# k : Number of clusters that will be fitted on the data
# mydata : The dataset where the gaussians will be fit on
#
# It returns three variables meanvec, covarvec, sizevec
# They contain mean, covariance, size values for each cluster
#
# It initialize the meanvec, covarvec, sizevec for EM iterations
# Size value for each cluster is calculated as 1/k
# Mean values are calculated with built in kmeans function
# Covariance values are calculated by the covariance estimator
# with the dataset and mean values
#
# The E-step is the expectation step.
# It calculates the responsibility of each point for each cluster
#
# The M-step is the maximization step.
# With the responsibility matrix calculated in E-step;
# mean, covariance and size values are updated for better gaussian fits
#
# EM algorithm runs for 20 iterations which is 
# the limit for obtaining the convergence
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
        meanvec(:,:,c) += (mydata(i,1:2) * ric_mat_norm(i,c) );
      end
      meanvec(:,:,c) /= mc;
      
      covarvec(:,:,c) = zeros(2,2);
      for i = 1:N
        temp = mydata(i,1:2)-meanvec(:,:,c);
        covarvec(:,:,c) += (ric_mat_norm(i,c)*(temp')*temp);
      end
      covarvec(:,:,c) /= mc;
    end
  end
  
end

# Multivariate gaussian likelihood calculator function
# It takes three arguments xi, mvec, covar
# It calculates the likelihood of xi being in the gaussian with mvec and covar
#
# xi : A multidimensional point (1-by-2)
# mvec : Multidimensional mean vector of the gaussian (1-by-2)
# covar : Covariance matrix of the gaussian (2-by-2)
#
# It applies the formula of multivariate gaussian likelihood
#
# It returns the likelihood/probability value 
xi=[]; mvec=[]; covar=[];
function result = mgLikelihood(xi,mvec,covar)

  d = size(xi)(2);
  temp1 = (2*pi)^(-d/2); 
  temp3 = xi-mvec;
  #{
  temp2 = 1/sqrt(det(covar));
  
     
  temp4 = (-1/2)*(temp3)*inv(covar)*(temp3');
  temp5 = exp(temp4);
  
  result = temp1*temp2*temp5;
  #}
  result = temp1 * exp ((-1/2)*sumsq ((xi-mvec)/chol(covar), 2)) / prod (diag (chol(covar)));
end

# Covariance estimator function
# It takes a dataset and multidimensional mean vector as arguments;mydata, myvec
# mydata : A dataset of points which is N-by-2 dimensional matrix
# mvec : A 1-by-2 vector that holds mean values for dimension 1 and 2
#
# It applies the estimator formula
# It returns the covariance matrix for the given arguments
function result = covarianceEstimate(mydata,mvec)
  N = size(mydata)(1);
  temp1 = mydata(:,1:2) - mvec ;
  result = (1/N)*(temp1')*temp1;
end


# Functions used in gaussian -- upwards
# --------------------------------------------------

# --------------------------------------------------
# Functions used in knn -- downwards



# Distance calculator function
# It takes 2 arguments mydata and mypoint
# mydata : A dataset of points which is N-by-2 dimensional matrix
# mypoint : A two dimensional point
#
# For each point in mydata, the function calculates distance from it to mypoint
#
# It returns N-by-1 dimensional distance vector
mydata=[]; mypoint=[];
function result = distListOfPointsToPoint(mydata, mypoint)
  result = (mydata(:,[1:2]) - mypoint').^2;
  result = realsqrt(abs(result(:,1)-result(:,2)));
end


# k-Nearest Neighbour classification function
# It takes four arguments cList,k,mydata,mypoint
#
# cList : It is the vector for the indices of classes - it is [1,2,3]
# k : It the given parameter indicating how many neighbours should be checked
# mydata : It is a 3 dimensional array with N-by-2-by-3 dimensions
#          it contains the training sets of all classes
# mypoint : A two dimensional point that will be classified
#
# For each point in mydata, function calculates the distance from it to mypoint
# The function obtains closest k points
# It counts the classes of these k points
# 
# The function returns the class number that have the highest count  
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


# Functions used in knn -- upwards