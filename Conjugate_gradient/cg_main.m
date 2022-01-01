clc;clear;
x0=[5 5]';
[x1,val1,k1,G1]=frcg('fun','gfun',x0);
[x2,val2,k2,G2]=Dcg('fun','gfun',x0);
[x3,val3,k3,G3]=DYcg('fun','gfun',x0);
[x4,val4,k4,G4]=CWcg('fun','gfun',x0);
[x5,val5,k5,G5]=PRPcg('fun','gfun',x0);
%%
% figure('Name','Contrast')
% plot(G1(1:20,end), 'LineWidth', 2);
% hold on;plot(G2(5:20,end), 'LineWidth', 2);
% hold on;plot(G3(5:20,end), 'LineWidth', 2);
% hold on;plot(G4(5:20,end), 'LineWidth', 2);
% hold on;plot(G5(5:20,end), 'LineWidth', 2);
% xlabel('共轭梯度法') ;ylabel('值');
% legend('FR','Dixon','Dai-Yuan','Crowder-Wolfe','PRP');

%% %等高线图
% x1 = -0.5:1e-2:1.2;
% x2 = -0.5:1e-2:1.5;
% [X1, X2] = meshgrid(x1, x2);
% F = 100*(X2-X1.^2).^2+(X1-1).^2;
% figure('Name','Contrast_3D');
% contour3(X1, X2, F, 50);
% hold on;plot(G1(:,1),G1(:,2),'--','MarkerIndices',1:5:15 ,'LineWidth', 2);
% hold on;plot(G2(:,1),G2(:,2),'--','MarkerIndices',1:5:15 ,'LineWidth', 2);
% hold on;plot(G3(:,1),G3(:,2),'--','MarkerIndices',1:5:15 ,'LineWidth', 2);
% hold on;plot(G4(:,1),G4(:,2),'--','MarkerIndices',1:5:15 ,'LineWidth', 2);
% hold on;plot(G5(:,1),G5(:,2),'--','MarkerIndices',1:5:15 ,'LineWidth', 2);
% xlabel('共轭梯度法前15次') ;ylabel('值');
% legend('','FR','Dixon','Dai-Yuan','Crowder-Wolfe','PRP');