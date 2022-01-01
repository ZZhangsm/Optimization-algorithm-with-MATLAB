%算法实际实现
clc
clear
syms x y k;

%具体参数设置
f1 = x^2 - 6*x + 2;
f2 = x^3 - 2*x + 1;
eps = 0.01;
basevalue1 = -7;
basevalue2 = -0.08866;


[xmin,xmax] = Advance_and_Retreat_Method(f1, 1, 0.1);
[x1,y1,k1,g1] = Parabola(f1,xmin, 1, xmax, eps);
figure('Name','Parabola1')
area(g1(:,6),g1(:,1),basevalue1)
title('抛物线法')
xlabel('迭代次数')
ylabel('函数值y')

[x2,y2,k2,g2] = Parabola(f2, 0, 1, 3, eps);
figure('Name','Parabola2')
area(g2(:,6),g2(:,1),basevalue2)
title('抛物线法')
xlabel('迭代次数')
ylabel('函数值y')
