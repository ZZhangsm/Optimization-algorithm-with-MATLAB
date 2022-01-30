%% 逻辑回归问题

% 设定随机种子。
clear;clc;
seed = 42;
ss = RandStream('mt19937ar','Seed',seed);
RandStream.setGlobalStream(ss);

%%%
% 在不同的数据集上进行实验。导入 LIBSVM 数据集 a9a 进行实验， |libsvmread|
% 为另外运行的读入程序。
dataset = 'a9a.test';
[b,A] = libsvmread(dataset);
A=A(1:500,:);b=b(1:500,:);
[m,n] = size(A);
mu = 1e-2/m;
fun = @(x) lr_loss(A,b,m,x,mu);
gfun =  @(x) g_lr_loss(A,b,m,x,mu);

%%%
x0 = zeros(n,1);
% [x,val,k,G]=grad_BB(fun,gfun,x0);
% [x4,val4,k4,G4]=grad_BB(fun,gfun,x0);
% [x2,val2,k2,G2]=grad_BBplus(fun,gfun,x0);
[x3,val3,k3,G3]= NewCG1(fun,gfun,x0);
% [x2,val2,k2,G2]=bfgs(fun,gfun,x0);

%%
% m1 = 1:10:k;
% semilogy(m1,G(1:10:end,end),'-.', 'Color',[0.2 0.1 0.99], 'LineWidth',2);
% hold on;
% m2 = 1:10:k2+1;
% semilogy(m2,G2(1:10:end,end),'-', 'Color',[0.99 0.1 0.2], 'LineWidth',1.8);
% % 
% ylabel('$\|\nabla \ell (x^k)\|_2$', 'fontsize', 14, 'interpreter', 'latex');
% xlabel('迭代步');
% legend('BB','ABB');

%% 目标函数,end)
% 逻辑回归的目标函数
function f = lr_loss(A,b,m,x,mu)
Ax=A*x;
expba=exp(-b.*Ax);
f = sum(log(1+expba))/m+mu*norm(x,2)^2;
end
function g = g_lr_loss(A,b,m,x,mu)
Ax=A*x;Atran=A';
expba=exp(-b.*Ax);
   g = Atran*(b./(1+expba) - b)/m + 2*mu*x;
end