# Reading the input dataset and saving it into individual columns
[col1,col2,col3] = textread('points2d.dat','%f %f %d');

# Combining columns in a matrix containing all dataset
allData = zeros(400,3);
allData(:,1) = col1;
allData(:,2) = col2;
allData(:,3) = col3;

# Extract classes from all dataset into different matrices
class0 = allData(find(col3==0),:);
class1 = allData(find(col3==1),:);
class2 = allData(find(col3==2),:);

# Divide class0 randomly into training, validation, test datasets
# Their sizes are 130+x,80 and 50+x respectively
temp1 = randperm(size(class0,1),80);
class0_training = class0(temp1,:);
temp2 = setdiff([1:size(class0,1)],temp1);
class0_test = class0(temp2,:);

# Divide class1 randomly into training, validation, test datasets
# Their sizes are 130+x,80 and 50+x respectively
temp1 = randperm(size(class1,1),80);
class1_training = class1(temp1,:);
temp2 = setdiff([1:size(class1,1)],temp1);
class1_test = class1(temp2,:);

# Divide class2 randomly into training, validation, test datasets
# Their sizes are 130+x,80 and 50+x respectively
temp1 = randperm(size(class2,1),80);
class2_training = class2(temp1,:);
temp2 = setdiff([1:size(class2,1)],temp1);
class2_test = class2(temp2,:);

# Combine training and test datasets for all 3 classes
# Combined training dataset is the concatenation of the training datasets of the classes 
# Combined test dataset is the concatenation of the test datasets of the classes 

trainingList = [];
trainingList = [trainingList; class0_training];
trainingList = [trainingList; class1_training];
trainingList = [trainingList; class2_training];

testList = [];
testList = [testList; class0_test];
testList = [testList; class1_test];
testList = [testList; class2_test];
