function [x,val,k,G]=grad_ABBplus(fun,gfun,x0)
%功能: 求解无约束问题: min f(x)
%输入: x0是初始点, fun, gfun分别是目标函数和梯度
%输出: x, val分别是近似最优点和最优值, k是迭代次数.
k=0;iterMax=5000; %最大迭代次数
alphaMin = 1e-5;alphaMax = 1e5;
M=10;epsilon=1e-4;tau=0.5;
xOld=x0;

%armjio准则确定初始步长
alpha0 = 0.5;dk= -feval(gfun, x0);
alpha = armijo_rule(fun, gfun, x0, alpha0, dk);

QOld = 1;
COld = feval(fun,xOld);
c1 = 0.5;eta = 0.5;
t0=cputime;
while (k<iterMax)
    t=cputime-t0 ;
    A(:,k+1)=[t norm(xOld) feval(fun,xOld) norm(feval(gfun,xOld))];
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
    % ABB(Adaptive Barzilai–Borwein)
    alpha_BB1 = dot(sk,sk)/dot(sk,yk);
    alpha_BB2 = dot(sk,yk)/dot(yk,yk);
    if alpha_BB2/alpha_BB1<tau
        alpha = alpha_BB2;
    else
        alpha = alpha_BB1;
    end
    alpha = max( min(alpha,alphaMax), alphaMin);
    QNew = eta*QOld +1;
    CNew = (eta*QOld*COld+fNew)/QNew;
    COld = CNew;xOld = xNew;
end
if k == iterMax
    fprintf('exceed max iteration, not found  minimal point x.\n');
end

x = xNew;
val = feval(fun,x);
G=A';
    
