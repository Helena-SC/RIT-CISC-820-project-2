function grad = grad_func2(x, A, b, c)
    Ax = A * x;
    grad = c + A' * (1 ./ (b - Ax));
end