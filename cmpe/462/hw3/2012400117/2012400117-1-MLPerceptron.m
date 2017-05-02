## PART 1 - DECLARATION OF VARIABLES

# Node sizes in input layer, hidden layer and output layer are initialized.
kSize = 3; # for input layer
hSize = 6; # for hidden layer
iSize = 3; # for output layer
# Initialization of learning rate
learning_rate = 3.8;


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



## PART 2 - FUNCTIONS

# Function for hyperbolic tangent
tempIntermediate = 0;
function tempval = myHyperbolicTangent(tempIntermediate)
  temp1 = exp(tempIntermediate)^2;
  tempval = (temp1-1)/(temp1+1);
end

# Function for calculating hidden layer vector
# The function will take two vectors tempxvec and tempwhk
# For the calculation,
# tempxvec parameter will be x_vec and
# tempwhk parameter will be w_hk
# For the bias of hidden layer, z0 value is always 1
tempxvec=[];tempwhk=[];
function tempvec = calculate_zvec(tempxvec, tempwhk)
  #tempvec = [1 tanh(tempxvec*tempwhk')];
  tempvec = [1];
  for hval=1:size(tempwhk,1)
    tempvec = [tempvec myHyperbolicTangent(tempwhk(hval,:)*(tempxvec'))];
  end
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
function tempval = calculate_whk(temp_LearningRate,temp_ovec,temp_vih,temp_zvec,temp_xvec,temp_h,temp_k,temp_j)
  tempval = -temp_LearningRate;
  
  temp2 = 0;
  temp3 = 0;
  
  for tempIndex = 1:3
    temp2+=exp(temp_ovec(tempIndex))*temp_vih(tempIndex,temp_h);
    temp3+=exp(temp_ovec(tempIndex));
  end
  
  tempval *= (temp2/temp3) - temp_vih(temp_j,temp_h);
  
  tempval *= (1-(temp_zvec(temp_h))^2)*temp_xvec(temp_k);
end


## PART 3 - MULTILAYER PERCEPTRON

# PROCESS THE PERCEPTRON MODEL UNTIL IT CONVERGES
# IN EACH ITERATION, PROCESS ON ALL TRAINING SET
tempDatasetSize = size(trainingList,1);
tempNumberofLoops = 0;
while(tempNumberofLoops < 10)
  tempErrorCount = 0;
  # FOR EACH POINT IN THE TRAINING SET, UPDATE THE PERCEPTRON
  for vi = trainingList'
    # CALCULATE VECTORS OF EACH LAYER AND CALCULATE ERROR
    x_vec = [1 vi'(1:2)]
    z_vec = calculate_zvec(x_vec,w_hk)
    o_vec = calculate_ovec(z_vec,v_ih)
    p_vec = calculate_pvec(o_vec);
    
    # error_training = calculate_error(p_vec(vi(3)+1));
  
    # OBTAIN THE CLASS THAT THE POINT IS COMING FROM AND STORE IN j
    [ignore1 j] = max(o_vec);
    
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
        temp_whk(hval,kval) = calculate_whk(learning_rate,o_vec,v_ih,z_vec,x_vec,hval+1,kval,j);
      end
    end
  
    v_ih += temp_vih;
    w_hk += temp_whk;
    
    # Count errors for convergence
    if((vi(3)+1)!=j)
      tempErrorCount +=1 ;
    end
  end
  # Print the error rate
  tempErrorCount/tempDatasetSize
  tempNumberofLoops+=1;
end
