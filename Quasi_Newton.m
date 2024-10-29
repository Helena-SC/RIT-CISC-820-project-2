function [x, minima, steps_done, f_vals, path] = Quasi_Newton(func, grad_func, x, tol, max_iter, constraint)
    steps_done = 0;
    n = length(x);
    H = eye(n);  
    alpha_start = 1;  
    f_vals = [func(x)];  
    path = x';  

    while steps_done < max_iter
        grad_x = grad_func(x);
        
        direction = -H * grad_x;

        alpha = Back_Track(func, grad_x, direction, x, alpha_start, constraint);
        
        x_new = x + alpha * direction;
        grad_new = grad_func(x_new);
        
        if constraint
            if Pass_Constraint(x_new)
                s = x_new - x;
                y = grad_new - grad_x;
                x = x_new;
            else
                alpha_start = alpha_start * 0.5;
                continue;
            end
        else
            s = x_new - x;
            y = grad_new - grad_x;
            x = x_new;
        end
        
        %  BFGS 
        rho = 1 / (y' * s);
        I = eye(n);
        H = (I - rho * (s * y')) * H * (I - rho * (y * s')) + rho * (s * s');
        
        steps_done = steps_done + 1;
        
        f_vals = [f_vals; func(x)];
        path = [path; x'];
        
        if norm(grad_x, 2) < tol
            break;
        end
    end
    
    minima = func(x);
end