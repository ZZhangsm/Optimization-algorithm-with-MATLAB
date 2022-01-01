function [ x, y ,k,g] = Parabola(f, x1 ,x2, x3, eps)
%{
    f       函数
    x1       初始搜索区间左区间
    x3       初始搜索区间右区间
    x2      初始插值点
    
    eps     精度
    x       自变量
    y    局部极小值
    k       迭代次数
%}

xmax = x3;
xmin = x1;
F = matlabFunction(f);
k=1;

while 1
    f1 = F(x1) ; f2 = F(x2) ; f3 = F(x3);
    a = 2*( f1*(x2-x3) + f2*(x3-x1) + f3*(x1-x2) );
    b = ( f1*(x2^2-x3^2) + f2*(x3^2-x1^2) + f3*(x1^2-x2^2) );
    %计算极小值点x_p
    x_p = b/a;
    f_p = F(x_p);
    %数组G储存迭代结果
    g(k,:) = [f_p,x1,x2,x3,x_p,k];
    if abs(x2-x_p) < eps
        x = x_p;
        y = F(x_p);
        break
    else
        if (x_p-x1)*(x_p-x2)<0
            if F(x_p) <= f2
                x3 = x2;
                x2 = x_p;
            else
                x1 = x_p;
            end
        else 
            if F(x_p) <= f2
                x1 = x2;
                x2 = x_p;
            else
                x3 = x_p;
            end
        end
    end
    k= k+1;
end
    
 %绘图
 figure('Name','Parabola1')
 xx = xmin:0.01:xmax;
 yy = F(xx);
 plot(xx, yy, 'LineWidth', 2)
  hold on  %在曲线图中继续绘图
 plot(x ,y,'p', 'LineWidth', 2)
 title('抛物线法')

 




  