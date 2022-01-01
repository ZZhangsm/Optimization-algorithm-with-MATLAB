clc;clear;
syms x val k;

x0=[10 10]';
[x1,val1,k1,G1]=Newton('fun','gfun','Hess',x0);
[x2,val2,k2,G2]=dampnm('fun','gfun','Hess',x0);
[x3,val3,k3,G3]=Decent_Newton('fun','gfun','Hess',x0);
[x4,val4,k4,G4]=ReviseNewton('fun','gfun','Hess',x0);
[x5,val5,k5,G5]=ReviseNewtonCholesky('fun','gfun','Hess',x0);

% %% 绘图
figure('Name','newton');
%plot(G1(:,3), 'LineWidth', 2);hold on;
plot(G2(5:15,3), 'LineWidth', 2);
hold on;plot(G3(5:15,3), 'LineWidth', 2);
hold on;plot(G4(5:15,3), 'LineWidth', 2);
hold on;plot(G5(5:15,3), 'LineWidth', 2);

% %% 等高线图
% x1 = -2:1e-2:1.5;
% x2 = -1.5:1e-2:2;
% [X1, X2] = meshgrid(x1, x2);
% F = 100*(X2-X1.^2).^2+(X1-1).^2;
% figure('Name','dampnm_contour');
% contour(X1, X2, F, 50);
% hold on
% plot(G1(:,1),G1(:,2),'-o','MarkerIndices',1:1:length(G1(:,2)) ,'LineWidth', 1);
% hold on
% plot(G2(:,1),G2(:,2),'-o','MarkerIndices',1:3:length(G2(:,2)) ,'LineWidth', 1)
% hold on
% plot(G3(:,1),G3(:,2),'-o','MarkerIndices',1:3:length(G3(:,2)) ,'LineWidth', 1)

