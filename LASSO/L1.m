%% control parameter
MaxIteration = 200; %最大迭代次数
FuncValueTol = 1e-6; %针对函数值的停机准则，当相邻两次迭代函数值之差小于该值时认为该条件满足
GradientTol = 1e-6; %针对梯度的停机准则， 当当前步梯度范数小于该值时认为该条件满足

%% Input data
m=32;n=64;r=0.1;
A=randn (m, n) ;
u=sprandn (n, 1,r) ;
b=A*u;
Initx0=randn (n,1) ;

mu = 0.2; % 目标函数中第二项的权重
Sigma = 0.1; % Huber 光滑化参数 σ

%% 初始点 Initx0 处的梯度值,根据公式(4)
r = A * Initx0 - b;
g = A' * r; % 梯度的第一部分
huber_g = sign(Initx0);
idx = abs(Initx0) < Sigma;
huber_g(idx) = Initx0(idx) / Sigma; % 梯度的第二部分
g = g + mu * huber_g; % 两部分梯度相加

%% 计算初始点Initx0 处光滑化函数（3）的值
f = 0.5*norm(r,2)^2 + mu*(sum(Initx0(idx).^2/(2*Sigma)) + sum(abs(Initx0(abs(Initx0) >= Sigma)) - Sigma/2));

%%
for k = 1:MaxIteration % 每一次迭代
    % 记录上一次迭代的信息
    fp = f; %当前函数值
    gp = g; %当前梯度值
    xp = Initx0; %当前变量值
    
    % 线搜索循环选取合适步长并更新迭代点 x，并且在新的 x 处更新各变量值
    Count = 1; %重置线搜索次数为1,步长搜索计数器
    alpha = 1; %步长的初始值
    t = 0.3;
    beta = 0.5;
    while 1
        x = xp - alpha*gp; %找到一个新的变量值
        Initx0 = x;
        % 计算新的变量值下，梯度和函数值
        r = A * x - b;
        g = A' * r;
        huber_g = sign(x);
        idx = abs(x) < Sigma;
        huber_g(idx) = x(idx) / Sigma;
        g = g + mu * huber_g;
        f = .5*norm(r,2)^2 + mu*(sum(x(idx).^2/(2*Sigma)) + sum(abs(x(abs(x) >= Sigma)) - Sigma/2));
        if f <= fp + t*alpha*(gp'*g) || Count >= 10
            break
        end
        alpha = beta*alpha; % 当前步长太长，进行缩减
        Count = Count+1; %计数器加1
    end
    
    % 线搜索结束，得到更新的 变量x, 梯度g。进行内层循环的收敛判断： 若当前梯度小于阈值或者目标函数变化小于阈值，内层迭代终止。
    nrmG = norm(g,2);
    if nrmG < GradientTol || abs(fp - f) < FuncValueTol
        break;
    end
end

f
x