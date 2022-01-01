function [x, y, k, G]=Golds_plus( f ,a ,b ,eps )
%{
    f       函数
    a       左区间
    b       右区间
    k       迭代次数
    eps     精度
    x       自变量
    y    局部极小值
%}

xmax = b;
xmin = a;
F = matlabFunction(f);
k = 1;
p = a + 0.382 * (b-a);
q = a + 0.618 * (b-a);
a_F = F(a);
b_F = F(b);
p_F = F(p);
q_F = F(q);
G = [];

while b-a >= eps
    A = [ a_F, p_F, q_F, b_F];
    [ ~ ,t] = min( A );
    
    if t == 1 || t == 2
        b = q;
        q = p;
        b_F = q_F;
        q_F = p_F;
        p = a + 0.382 * ( b-a );
        p_F = feval(F,p);     
    elseif t == 3 || t == 4
        a = p;
        p = q;
        a_F = p_F;
        p_F = q_F;
        q = a + 0.618 * ( b-a );
        q_F =feval(F,q);
    end
    %创建数组储存迭代结果
    Gp(k,:) = [(q + p) / 2  F((q + p) / 2) k ]
    k = k+1; 
   
end

%计算结果
x = (q + p) / 2;
y = F(x);
G = Gp;

%%%%%%%% 绘图
figure('Name', 'Golds_plus')
xx = xmin:0.01:xmax;
yy = F(xx);
plot(xx, yy, 'LineWidth', 2)
hold on  %在曲线图中继续绘图
plot(x,y,'p', 'LineWidth', 2)
title('0.618法的改进形式')
end
