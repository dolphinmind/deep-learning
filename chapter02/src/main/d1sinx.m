clear;
clc;

% 参数设置
x1_range = -3*pi : 0.1 : 3*pi;
x2_range = -3*pi : 0.1 : 3*pi;
[x1, x2] = meshgrid(x1_range, x2_range);

% 原始函数
z_clean = sin(x1) .* sin(x2);

% 加入高斯噪声（标准差可调）
% noise_std = 0.1;
% noise = noise_std * randn(size(z_clean));
% z_noisy = z_clean + noise;

% 绘图
figure

% 绘制含噪图像
surf(x1, x2, z_clean, 'EdgeColor', 'none');
colormap turbo
colorbar
xlabel('$x_1$', 'Interpreter', 'latex', 'FontSize', 14)
ylabel('$x_2$', 'Interpreter', 'latex', 'FontSize', 14)
zlabel('$z$', 'Interpreter', 'latex', 'FontSize', 14)
title(sprintf('$\\sin(x_1)\\sin(x_2)$ with Gaussian Noise'), ...
    'Interpreter', 'latex', 'FontSize', 16, 'FontWeight', 'bold');


view(45, 30)  % 设置视角

% 可选保存图像
% exportgraphics(gcf, 'noisy_2D_sin_surface.png', 'Resolution', 300);
