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
mvnpdf([1 2], [2 2], [1 0;0 5]);