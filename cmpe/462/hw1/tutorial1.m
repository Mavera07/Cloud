for i=1:2 # change it to 100
  sample_x = unifrnd(0,5,1,20);
  sample_y=[];
  for j=1:20
    sample_y=[sample_y,2*sin(1.5*sample_x(j))+normrnd(0,1)];
  end
  
  polymodels=[];
  for o=1:5
    polymodels=[polymodels,polyfit(sample_x,sample_y,o)];
  end
  
end