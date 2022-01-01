function [x,val,k,G] = Decent_Newton(fun,gfun,Hess,x0)
%牛顿-最速下降混合算法
%输入：fun：函数，gfun：函数梯度，Hess:Hess阵，x0：初始点
%输出：x:最优值点，val：最优值，k：迭代次数

maxk=5000;%最大迭代次数
k=1;
epsilon=1e-5;%精度
rho=0.5;
sigma=0.4;

while(k<=maxk)
    A(:,k)=[x0' feval(fun,x0) ];
   g=feval(gfun,x0);
   if(norm(g)<=epsilon)
       break
   end
   Gk=feval(Hess,x0);
   d=-Gk\g;%解方程，求方向
   if(dot(g,d)>0)
       d=-g;
   end
   %线搜索找步长
    m=0; mk=0;
    while(m<20) % 用Armijo搜索求步长
        if(feval(fun,x0+rho^m*d)<feval(fun,x0)+sigma*rho^m*g'*d)
            mk=m; break;
        end
        m=m+1;
    end
    x0=x0+rho^mk*d;
   k=k+1;
end

  x=x0;
  val=feval(fun,x0);
  G=A';




