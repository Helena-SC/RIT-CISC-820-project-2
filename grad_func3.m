function grad = grad_func3(x)
    x1 = x(1);
    x2 = x(2);
    grad = zeros(2, 1);
    grad(1) = -400 * (x2 - x1^2) * x1 - 2 * (1 - x1);
    grad(2) = 200 * (x2 - x1^2);
end