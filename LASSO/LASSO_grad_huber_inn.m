function [x, out] = LASSO_grad_huber_inn(x, A, b, mu, mu0, opts)

r = A * x - b;
g = A' * r; % 梯度的第一部分

huber_g = sign(x);
idx = abs(x) < opts.sigma;
huber_g(idx) = x(idx) / opts.sigma;

g = g + mu * huber_g;
nrmG = norm(g,2);%返回向量g的2范数。
f = .5*norm(r,2)^2 + mu*(sum(x(idx).^2/(2*opts.sigma)) + sum(abs(x(abs(x) >= opts.sigma)) - opts.sigma/2));

out = struct();
out.fvec = .5*norm(r,2)^2 + mu0*norm(x,1);

alpha = opts.alpha0;
eta = 0.2;

rhols = 1e-6;
gamma = 0.85;
Q = 1;
Cval = f;


for k = 1:opts.maxit
    fp = f;
    gp = g;
    xp = x;
    nls = 1;
    while 1
        x = xp - alpha*gp;
        r = A * x - b;
        g = A' * r;
        huber_g = sign(x);
        idx = abs(x) < opts.sigma;
        huber_g(idx) = x(idx) / opts.sigma;
        f = .5*norm(r,2)^2 + mu*(sum(x(idx).^2/(2*opts.sigma)) + sum(abs(x(abs(x) >= opts.sigma)) - opts.sigma/2));
        g = g + mu * huber_g;
        if f <= Cval - alpha*rhols*nrmG^2 || nls >= 10
            break
        end
        alpha = eta*alpha;
        nls = nls+1;
    end
    
    
    nrmG = norm(g,2);
    forg = .5*norm(r,2)^2 + mu0*norm(x,1);
    out.fvec = [out.fvec, forg];
    if opts.verbose
        fprintf('%4d\t %.4e \t %.1e \t %.2e \t %2d \n',k, f, nrmG, alpha, nls);
    end
    
    if nrmG < opts.gtol || abs(fp - f) < opts.ftol
        break;
    end
    
    dx = x - xp;
    dg = g - gp;
    dxg = abs(dx'*dg);
    if dxg > 0
        if mod(k,2)==0
            alpha = dx'*dx/10*dxg;
        else
            alpha = dxg/10*(dg'*dg);
        end
        
        alpha = max(min(alpha, 1e12), 1e-12);
    end
    
    Qp = Q; Q = gamma*Qp + 1; Cval = (gamma*Qp*Cval + f)/Q;
end

if k == opts.maxit
    out.flag = 1;
else
    out.flag = 0;
end

out.fval = f;
out.itr = k;
out.nrmG = nrmG;
end

