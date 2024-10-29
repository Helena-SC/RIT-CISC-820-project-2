% func 3 (Rosenbrock function)
function fx = func3(x)
    x1 = x(1);
    x2 = x(2);
    fx = 100 * (x2 - x1^2)^2 + (1 - x1)^2;
end