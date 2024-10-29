function H = hfunc2(x, A, b, c)
    
    % calculate Hessian matrix H(x)
    Ax = A * x;
    H_diag_elements = 1 ./ ((b - Ax).^2);
    H = A' * diag(H_diag_elements) * A;

end