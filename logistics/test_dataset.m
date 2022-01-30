%% 逻辑回归问题
%%%
% 在不同的数据集上进行实验。导入 LIBSVM 数据集进行实验， |libsvmread|
% 为另外运行的读入程序。

%% 
% 设定随机种子。
clear;clc;
seed = 42;
ss = RandStream('mt19937ar','Seed',seed);
RandStream.setGlobalStream(ss);

dataset = 'a9a.test';
[b,A] = libsvmread(dataset);
[m,n] = size(A);
mu = 1e-2/m;
fun = @(x) lr_loss(A,b,m,x,mu);
gfun =  @(x) g_lr_loss(A,b,m,x,mu);

x0 = zeros(n,1);
[x1,val1,k1,G1]=grad_ABBplus(fun,gfun,x0);
%%
dataset = 'CINA.test';
[b,A] = libsvmread(dataset);
[m,n] = size(A);
mu = 1e-2/m;
fun = @(x) lr_loss(A,b,m,x,mu);
gfun =  @(x) g_lr_loss(A,b,m,x,mu);

x0 = zeros(n,1);
[x2,val2,k2,G2]=grad_ABBplus(fun,gfun,x0);
%%

dataset = 'ijcnn1.test';
[b,A] = libsvmread(dataset);
[m,n] = size(A);
mu = 1e-2/m;
fun = @(x) lr_loss(A,b,m,x,mu);
gfun =  @(x) g_lr_loss(A,b,m,x,mu);

x0 = zeros(n,1);
[x3,val3,k3,G3]=grad_ABBplus(fun,gfun,x0);

%% 绘图
m1 = 1:10:k1;
% m1 = 1:10:k1+1;
semilogy(m1,G1(1:10:end,end),'-', 'Color',[0.2 0.1 0.99], 'LineWidth',2);
hold on;
m2 = 1:10:k2;
semilogy(m2,G2(1:10:end,end),'-.', 'Color',[0.99 0.1 0.2], 'LineWidth',1.8);
hold on;
m3 = 1:10:k3;
semilogy(m3,G3(1:10:end,end),'-.', 'Color',[0.99 0.1 0.99], 'LineWidth',1.5);
ylabel('$\|\nabla \ell (x^k)\|_2$', 'fontsize', 14, 'interpreter', 'latex');
xlabel('迭代步');
legend('mt19937ar','CINA','ijcnn1');

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
