
# Note that, iris.data.txt file is updated.
# Last 50 lines are deleted since we only need first two classes.
# Last column of csv file is for the class name.
# Class name Iris-setosa is replaced with 0.
# Class name Iris-versicolor is replaced with 1.

# Iris dataset that consists of 100 lines.
iris_data = csvread('iris.data.txt');
# Last column of dataset. It is the list of classes of the data. 
iris_class = iris_data(:,end); 

N=100; # Number of data entries in the dataset.
N_class_0=50; # Number of data for class 0 in the dataset.
N_class_1=50; # Number of data for class 1 in the dataset.
N_class_0_training=35; # Number of training data for class 0 in the dataset.
N_class_1_training=35; # Number of training data for class 1 in the dataset.
N_class_0_test=15; # Number of test data for class 0 in the dataset.
N_class_1_test=15; # Number of test data for class 1 in the dataset.
N_test=30; # Number of all test data in the dataset.

# There are 4 features in the dataset. (4 columns of data)
# For each feature following code will be executed.
# It will calculate mean and variance values for class 0 and 
# class 1 from training datasets.
# Then, to find the success of the classification, test dataset is used.
# Parametric classification is used.
# By applying normpdf function, likelihood values are 
# obtained for class 0 and class 1.
# By comparing likelihood values that come from class 0 and class 1,
# decision of classifying is made.
# Then the decision is compared with actual class of the data.
# Number of false decisions is counted and considered as error.
# Error value and size of the test dataset is printed on the screen.
for i=1:4
  # Current column of feature.
  feature = iris_data(:,i); 
  
  # Indeces for training datasets are randomly selected
  training_indeces_0 = randperm(N_class_0,N_class_0_training); 
  training_indeces_1 = randperm(N_class_1,N_class_1_training)+N_class_0;
  
  # Training data vectors are obtained by using indeces of training datasets.
  feature_from_class0 = feature(training_indeces_0);
  feature_from_class1 = feature(training_indeces_1);
  
  # Mean and variance values are calculated for class 0 and class 1.
  f0_mean = mean(feature_from_class0);
  f0_var = var(feature_from_class0);
  
  f1_mean = mean(feature_from_class1);
  f1_var = var(feature_from_class1);
  
  # Then test dataset is obtained by subtracting training datasets 
  # from the all Iris dataset.
  test_indeces_0 = setdiff([1:N_class_0],training_indeces_0);
  test_indeces_1 = setdiff([N_class_0+1:N],training_indeces_1);
  test_indeces = [test_indeces_0,test_indeces_1];
 
  # pdf values are calculated for class 0 and class 1
  pdf0 = normpdf(feature(test_indeces),f0_mean,f0_var);
  pdf1 = normpdf(feature(test_indeces),f1_mean,f1_var);
  
  # pdf values are compared and classification is done.
  # then the classification is compared with actual classes.
  # number of wrong decisions is counted and considered as error number.
  # and error number for that feature is printed with the size of test dataset.
  results = zeros(N_test,1);
  results(pdf1>pdf0)=1;
  error = sum(abs(results-iris_class(test_indeces)));
  
  fprintf("In feature %d, out of %d elements in test dataset, there are %d wrong decisions.\n",i,N_test,error);
  
end