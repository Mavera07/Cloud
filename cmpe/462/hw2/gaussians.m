
# class 0 // (-7.5 : 9)  // (-5 : 10)
# k = 1 // 0.75 2.5
# class 1 // (-11 : 4)  // ( -8 : 5)
# k = 1 // -3.5 -1.5
# class 2 // (-14 : 5)  // ( -13 : 4)
# k = 1 // -4.5 -4.5

for ki = 1:3
  [means vars] = EM(ki,mydata)
  # save the result
end
 
# calculate error on validation set
# save/return the solution
