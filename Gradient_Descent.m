function [x, minima, steps_done, f_vals, path] = Gradient_Descent(func, grad_func, x, alpha_start, constraint)
    % Hyperparameters
    max_steps = 1000;
    tolerance = 1e-6;
    good_enough = false;
    max_steps_done = false;
    steps_done = 0;
    f_vals = [];
    path = x';

    while ~good_enough && ~max_steps_done
        grad_x = grad_func(x);
        direction = -grad_x;
 
        alpha = Back_Track(func, grad_x, direction, x, alpha_start, constraint); 
        x_updated = x + direction * alpha;
        steps_done = steps_done + 1;

        f_vals = [f_vals; func(x)];
        path = [path; x'];

        if abs(func(x_updated) - func(x)) < tolerance
            good_enough = true;
        end

        if steps_done >= max_steps
            max_steps_done = true;
        end

        x = x_updated;
    end

    minima = func(x);
end