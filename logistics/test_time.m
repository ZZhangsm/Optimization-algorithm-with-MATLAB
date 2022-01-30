
plot( G(1:10:end,1),G(1:10:end,1)/G(end,1),'LineWidth',2);
hold on;plot( G2(1:10:end,1),G2(1:10:end,1)/G2(end,1),'LineWidth',2);
hold on;plot( G3(1:10:end,1),G3(1:10:end,1)/G3(end,1),'LineWidth',2);
hold on;plot( G4(1:10:end,1),G4(1:10:end,1)/G4(end,1),'LineWidth',2);
xlabel('CPU运行时间');ylabel('任务完成度');
legend('BB','BBplus','ABB','ABBplus','Location','best');

m1 = 1:10:k+1;
semilogy(m1,G(1:10:end,end),'-.',  'LineWidth',2);
hold on;
m2 = 1:10:k4+1;
semilogy(m2,G4(1:10:end,end),'-.', 'Color',[0.99 0.1 0.2], 'LineWidth',1.8);
m2 = 1:10:k4+1;
semilogy(m2,G4(1:10:end,end),'-.', 'Color',[0.99 0.1 0.99], 'LineWidth',1.5);
m2 = 1:10:k4+1;
semilogy(m2,G4(1:10:end,end),'-', 'Color',[0.99 0.1 0.2], 'LineWidth',1.8);
ylabel('$\|\nabla \ell (x^k)\|_2$', 'fontsize', 14, 'interpreter', 'latex');
xlabel('迭代步');
legend('BB','BBplus','ABB','ABBplus','Location','best');
