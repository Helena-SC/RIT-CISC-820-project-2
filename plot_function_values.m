function plot_function_values(f_vals_list, labels)
    figure;
    num_iterations = length(f_vals_list{1});
    iterations = 1:num_iterations;
    plot( iterations,f_vals_list{1}, '-o', 'DisplayName', labels{1});
    xlabel('Number of Iterations');
    ylabel('Function Value');
    title([labels{1}]);
    legend;
    grid on;
end