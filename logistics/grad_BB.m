function [x, val, iter, G] = grad_BB(fun,gfun,x0)
%功能：求解无约束问题：min f(x)
%其中步长选取使用BB方法确定
%输入: x0是初始点, fun, gfun分别是目标函数和梯度
%输出: x, val分别是近似最优点和最优值, k是迭代次数.
iter = 0; iterMax = 5000;
alphaMin = 1e-5; alphaMax = 1e5;
M =10; epsilon = 1e-4;
c1=0.5;beta=0.5;
xOld = x0;
alpha = 1;
t0=cputime;

while iter <= iterMax
    t=cputime-t0 ;
    A(:,iter+1)=[t norm(xOld) feval(fun,xOld) norm(feval(gfun,xOld))];
    g = feval(gfun,xOld);%梯度
    d=-g;%方向
    if norm(g)<= epsilon
        break;end    
    %% 回溯法找最大值
    N = min([iter M]);
    xp = xOld;
    fBest = feval(fun,xOld);
    for j = 1:N
        xj = xp-alpha*d;
        fj = feval(fun,xj);
        if fj > fBest
            fBest = fj;
        end
        xp = xj;
    end
    %% BB step-size
    while feval(fun,xOld+alpha*d) >= fBest-c1*alpha*dot(g,g)
        alpha = alpha*beta;
    end
    
    xNew = xOld+alpha*d;
    
    sk = xNew-xOld; yk = feval(gfun,xNew)-feval(gfun,xOld);
    if mod(iter,2)==1
        alpha = dot(sk,yk)/dot(yk,yk);
    else
        alpha = dot(sk,sk)/dot(sk,yk);
    end
    alpha = max( min(alpha,alphaMax), alphaMin);
    xOld = xNew;
    iter = iter+1;
end
x = xNew;
val = feval(fun,x);
G=A';
