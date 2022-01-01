function [fmin, xmin, fk, xk] = gradient_descent_fix_stepsize(func, gfunc, x0, alpha, epsilon)

iIter = 1;
iterMax = 500;
xOld = x0;
xk = zeros(size(x0, 1), 66);
xk(:, 1) = x0;
fk = zeros(1, 66);

while iIter < iterMax
    dk = feval(gfunc, xOld);
    xNew = xOld - alpha * dk;
    
    if norm(xNew - xOld, 2) <= epsilon
        break;
    end
    
    iIter = iIter + 1;
    
    xk(:, iIter) = xNew;
    fk(:, iIter) = feval(func, xNew);
    
    xOld = xNew;
end


if iIter == iterMax
    fprintf('reach maximum iteration, and not found minimal x!\n');
end

xmin = xNew;
fmin = feval(func, xmin);
fprintf('iIter = %d, fmin = %f\n', iIter, fmin);   



end
