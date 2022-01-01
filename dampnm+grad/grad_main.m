clc;clear;
syms x val k;
x0=[0 2]';
[x,val,k,G1]=grad('fun','gfun',x0);
[x,val,k,G2]=grad_plus1('fun','gfun',x0);

%绘图
figure('Name','grad');
a=(G1(:,3)-G1(end,3))/G1(end,3);
b=(G2(:,3)-G2(end,3))/G2(end,3);
plot(a(1:40,1), 'LineWidth', 2)
hold on
%figure('Name','grad_BB');
plot(b(1:40,1), 'LineWidth', 2)
title('对比')
%等高线图
x1 = -1.5:1e-2:1.5;
x2 = -1:1e-2:2;

[X1, X2] = meshgrid(x1, x2);
F = 100*(X2-X1.^2).^2+(X1-1).^2;
figure('Name','grad_contour');
contour(X1, X2, F, 50)
hold on
plot(G1(:,1),G1(:,2),'-o','MarkerIndices',1:50:length(G1(:,2)) ,'LineWidth', 1)
title('grad _ contour')

figure('Name','gradBB_contour')
contour(X1, X2, F, 50);
hold on
plot(G2(:,1),G2(:,2),'-o','MarkerIndices',1:20:length(G1(:,2)) ,'LineWidth', 1)
title('gradBB _ contour')
