% Plot optimization path function
function plot_descent_path(func, path, title_str)
    figure;
    hold on;
    % Plot the contour of the target function
    [X, Y] = meshgrid(linspace(min(path(:, 1)) - 1, max(path(:, 1)) + 1, 100), linspace(min(path(:, 2)) - 1, max(path(:, 2)) + 1, 100));
    Z = arrayfun(@(x, y) func([x; y]), X, Y);
    contour(X, Y, Z, 50);

    % Plot the optimization path
    for i = 1:size(path, 1) - 1
        quiver(path(i, 1), path(i, 2), path(i + 1, 1) - path(i, 1), path(i + 1, 2) - path(i, 2), 0, 'r', 'LineWidth', 1.5, 'MaxHeadSize', 0.5);
    end
    plot(path(:, 1), path(:, 2), '-o', 'LineWidth', 2, 'MarkerSize', 4, 'MarkerFaceColor', 'r');
    % Initial point with coordinates
    plot(path(1, 1), path(1, 2), 'go', 'MarkerSize', 8, 'MarkerFaceColor', 'g');
    coords = sprintf('(%.2f, %.2f)', path(1, 1), path(1, 2));
    text(path(1, 1), path(1, 2), ['Initial Point ', coords], 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'Color', 'g');

    % End point with coordinates
    plot(path(end, 1), path(end, 2), 'bo', 'MarkerSize', 8, 'MarkerFaceColor', 'b');
    coords = sprintf('(%.2f, %.2f)', path(end, 1), path(end, 2));
    text(path(end, 1), path(end, 2), ['End Point ', coords], 'VerticalAlignment', 'top', 'HorizontalAlignment', 'left', 'Color', 'b');

    xlabel('x_1');
    ylabel('x_2');
    title(title_str);
    grid on;
    hold off;
end