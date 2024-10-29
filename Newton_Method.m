% Newton Method with Backtracking Line Search and Constraint Handling for func2
function [x, minima, steps_done, f_vals, path] = Newton_Method(func, grad_func, hessian_func, x, tol, max_iter, fun_2_flag)
    steps_done = 0;
    f_vals = [func(x)];
    path = x';  
    
    if fun_2_flag
        tmp_alpha = [];  
    end

    while steps_done < max_iter
        grad_x = grad_func(x);
        hessian_x = hessian_func(x);


        direction = hessian_x \ (-grad_x);


        alpha = Back_Track(func, grad_x, direction, x, 1, fun_2_flag);
        
        if fun_2_flag
            tmp_alpha(end + 1) = alpha; 
        end


        x_updated = x + direction * alpha;
        f_vals = [f_vals; func(x_updated)];  
        path = [path; x_updated'];  


        if abs(func(x_updated) - func(x)) < tol
            break;
        end

        steps_done = steps_done + 1;
        if steps_done >= max_iter
            break;
        end

        x = x_updated;
    end

    if fun_2_flag
 
        figure;
        axis_x = 1:length(tmp_alpha);
        plot(axis_x, tmp_alpha, '-o');
        xlabel('Iteration Number');
        ylabel('Alpha Value');
        title('Alpha Value over Iterations for Function 2');
        grid on;
    end

    minima = func(x);
end