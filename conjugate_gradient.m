% Conjugate Gradient Method with Special Handling for Function 2
function [x, minima, steps_done, f_vals, path] = conjugate_gradient(func, grad_func, x, tol, max_iter, constraint)
    % Initialize variables
    steps_done = 0;
    f_vals = [];  % To store function values for plotting
    path = x';  % To store the optimization path
    grad_x = grad_func(x);
    direction = -grad_x;  % Initial search direction
    alpha_start = 1;  % Initial step size
    
    while steps_done < max_iter
        % Compute step size using Backtracking Line Search
        alpha = Back_Track(func, grad_x, direction, x, alpha_start, constraint);
        
        % Update x
        x_updated = x + alpha * direction;
        grad_new = grad_func(x_updated);
        
        % If func2, ensure updated x is within feasible region
        if constraint
            if Pass_Constraint(x_updated)
                % Update x and proceed
                x = x_updated;
            else
                % Reduce alpha if x is not in the feasible region
                alpha_start = alpha_start * 0.5;
                continue;
            end
        else
            % For other functions, update x directly
            x = x_updated;
        end
        
        % Calculate beta using Fletcher-Reeves formula
        beta = (grad_new' * grad_new) / (grad_x' * grad_x);
        
        % Update direction
        direction = -grad_new + beta * direction;
        
        % Update gradient
        grad_x = grad_new;
        
        % Increment step count
        steps_done = steps_done + 1;
        
        % Store current function value and path
        f_vals = [f_vals; func(x)];
        path = [path; x'];
        
        % Check convergence
        if norm(grad_x, 2) < tol
            break;
        end
    end
    
    % Return final results
    minima = func(x);
end