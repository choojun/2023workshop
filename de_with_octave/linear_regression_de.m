pkg load statistics

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% In these line of code, a straight line is adapted
% to points on the curve of y = sin(x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y = sin(x)
% generate the artificial data
x = linspace(0, 2, 10)'; y = sin(x);

% ------------------------------------------------------
% perform the linear regression, aiming for a straight line
F = [ones(size(x)), x];
[p, e_var, r, p_var] = LinearRegression(F, y);
Parameters_and_StandardDeviation = [p sqrt(p_var)]
estimated_std = sqrt(mean(e_var))
y_reg = F * p;
figure(10); plot(x, y, '+', x, y_reg)

% ------------------------------------------------------
% perform the linear regression, aiming for a parabola
F = [ones(size(x)), x, x.^2];
[p, e_var, r, p_var] = LinearRegression(F,y);
Parameters_and_StandardDeviation = [p sqrt(p_var)]
estimated_std = sqrt(mean(e_var))
y_reg = F*p;
figure(11); plot(x, y, '+', x, y_reg)

% ------------------------------------------------------
% perform the linear regression, and describe a plane in 3D space
N = 100; x = 2*rand(N,1); y = 3*rand(N,1); z = 2 + 2*x - 1.5*y + 0.5*randn(N, 1);
F = [ones(size(x)), x, y];
p = LinearRegression(F, z)
[x_grid, y_grid] = meshgrid([0:0.1:2], [0:0.2:3]);
z_grid = p(1) + p(2)*x_grid + p(3)*y_grid;
figure(12); plot3(x, y, z, '*')
hold on
mesh(x_grid, y_grid, z_grid)
xlabel('x'); ylabel('y'); zlabel('z');
hold off

% -------------------------------------------------------
% The function LinearRegression() does not determine the confidence intervals
% for the parameters. However, it returns the estimated standard deviations,
% resp. the variances. With these the confidence intervals can be computed,
% using the t-distribution.
[p,~,~,p_var] = LinearRegression(F,z);
alpha = 0.05;
p_CI = p + tinv(1-alpha/2,N-3)*[-sqrt(p_var) +sqrt(p_var)]

