% 清理环境
clf;
clear;

% 设置自变量范围 [0, 10]
x = linspace(0, 10, 80);        % x 轴上点
t = linspace(-1.5, 1.5, 300);   % t 是纵向高斯分布的范围

% 条件均值和方差
mu = sin(x);                    % 均值函数 f*(x)
sigma = 0.2;                    % 固定标准差

% 绘图开始
figure; hold on;

% 逐点画高斯密度线
for i = 1:length(x)
    % 计算高斯密度
    p = (1 / (sqrt(2*pi)*sigma)) * exp(- (t - mu(i)).^2 / (2*sigma^2));
    px = p / max(p) * 0.3;  % 压缩密度宽度用于显示

    % 绘制每条竖直高斯分布线（灰蓝色）
    plot(x(i) + px, t, 'Color', 'b', 'LineWidth', 1);
end

% 添加回归函数 f*(x) = sin(x)
x_dense = linspace(0, 10, 1000);
plot(x_dense, sin(x_dense), 'r-', 'LineWidth', 2);

% 图形美化设置
xlabel('$x$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('$t$', 'Interpreter', 'latex', 'FontSize', 14);
title('条件分布 p(t|x) 与回归函数 f^{*}(x)', 'Interpreter', 'tex', 'FontSize', 16);

ylim([-1.5, 1.5]);
xlim([0, 10]);
set(gca, 'FontName', 'Times', 'FontSize', 12);
box on;
