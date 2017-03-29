#{
k=0;N=0;mydata=[];
function [means vars error] = EM(k,N,mydata)
  
  # sizevec
  # meanvec
  # varvec

  for EM_turn = 1:20
    # E-step
    ric_mat = zeros(N,k);

    for i = 1:N
      for c = 1:k        
          ric_mat(i,c) = # (size * normpdf) / sum(size * normpdf)        
      end   
    end
    
    # M-step
    mc_vec = mean(ric_mat);  
    sizevec = mc_vec/sum(mc_vec);
    meanvec = sum( (ric_mat' .* "datavec")' )./mc_vec;

    temp = ("datavec with k copy columns"-meanvec);
    varvec = sum(ric_mat*(temp'*temp))./mc_vec;
  end
  
end
#}

mydata=[]; mypoint=[];
function result = distListOfPointsToPoint(mydata, mypoint)
  N = size(mydata)(1);
  result = zeros(N,1);
  for i = 1:N
    temp1 = mypoint(1)-mydata(i,1);
    temp2 = mypoint(2)-mydata(i,2);
    result(i) = sqrt(temp1^2+temp2^2);
  end
end

k=0; mydata=[];
function result = kthDist(k,mydata,mypoint)
  distances = distListOfPointsToPoint(mydata,mypoint);
  distances = sort(distances);
  result = distances(k);
end