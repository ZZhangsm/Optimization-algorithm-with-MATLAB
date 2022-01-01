function [W,b] = M_Perceptron(X, y, alpha, beta, Maxstep)
%矩阵型四分类感知器学习算法
%W = [ w_ij ]为待求得权重向量， b=[b_j]为偏置项
%X=[] 为输入空间，本次为2*1的，y为输出空间，取值为（0,0）（0,1）（1,0）（1,1）