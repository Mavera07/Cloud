[col1,col2,col3] = textread('points2d.dat','%f %f %d');
allData = [col1 col2 col3];

class1 = allData(col3==(zeros(6000,1)+1));
size(allData)
size(class1)
class1(1)
