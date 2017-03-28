
for ki = 1:3
  [means vars] = EM(ki,mydata)
  # save the result
end
 
# calculate error on validation set
# save/return the solution
