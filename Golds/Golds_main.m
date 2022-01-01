%算法实际实现
clc
clear
syms x y k G;

%具体函数调用
f1 = x^2- x-1;
f2 = x^3 - 2*x +1;
f3 =sin(x)+sin(3*x);
eps = 0.05;

%调用改进形式0.618法
[x1,y1,k1,G1] = Golds_plus( f2, 0, 3, eps );
%调用0.618法
[x2,y2,k2,G2] = Golds( f2, 0, 3, eps );

figure('Name', 'Contrast')
plot(G1(:,3),G1(:,2),'LineWidth',2)
hold on 
plot(G2(:,3),G2(:,2),'LineWidth',3)

title('0.618法对比')
xlabel('迭代次数')
ylabel('函数值y')
 
