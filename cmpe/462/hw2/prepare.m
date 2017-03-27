[col1,col2,col3] = textread('points2d.dat','%f %f %d');

allData = zeros(6000,3);
allData(:,1) = col1;
allData(:,2) = col2;
allData(:,3) = col3;

# Following command converts doubles to integers
# allData = [col1 col2 col3];

# Matrix conditional selections
# find(col3==0)
# col3==0
# allData(list1>list2)

# Extract classes
class0 = allData(find(col3==0),:);
class1 = allData(find(col3==1),:);
class2 = allData(find(col3==2),:);

# Divide class0
temp1 = randperm(2000,1000);
class0_training = class0(temp1,:);

temp2 = setdiff([1:2000],temp1);
temp1 = class0(temp2,:);

temp2 = randperm(1000,500);
class0_validation = temp1(temp2,:);

temp3 = setdiff([1:1000],temp2);
class0_test = temp1(temp3,:);

# Divide class1
temp1 = randperm(2000,1000);
class1_training = class1(temp1,:);

temp2 = setdiff([1:2000],temp1);
temp1 = class1(temp2,:);

temp2 = randperm(1000,500);
class1_validation = temp1(temp2,:);

temp3 = setdiff([1:1000],temp2);
class1_test = temp1(temp3,:);

# Divide class2
temp1 = randperm(2000,1000);
class2_training = class2(temp1,:);

temp2 = setdiff([1:2000],temp1);
temp1 = class2(temp2,:);

temp2 = randperm(1000,500);
class2_validation = temp1(temp2,:);

temp3 = setdiff([1:1000],temp2);
class2_test = temp1(temp3,:);

