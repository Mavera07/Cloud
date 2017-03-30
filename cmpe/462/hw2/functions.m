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


k=0; mydata=[]; mypoint=[]; cList=[];
function result = knnVoteResult(cList,k,mydata,mypoint)
 
  distances= [];
  for ci = cList
    distList_ci = distListOfPointsToPoint(mydata(:,:,ci),mypoint);
    distList_ci = sort(distList_ci);
    distList_ci = distList_ci(1:k);
    distList_ci = [distList_ci ones(k,1)*(ci-1)];
    distances = [distances ;distList_ci];
  end
  
  distances = sortrows(distances);
  distances = distances(1:k,:);
  result = mode(distances(:,2));
  
end

