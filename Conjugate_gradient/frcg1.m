function [x,val,k,G]=frcg1(fun,gfun,x0)
%功能: 用FR共轭梯度法求解无约束问题: min f(x)
%输入: x0是初始点, fun, gfun分别是目标函数和梯度
%输出: x, val分别是近似最优点和最优值, k是迭代次数.
epsilon=1e-4;rho=0.6;sigma=0.4;
k=0;maxk=500;
while k<=maxk
    A(:,k+1)=[x0' feval(fun,x0) ];
    gk=feval(gfun,x0);
    if (norm(gk)<=epsilon)break;end
    if k==0
        dk=-gk;
    else
        beta=dot(gk,gk)/dot(g0,g0);
        dk=-gk+beta*d0;
    end
    m=0; mk=0;
    while(m<20) %Armijo搜索
        if(feval(fun,x0+rho^m*dk)<feval(fun,x0)+sigma*rho^m*gk'*dk)
            mk=m; break;
        end
        m=m+1;
    end
    x0=x0+rho^mk*dk;
    d0=dk;g0=gk;
    k=k+1;
end
x=x0;
val=feval(fun,x);
G=A';