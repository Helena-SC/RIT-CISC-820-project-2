function fx = func1(x)
    fx = sum((1:length(x))' .* (x .^ 2));
end