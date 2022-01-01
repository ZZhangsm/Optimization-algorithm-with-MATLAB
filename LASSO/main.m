clc;clear;
x=0.1;r=0.1;
m=32;n=64;
A=randn (m, n) ;
u=sprandn (n, 1,r) ;
b=A*u;mu0=0.001;mu=0;

opts.maxit = 20; 
opts.sigma = 0.1; 
opts.alpha0 = 0.01; 
opts.gtol = 1e-6;
opts.ftol = 1e-8; 
opts.verbose = 0; 

[x, out] = LASSO_grad_huber_inn(x, A, b, mu, mu0, opts)