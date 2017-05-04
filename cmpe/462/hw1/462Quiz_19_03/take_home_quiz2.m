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

X = temp_set;
c = c_set;



figure;
hold;

plot(range,x1_set,"ro", "markersize", 10, "linewidth", 3);
plot(range, x2_set,"go", "markersize", 10, "linewidth", 3); 



figure;
hold;


c1 = X(find(c==1),:);
c2 = X(find(c==2),:);


classes = max(c);
mu_total = mean(X);
mu = [ mean(c1); mean(c2) ];
Sw = (X - mu(c,:))'*(X - mu(c,:));
Sb = (ones(classes,1) * mu_total - mu)' * (ones(classes,1) * mu_total - mu);


[V, D] = eig(Sw\Sb);


[D, i] = sort(diag(D), 'descend');
V = V(:,i);


scale = 2;
pc1 = line([mu_total(1) - scale * V(1,1) mu_total(1) + scale * V(1,1)], [mu_total(2) - scale * V(2,1) mu_total(2) + scale * V(2,1)]);

set(pc1, 'color', [1 0 0], "linestyle", "--");


p1 = plot(c1(:,1), c1(:,2), "ro", "markersize",10, "linewidth", 3);
p2 = plot(c2(:,1), c2(:,2), "go", "markersize",10, "linewidth", 3);

Xm = bsxfun(@minus, X, mu_total);
z = Xm*V(:,1);

p = z*V(:,1)';
p = bsxfun(@plus, p, mu_total);


y1 = p(find(c==1),:);
y2 = p(find(c==2),:);

p1 = plot(y1(:,1),y1(:,2),"ro", "markersize", 10, "linewidth", 3);
p2 = plot(y2(:,1), y2(:,2),"go", "markersize", 10, "linewidth", 3);