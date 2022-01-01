function [x,val,k,G]=grad_plus(fun,gfun,x0)
%功能: 用最速下降法求解无约束问题: min f(x)
%输入: x0是初始点, fun, gfun分别是目标函数和梯度
%输出: x, val分别是近似最优点和最优值, k是迭代次数.
k=1;iterMax=500; %最大迭代次数
alphaMin = 1e-5;alphaMax = 1e5;
M=10;epsilon=1e-5;
xOld=x0;

%armjio准则确定初始步长
alpha = 0.5;
[~, ~, alpha] = armijo_rule(fun, gfun, x0,alpha, -feval(gfun, x0));

QOld = 1;
COld = feval(fun,xOld);
c1 = 0.5;eta = 0.5;

while (k<iterMax)
    A(:,k)=[xOld' feval(fun,xOld) ];
    g=feval(gfun,xOld); %计算梯度
    d=-g; %计算搜索方向
    
    %%
    for i=1:M
        xNew = xOld+alpha*d;
        fNew = feval(fun,xNew);
        if fNew <= COld + alpha*c1*dot(d,d)
            break;
        end
        alpha = alpha*eta;
    end
    k=k+1;
    if norm(g,2)<epsilon
        break;
    end
    
    %% BB step-size

    sk = xNew-xOld; yk = feval(gfun,xNew)-feval(gfun,xOld);
    if mod(k,2)==1
        alpha = dot(sk,yk)/dot(yk,yk);
    else
        alpha = dot(sk,sk)/dot(sk,yk);
    end
    
   
    alpha = max( min(alpha,alphaMax), alphaMin);
    QNew = eta*QOld +1;
    CNew = (eta*QOld*COld+fNew)/QNew;
    COld = CNew;
    xOld = xNew;
end
if k == iterMax
    fprintf('exceed max iteration, not found  minimal point x.\n');
end

x = xNew;
val = feval(fun,x);
G=A';
    