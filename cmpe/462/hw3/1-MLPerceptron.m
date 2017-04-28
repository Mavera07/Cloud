## PART 1 - DECLARATION OF VARIABLES

# Node sizes in input layer, hidden layer and output layer are initialized.
kSize = 3; # for input layer
hSize = 6; # for hidden layer
iSize = 3; # for output layer
# Initialization of learning rate
learning_rate = 311.8;


# Vectors for input layer, hidden layer and output layer are defined.
x_vec = ones(1,kSize); # input layer
z_vec = ones(1,hSize); # hidden layer
o_vec = ones(1,iSize); # output layer
# Vector for softmax values of output vector to normalize output vector
p_vec = ones(1,iSize); # softmax vector


# v_ih is defined for the weights between output layer and hidden layer
# Calculation : ([0,1]-0.5)*2/100
# Range of [-0.01,0.01] is obtained
v_ih = ((rand(iSize,hSize)-0.5)*2)/100;
# w_hk is defined for the weights between hidden layer and input layer
# Calculation : ([0,1]-0.5)*2/100
# Range of [-0.01,0.01] is obtained
w_hk = ((rand(hSize-1,kSize)-0.5)*2)/100;


# declaration of training error value
#error_training = 0;



## PART 2 - FUNCTIONS

# Function for calculating hidden layer vector
# The function will take two vectors tempxvec and tempwhk
# For the calculation,
# tempxvec parameter will be x_vec and
# tempwhk parameter will be w_hk
# For the bias of hidden layer, z0 value is always 1
tempxvec=[];tempwhk=[];
function tempvec = calculate_zvec(tempxvec, tempwhk)
  tempvec = [1 tanh(tempxvec*tempwhk')];
end

# Function for calculating output vector
# The function will take two vectors tempzvec and tempvih
# For output layer vector calculation,
# tempzvec parameter will be z_vec and
# tempvih parameter will be v_ih
tempzvec=[];tempvih=[];
function tempvec = calculate_ovec(tempzvec, tempvih)
  tempvec = tempzvec*tempvih';
end

# Function for calculating softmax vector
# The function will take one vector tempovec
# tempovec parameter will be o_vec
tempovec=[];
function tempvec = calculate_pvec(tempovec)
  tempisize = size(tempovec,2);
  
  tempvec2 =[];
  for tempi=1:tempisize
    tempvec2(tempi) = exp(tempovec(tempi));
  end
  
  tempvec=tempvec2./sum(tempvec2);
end

# Function for calculating error
# It will take temppj parameter
# temppj is the jth element in the p_vec
temppj = [];
function tempval = calculate_error(temppj)
  tempval = -log(temppj);
end


# Function for calculating the change in v_ih
temp_LearningRate=0; temp_pvec=[];temp_zvec=[];temp_i=0;temp_j =0;temp_h=0;
function tempval = calculate_vih(temp_LearningRate, temp_pvec,temp_zvec,temp_i,temp_h,temp_j)
  if temp_i == temp_j
    tempval = temp_LearningRate*(1-temp_pvec(temp_j))*temp_zvec(temp_h);
  else
    tempval = temp_LearningRate*(-temp_pvec(temp_i))*temp_zvec(temp_h);
  end
end
# Function for calculating the change in w_hk
temp_LearningRate=0; temp_pvec=[];temp_vih=[];temp_zvec=[]; temp_xvec=[];temp_h=0;temp_k=0;temp_j =0;
function tempval = calculate_whk(temp_LearningRate,temp_pvec,temp_vih,temp_zvec,temp_xvec,temp_h,temp_k,temp_j)
  tempval = temp_LearningRate*(1-temp_pvec(temp_j))*temp_vih(temp_j,temp_h)*(1-(temp_zvec(temp_h))^2)*temp_xvec(temp_k);
end


## PART 3 - MULTILAYER PERCEPTRON

# PROCESS THE PERCEPTRON MODEL UNTIL IT CONVERGES
# IN EACH ITERATION, PROCESS ON ALL TRAINING SET
tempNumberofLoops = 0;
while(tempNumberofLoops < 15)

  tempErrorCount = 0;
  # FOR EACH POINT IN THE TRAINING SET, UPDATE THE PERCEPTRON
  for vi = trainingList'
    # CALCULATE VECTORS OF EACH LAYER AND CALCULATE ERROR
    x_vec = [1 vi'(1:2)];
    z_vec = calculate_zvec(x_vec,w_hk);
    o_vec = calculate_ovec(z_vec,v_ih);
    p_vec = calculate_pvec(o_vec);
    # error_training = calculate_error(p_vec(vi(3)+1));
  
    # OBTAIN THE CLASS THAT THE POINT IS COMING FROM AND STORE IN j
    [ignore1 j] = max(o_vec);
    
    # Count errors for convergence
    if((vi(3)+1)!=j)
      tempErrorCount +=1 ;
    end
    # USE BACKPROPAGATION AND FIND THE UPDATE FOR EACH v WEIGTH
    temp_vih = zeros(iSize,hSize);
    for ival = 1:iSize
      for hval = 1:hSize
        temp_vih(ival,hval) = calculate_vih(learning_rate,p_vec,z_vec,ival,hval,j); 
      end
    end    
    # USE BACKPROPAGATION AND FIND THE UPDATE FOR EACH w WEIGTH
    temp_whk = zeros(hSize-1,kSize);
    for hval = 1:(hSize-1)
      for kval = 1:kSize
        temp_whk(hval,kval) = calculate_whk(learning_rate,p_vec,v_ih,z_vec,x_vec,hval+1,kval,j);
      end
    end
  
    v_ih += temp_vih;
    w_hk += temp_whk;
  end
  tempErrorCount
  tempNumberofLoops += 1;
end

w_hk

#3^2
#v_ih
#v_ih(j,2:6)

#z_vec
#z_vec(2:6)
#sum(temp_vih(temp_i,:));

#v_ih
#sum(v_ih(1,:))
#{
z_vec = calculate_zvec(x_vec,w_hk);
o_vec = calculate_ovec(z_vec,v_ih);
p_vec = calculate_pvec(o_vec);
error_training = calculate_error(p_vec(1));
#}