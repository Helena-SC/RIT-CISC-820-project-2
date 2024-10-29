function hessian = hfunc3(x)
    x1 = x(1);
    x2 = x(2);
    hessian = zeros(2, 2);
    hessian(1, 1) = 1200 * x1^2 - 400 * x2 + 2;
    hessian(1, 2) = -400 * x1;
    hessian(2, 1) = -400 * x1;
    hessian(2, 2) = 200;
end
