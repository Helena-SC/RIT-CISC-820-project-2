function fx = func2(x, A, b, c)
    if size(x, 2) > 1
        x = x';
    end
    Ax = A * x;
    fx = c' * x - sum(log(b - Ax));
end