#polyval([2,2,3],[5,2])

#sample_x = unifrnd(0,5,1,20);
#sample_x(20)

#polyfit([5,7,11],[3,2,6],2)


#variance_list = zeros(5,1)


#csvread('iris.data.txt')


# 0 Iris-setosa , 1 Iris-versicolor

iris_data = csvread('iris.data.txt');
iris_class = iris_data(:,end);

for i=1:4
  feature = iris_data(:,i);
  feature_from_class0 = feature(5:35);
  feature_from_class1 = feature(66:95);
  
  f0_mean = mean(feature_from_class0);
  f0_var = var(feature_from_class0);
  
  f1_mean = mean(feature_from_class1);
  f1_var = var(feature_from_class1);
  
  
  count_0 =0;
  count_1 =0;
  error_no = 0;
  pdf_count_0 =0;
  pdf_count_1 =0;
  pdf_error_no = 0;
  
  
  
  for j=1:100
  
    
    
    val1 = normcdf(feature(j),f0_mean,f0_var);
    val2 = normcdf(feature(j),f1_mean,f1_var);
    if(val1 > 0.5)
      val1 = 1- val1;
    end
    if(val2 > 0.5)
      val2 = 1- val2;
    end
    
  
    if(val1 > val2 )
      count_0 +=1;
      if(iris_class(j)==1)
        error_no +=1;
      end
    elseif(val1 < val2)
      count_1 +=1;
      if(iris_class(j)==0)
        error_no +=1;
      end
    end
    
    pdf_val1 = normpdf(feature(j),f0_mean,f0_var)
    pdf_val2 = normpdf(feature(j),f1_mean,f1_var);
    
    if(pdf_val1 > pdf_val2)
      pdf_count_0 +=1;
      if(iris_class(j)==1)
        pdf_error_no +=1;
      end
    elseif(pdf_val1 < pdf_val2)
      pdf_count_1 +=1;
      if(iris_class(j)==0)
        pdf_error_no +=1;
      end
    end
    

  end 
   
  count_0
  count_1
  error_no
  x=1;
  pdf_count_0
  pdf_count_1
  pdf_error_no
  x=2;
  x=3;
  
   
  #x_vals = [0:0.1:7];
  #min(normpdf(feature_0,f0_mean,f0_var))
  #min(normpdf(feature_1,f0_mean,f0_var))
  #max(normpdf(feature_0,f0_mean,f0_var))
  #max(normpdf(feature_1,f0_mean,f0_var))
  #min(normpdf(feature_0,f1_mean,f1_var))
  #min(normpdf(feature_1,f1_mean,f1_var))
  #max(normpdf(feature_0,f1_mean,f1_var))
  #max(normpdf(feature_1,f1_mean,f1_var))
end


# 0 Iris-setosa , 1 Iris-versicolor

iris_data = csvread('iris.data.txt');
iris_class = iris_data(:,end);

for i=1:4
  feature = iris_data(:,i);
  
  training_indeces_0 = randperm(50,35);
  training_indeces_1 = randperm(50,35)+50;
  
  
  feature_from_class0 = feature(1:50);
  feature_from_class1 = feature(51:100);
  
  f0_mean = mean(feature_from_class0);
  f0_var = var(feature_from_class0);
  
  f1_mean = mean(feature_from_class1);
  f1_var = var(feature_from_class1);
  
  
  pdf0 = normpdf(feature,f0_mean,f0_var);
  pdf1 = normpdf(feature,f1_mean,f1_var);
  
  
  results = zeros(100,1);
  results(pdf1>pdf0)=1;
  sum(abs(results-iris_class))
  
end

# -------


# 0 Iris-setosa , 1 Iris-versicolor

iris_data = csvread('iris.data.txt');
iris_class = iris_data(:,end);

N=100;
N_class_0=50;
N_class_1=50;
N_class_0_training=35;
N_class_1_training=35;
N_class_0_validation=15;
N_class_1_validation=15;
N_validation=30;

for i=1:4
  feature = iris_data(:,i);
  
  training_indeces_0 = randperm(N_class_0,N_class_0_training);
  training_indeces_1 = randperm(N_class_1,N_class_1_training)+N_class_0;
  
  feature_from_class0 = feature(training_indeces_0);
  feature_from_class1 = feature(training_indeces_1);
  
  f0_mean = mean(feature_from_class0);
  f0_var = var(feature_from_class0);
  
  f1_mean = mean(feature_from_class1);
  f1_var = var(feature_from_class1);
  
  
  validation_indeces_0 = setdiff([1:N_class_0],training_indeces_0);
  validation_indeces_1 = setdiff([N_class_0+1:N],training_indeces_1);
  validation_indeces = [validation_indeces_0,validation_indeces_1];
 
  pdf0 = normpdf(feature(validation_indeces),f0_mean,f0_var);
  pdf1 = normpdf(feature(validation_indeces),f1_mean,f1_var);
  
  
  results = zeros(N_validation,1);
  results(pdf1>pdf0)=1;
  sum(abs(results-iris_class(validation_indeces)))
  
end