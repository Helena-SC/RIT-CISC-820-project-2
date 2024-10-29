%%%%%%%%%%% run this file please 
%%%%%%%%%%% CISC.820.project2 written by Shichang Lian 
close all;
clc;
clear all;
rng(42);
warning('off', 'all');

alpha_start = 1.0;  % initial learning rateeigenvalues
tol = 1e-6;  % torrence
max_iter = 1000;  % max Iteration

x_start1 = ones(100,1);  
starting_points = {[1.5; 2], [10; 10], [5; 5]}; 

fid_A = fopen('fun2_A.txt', 'r');
A = fscanf(fid_A, '%e', [500, 100]);
fclose(fid_A);

fid_b = fopen('fun2_b.txt', 'r');
b = fscanf(fid_b, '%e', [500, 1]);  
fclose(fid_b);

fid_c = fopen('fun2_c.txt', 'r');
c = fscanf(fid_c, '%e', [100, 1]);
fclose(fid_c);

%testtify if function 2 is convex or not
x = zeros(100, 1);  % the start point of function2
% Check if Ax < b
if all(A*x < b)
    H = hfunc2(x, A, b, c);
    eigenvalues = eig(H);
    if all(eigenvalues > 0)
        disp('The function2 is convex when A*x < b.');  % the result will be this one
    else
        disp('The function2 is not convex.');
    end
else
    disp('Does not meet feasible region conditions，function2 does not exist');
end
% %%%%%%%%%% start Optimization -- Gradient Descent
% Optimize Function 1
fprintf('Running Gradient Descent on Function 1 \n');
[x_min1_gd, f_min1_gd, iter1_gd, f_vals1_gd, path1_gd] = Gradient_Descent(@func1, @grad_func1, x_start1, alpha_start,  false);
fprintf('Function 1 Minimum Value: %.6f \n', f_min1_gd);
fprintf('Number of Iterations: %d', iter1_gd);
plot_function_values({f_vals1_gd},  {'Function 1 (GD)'});

% Optimize Function 2
fprintf('\nRunning Gradient Descent on Function 2 \n');
[x_min2_gd, f_min2_gd, iter2_gd, f_vals2_gd, path2_gd] = Gradient_Descent(@(x) func2(x, A, b, c), @(x) grad_func2(x, A, b, c), x, alpha_start,  true);
fprintf('Function 2 Minimum Value: %.6f \n', f_min2_gd);
fprintf('Number of Iterations: %d', iter2_gd);
plot_function_values({f_vals2_gd}, {'Function 2 (GD)'});

% Optimize Function 3
fprintf('\nRunning Gradient Descent on Function 3 \n');
for i = 1:length(starting_points)
    [x_min3_gd, f_min3_gd, iter3_gd, f_vals3_gd, path3_gd] = Gradient_Descent(@func3, @grad_func3, starting_points{i}, alpha_start, false);
    start_point_str = sprintf('[%.2f, %.2f]', starting_points{i}(1), starting_points{i}(2));
    fprintf('Function 3 Minimum Value with starting point %s: %.6f \n', start_point_str, f_min3_gd);
    fprintf('Number of Iterations: %d \n', iter3_gd);
    plot_function_values({f_vals3_gd}, {sprintf('Function 3 (GD) with starting point %s', start_point_str)});
    plot_descent_path(@func3, path3_gd, sprintf('Function 3 Path (GD) with starting point %s', start_point_str));
end
%%%%%%%%%% start Optimization -- Newton Method
% Optimize Function 1
fprintf('\nRunning Newton Method on Function 1 \n');
[x_min1_N, f_min1_N, iter1_N,f_vals1_N, path1_N] = Newton_Method(@func1, @grad_func1, @hfunc1, x_start1, tol, max_iter,false);
fprintf('Function 1 Minimum Value: %.6f \n', f_min1_N);
fprintf('Number of Iterations: %d', iter1_N);
plot_function_values({f_vals1_N},  {'Function 1 (Newton)'});

% Optimize Function 2
fprintf('\nRunning Newton Method on Function 2 \n');
[x_min2_N, f_min2_N, iter2_N,f_vals2_N, path2_N] = Newton_Method(@(x) func2(x, A, b, c), @(x) grad_func2(x, A, b, c), @(x) hfunc2(x, A, b), x, tol, max_iter,true);
fprintf('Function 2 Minimum Value: %.6f \n', f_min2_N);
fprintf('Number of Iterations: %d', iter2_N);
plot_function_values({f_vals2_N}, {'Function 2 (Newton)'});

% Optimize Function 3
fprintf('\nRunning Newton Method on Function 3 \n');
for i = 1:length(starting_points)
    [x_min3_N, f_min3_N, iter3_N, f_vals3_N, path3_N] = Newton_Method(@func3, @grad_func3, @hfunc3, starting_points{i}, tol, max_iter, false);
    start_point_str = sprintf('[%.2f, %.2f]', starting_points{i}(1), starting_points{i}(2));
    fprintf('Function 3 Minimum Value with starting point %s: %.6f \n', start_point_str, f_min3_N);
    fprintf('Number of Iterations: %d \n', iter3_N);
    plot_function_values({f_vals3_N}, {sprintf('Function 3 (Newton) with starting point %s', start_point_str)});
    plot_descent_path(@func3, path3_N, sprintf('Function 3 Path (Newton) with starting point %s', start_point_str));
