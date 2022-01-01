function [W,b] = Perceptron(X,y,lr,Maxstep)
%感知机学习算法
%W=[w1, w2, ... ,wn]为待求的权重向量，b为偏差
%X=[]为输入空间,本次取二维的，y为输出空间，取值为[-1,1]

[n,m] = size(X);%求解矩阵X的大小
%给权值和偏差赋初始值，指定学习步长
W = zeros(m,1);%W为m行的列向量
b = 0;%设置偏差的初始值为0


for step = 1:Maxstep%迭代更新参数值
    flag = true;%设置一个标志位用来判断是否存在误分类点
    for i = 1:n 
        if (y(i)* ( X(i,:)*W+b ) ) <=0 %判断随机选择的点是否是误分类点
            flag = false;%若随机选择的点是误分类点，则将标志位设置为false
            %根据梯度下降法更新权重和偏差参数
            W = W + lr*y(i)*X(i,:)';
            b = b + lr*y(i);
        end
    end
    if flag == true%如果标志位为true,表示误分类点数为0，算法已经实现正确分类，不需要继续迭代更新了，跳出循坏
        break       
    end
end




