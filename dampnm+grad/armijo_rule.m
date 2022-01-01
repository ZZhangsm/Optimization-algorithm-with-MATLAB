function [fnew, xnew, alpha] = armijo_rule(func, gfunc, x0, alpha0, dk)

c1 = 1e-3;
alpha = alpha0;
gamma = 0.8;

iIter = 0;
iterMax = 200;
alphaMin = 1e-5;

while iIter < iterMax 
    
    xnew = x0 + alpha * dk;
    fnew = feval(func, xnew);
    f0 = feval(func, x0);
    if fnew <= f0 + c1 * feval(gfunc, x0)' * dk
        break;
    end
    
    if alpha < alphaMin
        break;
    end
    
    alpha = gamma * alpha;
    iIter = iIter + 1;   
end

if iIter == iterMax
    alpha = alphaMin;
    fprintf('reach maximum iteration, and not found suitable alpha.\n');
end

xnew = x0 + alpha * dk;
fnew = feval(func, xnew);

end
