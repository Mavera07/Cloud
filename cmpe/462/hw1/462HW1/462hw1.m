N = 20; # Size of a sample.
M = 100; # Number of samples.
Order = 5; # Samples will be fit to polynomial models of this number of orders.


# Dataset X creation - Nx1 vector
# Uniform distribution is used to generate N values.
sample_x = unifrnd(0,5,1,N);

# f function that constructs dataset Y_i from dataset X
# Y_i is a sample consists of N values.
function fx_y = func_x_to_y(vec_x,index)
  fx_y = 2*sin(1.5*vec_x(index));
end

# Dataset Y creation - MxN matrix
# There are M samples. 
# Each sample can be represented as Y_i.
# Y_i is a sample consists of N values generated from dataset X.
# Same dataset X is used to generate each Y_i.
sample_y= zeros(M,N);
for i=1:M
  for j=1:N
    sample_y(i,j)=func_x_to_y(sample_x,j)+normrnd(0,1);
  end
end

# --------------------------------------
# --------------------------------------

# Function that finds the parameters of a polynomial function.
# It is assumed that there is a function g(x),
# that fits to dataset such that g(x_t) = y_t.
# The order of polynomial function is given as input.
# The function takes x vector and corresponding y vector as input.
# For example, if order is 2, the function is like a.x^2 + b.x +c,
# therefore, this function returns values of a,b and c.
# Note that, this function has the same functionality of 'polyfit' function.
function parameters = mypolyfit(vec_x,vec_y,order_num)
  
  row_number = length(vec_x);
  col_number = order_num+1;

  design_matrix = zeros(row_number,col_number);

  for i=1:row_number  
    for j=1:col_number
      design_matrix(i,j)=vec_x(i)^(col_number-j);    
    end
  end
  parameters = inv((design_matrix')*design_matrix)*(design_matrix')*(vec_y');
  
end

# --------------------------------------
# --------------------------------------
# PART 1 of HW1

# For each order value from 1 to given value of 'order',
# there will be values for bias and variance.
# Following vectors will store these values.
bias_list = zeros(Order,1);
variance_list = zeros(Order,1);

# For each order of polynomial fit
for order_val=1:Order

  # Model Creation
  # For each sample Y_i in dataset Y, a model will be generated.
  # Then average model will be generated
  # by taking the mean of parameters of models.
  models = zeros(M,order_val+1);
  for i=1:M
    models(i,:) = mypolyfit(sample_x,sample_y(i,:),order_val);
  end
  model_avg = mean(models);
  
  
  
  # Calculating bias, variance, error of model  
  # Bias
  # Applying formula of bias
  # Average model, f function and dataset X is used
  bias = 0;
  for i=1:N
    diff_i = polyval(model_avg,sample_x(i))-func_x_to_y(sample_x,i);
    bias = bias + diff_i^2;
  end
  bias = bias/N;
  
  # Variance
  # Applying formula of variance
  # Average model, all models, and dataset X is used
  variance = 0;
  for i=1:N
    for j=1:M
      diff_i = polyval(models(j,:),sample_x(i)) - polyval(model_avg,sample_x(i));
      variance = variance + diff_i^2;
    end
  end
  variance = variance/(M*N);
  
  # Save bias and variance in the vectors to be able to plot them together
  bias_list(order_val) = bias;
  variance_list(order_val) = variance;
end

# --------------------------------------
# --------------------------------------

# Result of PART 1
# Plot bias, variance and error
figure;
hold;
plot(bias_list,"g")
plot(variance_list,"b")
plot(bias_list+variance_list,"r")

legend("bias","variance","error") 







# --------------------------------------
# --------------------------------------
# PART 2 of HW1

# Each sample will be fit to polynomial models of this number of orders.
Order=5; 

# For each order value from 1 to given value of 'order',
# there will be values for bias and variance.
# For training and validation datasets,
# there will be different bias and variance values.
# Following vectors will store these values.
bias_list_training = zeros(Order,1);
variance_list_training = zeros(Order,1);

bias_list_validation = zeros(Order,1);
variance_list_validation = zeros(Order,1);

# For each order of polynomial fit
for order_val=1:Order

  # Model Creation
  # For each sample Y_i in dataset Y, a model will be generated.
  # In each sample, only odd indexed values are used to construct model.
  # Then average model will be generated 
  # by taking the mean of parameters of models.
  models = zeros(M,order_val+1);
  for i=1:M
    models(i,:) = mypolyfit(sample_x(1:2:20),sample_y(i,1:2:20),order_val);
  end
  model_avg = mean(models);
  
  # Bias, variance, error of model  
  # Bias
  # Applying formula of bias
  # Average model, f function and dataset X is used
  
  # Calculate bias for training dataset
  bias = 0;
  for i=1:2:20
    diff_i = polyval(model_avg,sample_x(i))-func_x_to_y(sample_x,i);
    bias = bias + diff_i^2;
  end
  bias = bias/10;
  
  bias_list_training(order_val) = bias;
  
  
  # Calculate bias for validation dataset
  bias = 0;
  for i=2:2:20
    diff_i = polyval(model_avg,sample_x(i))-func_x_to_y(sample_x,i);
    bias = bias + diff_i^2;
  end
  bias = bias/10;
  
  bias_list_validation(order_val) = bias;
  
  # Variance
  # Applying formula of variance
  # Average model, all models, and dataset X is used
  
  # Calculate variance for training dataset
  variance = 0;
  for i=1:2:20
    for j=1:M
      diff_i = polyval(models(j,:),sample_x(i)) - polyval(model_avg,sample_x(i));
      variance = variance + diff_i^2;
    end
  end
  variance = variance/(M*10);
  
  variance_list_training(order_val) = variance;
  
  
  # Calculate variance for validation dataset
  variance = 0;
  for i=2:2:20
    for j=1:M
      diff_i = polyval(models(j,:),sample_x(i)) - polyval(model_avg,sample_x(i));
      variance = variance + diff_i^2;
    end
  end
  variance = variance/(M*10);
  
  variance_list_validation(order_val) = variance;
  
end


# --------------------------------------
# --------------------------------------

# Result of PART 2
# Plot error values of training and validation datasets
figure;
hold;
plot(bias_list_training+variance_list_training,"r")
plot(bias_list_validation+variance_list_validation,"b")
legend("training","validation") 


# --------------------------------------
# --------------------------------------



