#{
# class 0 // (-7.5 : 9)  // (-5 : 10)
# k = 1 // 0.75 2.5
# class 1 // (-11 : 4)  // ( -8 : 5)
# k = 1 // -3.5 -1.5
# class 2 // (-14 : 5)  // ( -13 : 4)
# k = 1 // -4.5 -4.5

# class 0 // (-7.5 : 9)  // (-5 : 10)
# k = 1 // 0.75 2.5
# class 1 // (-11 : 4)  // ( -8 : 5)
# k = 1 // -3.5 -1.5
# class 2 // (-14 : 5)  // ( -13 : 4)
# k = 1 // -4.5 -4.5

 
#{
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

clusterVotes;
#}


# In gaussian, likelihood = normpdf function

# Following for loop
# iterates for each rows
# for 6000x3 matrix
# for xi = mydata'
# end

mat = [1:10;11:20];  mat2 = [11:20]';
mean(mat);

mat3 = [5:8 ; 9:12];
mat4 = [1:4];

mat3 ./ mat4;

mat';
mat' - [1,2];

mat2/2 ;

mat5 = zeros(5,3);
mat5(:,1) = [1:5];
mat5(:,2) = [1:5];
mat5(:,3) = [1:5];

mat5 - [1 2 3];

size(mat4);

# IMPORTANT
#mat2([1 2])

#figure;
temp3 = sort(class2);
temp4 = sort([1 2 1]);
temp5 = sort([1 2 1]);
#plot(temp3(:,1),temp3(:,2),temp4(:,1),temp4(:,2),temp5(:,1),temp5(:,2));

#{
cList = [1 2 3];
kList = [1 10 40];

for ci = cList
  ci
  N = size(trainingList(:,:,ci))(1);
  
  # SELECT BEST k WITH VALIDATION SET
  for ki = kList
  
    for vi = validationList(:,:,ci)'
    
      probList =[];
      for cj = cList
        dist = kthDist(ki,trainingList(:,:,cj),vi([1 2]));
        prob = ki/(2*N*dist);
        probList(end+1)=prob;
      end
        
  
    end
        
  end
  
  
  
end




# kthDist(40,class0_training,[class0_validation(1,1) class0_validation(1,2)])
# calculate error on validation set
# save the solution

#}

temp2 = [];
temp2(end+1) = 5;
temp2(end+1) = 3;
temp2;

#printf([num2str(ci) "-" num2str(ki) "Heeeeeey" num2str(errorCount)])  

temp2 = [2 3 2 2 2 2 2 4 4 4 4 4 4 4 4];
a =mode(temp2);


cList = [1 2 3];

tempList=[];
tempList(:,:,1) = [1 2 0; 2 3 0];
tempList(:,:,2) = [4 5 1; 5 6 1];
tempList(:,:,3) = [8 9 2; 9 100 2];
#estimation = knnVoteResult(cList,1,tempList,[9 9]);

temp1 = [ 5 3 15 59 1 15];
[M,I] = min(temp1);

cList = [1 2 3];
kList = [1 10 40];

kSize = size(kList)(2);
cSize = size(cList)(2);

find(kList==1);

size(cList);
pi;

exp(0);
exp(1);
exp(2);

mgLikelihood([1 2], [2 2], [1 0;0 5]);
#mvnpdf([1 2], [2 2], [1 0;0 5]);

size(class0_training);
size(class0_training)(1);


#{
# M-step
    mc_vec = mean(ric_mat_norm);
    sizevec = mc_vec/sum(mc_vec);
    for c = 1:k
    
      meanvec(:,:,c) = sum( mydata(:,1:2) .* ric_mat_norm(:,c) )./mc_vec(c);
      
      temp = mydata(:,1:2)-meanvec(:,:,c);
      varvec(:,:,c) = sum((temp*temp').*ric_mat_norm(:,c))./mc_vec;
    end
    
    #}
    
    
meanvec = [];
meanvec(:,:,1) =[0.35 1.5];
meanvec(:,:,2) =[1.05 3.5];
#{    
temp1 = [];
temp1(:,:,:,1,1)=meanvec;

meanvec(:,:,3) =[1.05 3.5];
temp1(:,:,:,2,1)=meanvec;

temp1(:,:,:,1,2)=meanvec

temp1(:,:,:,1,1);
#}
temp1= [];
temp1(end+1,:) = [1,2];
temp1(end+1,:) = [1,2];

[a b] = max([2 6 78 3 -2 6]);

6*2+[1:3];
sum(1:0);

kList = [1 2 3];
ci=3;
ki=3;
kj=3;
sum(kList)*(ci-1)+sum(1:ki-1)+kj;


kList = [1 2 3];
cj=3;
ki=3;
kj=3;
2*sum(kList)*(cj-1)+2*sum(1:ki-1)+2*(kj-1)+[1 2];


kList = [1 2 3];
cj=2;
ki=1;
kj=1;
sum(kList)*(cj-1)+sum(1:ki-1)+kj;

k = 3;
   
sizevec = zeros(1,k);
for temp = 1:k
  sizevec(1,temp) = 1/k;
end
sizevec;

temp1 = [1 2; 3 4 ; 5 7];
temp1 = temp1.^2;
realsqrt(temp1);

temp1 - [1 2];

size(class0_training(:,[1]))
[a b] = kmeans(class0_training(:,[1 2]),3);
b;
b(1,:);
b(2,:);
b(3,:);

mydata = class0_training;
N = size(mydata)(1);
  
sizevec = zeros(1,k);
for temp = 1:k
  sizevec(1,temp) = 1/k;
end


#{
[ignore1 tempmeans] = kmeans(class0_training(:,[1 2]),k);

k=3;
meanvec = [];
[ignore1 tempmeans] = kmeans(mydata(:,[1 2]),k);
covarvec = [];
sizevec = zeros(1,k);
for tempIndex = 1:k
  meanvec(:,:,tempIndex) = tempmeans(tempIndex,:);
  covarvec(:,:,tempIndex) = covarianceEstimate(mydata,meanvec(:,:,tempIndex));
  sizevec(1,tempIndex) = 1/k;
end

idx = cluster(gmdistribution(tempmeans,covarvec,sizevec),class0_training(:,[1 2]))
#}


aaa = [102 2 3 4];
conf = 10;
confValues = num2str(base2dec(dec2base(conf, 3),10),'%03d');

aaa(1);

#}

figure;
hold;

plot(class0_training(:,1),class0_training(:,2),"*b");
plot(class1_training(:,1),class1_training(:,2),"*r")
plot(class2_training(:,1),class2_training(:,2),"*g")

bestModel(1,1) = 3;
bestModel(1,2) = 3;
bestModel(1,3) = 3;

for cj = cList  

  ki = bestModel(1,cj);
  for kj = 1:ki
    tempMean1 = clusterMeans(sum(kList)*(cj-1)+sum(1:ki-1)+kj,:);
    plot(tempMean1(1,1),tempMean1(1,2),"k*","markersize",30)
  end
end

