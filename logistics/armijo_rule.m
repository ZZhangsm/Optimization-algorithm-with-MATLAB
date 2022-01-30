function alpha = armijo_rule(fun, gfun, x0, alpha0, dk)
%利用armjio准则确定步长
c1 = 1e-3;gamma = 0.8;
alpha = alpha0;
iIter = 0;iterMax = 200;
alphaMin = 1e-5;

while iIter < iterMax
    xnew = x0 + alpha * dk;
    fnew = feval(fun, xnew);
    f0 = feval(fun, x0);
    g0 = feval(gfun, x0);
    if fnew <= f0 + c1 * g0' * dk
        break;end
    if alpha < alphaMin
        break;end
    alpha = gamma * alpha;
    iIter = iIter + 1;
end

if iIter == iterMax
    alpha = alphaMin;
    fprintf('reach maximum iteration, and not found suitable alpha.\n');
end

end
