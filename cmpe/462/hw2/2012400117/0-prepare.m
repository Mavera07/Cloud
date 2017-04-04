# Reading the input dataset and saving it into individual columns
[col1,col2,col3] = textread('points2d.dat','%f %f %d');

# Combining columns in a matrix containing all dataset
allData = zeros(6000,3);
allData(:,1) = col1;
allData(:,2) = col2;
allData(:,3) = col3;

# Extract classes from all dataset into different matrices
class0 = allData(find(col3==0),:);
class1 = allData(find(col3==1),:);
class2 = allData(find(col3==2),:);

# Divide class0 randomly into training, validation, test datasets
# Their sizes are 1000,500 and 500 respectively
temp1 = randperm(2000,1000);
class0_training = class0(temp1,:);

temp2 = setdiff([1:2000],temp1);
temp1 = class0(temp2,:);

temp2 = randperm(1000,500);
class0_validation = temp1(temp2,:);

temp3 = setdiff([1:1000],temp2);
class0_test = temp1(temp3,:);

# Divide class1 randomly into training, validation, test datasets
# Their sizes are 1000,500 and 500 respectively
temp1 = randperm(2000,1000);
class1_training = class1(temp1,:);

temp2 = setdiff([1:2000],temp1);
temp1 = class1(temp2,:);

temp2 = randperm(1000,500);
class1_validation = temp1(temp2,:);

temp3 = setdiff([1:1000],temp2);
class1_test = temp1(temp3,:);

# Divide class2 randomly into training, validation, test datasets
# Their sizes are 1000,500 and 500 respectively
temp1 = randperm(2000,1000);
class2_training = class2(temp1,:);

temp2 = setdiff([1:2000],temp1);
temp1 = class2(temp2,:);

temp2 = randperm(1000,500);
class2_validation = temp1(temp2,:);

temp3 = setdiff([1:1000],temp2);
class2_test = temp1(temp3,:);


# Combine training, validation and test datasets for all 3 classes
# Resulting variables are 3-dimensional arrays where 
# 3rd dimension indicates the class 

trainingList = [];
trainingList(:,:,1) = class0_training;
trainingList(:,:,2) = class1_training;
trainingList(:,:,3) = class2_training;

validationList = [];
validationList(:,:,1) = class0_validation;
validationList(:,:,2) = class1_validation;
validationList(:,:,3) = class2_validation;

testList = [];
testList(:,:,1) = class0_test;
testList(:,:,2) = class1_test;
testList(:,:,3) = class2_test;
