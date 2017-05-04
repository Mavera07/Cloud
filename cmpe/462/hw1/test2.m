#vec1 = [0 9 12 43];
#vec2 = [1 4];

#[vec1, vec2]

#A = rand(4,3);
#size(A)(1)

#plot(vec1,"r:")
#legend("vec1")

a = 12;
global a;
function temp1 = myfunc3()
  global a;
  a
  temp1 =3;
end


#a= 15;
myfunc3()
mean([1,2;3,4])