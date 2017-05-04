range = [0:0.1:5];
 
func1 = [-1 1];
func2 = [-2 -6];


x1_set = [];
x2_set = [];
c_set = [];

for i = 1:size(range)(2)
  x1_set = [x1_set,polyval(func1,range(i))+normrnd(0,1)];
  x2_set = [x2_set,polyval(func2,range(i))+normrnd(0,1)];
  c_set = [1,c_set,2];
end

temp_set = zeros(102,2);
temp_set(:,1) = [range,range];
temp_set(:,2) = [x1_set,x2_set];


figure;
hold;

plot(range,x1_set,"ro", "markersize", 10, "linewidth", 3);
plot(range, x2_set,"go", "markersize", 10, "linewidth", 3); 

X = temp_set;
c = c_set;

figure;
hold;

mu = mean(X);
Xm = bsxfun(@minus, X, mu);
C = cov(Xm);
[V,D] = eig(C);
[D, i] = sort(diag(D), 'descend');
V = V(:,i);
scale = 3;
pc1 = line([mu(1) - scale * V(1,1) mu(1) + scale * V(1,1)], [mu(2) - scale * V(2,1) mu(2) + scale * V(2,1)]);
pc2 = line([mu(1) - scale * V(1,2) mu(1) + scale * V(1,2)], [mu(2) - scale * V(2,2) mu(2) + scale * V(2,2)]);

set(pc1, 'color', [1 0 0], "linestyle", "--");
set(pc2, 'color', [0 1 0], "linestyle", "--");


% project on pc1
z = Xm*V(:,1);
% and reconstruct it
p = z*V(:,1)';
p = bsxfun(@plus, p, mu);

y1 = p(find(c==1),:);
y2 = p(find(c==2),:);

p1 = plot(y1(:,1),y1(:,2),"ro", "markersize", 10, "linewidth", 3);
p2 = plot(y2(:,1), y2(:,2),"go", "markersize", 10, "linewidth", 3); 

% project on pc2

figure;
hold;

pc1 = line([mu(1) - scale * V(1,1) mu(1) + scale * V(1,1)], [mu(2) - scale * V(2,1) mu(2) + scale * V(2,1)]);
pc2 = line([mu(1) - scale * V(1,2) mu(1) + scale * V(1,2)], [mu(2) - scale * V(2,2) mu(2) + scale * V(2,2)]);

set(pc1, 'color', [1 0 0], "linestyle", "--");
set(pc2, 'color', [0 1 0], "linestyle", "--");


p = z*V(:,2)';
p = bsxfun(@plus, p, mu);

y1 = p(find(c==1),:);
y2 = p(find(c==2),:);

p1 = plot(y1(:,1),y1(:,2),"ro", "markersize", 10, "linewidth", 3);
p2 = plot(y2(:,1), y2(:,2),"go", "markersize", 10, "linewidth", 3); 