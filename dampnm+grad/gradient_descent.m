function [fmin, xmin] = gradient_descent(func, gfunc, x0, epsilon)
%function [fmin, xmin, fk, xk] = gradient_descent(func, gfunc, x0, epsilon)
iIter = 1;iterMax = 500;
xOld = x0;

alphaMin = 1e-5;alphaMax = 1e5;
M = 10;
alpha = 0.5;
[~, ~, alpha] = armijo_rule(func, gfunc, x0, 0.5, -feval(gfunc, x0));

QOld = 1;
COld = feval(func, xOld);
c1 = 0.5;eta = 0.5;
% xk = zeros(size(x0, 1), 11);
% fk = zeros(11, 1);
% xk(:, 1) = x0;
% fk(1, :) = feval(func, x0);

while iIter < iterMax
    g = feval(gfunc, xOld);
    d = -g;
    
    % Zhang, Hanger nonmonotone line search
    for i = 1:M
        xNew = xOld + alpha * d;
        fNew = feval(func, xNew);
        if fNew <= COld + alpha * c1 * dot(d, d)
            break;
        end
        alpha = alpha * eta;
    end
    
    %xNew = xOld - alpha * dk;
    iIter = iIter + 1;
    
    if norm(g, 2) < epsilon
        break;
    end
    
    % BB step-size calculation
    sk = xNew - xOld; yk = feval(gfunc, xNew) - feval(gfunc, xOld);
    if mod(iIter, 2) == 1
        alpha = dot(sk, yk) / dot(yk, yk);
    else
        alpha = dot(sk, sk) / dot(sk, yk);
    end
    
    alpha = max(min(alpha, alphaMax), alphaMin);
    
    QNew = eta * QOld + 1;
    CNew = (eta * QOld * COld + fNew) / QNew;
    COld = CNew;
    
    xOld = xNew;
%     xk(:, iIter) = xNew;
%     fk(iIter, :) = fNew;
end

if iIter == iterMax
    fprintf('exceed max iteration, not found  minimal point x.\n');
end

xmin = xNew;
fmin = feval(func, xmin);
fprintf('iIter = %d, fmin = %f\n', iIter, fmin);

end
