clc;clear;
syms x val k;
x0=[0 2]';
% [x1,val1,k1,G1]=grad('fun','gfun',x0);
% [x2,val2,k2,G2]=grad_plus('fun','gfun',x0);
%[x4,val4,k4,G4]=grad_ABBplus('fun','gfun',x0);
% [x3,val3,k3,G3]=grad_BB('fun','gfun',x0);
[x3,val3,k3,G3]=NewCG('fun','gfun',x0);
%% 绘图
% figure('Name','grad');
%a=(G1(:,3)-G1(end,3))/G1(end,3);
%b=(G2(:,3)-G2(end,3))/G2(end,3);
%plot(a(1:40,1), 'LineWidth', 2)
% hold on;
%figure('Name','grad_BB');
%plot(b(1:40,1), 'LineWidth', 2)
%title('对比')

% plot(G3(1:50,end),'LineWidth',2);
% hold on;plot(G4(1:50,end),'LineWidth',2);

% semilogy(G4(:,end),'-', 'Color',[0.99 0.1 0.2], 'LineWidth',1.8);hold on;
% semilogy(G3(:,end),'-.', 'Color',[0.2 0.1 0.99], 'LineWidth',2);
% legend('BB','ABBplus');
% ylabel('$\|\nabla \ell (x^k)\|_2$', 'fontsize', 14, 'interpreter', 'latex');
% xlabel('迭代步');
%% 等高线图
% x1 = -1.5:1e-2:1.5;
% x2 = -1:1e-2:2;
% 
% [X1, X2] = meshgrid(x1, x2);
% F = 100*(X2-X1.^2).^2+(X1-1).^2;
% figure('Name','grad_contour');
% contour(X1, X2, F, 50);
% hold on;
% plot(G2(:,1),G2(:,2),'-o','MarkerIndices',1:50:length(G2(:,2)) ,'LineWidth', 1);
% title('grad _ contour');
% 
% figure('Name','gradBB_contour');
% contour(X1, X2, F, 50);
% hold on;
% plot(G4(:,1),G4(:,2),'-o','MarkerIndices',1:20:length(G4(:,2)) ,'LineWidth', 1);
% title('gradBB _ contour');
