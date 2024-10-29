% Backtracking Line Search Method with Constraint Handling for func2
function alpha = Back_Track(func, grad, p, x, alpha, constraint)
    % constraint is a boolean which will only be true for func2 to avoid negatives in log function
    % Hyperparameters
    c1 = 0.1;
    rou = 0.5;
    
    if constraint
        while ~Pass_Constraint(x + alpha * p) || func(x + alpha * p) > (c1 * alpha * dot(p, grad)) + func(x)
            alpha = rou * alpha;
        end
    else
        while func(x + alpha * p) > (c1 * alpha * dot(p, grad)) + func(x)
            alpha = rou * alpha;
        end
    end
end