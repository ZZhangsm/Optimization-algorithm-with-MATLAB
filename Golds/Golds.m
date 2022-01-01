function [x, y, k, G]=Golds( f ,a ,b ,eps )
%{
    f       函数
    a       左区间
    b       右区间
    eps     精度
    x       自变量
    y    局部极小值
%}

xmax = b;
xmin = a;
F = matlabFunction(f);
p = a + 0.382 * ( b - a );
q = a + 0.618 * ( b - a );
q_F = F(q);
p_F = F(p);
k=1
G = [];

while (abs( q-a ) >= eps || abs( b-p ) >= eps)
    if p_F <= q_F 
        b = q;
        q_F = p_F;
        q = p;
        p = a + 0.382 * ( b-a );
        p_F = F(p);  
        
    else 
        a = p;
        p_F = q_F;
        p = q;
        q = a + 0.618*( b-a );
        q_F = F(q);
    end
    Gp(k,:) = [(q + p) / 2  F((q + p) / 2) k ];
    k = k+1;
end

%计算结果
x = (q + p) / 2;
y = F(x);
G = Gp;

%%%%%%%% 绘图
figure('Name', 'Golds')
xx = xmin:0.01:xmax;
yy = F(xx);
plot(xx, yy, 'LineWidth', 2)
hold on
plot(x,y,'p', 'LineWidth', 2)
title('0.618法')
end
