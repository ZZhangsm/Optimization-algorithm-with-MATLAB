close all
% f(x, y) = x^2 + 10y^2;

func = @(x)(x(1)^2 + 10 * x(2)^2);
gfunc = @(x)([2*x(1); 20 * x(2)]);
epsilon = 1e-5;

x0 = [10; 1];
alpha = 0.085;

[fmin, xmin, fk, xk] = gradient_descent_fix_stepsize(func, gfunc, x0, alpha, epsilon);
x1 = -12:1e-2:12;
x2 = -10:1e-2:10;
[X1, X2] = meshgrid(x1, x2);
F = X1.^2 + 10 * X2.^2;
figure, contour(X1, X2, F, 50)
hold on
plot(xk(1,:), xk(2,:), 'LineWidth', 2)
plot(xk(1,:), xk(2,:), 'o', 'LineWidth', 2)


x0 = [-10; -1];
[fmin, xmin, fkBB, xkBB] = gradient_descent(func, gfunc, x0, epsilon);
hold on
plot(xkBB(1, :), xkBB(2, :), 'k', 'LineWidth', 2);
plot(xkBB(1, :), xkBB(2, :), 'bo', 'LineWidth', 2);