end
%%%%%%%%%% start Optimization -- Quasi Newton
% Optimize Function 1
fprintf('\nRunning Quasi Newton on Function 1 \n');
[x_min1_QN, f_min1_QN, iter1_QN,f_vals1_QN, path1_QN] = Quasi_Newton(@func1, @grad_func1, x_start1, tol, max_iter,false);
fprintf('Function 1 Minimum Value: %.6f \n', f_min1_QN);
fprintf('Number of Iterations: %d', iter1_QN);
plot_function_values({f_vals1_QN},  {'Function 1 (Quasi Newton)'});


% Optimize Function 2
fprintf('\nRunning Quasi Newton on Function 2 \n');
[x_min2_QN, f_min2_QN, iter2_QN,f_vals2_QN, path2_QN] = Quasi_Newton(@(x) func2(x, A, b, c), @(x) grad_func2(x, A, b, c), x, tol, max_iter,true);
fprintf('Function 2 Minimum Value: %.6f \n', f_min2_QN);
fprintf('Number of Iterations: %d', iter2_QN);
plot_function_values({f_vals2_QN}, {'Function 2 (Quasi Newton)'});


% Optimize Function 3
fprintf('\nRunning Quasi Newton on Function 3 \n');
for i = 1:length(starting_points)
    [x_min3_QN, f_min3_QN, iter3_QN, f_vals3_QN, path3_QN] = Quasi_Newton(@func3, @grad_func3, starting_points{i}, tol, max_iter, false);
    start_point_str = sprintf('[%.2f, %.2f]', starting_points{i}(1), starting_points{i}(2));
    fprintf('Function 3 Minimum Value with starting point %s: %.6f \n', start_point_str, f_min3_QN);
    fprintf('Number of Iterations: %d \n', iter3_QN);
    plot_function_values({f_vals3_QN}, {sprintf('Function 3 (Quasi Newton) with starting point %s', start_point_str)});
    plot_descent_path(@func3, path3_QN, sprintf('Function 3 Path (Quasi Newton) with starting point %s', start_point_str));
end
%%%%%%%%%% start Optimization -- Conjugate Gradient
% Optimize Function 1
fprintf('\nRunning Conjugate Gradient on Function 1 \n');
[x_min1_cg, f_min1_cg, iter1_cg,f_vals1_cg, path1_cg] = conjugate_gradient(@func1, @grad_func1, x_start1, tol,max_iter, false);
fprintf('Function 1 Minimum Value: %.6f \n', f_min1_cg);
fprintf('Number of Iterations: %d ', iter1_cg);
plot_function_values({f_vals1_cg},  {'Function 1 (Conjugate Gradient)'});

% Optimize Function 2
fprintf('\nRunning Conjugate Gradient on Function 2 \n');
[x_min2_cg, f_min2_cg, iter2_cg,f_vals2_cg, path2_cg] = conjugate_gradient(@(x) func2(x, A, b, c), @(x) grad_func2(x, A, b, c), x, tol,max_iter, true);
fprintf('Function 2 Minimum Value: %.6f \n', f_min2_cg);
fprintf('Number of Iterations: %d ', iter2_cg);
plot_function_values({f_vals2_cg},  {'Function 2 (Conjugate Gradient)'});

% Optimize Function 3
fprintf('\nRunning Conjugate Gradient on Function 3 \n');
for i = 1:length(starting_points)
    [x_min3_cg, f_min3_cg, iter3_cg, f_vals3_cg, path3_cg] = conjugate_gradient(@func3, @grad_func3, starting_points{i}, tol, max_iter, false);
    start_point_str = sprintf('[%.2f, %.2f]', starting_points{i}(1), starting_points{i}(2));
    fprintf('Function 3 Minimum Value with starting point %s: %.6f \n', start_point_str, f_min3_cg);
    fprintf('Number of Iterations: %d \n', iter3_cg);
    plot_function_values({f_vals3_cg}, {sprintf('Function 3 (Conjugate Gradient) with starting point %s', start_point_str)});
    plot_descent_path(@func3, path3_cg, sprintf('Function 3 Path (Conjugate Gradient) with starting point %s', start_point_str));
end
%%%%%%%%%% get all the plots and save them in predefined folder
folderPath = './plots';  

if ~exist(folderPath, 'dir')
    mkdir(folderPath); 
end

figList = findobj(allchild(0), 'flat', 'Type', 'figure');
set(findobj(allchild(0), 'flat', 'Type', 'figure'), 'Color', 'w'); 
set(findall(0, 'Type', 'axes'), 'Color', 'w');

for i = 1:length(figList)
    fig = figure(figList(i));  
    fileName = fullfile(folderPath, sprintf('Figure_%d.png', i));     
    print(fig, fileName, '-dpng', '-r1080');  
end
disp(['All figures have been saved to ', folderPath]);