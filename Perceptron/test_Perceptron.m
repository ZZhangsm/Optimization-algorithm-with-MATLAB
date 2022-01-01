%算法实际实现
clc
%指定输入空间
X = [3,3 ; 4,3 ; 1,1 ;2,2 ;0,5];
%指定输出空间
y = [1,1,-1 ,1,-1];
lr = 0.5;
iter = 500;

%求解y的列长度
n = size(y,2);

%绘制出特征空间中的实例点

for j = 1:n
    %绘制正实例点
    if y(j) == 1
        plot(X(j,1),X(j,2),'r*');
    end
    %绘制负实例点
    if y(j) == -1
        plot(X(j,1),X(j,2),'bo');
    end
    %该语句可以在原图的基础上绘制新的图像，不加则只能看到最后一个点
    hold on
end

%调用函数更新参数
[W,b] = Perceptron(X,y,lr,iter);

xlabel =linspace(0,5,500);
%将X(2)看成因变量，X（1）看作自变量，故可以得出算法绘制出的超平面
ylabel = -(W(1)/W(2))*xlabel -b/W(2);
plot(xlabel,ylabel);

